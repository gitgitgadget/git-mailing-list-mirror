Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CBD381BD
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711711189; cv=none; b=aP1JWRziph9q4fiOedVWbDAuc8m/o3pMLIUdh3VTjYALr8mf5NBJNGJP5LXISPHZodbmLXGGtubcr8XI02vBFE1t4T5jr5vepIW7Tbi2SQDOOC1ZaF6xsOl/Q6TA2DPhejjtJtpRrsHzAAyPi/dNjrGculzPQY5COK3YLTnS8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711711189; c=relaxed/simple;
	bh=O1bDt/B2g9RRPI6FC4prfESWX4cyLUNGGJ8YsATc0Jo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=gP6DZMp0/0MCfKJ15lHe1MMp7VcBWB/G4hjHSarJxPdFyiMhDhFNE/NuG7etaNPLiBrXxWza7xNtGFJxgS6BmwwbK2piDsFJziu+/fHJEi2e0NDEm+sOJobYtIZyHKsizCw+Crk05Uqqx1HrWGI8wx0Df0FzKcWlFbLWM3NTous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBuOO+Fd; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBuOO+Fd"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41550858cabso1940865e9.2
        for <git@vger.kernel.org>; Fri, 29 Mar 2024 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711711184; x=1712315984; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAw0YXuCXFLOo2TgGHKlOFqfmrpxmNZcW9baxykH12A=;
        b=eBuOO+Fd7P8ZhGMiTzVlyeFQxkHoMJZoV1ZRbf4bHoOxhWWhf3IRftaQj3py2bPuld
         3vnHtBrgyaMTjMxHi4CgFvK2oEMZWvgRVqh6A/UGTqhNt8s7UWvqMyEfeTlf1yVS+DVk
         t6FNlDs+9o2ffO7DfhyFO5A1hW/hrodPuFCR23lLzbveKbGyNhIeGAgKOFkjWaQjM8ta
         +FJrY8LkU54Q3T/XFC1KG/MURLGhJ/I1ZCyrDStEsBqce2z2ezMMrI63mDSujGRAic73
         hnu5LcEGKYJbpdN9umTPVOwlgb7qxb4wiJX1VBoYi7yGsZtYvI5ZbWtusbIFs7sYnN0u
         vHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711711184; x=1712315984;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAw0YXuCXFLOo2TgGHKlOFqfmrpxmNZcW9baxykH12A=;
        b=SuC4i+hcGVB2HI90tDJGYmkUthSQJkEFREL+MCCQj6M9MYeQzEfE/6v/ZnJbNTQ0+t
         1rl710TgZDgoe8W1tOpN+Mb8m2hahjWpU3TtLR+yz5g3z0Du5R3qymy8lqVtG36RliF7
         p1hDavkijKxHLLQ4HL0w8UWB40w8MK3dI4xQQI4sm4ZX60+EfmaD3BYLT6AnEM3MZUf2
         ak6+31UBqV/VaI1l5WRxxkkygd+s9TgbIoN0RPI4kiZ/BuRvzwUVmu326ojQe3/o+vsk
         KGLl6Zxv5xHqtWamO5QZNC9tQkRPcJTBkL5AtlpAaNtL9lgYTvMfhckWCm1g4ax+Gvt3
         yxpg==
X-Gm-Message-State: AOJu0YwiJ1wOHh6ZjYVdZzuGGWhXeYtFeQkjEalcuU0+igENs3NNvbn2
	ht08ZVQYFpWDAFbon6h1CMngBIVNRXUaKcpR7r1rVxZdWuLYPzI9zNvHP/rB
X-Google-Smtp-Source: AGHT+IEsQEYWjlcqEYTiaZ+c/XE1lLQkN1CycuWKmRvmg7btlrN+FABQQISsVUVp7aXJLC1AW37gXQ==
X-Received: by 2002:a05:600c:1393:b0:414:e738:d02a with SMTP id u19-20020a05600c139300b00414e738d02amr1380330wmf.32.1711711184077;
        Fri, 29 Mar 2024 04:19:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c351100b00414854cd257sm5103794wmq.20.2024.03.29.04.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 04:19:43 -0700 (PDT)
Message-Id: <pull.1702.v2.git.1711711181.gitgitgadget@gmail.com>
In-Reply-To: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
References: <pull.1702.git.1711318739.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 29 Mar 2024 11:19:36 +0000
Subject: [PATCH v2 0/5] Doc new guidelines
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
    Jeff King <peff@peff.net>,
    Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This version is a simplification of the markup. The behavior is variable,
depending on versions of asciidoc[tor], but at least, it works both on my
station and in github-ci. @Martin, please check on your platform.

Changes since v1:

 * use unconstrained markup ++ for verbatim stuck to emphasis, instead of
   {empty} trickery
 * document and apply markup on man page references
 * split git-clone commit into markup and non-autoreference

Jean-Noël Avila (5):
  doc: rework CodingGuidelines with new formatting rules
  doc: allow literal and emphasis format in doc vs help tests
  doc: git-init: apply new documentation formatting guidelines
  doc: git-clone: apply new documentation formatting guidelines
  doc: git-clone: do not autoreference the manpage in itself

 Documentation/CodingGuidelines | 153 ++++++++++++++++++---------------
 Documentation/config/clone.txt |  20 +++--
 Documentation/config/init.txt  |   4 +-
 Documentation/git-clone.txt    | 120 +++++++++++++-------------
 Documentation/git-init.txt     |  56 ++++++------
 Documentation/urls.txt         |  44 +++++-----
 t/t0450-txt-doc-vs-help.sh     |   4 +-
 7 files changed, 216 insertions(+), 185 deletions(-)


base-commit: 11c821f2f2a31e70fb5cc449f9a29401c333aad2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1702%2Fjnavila%2Fdoc_new_Guidelines-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1702/jnavila/doc_new_Guidelines-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1702

Range-diff vs v1:

 1:  d08e8bfd9bc ! 1:  8a25ab1c3b6 doc: rework CodingGuidelines with new formatting rules
     @@ Documentation/CodingGuidelines: Writing Documentation:
      +   `.git/config`
      +   `GIT_DIR`
      +   `HEAD`
     ++   `umask`(2)
      +
      + An environment variable must be prefixed with "$" only when referring to its
      + value and not when referring to the variable itself, in this case there is
     @@ Documentation/CodingGuidelines: Writing Documentation:
      +   _<key-id>_
      +
      + When literal and placeholders are mixed, each markup is applied for
     -+ each sub-entity. If they are stuck, a special markup, with an {empty}
     -+ entity is needed:
     ++ each sub-entity. If they are stuck, a special markup, called
     ++ unconstrained formatting is required.
     ++ Unconstrained formating for placeholders is __<like-this>__
     ++ Unconstrained formatting for literal formatting is ++like this++
      +   `--jobs` _<n>_
     -+   `--sort=`{empty}__<key>__
     -+   __<directory>__{empty}`/.git`
     -+   `remote.`{empty}__<name>__{empty}`.mirror`
     ++   ++--sort=++__<key>__
     ++   __<directory>__++/.git++
     ++   ++remote.++__<name>__++.mirror++
      +
     -+Synopsis Syntax
     ++ caveat: ++ unconstrained format is not verbatim and may expand
     ++ content. Use Asciidoc escapes inside them.
       
      - When a placeholder is cited in text paragraph, it is enclosed in angle
      - brackets to remind the reader the reference in the synopsis section.
      - For better visibility, the placeholder is typeset in italics:
      -   The _<file>_ to be added.
     ++Synopsis Syntax
     ++
      + Syntax grammar is formatted neither as literal nor as placeholder.
      +
      + A few commented examples follow to provide reference when writing or
     @@ Documentation/CodingGuidelines: Writing Documentation:
          (Zero or more of <file>.)
       
      -   --exec-path[=<path>]
     -+   `--exec-path`[`=`{empty}__<path>__]
     ++   ++--exec-path++[++=++__<path>__]
          (Option with an optional argument.  Note that the "=" is inside the
          brackets.)
       
     @@ Documentation/CodingGuidelines: Writing Documentation:
        alternate arguments of an option:
      -    Do: --track[=(direct|inherit)]
      -    Don't: --track[=(direct | inherit)]
     -+    Do: `--track`[`=`(`direct`|`inherit`)]`
     -+    Don't: `--track`[`=`(`direct` | `inherit`)]
     ++    Do: ++--track++[++=++(`direct`|`inherit`)]`
     ++    Don't: ++--track++[++=++(`direct` | `inherit`)]
       
        Parentheses are used for grouping:
      -   [(<rev> | <range>)...]
 2:  202ed891463 ! 2:  1a4feff2aea doc: allow literal and emphasis format in doc vs help tests
     @@ t/t0450-txt-doc-vs-help.sh: txt_to_synopsis () {
       			/^$/d;
       			/^\[verse\]$/d;
      -
     -+			s/{empty}\|_\|`//g;
     ++			s/_//g;
     ++			s/++//g;
     ++			s/`//g;
       			s/{litdd}/--/g;
       			s/'\''\(git[ a-z-]*\)'\''/\1/g;
       
 3:  310f09fc81c ! 3:  ad7986e4c39 doc: git-init: apply new documentation formatting guidelines
     @@ Documentation/git-init.txt: git-init - Create an empty Git repository or reiniti
      -	  [--ref-format=<format>]
      -	  [-b <branch-name> | --initial-branch=<branch-name>]
      -	  [--shared[=<permissions>]] [<directory>]
     -+`git init` [`-q` | `--quiet`] [`--bare`] [`--template=`{empty}__<template-directory>__]
     -+	  [`--separate-git-dir` _<git-dir>_] [`--object-format=`{empty}__<format>__]
     -+	  [`--ref-format=`{empty}__<format>__]
     -+	  [`-b` _<branch-name>_ | `--initial-branch=`{empty}__<branch-name>__]
     -+	  [`--shared`[`=`{empty}__<permissions>__]] [_<directory>_]
     ++`git init` [`-q` | `--quiet`] [`--bare`] [++--template=++__<template-directory>__]
     ++	  [`--separate-git-dir` _<git-dir>_] [++--object-format=++__<format>__]
     ++	  [++--ref-format=++__<format>__]
     ++	  [`-b` _<branch-name>_ | ++--initial-branch=++__<branch-name>__]
     ++	  [++--shared++[++=++__<permissions>__]] [_<directory>_]
       
       
       DESCRIPTION
     @@ Documentation/git-init.txt: the repository to another place if `--separate-git-d
       current working directory.
       
      ---object-format=<format>::
     -+`--object-format=`{empty}__<format>__::
     ++++--object-format=++__<format>__::
       
       Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
       values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
     @@ Documentation/git-init.txt: the repository to another place if `--separate-git-d
       include::object-format-disclaimer.txt[]
       
      ---ref-format=<format>::
     -+`--ref-format=`{empty}__<format>__::
     ++++--ref-format=++__<format>__::
       
       Specify the given ref storage _<format>_ for the repository. The valid values are:
       +
       include::ref-storage-format.txt[]
       
      ---template=<template-directory>::
     -+`--template=`{empty}__<template-directory>__::
     ++++--template=++__<template-directory>__::
       
       Specify the directory from which templates will be used.  (See the "TEMPLATE
       DIRECTORY" section below.)
       
      ---separate-git-dir=<git-dir>::
     -+`--separate-git-dir=`{empty}__<git-dir>__::
     ++++--separate-git-dir=++__<git-dir>__::
       
       Instead of initializing the repository as a directory to either `$GIT_DIR` or
       `./.git/`, create a text file there containing the path to the actual
     @@ Documentation/git-init.txt: repository.
      --b <branch-name>::
      ---initial-branch=<branch-name>::
      +`-b` _<branch-name>_::
     -+`--initial-branch=`{empty}__<branch-name>__::
     ++++--initial-branch=++__<branch-name>__::
       
       Use _<branch-name>_ for the initial branch in the newly created
       repository.  If not specified, fall back to the default name (currently
     @@ Documentation/git-init.txt: repository.
       customized via the `init.defaultBranch` configuration variable).
       
      ---shared[=(false|true|umask|group|all|world|everybody|<perm>)]::
     -+`--shared`[`=`(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
     ++++--shared++[++=++(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
       
       Specify that the Git repository is to be shared amongst several users.  This
       allows users belonging to the same group to push into that
     -@@ Documentation/git-init.txt: The option can have the following values, defaulting to `group` if no value
     + repository.  When specified, the config variable `core.sharedRepository` is
     + set so that files and directories under `$GIT_DIR` are created with the
     + requested permissions.  When not specified, Git will use permissions reported
     +-by `umask(2)`.
     ++by `umask`(2).
     + +
     + The option can have the following values, defaulting to `group` if no value
       is given:
       +
       --
     @@ Documentation/git-init.txt: The option can have the following values, defaulting
      +`umask`::
      +`false`::
       
     - Use permissions reported by umask(2). The default, when `--shared` is not
     +-Use permissions reported by umask(2). The default, when `--shared` is not
     ++Use permissions reported by `umask`(2). The default, when `--shared` is not
       specified.
       
      -group::
     @@ Documentation/git-init.txt: The option can have the following values, defaulting
      +`group`::
      +`true`::
       
     - Make the repository group-writable, (and g+sx, since the git group may not be
     +-Make the repository group-writable, (and g+sx, since the git group may not be
     ++Make the repository group-writable, (and `g+sx`, since the git group may not be
       the primary group of all users). This is used to loosen the permissions of an
     -@@ Documentation/git-init.txt: permission bits (e.g. if umask is `0022`, using `group` will not remove read
     +-otherwise safe umask(2) value. Note that the umask still applies to the other
     ++otherwise safe `umask`(2) value. Note that the umask still applies to the other
     + permission bits (e.g. if umask is `0022`, using `group` will not remove read
       privileges from other (non-group) users). See `0xxx` for how to exactly specify
       the repository permissions.
       
     @@ Documentation/git-init.txt: permission bits (e.g. if umask is `0022`, using `gro
      +_<perm>_::
       
       _<perm>_ is a 3-digit octal number prefixed with `0` and each file
     - will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
     +-will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
     ++will have mode _<perm>_. _<perm>_ will override users' `umask`(2)
     + value (and not only loosen permissions as `group` and `all`
     + do). `0640` will create a repository which is group-readable, but
     + not group-writable or accessible to others. `0660` will create a repo
 4:  5ae83d3f799 ! 4:  54c2012429d doc: git-clone: apply new documentation guidelines
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: git-clone: apply new documentation guidelines
     -
     -    Heavily apply literal and placeholder markup everywhere.
     +    doc: git-clone: apply new documentation formatting guidelines
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
     @@ Documentation/config/clone.txt
      -clone.defaultRemoteName::
      +`clone.defaultRemoteName`::
       	The name of the remote to create when cloning a repository.  Defaults to
     --	`origin`, and can be overridden by passing the `--origin` command-line
     -+	`origin`.
     -+ifdef::git-clone[]
     -+	It can be overridden by passing the `--origin` command-line
     -+	option.
     -+endif::[]
     -+ifndef::git-clone[]
     -+	It can be overridden by passing the `--origin` command-line
     + 	`origin`, and can be overridden by passing the `--origin` command-line
       	option to linkgit:git-clone[1].
     -+endif::[]
     -+`clone.rejectShallow`::
     -+	Reject cloning a repository if it is a shallow one. This can be overridden by
     -+	passing the `--reject-shallow` option on the command line.
     -+ifndef::git-clone[]
     -+	See linkgit:git-clone[1]
     -+endif::[]
       
      -clone.rejectShallow::
     --	Reject cloning a repository if it is a shallow one; this can be overridden by
     --	passing the `--reject-shallow` option on the command line. See linkgit:git-clone[1]
     --
     ++`clone.rejectShallow`::
     + 	Reject cloning a repository if it is a shallow one; this can be overridden by
     + 	passing the `--reject-shallow` option on the command line. See linkgit:git-clone[1]
     + 
      -clone.filterSubmodules::
      +`clone.filterSubmodules`::
       	If a partial clone filter is provided (see `--filter` in
     @@ Documentation/git-clone.txt: git-clone - Clone a repository into a new directory
      -	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
      -	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
      -	  [<directory>]
     -+`git clone` [`--template=`{empty}__<template-directory>__]
     ++`git clone` [++--template=++__<template-directory>__]
      +	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirror`]
      +	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--reference` _<repository>_]
      +	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
      +	  [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
     -+	  [`--recurse-submodules`[`=`{empty}__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
     ++	  [++--recurse-submodules++[++=++__<pathspec>__]] [`--`[`no-`]`shallow-submodules`]
      +	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--`[`no-`]`reject-shallow`]
     -+	  [`--filter=`{empty}__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
     ++	  [++--filter=++__<filter-spec>__] [`--also-filter-submodules`]] [`--`] _<repository>_
      +	  [_<directory>_]
       
       DESCRIPTION
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	standard error stream is not directed to a terminal.
       
      ---server-option=<option>::
     -+`--server-option=`{empty}__<option>__::
     ++++--server-option=++__<option>__::
       	Transmit the given string to the server when communicating using
       	protocol version 2.  The given string must not contain a NUL or LF
       	character.  The server's handling of server options, including
       	unknown ones, is server-specific.
      -	When multiple `--server-option=<option>` are given, they are all
     -+	When multiple `--server-option=`{empty}__<option>__ are given, they are all
     ++	When multiple ++--server-option=++__<option>__ are given, they are all
       	sent to the other side in the order listed on the command line.
       
      --n::
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	working directory as needed.
       
      ---filter=<filter-spec>::
     -+`--filter=`{empty}__<filter-spec>__::
     ++++--filter=++__<filter-spec>__::
       	Use the partial clone feature and request that the server sends
       	a subset of reachable objects according to a given object filter.
       	When using `--filter`, the supplied _<filter-spec>_ is used for
       	the partial clone filter. For example, `--filter=blob:none` will
       	filter out all blobs (file contents) until needed by Git. Also,
      -	`--filter=blob:limit=<size>` will filter out all blobs of size
     -+	`--filter=blob:limit=`{empty}__<size>__ will filter out all blobs of size
     ++	++--filter=blob:limit=++__<size>__ will filter out all blobs of size
       	at least _<size>_. For more details on filter specifications, see
       	the `--filter` option in linkgit:git-rev-list[1].
       
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	run on the other end.
       
      ---template=<template-directory>::
     -+`--template=`{empty}__<template-directory>__::
     ++++--template=++__<template-directory>__::
       	Specify the directory from which templates will be used;
       	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
       
      --c <key>=<value>::
      ---config <key>=<value>::
     -+`-c` __<key>__{empty}`=`{empty}__<value>__::
     -+`--config` __<key>__{empty}`=`{empty}__<value>__::
     ++`-c` __<key>__++=++__<value>__::
     ++`--config` __<key>__++=++__<value>__::
       	Set a configuration variable in the newly-created repository;
       	this takes effect immediately after the repository is
       	initialized, but before the remote history is fetched or any
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       variables do not take effect until after the initial fetch and checkout.
       Configuration variables known to not take effect are:
      -`remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
     -+`remote.`{empty}__<name>__{empty}`.mirror` and `remote.`{empty}__<name>__{empty}`.tagOpt`.  Use the
     ++++remote.++__<name>__++.mirror++ and ++remote.++__<name>__++.tagOpt++.  Use the
       corresponding `--mirror` and `--no-tags` options instead.
       
      ---depth <depth>::
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	also pass `--shallow-submodules`.
       
      ---shallow-since=<date>::
     -+`--shallow-since=`{empty}__<date>__::
     ++++--shallow-since=++__<date>__::
       	Create a shallow clone with a history after the specified time.
       
      ---shallow-exclude=<revision>::
     -+`--shallow-exclude=`{empty}__<revision>__::
     ++++--shallow-exclude=++__<revision>__::
       	Create a shallow clone with a history, excluding commits
       	reachable from a specified remote branch or tag.  This option
       	can be specified multiple times.
     @@ Documentation/git-clone.txt: the clone is finished. This option is ignored if th
       	in the bundle will be stored under the hidden `refs/bundle/*`
      
       ## Documentation/urls.txt ##
     +@@ Documentation/urls.txt: should be used with caution on unsecured networks.
     + 
     + The following syntaxes may be used with them:
     + 
     +-- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
     +-- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
     +-- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
     +-- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
     ++- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     ++- ++git://++__<host>__{startsb}:__<port>__{endsb}++/++__<path-to-git-repo>__
     ++- ++http++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     ++- ++ftp++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     + 
     + An alternative scp-like syntax may also be used with the ssh protocol:
     + 
     +-- {startsb}user@{endsb}host.xz:path/to/repo.git/
     ++- {startsb}__<user>__++@++{endsb}__<host>__++:/++__<path-to-git-repo>__
     + 
     + This syntax is only recognized if there are no slashes before the
     + first colon. This helps differentiate a local path that contains a
     +@@ Documentation/urls.txt: colon. For example the local path `foo:bar` could be specified as an
     + absolute path or `./foo:bar` to avoid being misinterpreted as an ssh
     + url.
     + 
     +-The ssh and git protocols additionally support ~username expansion:
     ++The ssh and git protocols additionally support ++~++__<username>__ expansion:
     + 
     +-- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
     +-- git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
     +-- {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
     ++- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
     ++- ++git://++__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
     ++- {startsb}__<user>__++@++{endsb}__<host>__++:~++__<user>__++/++__<path-to-git-repo>__
     + 
     + For local repositories, also supported by Git natively, the following
     + syntaxes may be used:
     + 
     +-- /path/to/repo.git/
     +-- \file:///path/to/repo.git/
     ++- `/path/to/repo.git/`
     ++- ++file:///path/to/repo.git/++
     + 
     + ifndef::git-clone[]
     + These two syntaxes are mostly equivalent, except when cloning, when
      @@ Documentation/urls.txt: endif::git-clone[]
       accept a suitable bundle file. See linkgit:git-bundle[1].
       
 -:  ----------- > 5:  38bd78c92eb doc: git-clone: do not autoreference the manpage in itself

-- 
gitgitgadget
