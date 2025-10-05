Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8845E29AB02
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759698712; cv=none; b=Tf7Xh47QZUjNHOMDQXwiJ5s4eyNTuVQ+7DngQrMyvbtWFZgr6BaN5yZHIy6F95shpNCG1iWMGEBFYfiYKkLpwm51PgMNRCElI8BnBSk30Oh8EV9TzzJ8s5IxMNcx9n8OYmAJoqFyP6SjD0lUs4d8czGQvxqrKJKwTZs+rTYOX7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759698712; c=relaxed/simple;
	bh=inaX5fsgJabGHOMfUPW9Qm+fvCOEt+P0/XG02WgCI1c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=Z53Ph9uYWa/M8V38n84VhftUjNpH94PgzS+UY9NQfVYQ94PKxScs5PCp7mCsxpMB5gLn0K5CKi99DuOYyQPShX3lRptn+OfKqfKwMSNfODLVhXvE+IP/9fQuneXwn9/Nbp2QJYEmeJ07ydtwmDcgCeELZkI/FAbzP3dgUTSyDU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KUWPOy1I; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUWPOy1I"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-90926724bceso361126039f.1
        for <git@vger.kernel.org>; Sun, 05 Oct 2025 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759698709; x=1760303509; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diYTBvMAPkL487mbvITlpBUW0JOmhpnS8u2WCbFi0OQ=;
        b=KUWPOy1Igav+jEU4LYFatNt97fOePlpDeeFUyXyFmvLfJlb23DU36uDGSKt+XUh3de
         63D0Ha9qmjgzq1QhHwhXKcAhIJn2JvNYRi5SUWgua3jeSF+3DA3N0pT13lpaA+VSUUWP
         IjyJIf30mbF7ZaWItOYR8yS7iMF2Xa0lwkwHHGdkk3/Gxrom+hrfycemoZdBq2iNwUR7
         seqUbZlzG6hps0+4YRgkCdQCkHohPvIq6NjQJpZs9HYmhtH3d0pjg/A7Yr2vPYXqp9Hm
         cgom5mjKP2VbYzTh47URnJA3vW+bPGQR50Fsnn+cUus79d0zfp58no3P5xOS+EQxuCaS
         7gOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759698709; x=1760303509;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diYTBvMAPkL487mbvITlpBUW0JOmhpnS8u2WCbFi0OQ=;
        b=gkvPz0A6QkL/BhgjjF8rQu4ISGXE8jHW4nkR1cu14aVRKwv+9f7nzvOVSWoINQACCr
         3bhW9ny78445P2ha3GkVGfQ/wlZfdMFUtElJhqD04xPTw7UByK7z3cfc8pYEsdwcPl9r
         u301avcwBq0Kf1BqQbwDx/5GDeBHkQF6lz3wX6TV3rydSA46Jih4tWtp5UMut8hl0jFu
         HETDYF3S/4w8E3rTiVetwcSf5inin2927Hb5/6gw9uq0KHFKJU9jRr+Mi/7xJ+0UHy+y
         NEue4spNJpLQlVaq6vnRhm8OwImMh9EqUG0aAwf9pShfS8XWrbs+6N5IKvvSHRlEmlaW
         e8cQ==
X-Gm-Message-State: AOJu0YyVdHxOD6FfRVIqiJw6xYsBChheq//CsLhQDOlqZadoqJp1yc8M
	iPjNuSTVPNqS32cZ96YKptp8UX6NNvxE5Fimp4TmUziRf1Q1SC3jO1JGg5D1p3Y2
X-Gm-Gg: ASbGnctHM0bsPF8XbM6l0HHrsVHDNBhHKB1/8A2s37YefHrKF/Z/ethnTLMJLzOYIzS
	at7+Hl+7OMk2IdY2F0yZws28RxmCbXLdt2imUyWm6DlzrjBfYzXQeK8YnOJaZ/dW4h+a0lbYdHs
	V38v8DXQW2csV9Sq8vOM9/mXV6I20NgwsMlN3vjssUP5WViXaBxDt2emAlnFPl2ksa8lu0AgLvz
	SsWs6b4iMeObvQ56SyWqAlByz7eImn9nEWTUIL26mr/klq6W+IV02rywgrUjhajEaBBf+XCuB1j
	TezCGV5m5gyvFqqbVDGsTtBPYVvIoM3P/ZXMG2vsMvB/labkajcgWLkShBZ2bOkzKa0R+Z8YzZd
	DpJak9gJUBiFqfs58Q1gN1IWf2gKSB6QVuR2yNsSZeHbYDHht8dBYp48tqHc=
X-Google-Smtp-Source: AGHT+IFicsevkAILr2keIqhlX/NRNKPf4LTyQt1igJeFKxfiHkojnbfSrPVbBwZ6P0c1Ua2jbfworw==
X-Received: by 2002:a92:cda3:0:b0:42d:89b9:5d30 with SMTP id e9e14a558f8ab-42e7ad887d6mr147562415ab.19.1759698709156;
        Sun, 05 Oct 2025 14:11:49 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.193.20])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5f8c432esm4182240173.58.2025.10.05.14.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 14:11:48 -0700 (PDT)
Message-Id: <9d231428eaf45c131a5caddad510d86c5f22fe9b.1759698702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
References: <pull.1969.git.1759698702.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Oct 2025 21:11:41 +0000
Subject: [PATCH 2/3] doc: convert git tag to synopsis style
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
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

- Switch the synopsis to a synopsis block which will automatically
  format placeholders in italics and keywords in monospace
- Use _<placeholder>_ instead of <placeholder> in the description
- Use `backticks` for keywords and more complex option
descriptions. The new rendering engine will apply synopsis rules to
these spans.

Also add the config section in the manual page and do not refer to the man
page in the description of settings when this description is already in the
man page.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/tag.adoc |  22 +++--
 Documentation/git-tag.adoc    | 173 ++++++++++++++++++----------------
 2 files changed, 104 insertions(+), 91 deletions(-)

diff --git a/Documentation/config/tag.adoc b/Documentation/config/tag.adoc
index 5062a057ff..d878da98d4 100644
--- a/Documentation/config/tag.adoc
+++ b/Documentation/config/tag.adoc
@@ -1,17 +1,23 @@
-tag.forceSignAnnotated::
+`tag.forceSignAnnotated`::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
 	precedence over this option.
 
-tag.sort::
-	This variable controls the sort ordering of tags when displayed by
-	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
-	value of this variable will be used as the default.
+`tag.sort`::
+ifdef::git-tag[]
+This variable controls the sort ordering of tags when displayed by `git-tag`.
+endif::git-tag[]
+ifndef::git-tag[]
+This variable controls the sort ordering of tags when displayed by
+linkgit:git-tag[1].
+endif::git-tag[]
+Without the `--sort=<value>` option provided, the value of this variable will
+be used as the default.
 
-tag.gpgSign::
+`tag.gpgSign`::
 	A boolean to specify whether all tags should be GPG signed.
 	Use of this option when running in an automated script can
 	result in a large number of tags being signed. It is therefore
-	convenient to use an agent to avoid typing your gpg passphrase
+	convenient to use an agent to avoid typing your GPG passphrase
 	several times. Note that this option doesn't affect tag signing
-	behavior enabled by "-u <keyid>" or "--local-user=<keyid>" options.
+	behavior enabled by `-u <keyid>` or `--local-user=<keyid>` options.
diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
index a4b1c0ec05..0f7badc116 100644
--- a/Documentation/git-tag.adoc
+++ b/Documentation/git-tag.adoc
@@ -8,21 +8,21 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 
 SYNOPSIS
 --------
-[verse]
-'git tag' [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
+[synopsis]
+git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] [-e]
 	[(--trailer <token>[(=|:)<value>])...]
 	<tagname> [<commit> | <object>]
-'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
+git tag -d <tagname>...
+git tag [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
 	[--points-at <object>] [--column[=<options>] | --no-column]
 	[--create-reflog] [--sort=<key>] [--format=<format>]
 	[--merged <commit>] [--no-merged <commit>] [<pattern>...]
-'git tag' -v [--format=<format>] <tagname>...
+git tag -v [--format=<format>] <tagname>...
 
 DESCRIPTION
 -----------
 
-Add a tag reference in `refs/tags/`, unless `-d/-l/-v` is given
+Add a tag reference in `refs/tags/`, unless `-d`/`-l`/`-v` is given
 to delete, list or verify tags.
 
 Unless `-f` is given, the named tag must not yet exist.
@@ -58,129 +58,129 @@ lightweight tags by default.
 
 OPTIONS
 -------
--a::
---annotate::
+`-a`::
+`--annotate`::
 	Make an unsigned, annotated tag object
 
--s::
---sign::
+`-s`::
+`--sign`::
 	Make a GPG-signed tag, using the default e-mail address's key.
 	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
 	configuration variable if it exists, or disabled otherwise.
 	See linkgit:git-config[1].
 
---no-sign::
+`--no-sign`::
 	Override `tag.gpgSign` configuration variable that is
 	set to force each and every tag to be signed.
 
--u <key-id>::
---local-user=<key-id>::
+`-u <key-id>`::
+`--local-user=<key-id>`::
 	Make a GPG-signed tag, using the given key.
 
--f::
---force::
+`-f`::
+`--force`::
 	Replace an existing tag with the given name (instead of failing)
 
--d::
---delete::
+`-d`::
+`--delete`::
 	Delete existing tags with the given names.
 
--v::
---verify::
+`-v`::
+`--verify`::
 	Verify the GPG signature of the given tag names.
 
--n<num>::
-	<num> specifies how many lines from the annotation, if any,
-	are printed when using -l. Implies `--list`.
+`-n<num>`::
+	_<num>_ specifies how many lines from the annotation, if any,
+	are printed when using `-l`. Implies `--list`.
 +
 The default is not to print any annotation lines.
 If no number is given to `-n`, only the first line is printed.
 If the tag is not annotated, the commit message is displayed instead.
 
--l::
---list::
+`-l`::
+`--list`::
 	List tags. With optional `<pattern>...`, e.g. `git tag --list
 	'v-*'`, list only the tags that match the pattern(s).
 +
-Running "git tag" without arguments also lists all tags. The pattern
-is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
+Running `git tag` without arguments also lists all tags. The pattern
+is a shell wildcard (i.e., matched using `fnmatch`(3)). Multiple
 patterns may be given; if any of them matches, the tag is shown.
 +
 This option is implicitly supplied if any other list-like option such
 as `--contains` is provided. See the documentation for each of those
 options for details.
 
---sort=<key>::
+`--sort=<key>`::
 	Sort based on the key given.  Prefix `-` to sort in
-	descending order of the value. You may use the --sort=<key> option
-	multiple times, in which case the last key becomes the primary
-	key. Also supports "version:refname" or "v:refname" (tag
-	names are treated as versions). The "version:refname" sort
-	order can also be affected by the "versionsort.suffix"
+	descending order of the value. You may use the `--sort=<key>` option
+	multiple times, in which case the last _<key>_ becomes the primary
+	key. Also supports "`version:refname`" or "`v:refname`" (tag
+	names are treated as versions). The "`version:refname`" sort
+	order can also be affected by the "`versionsort.suffix`"
 	configuration variable.
 	The keys supported are the same as those in `git for-each-ref`.
 	Sort order defaults to the value configured for the `tag.sort`
 	variable if it exists, or lexicographic order otherwise. See
 	linkgit:git-config[1].
 
---color[=<when>]::
+`--color[=<when>]`::
 	Respect any colors specified in the `--format` option. The
-	`<when>` field must be one of `always`, `never`, or `auto` (if
-	`<when>` is absent, behave as if `always` was given).
+	_<when>_ field must be one of `always`, `never`, or `auto` (if
+	_<when>_ is absent, behave as if `always` was given).
 
--i::
---ignore-case::
+`-i`::
+`--ignore-case`::
 	Sorting and filtering tags are case insensitive.
 
---omit-empty::
+`--omit-empty`::
 	Do not print a newline after formatted refs where the format expands
 	to the empty string.
 
---column[=<options>]::
---no-column::
+`--column[=<options>]`::
+`--no-column`::
 	Display tag listing in columns. See configuration variable
 	`column.tag` for option syntax. `--column` and `--no-column`
-	without options are equivalent to 'always' and 'never' respectively.
+	without options are equivalent to `always` and `never` respectively.
 +
 This option is only applicable when listing tags without annotation lines.
 
---contains [<commit>]::
-	Only list tags which contain the specified commit (HEAD if not
+`--contains [<commit>]`::
+	Only list tags which contain _<commit>_ (`HEAD` if not
 	specified). Implies `--list`.
 
---no-contains [<commit>]::
-	Only list tags which don't contain the specified commit (HEAD if
+`--no-contains [<commit>]`::
+	Only list tags which don't contain _<commit>_ (`HEAD` if
 	not specified). Implies `--list`.
 
---merged [<commit>]::
-	Only list tags whose commits are reachable from the specified
-	commit (`HEAD` if not specified).
+`--merged [<commit>]`::
+	Only list tags whose commits are reachable from
+	_<commit>_ (`HEAD` if not specified).
 
---no-merged [<commit>]::
-	Only list tags whose commits are not reachable from the specified
-	commit (`HEAD` if not specified).
+`--no-merged [<commit>]`::
+	Only list tags whose commits are not reachable from
+	_<commit>_ (`HEAD` if not specified).
 
---points-at <object>::
-	Only list tags of the given object (HEAD if not
+`--points-at [<object>]`::
+	Only list tags of _<object>_ (`HEAD` if not
 	specified). Implies `--list`.
 
--m <msg>::
---message=<msg>::
-	Use the given tag message (instead of prompting).
+`-m <msg>`::
+`--message=<msg>`::
+	Use _<msg>_ (instead of prompting).
 	If multiple `-m` options are given, their values are
 	concatenated as separate paragraphs.
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
--F <file>::
---file=<file>::
-	Take the tag message from the given file.  Use '-' to
+`-F <file>`::
+`--file=<file>`::
+	Take the tag message from _<file>_.  Use `-` to
 	read the message from the standard input.
 	Implies `-a` if none of `-a`, `-s`, or `-u <key-id>`
 	is given.
 
---trailer <token>[(=|:)<value>]::
-	Specify a (<token>, <value>) pair that should be applied as a
+`--trailer <token>[(=|:)<value>]`::
+	Specify a (_<token>_, _<value>_) pair that should be applied as a
 	trailer. (e.g. `git tag --trailer "Custom-Key: value"`
 	will add a "Custom-Key" trailer to the tag message.)
 	The `trailer.*` configuration variables
@@ -190,46 +190,45 @@ This option is only applicable when listing tags without annotation lines.
 	The trailers can be extracted in `git tag --list`, using
 	`--format="%(trailers)"` placeholder.
 
--e::
---edit::
-	The message taken from file with `-F` and command line with
-	`-m` are usually used as the tag message unmodified.
-	This option lets you further edit the message taken from these sources.
+`-e`::
+`--edit`::
+	Let further edit the message taken from file with `-F` and command line with
+	`-m`.
 
---cleanup=<mode>::
-	This option sets how the tag message is cleaned up.
-	The  '<mode>' can be one of 'verbatim', 'whitespace' and 'strip'.  The
-	'strip' mode is default. The 'verbatim' mode does not change message at
-	all, 'whitespace' removes just leading/trailing whitespace lines and
-	'strip' removes both whitespace and commentary.
+`--cleanup=<mode>`::
+	Set how the tag message is cleaned up.
+	The  _<mode>_ can be one of `verbatim`, `whitespace` and `strip`.  The
+	`strip` mode is default. The `verbatim` mode does not change message at
+	all, `whitespace` removes just leading/trailing whitespace lines and
+	`strip` removes both whitespace and commentary.
 
---create-reflog::
+`--create-reflog`::
 	Create a reflog for the tag. To globally enable reflogs for tags, see
 	`core.logAllRefUpdates` in linkgit:git-config[1].
 	The negated form `--no-create-reflog` only overrides an earlier
 	`--create-reflog`, but currently does not negate the setting of
 	`core.logAllRefUpdates`.
 
---format=<format>::
+`--format=<format>`::
 	A string that interpolates `%(fieldname)` from a tag ref being shown
 	and the object it points at.  The format is the same as
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
-<tagname>::
+_<tagname>_::
 	The name of the tag to create, delete, or describe.
 	The new tag name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a tag name.
 
-<commit>::
-<object>::
+_<commit>_::
+_<object>_::
 	The object that the new tag will refer to, usually a commit.
-	Defaults to HEAD.
+	Defaults to `HEAD`.
 
 CONFIGURATION
 -------------
-By default, 'git tag' in sign-with-default mode (-s) will use your
+By default, `git tag` in sign-with-default mode (`-s`) will use your
 committer identity (of the form `Your Name <your@email.address>`) to
 find a key.  If you want to use a different default key, you can specify
 it in the repository configuration as follows:
@@ -252,7 +251,7 @@ On Re-tagging
 What should you do when you tag a wrong commit and you would
 want to re-tag?
 
-If you never pushed anything out, just re-tag it. Use "-f" to
+If you never pushed anything out, just re-tag it. Use `-f` to
 replace the old one. And you're done.
 
 But if you have pushed things out (or others could just read
@@ -268,12 +267,12 @@ the old tag. In that case you can do one of two things:
 
 . The insane thing.
   You really want to call the new version "X" too, 'even though'
-  others have already seen the old one. So just use 'git tag -f'
+  others have already seen the old one. So just use `git tag -f`
   again, as if you hadn't already published the old one.
 
 However, Git does *not* (and it should not) change tags behind
 users back. So if somebody already got the old tag, doing a
-'git pull' on your tree shouldn't just make them overwrite the old
+`git pull` on your tree shouldn't just make them overwrite the old
 one.
 
 If somebody got a release tag from you, you cannot just change
@@ -325,7 +324,7 @@ private anchor point tags from the other person.
 
 Often, "please pull" messages on the mailing list just provide
 two pieces of information: a repo URL and a branch name; this
-is designed to be easily cut&pasted at the end of a 'git fetch'
+is designed to be easily cut&pasted at the end of a `git fetch`
 command line:
 
 ------------
@@ -403,6 +402,14 @@ FILES
 	user in an editor session will be available in this file, but
 	may be overwritten by the next invocation of `git tag`.
 
+CONFIGURATION
+-------------
+
+include::includes/cmd-config-section-all.adoc[]
+
+:git-tag: 1
+include::config/tag.adoc[]
+
 NOTES
 -----
 
-- 
gitgitgadget

