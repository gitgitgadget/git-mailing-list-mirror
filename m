Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE85AD29E
	for <git@vger.kernel.org>; Sun, 11 Aug 2024 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723389619; cv=none; b=SM7TSTsfcrumoDPHipXsv48hgUZqof5V7axr5hQBsIzqIFcY2JbMkVdMVxe6mNVBLnXd0A4uPVcZmCSCCvclqgMzku4Drp673zV0QkqA8y5Md/fvx8EoRtLKbA1WZaSgVZCiKukqkbqGgfqxKWv2ABYVT+NNQTh2xEYXOPMx8sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723389619; c=relaxed/simple;
	bh=F7zJBalsIEmP+joUVJ/BaLVVyxIjWyg3LSHGF0/q5Hg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=HDre58aTRHSliVigRNvbXtngYXbSYSHvg3leR5cVDN5epERf7YkVHo1Pg0E9L8Cw8k94brplsjGBp3V9bVRLhHocfetixPwdaSIYTXfCF/4N8vmVQWUZti3Iyn6A5EXGG0tuPRQlemXfl0pORPP/aG4JR6K5ozT+xVVFXeadkDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bkx+P5pf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bkx+P5pf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42803bbf842so34679845e9.1
        for <git@vger.kernel.org>; Sun, 11 Aug 2024 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723389615; x=1723994415; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJgSigznHMP7NzHStgwwsxpLbayZmCFyZX7tRAc58iw=;
        b=Bkx+P5pfAqKoJ0sgVKMpi+FF2jec5NpTcAd50Ubk7Nq0i84RH7aLZOCjkv556zDbMA
         vQFGahwrBh42SkEJRy33aUsPKrvJiRDJX9HlbPyYgnWl2QOlipIvWFHySdb8txO7K8NW
         zBCyBDh7UiBy7a3g9Ri2owtFFJmfxAsACmoz/bJRLZh6U04uuF03deu24Q9B03omub4n
         FtuyWlv4TS4zsRtbhM+09paWM+Keo3sy7/i9lRPad2AssAqdG1qYbXy3bMZ4mxoZD94f
         d/9Tft2H9X5qFCu8IuOp6DeJ9Y2/pgKPq7tXuWWqXmHf5ptNsye7AP+9SlEDWP02FrIc
         l80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723389615; x=1723994415;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJgSigznHMP7NzHStgwwsxpLbayZmCFyZX7tRAc58iw=;
        b=DSLup2nmkr5AJW6J1ODQxOdkXkOh1KCm2gX1qygwmsZxQq89nT+yFTTmVGVBvWz5NL
         QwKLm0f9AJFzXEzLbCSYqVtBTu7hintlnDvIP96ZMFkscMwpJPO1OJUYfXlSpTEj35A8
         ngfq0dCOwoutDgW9ntHBOlRWYAIUvFsBMKx/U4dxEJUqm9vwaWz48sXub0ro24CD1tKa
         BAYc/StqOiODYxLq9/01FugIJgnSE8VSBNEUZj93MQsr4ikjwLhuAGzRfBCPGy7f5fBW
         XOY+vy1o9Kl+r/zoG2txgAXLBxEt4ToihlNbhFMAPgyTRiR0KVWRD8ELzksVCYWRWyF6
         m+gQ==
X-Gm-Message-State: AOJu0YxdpaOEq8y9iD/Ar0hMUI1eYI68lv9oZ8VkVk8zDmb77r98+a8N
	aA32h49Ec69jIqT3urxtVl0zc2qfWdyGeRiJNqPTakqjLu3092lmrXRZ9A==
X-Google-Smtp-Source: AGHT+IFdp94UEjOf8Wq9iYBdaQt4KHmZAzIH8TISIVYA1EUB2WWrRGidPKZL3YQKISBJtCAUjsnF/w==
X-Received: by 2002:a05:6000:1844:b0:367:90cc:fe8b with SMTP id ffacd0b85a97d-36d5e7fd9c6mr5756634f8f.27.1723389614157;
        Sun, 11 Aug 2024 08:20:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ecc7b2asm5078110f8f.102.2024.08.11.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 08:20:13 -0700 (PDT)
Message-Id: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
References: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 11 Aug 2024 15:20:09 +0000
Subject: [PATCH v3 0/3] doc: introducing synopsis para
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

Following several issues with the way the formatting of synopsis is done in
the manpages that were recently reworked, this patch series introduces the
processing of a new custom paragraph attribute 'synopsis'. Additionally, as
s macro is introduce to apply the same rules freely in the text.

This extension is added to asciidoc and asciidoctor and lets write the
synopsis of the commands without any typeset. The git-init and git-clone
manpages are converted to this new system.

Changes since V1:

 * switch to sed for asciidoc filter and refine the regex for support under
   macOS

Changes since V2:

 * introduce the s macro to freely apply synopsis styling wherever needed,
   without formatting hassle.

Jean-Noël Avila (3):
  doc: introduce a synopsis custom paragraph attribute
  doc: update the guidelines to reflect the current formatting rules
  doc: apply synopsis simplification on git-clone and git-init

 Documentation/CodingGuidelines          | 54 +++++++++---------
 Documentation/asciidoc.conf             | 21 ++++++-
 Documentation/asciidoctor-extensions.rb | 33 +++++++++++
 Documentation/git-clone.txt             | 76 ++++++++++++-------------
 Documentation/git-init.txt              | 33 +++++------
 Documentation/urls.txt                  | 26 ++++-----
 t/t0450-txt-doc-vs-help.sh              | 11 ++--
 7 files changed, 150 insertions(+), 104 deletions(-)


base-commit: ad57f148c6b5f8735b62238dda8f571c582e0e54
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1766%2Fjnavila%2Fdoc_synopsis_para-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1766/jnavila/doc_synopsis_para-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1766

Range-diff vs v2:

 1:  aba144f4ff3 ! 1:  0d7c1dd8f26 doc: introduce a synopsis custom paragraph attribute
     @@ Commit message
          created and the backends of asciidoc and asciidoctor take in charge to
          correctly add the required typesetting.
      
     +    additionally, a 's' macro ('s' standing for synopsis) is introduced to
     +    allow writers to freely apply automatic styling whereever required.
     +
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/asciidoc.conf ##
     -@@ Documentation/asciidoc.conf: git-relative-html-prefix=
     +@@
     + 
     + [macros]
     + (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
     +-
     ++(?su)[\\]?(?P<name>s):(?P<target>\S*?)\["(?P<attrlist>.*?)"\]=
     + [attributes]
     + asterisk=&#42;
     + plus=&#43;
     +@@ Documentation/asciidoc.conf: ifdef::backend-docbook[]
     + {0#<citerefentry>}
     + {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
     + {0#</citerefentry>}
     ++
     ++[s-inlinemacro]
     ++{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[ |()>]|^|\]|&gt;)(\.?[-a-zA-Z0-9:+=~@,\/]+\.?)',r'\1<literal>\2</literal>', '{attrlist}'))}
     + endif::backend-docbook[]
     + 
     + ifdef::backend-docbook[]
     +@@ Documentation/asciidoc.conf: ifdef::backend-xhtml11[]
     + git-relative-html-prefix=
       [linkgit-inlinemacro]
       <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
     - endif::backend-xhtml11[]
     ++
     ++[s-inlinemacro]
     ++{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[ |()>]|^|\]|&gt;)(\.?[-=a-zA-Z0-9:+,@]+\.?)',r'\1<code>\2</code>', '{attrlist}'))}
     ++
     ++endif::backend-xhtml11[]
      +
      +ifdef::backend-docbook[]
      +ifdef::doctype-manpage[]
      +[paradef-default]
     -+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])([-=a-zA-Z0-9:+.]+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
     ++synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@]+\.?+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
      +endif::doctype-manpage[]
      +endif::backend-docbook[]
      +
      +ifdef::backend-xhtml11[]
      +[paradef-default]
     -+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])([-=a-zA-Z0-9:+.]+)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
     -+endif::backend-xhtml11[]
     ++synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@]+\.?)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
     + endif::backend-xhtml11[]
      
       ## Documentation/asciidoctor-extensions.rb ##
     +@@ Documentation/asciidoctor-extensions.rb: module Git
     +       end
     +     end
     + 
     ++    class SynopsisMacroProcessor < Asciidoctor::Extensions::InlineMacroProcessor
     ++      use_dsl
     ++
     ++      named :s
     ++      match(/s:\["(.+?)"\]/)
     ++
     ++      def process(parent, target, attrs)
     ++        l = target.gsub(/([\[\] |()]|^|&gt;)(\.?[-a-zA-Z0-9:+=~@,\/]+\.?)/, '\1{empty}`\2`{empty}')
     ++                  .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '__\\1__')
     ++                  .gsub(']', ']{empty}')
     ++
     ++        create_inline parent, :quoted, l, attributes: { 'subs' => :normal }
     ++      end
     ++    end
     ++
     +     class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
     +       def process document, output
     +         if document.basebackend? 'docbook'
      @@ Documentation/asciidoctor-extensions.rb: module Git
               output
             end
     @@ Documentation/asciidoctor-extensions.rb: module Git
      +
      +      def process parent, reader, attrs
      +        outlines = reader.lines.map do |l|
     -+          l.gsub(/([\[\] |()>]|^)([-a-zA-Z0-9:+=.]+)/, '\\1{empty}`\\2`{empty}')
     ++          l.gsub(/([\[\] |()>]|^)([-a-zA-Z0-9:+=]+)/, '\1{empty}`\2`{empty}')
      +           .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
      +           .gsub(']', ']{empty}')
      +        end
     @@ Documentation/asciidoctor-extensions.rb: module Git
       
       Asciidoctor::Extensions.register do
         inline_macro Git::Documentation::LinkGitProcessor, :linkgit
     ++  inline_macro Git::Documentation::SynopsisMacroProcessor
      +  block Git::Documentation::SynopsisBlock
         postprocessor Git::Documentation::DocumentPostProcessor
       end
 2:  b6387bef40d ! 2:  92f3121cf4e doc: update the guidelines to reflect the current formatting rules
     @@ Commit message
      
       ## Documentation/CodingGuidelines ##
      @@ Documentation/CodingGuidelines: Markup:
     +    _<key-id>_
     + 
     +  When literal and placeholders are mixed, each markup is applied for
     +- each sub-entity. If they are stuck, a special markup, called
     +- unconstrained formatting is required.
     +- Unconstrained formating for placeholders is __<like-this>__
     +- Unconstrained formatting for literal formatting is ++like this++
     +-   `--jobs` _<n>_
     +-   ++--sort=++__<key>__
     +-   __<directory>__++/.git++
     +-   ++remote.++__<name>__++.mirror++
     +-
     +- caveat: ++ unconstrained format is not verbatim and may expand
     +- content. Use Asciidoc escapes inside them.
     ++ each sub-entity. If the formatting is becoming too hairy, you can use the
     ++ s:["foo"] formatting macro and let it format the groups for you.
     ++   `--jobs` _<n>_ or s:["--jobs <n>"]
     ++   s:["--sort=<key>
     ++   s:["<directory>/.git"]
     ++   s:["remote.<name>.mirror"]
     ++   s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
     ++
     ++Note that the double-quotes are required by the macro.
       
       Synopsis Syntax
       
 3:  2a61e0945de ! 3:  02406b91894 doc: apply synopsis simplification on git-clone and git-init
     @@ Documentation/git-clone.txt: git-clone - Clone a repository into a new directory
       
       DESCRIPTION
       -----------
     +@@ Documentation/git-clone.txt: prevent the unintentional copying of files by dereferencing the symbolic
     + links.
     + +
     + *NOTE*: this operation can race with concurrent modification to the
     +-source repository, similar to running `cp -r src dst` while modifying
     +-`src`.
     ++source repository, similar to running s:["cp -r <src> <dst>"] while modifying
     ++_<src>_.
     + 
     + `--no-hardlinks`::
     + 	Force the cloning process from a repository on a local
     +@@ Documentation/git-clone.txt: If you want to break the dependency of a repository cloned with `--shared` on
     + its source repository, you can simply run `git repack -a` to copy all
     + objects from the source repository into a pack in the cloned repository.
     + 
     +-`--reference`[`-if-able`] _<repository>_::
     ++s:["--reference[-if-able] <repository>"]::
     + 	If the reference _<repository>_ is on the local machine,
     + 	automatically setup `.git/objects/info/alternates` to
     + 	obtain objects from the reference _<repository>_.  Using
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + 	is specified. This flag forces progress status even if the
     + 	standard error stream is not directed to a terminal.
     + 
     +-++--server-option=++__<option>__::
     ++s:["--server-option=<option>"]::
     + 	Transmit the given string to the server when communicating using
     + 	protocol version 2.  The given string must not contain a NUL or LF
     + 	character.  The server's handling of server options, including
     + 	unknown ones, is server-specific.
     +-	When multiple ++--server-option=++__<option>__ are given, they are all
     ++	When multiple s:["--server-option=<option>"] are given, they are all
     + 	sent to the other side in the order listed on the command line.
     + 
     + `-n`::
     + `--no-checkout`::
     +-	No checkout of HEAD is performed after the clone is complete.
     ++	No checkout of `HEAD` is performed after the clone is complete.
     + 
     + `--`[`no-`]`reject-shallow`::
     + 	Fail if the source repository is a shallow repository.
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + `--bare`::
     + 	Make a 'bare' Git repository.  That is, instead of
     + 	creating _<directory>_ and placing the administrative
     +-	files in _<directory>_`/.git`, make the _<directory>_
     ++	files in s:["<directory>/.git"], make the _<directory>_
     + 	itself the `$GIT_DIR`. This obviously implies the `--no-checkout`
     + 	because there is nowhere to check out the working tree.
     + 	Also the branch heads at the remote are copied directly
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + 	linkgit:git-sparse-checkout[1] command can be used to grow the
     + 	working directory as needed.
     + 
     +-++--filter=++__<filter-spec>__::
     ++s:["--filter=<filter-spec>"]::
     + 	Use the partial clone feature and request that the server sends
     + 	a subset of reachable objects according to a given object filter.
     + 	When using `--filter`, the supplied _<filter-spec>_ is used for
     + 	the partial clone filter. For example, `--filter=blob:none` will
     + 	filter out all blobs (file contents) until needed by Git. Also,
     +-	++--filter=blob:limit=++__<size>__ will filter out all blobs of size
     ++	s:["--filter=blob:limit=<size>"] will filter out all blobs of size
     + 	at least _<size>_. For more details on filter specifications, see
     + 	the `--filter` option in linkgit:git-rev-list[1].
     + 
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + 
     + `-b` _<name>_::
     + `--branch` _<name>_::
     +-	Instead of pointing the newly created HEAD to the branch pointed
     +-	to by the cloned repository's HEAD, point to _<name>_ branch
     ++	Instead of pointing the newly created `HEAD` to the branch pointed
     ++	to by the cloned repository's `HEAD`, point to _<name>_ branch
     + 	instead. In a non-bare repository, this is the branch that will
     + 	be checked out.
     +-	`--branch` can also take tags and detaches the HEAD at that commit
     ++	`--branch` can also take tags and detaches the `HEAD` at that commit
     + 	in the resulting repository.
     + 
     + `-u` _<upload-pack>_::
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + 	via ssh, this specifies a non-default path for the command
     + 	run on the other end.
     + 
     +-++--template=++__<template-directory>__::
     ++s:["--template=<template-directory>"]::
     + 	Specify the directory from which templates will be used;
     + 	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
     + 
     +-`-c` __<key>__++=++__<value>__::
     +-`--config` __<key>__++=++__<value>__::
     ++`-c` s:["<key>=<value>"]::
     ++`--config` s:["<key>=<value>"]::
     + 	Set a configuration variable in the newly-created repository;
     + 	this takes effect immediately after the repository is
     + 	initialized, but before the remote history is fetched or any
     +@@ Documentation/git-clone.txt: objects from the source repository into a pack in the cloned repository.
     + Due to limitations of the current implementation, some configuration
     + variables do not take effect until after the initial fetch and checkout.
     + Configuration variables known to not take effect are:
     +-++remote.++__<name>__++.mirror++ and ++remote.++__<name>__++.tagOpt++.  Use the
     ++s:["remote.<name>.mirror"] and s:["remote.<name>.tagOpt"].  Use the
     + corresponding `--mirror` and `--no-tags` options instead.
     + 
     +-`--depth` _<depth>_::
     ++s:["--depth <depth>"]::
     + 	Create a 'shallow' clone with a history truncated to the
     + 	specified number of commits. Implies `--single-branch` unless
     + 	`--no-single-branch` is given to fetch the histories near the
     + 	tips of all branches. If you want to clone submodules shallowly,
     + 	also pass `--shallow-submodules`.
     + 
     +-++--shallow-since=++__<date>__::
     ++s:["--shallow-since=<date>"]::
     + 	Create a shallow clone with a history after the specified time.
     + 
     +-++--shallow-exclude=++__<revision>__::
     ++s:["--shallow-exclude=<revision>"]::
     + 	Create a shallow clone with a history, excluding commits
     + 	reachable from a specified remote branch or tag.  This option
     + 	can be specified multiple times.
     + 
     +-`--`[`no-`]`single-branch`::
     ++s:["--[no-]single-branch"]::
     + 	Clone only the history leading to the tip of a single branch,
     + 	either specified by the `--branch` option or the primary
     + 	branch remote's `HEAD` points at.
     +@@ Documentation/git-clone.txt: corresponding `--mirror` and `--no-tags` options instead.
     + 
     + `--no-tags`::
     + 	Don't clone any tags, and set
     +-	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
     ++	s:["remote.<remote>.tagOpt=--no-tags"] in the config, ensuring
     + 	that future `git pull` and `git fetch` operations won't follow
     + 	any tags. Subsequent explicit tag fetches will still work,
     + 	(see linkgit:git-fetch[1]).
     +@@ Documentation/git-clone.txt: maintain a branch with no references other than a single cloned
     + branch. This is useful e.g. to maintain minimal clones of the default
     + branch of some repository for search indexing.
     + 
     +-`--recurse-submodules`[`=`{empty}__<pathspec>__]::
     ++s:["--recurse-submodules[=<pathspec>]"]::
     + 	After the clone is created, initialize and clone submodules
     + 	within based on the provided _<pathspec>_.  If no _=<pathspec>_ is
     + 	provided, all submodules are initialized and cloned.
     +@@ Documentation/git-clone.txt: branch of some repository for search indexing.
     + +
     + Submodules are initialized and cloned using their default settings. This is
     + equivalent to running
     +-`git submodule update --init --recursive <pathspec>` immediately after
     ++s:["git submodule update --init --recursive <pathspec>"] immediately after
     + the clone is finished. This option is ignored if the cloned repository does
     + not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
     + or `--mirror` is given)
     + 
     +-`--`[`no-`]`shallow-submodules`::
     ++s:["--[no-]shallow-submodules"]::
     + 	All submodules which are cloned will be shallow with a depth of 1.
     + 
     +-`--`[`no-`]`remote-submodules`::
     ++s:["--[no-]remote-submodules"]::
     + 	All submodules which are cloned will use the status of the submodule's
     + 	remote-tracking branch to update the submodule, rather than the
     + 	superproject's recorded SHA-1. Equivalent to passing `--remote` to
     + 	`git submodule update`.
     + 
     +-`--separate-git-dir=`{empty}__<git-dir>__::
     ++s:["--separate-git-dir=<git-dir>"]::
     + 	Instead of placing the cloned repository where it is supposed
     + 	to be, place the cloned repository at the specified directory,
     + 	then make a filesystem-agnostic Git symbolic link to there.
     + 	The result is Git repository can be separated from working
     + 	tree.
     + 
     +-`--ref-format=`{empty}__<ref-format>__::
     ++s:["--ref-format=<ref-format>"]::
     + 
     + Specify the given ref storage format for the repository. The valid values are:
     + +
     +@@ Documentation/git-clone.txt: _<directory>_::
     + 	for `host.xz:foo/.git`).  Cloning into an existing directory
     + 	is only allowed if the directory is empty.
     + 
     +-`--bundle-uri=`{empty}__<uri>__::
     ++s:["--bundle-uri=<uri>"]::
     + 	Before fetching from the remote, fetch a bundle from the given
     + 	_<uri>_ and unbundle the data into the local repository. The refs
     + 	in the bundle will be stored under the hidden `refs/bundle/*`
      
       ## Documentation/git-init.txt ##
      @@ Documentation/git-init.txt: git-init - Create an empty Git repository or reinitialize an existing one
     @@ Documentation/git-init.txt: git-init - Create an empty Git repository or reiniti
       
       
       DESCRIPTION
     +@@ Documentation/git-init.txt: directory with subdirectories for `objects`, `refs/heads`,
     + commits will be created (see the `--initial-branch` option below
     + for its name).
     + 
     +-If the `$GIT_DIR` environment variable is set then it specifies a path
     ++If the `GIT_DIR` environment variable is set then it specifies a path
     + to use instead of `./.git` for the base of the repository.
     + 
     + If the object storage directory is specified via the
     +-`$GIT_OBJECT_DIRECTORY` environment variable then the sha1 directories
     ++`GIT_OBJECT_DIRECTORY` environment variable then the sha1 directories
     + are created underneath; otherwise, the default `$GIT_DIR/objects`
     + directory is used.
     + 
     +@@ Documentation/git-init.txt: Only print error and warning messages; all other output will be suppressed.
     + Create a bare repository. If `GIT_DIR` environment is not set, it is set to the
     + current working directory.
     + 
     +-++--object-format=++__<format>__::
     +-
     ++s:["--object-format=<format>"]::
     + Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
     + values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
     + +
     + include::object-format-disclaimer.txt[]
     + 
     +-++--ref-format=++__<format>__::
     +-
     ++s:["--ref-format=<format>"]::
     + Specify the given ref storage _<format>_ for the repository. The valid values are:
     + +
     + include::ref-storage-format.txt[]
     + 
     +-++--template=++__<template-directory>__::
     +-
     ++s:["--template=<template-directory>"]::
     + Specify the directory from which templates will be used.  (See the "TEMPLATE
     + DIRECTORY" section below.)
     + 
     +-++--separate-git-dir=++__<git-dir>__::
     +-
     ++s:["--separate-git-dir=<git-dir>"]::
     + Instead of initializing the repository as a directory to either `$GIT_DIR` or
     + `./.git/`, create a text file there containing the path to the actual
     + repository.  This file acts as a filesystem-agnostic Git symbolic link to the
     +@@ Documentation/git-init.txt: repository.
     + If this is a reinitialization, the repository will be moved to the specified path.
     + 
     + `-b` _<branch-name>_::
     +-++--initial-branch=++__<branch-name>__::
     +-
     ++s:["--initial-branch=<branch-name>"]::
     + Use _<branch-name>_ for the initial branch in the newly created
     + repository.  If not specified, fall back to the default name (currently
     + `master`, but this is subject to change in the future; the name can be
     + customized via the `init.defaultBranch` configuration variable).
     + 
     +-++--shared++[++=++(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
     ++s:["--shared[=(false|true|umask|group|all|world|everybody|<perm>)]"]::
     + 
     + Specify that the Git repository is to be shared amongst several users.  This
     + allows users belonging to the same group to push into that
     +
     + ## Documentation/urls.txt ##
     +@@ Documentation/urls.txt: Git supports ssh, git, http, and https protocols (in addition, ftp
     + and ftps can be used for fetching, but this is inefficient and
     + deprecated; do not use them).
     + 
     +-The native transport (i.e. git:// URL) does no authentication and
     ++The native transport (i.e. `git://` URL) does no authentication and
     + should be used with caution on unsecured networks.
     + 
     + The following syntaxes may be used with them:
     + 
     +-- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     +-- ++git://++__<host>__{startsb}:__<port>__{endsb}++/++__<path-to-git-repo>__
     +-- ++http++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     +-- ++ftp++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     ++- s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
     ++- s:["git://<host>[:<port>]/<path-to-git-repo>"]
     ++- s:["http[s]://<host>[:<port>]/<path-to-git-repo>"]
     ++- s:["ftp[s]://<host>[:<port>]/<path-to-git-repo>"]
     + 
     + An alternative scp-like syntax may also be used with the ssh protocol:
     + 
     +-- {startsb}__<user>__++@++{endsb}__<host>__++:/++__<path-to-git-repo>__
     ++- s:["[<user>@]<host>:/<path-to-git-repo>"]
     + 
     + This syntax is only recognized if there are no slashes before the
     + first colon. This helps differentiate a local path that contains a
     +@@ Documentation/urls.txt: colon. For example the local path `foo:bar` could be specified as an
     + absolute path or `./foo:bar` to avoid being misinterpreted as an ssh
     + url.
     + 
     +-The ssh and git protocols additionally support ++~++__<username>__ expansion:
     ++The ssh and git protocols additionally support s:["~<username>"] expansion:
     + 
     +-- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
     +-- ++git://++__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
     +-- {startsb}__<user>__++@++{endsb}__<host>__++:~++__<user>__++/++__<path-to-git-repo>__
     ++- s:["ssh://[<user>@]<host>[:<port>]/~<user>/<path-to-git-repo>"]
     ++- s:["git://<host>[:<port>]/~<user>/<path-to-git-repo>"]
     ++- s:["[<user>@]<host>:~<user>/<path-to-git-repo>"]
     + 
     + For local repositories, also supported by Git natively, the following
     + syntaxes may be used:
     + 
     + - `/path/to/repo.git/`
     +-- ++file:///path/to/repo.git/++
     ++- `file:///path/to/repo.git/`
     + 
     + ifndef::git-clone[]
     + These two syntaxes are mostly equivalent, except when cloning, when
     +@@ Documentation/urls.txt: endif::git-clone[]
     + accept a suitable bundle file. See linkgit:git-bundle[1].
     + 
     + When Git doesn't know how to handle a certain transport protocol, it
     +-attempts to use the `remote-`{empty}__<transport>__ remote helper, if one
     ++attempts to use the s:["remote-<transport>"] remote helper, if one
     + exists. To explicitly request a remote helper, the following syntax
     + may be used:
     + 
     +-- _<transport>_::__<address>__
     ++- s:["<transport>::<address>"]
     + 
     + where _<address>_ may be a path, a server and path, or an arbitrary
     + URL-like string recognized by the specific remote helper being

-- 
gitgitgadget
