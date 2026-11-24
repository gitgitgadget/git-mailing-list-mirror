Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556945;
	b=pSnHGgauL+QsDbe2Q2rvYLgPrb7UyY2Rgh26ISMR9Rez/ZQm2m4BLi+kayMEoOBCmB0r
	 J6M4vpzHa0oN5B3GQhihwP9nEoOYHxKpnX4NiZsuro49T0PWi4wklkBzS4OQE6hDUwrRx
	 BnNV1+yk0/r/gVm68eWyDkU4NnYTMRrYd2Hr1JukGzLZAWTorrYUJRxs/j5VYx4grlpmb
	 eLzwjV2Y758H/MGwlFA5UfnhDGNKhzg9h6N3MOwdQPDC6yFVVM/Zh9R9tTAVijXO6IJ+9
	 k5l9WRxNRG9beElHTiV1Pu0BGhjE2ajo9V0bxEcMtiU4wzFkQTUHMZhtf83biGTSfkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Fcc:To:Cc;
	bh=JNrJ0SzdC/sgBEIMGDG/O32b8zzhT2U+fbi01NeACCk=;
	b=yf68pLyaVZrDRk/hjlv7BUBx+BmBjNa+0JsMOVAAX9jz0Ylblyv+JXAIch1nDRnbR7xn
	 /EyK/n5fL9a4WyH9dXGAY0OK+lXt+gJIsC0hLdunJd1hl9xAeG+pK6VxPlROfpiVmjmmO
	 va07tIssJwDRsC/VvINfJu+jxrOelcRnnlSF9iq6u3Wf3CPaeyQuW2DlT2tm+3XPFF0PL
	 Ug1h48wTC/uBBCnO3GJWa9albgLQZygfKQYsq9FoIU2NQkQu05OlFf/cITgieHHhsAORy
	 wJa6rvxTUHC8x/i6oC5VRGvMjjpKtyiHnLxBHVlKK2E/GeHRj1ofR86uPmsc5nvgHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJC0EfBK;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A606606A331
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 21:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A606606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aJC0EfBK
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-71b47eede22so2829328eaf.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556944; x=1796161744; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JNrJ0SzdC/sgBEIMGDG/O32b8zzhT2U+fbi01NeACCk=;
        b=aJC0EfBKYKz6aE6GeqjJrX6KRGtDmK1THXzkrdssh4g3OSyyriz5qhVhAvXW3oETza
         VVeo5JRiqDuvPEMwDwIMd9rNLEip6r06hJE7m70MoFK0vn0eAw/IttmHnqoqwsfAbQfX
         WwAAtrEbZVDDzV4Jt7XJIxAZXUa/1ty9dgUq9z5EK4Ty81qYCG48v+mJm/5M6ncGEWD+
         8OGL1y/C7Iw281u1HQpY+BjYcdXZCxItFgR+IN3ErVTO+JlhBuCg+MhS0g/QeXMdvToG
         QFJoVnNQgUZZLiBqPt4ArcHroR45HvDfI8RshMbp4+SivHHqMJ6TGEFcU6y8XbEq+usr
         warQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556944; x=1796161744;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JNrJ0SzdC/sgBEIMGDG/O32b8zzhT2U+fbi01NeACCk=;
        b=s6EL9Q/pq3lyb2VTZEjoz7Q4ngiHxN8PljrQd/GJ8kNTqV3deLoyTggZ5wb7BnFxO8
         +EKHWnXIuW1pm6Rb6M3LjdCNw6bJID7zGbBpRws7Fh8ffibiiASUa9Gj5p9zDOTGDAF8
         i7DZa7A0nxRW5hZ6jltyNkwY4i7JhAtF4YDWHvcZlZD+id2jUjmyBtu3xWZEF7ND3jYR
         K5Dsk3htbn6duyRfD2lrkh7iF+nvcOTI6MLrTYswH4PlcNCqCKh/6HwfBKlf+x0WnJAQ
         vz5wF90y0A/4BBGG0Z6VoWDThoSbgb+YbxjzuaOeCnQ7buBW6qZgP/8TGeDB4ScnWdob
         qkEg==
X-Gm-Message-State: APuU4Z/datxUL7uq1MgTPewuJbH64LnZx5mXqQOsAeB2BLCvtAoRtwPd
	Gv2nockYWJv3s7v/Zb4/Sqt0lQA+RCYh9kgIQ0zGCvukSlirBKsgynTbDLAaGw==
X-Gm-Gg: AZFdTZcrR24yWXV8qX1ebftRzrANbII/aRSLGEqFKyP7yiWOCernJVJmcQDozsbjUbT
	FGClEc8NMo3EVy9+0EjkizaNDQNFZ68A8YgJvrcgm68aY2LvpG9/iqiHkk2H2XhYN54W8b5gr5o
	raPC+/6Kge/577grzG2H4UHnjwQ2Uqcww2nE0bQ4MSgYt0XQjQAxnbjEht8l9Vra1YKof1fXTI+
	2LCkYx96xL/723491wabFYVxbs2wALufGirrHP5OK9f7E9lBqb4QOxg6TN+3QSZun2wN9O+8+ir
	hbkZvV/GJCG3YFG/L1Ppn9uOAt1MYYG0wNx9rsQkjiSyGFbu54FajeDKh9kREPtODo7b/VXNiqi
	duy8g8CdALc1FSWnwGYyPGWbLFVWhfFBKMosRuV0J6feZ4/7jea05BRa8YSQodPvaxfL3eh/1QJ
	hf5JC93tzAVNnB6r6FJ8PaT7LsOZMumX4q9XhY3676v6NdVzbK/xdjTaO2rRsRJbZO5L4ZUpNAy
	IpD412NatbPyg80J+oNMA6zo0AlowuydcX22H+aio4D4wSGeSUE8XwuOrYysVK02kg1ngSCM9BI
	AvUunv92TbrquQaXvWYRHJGWi0fQmPPd
X-Received: by 2002:a05:6820:a006:b0:6cd:3ffc:ad02 with SMTP id 006d021491bc7-71b3959e7cfmr10788060eaf.82.1795556944004;
        Tue, 24 Nov 2026 13:49:04 -0800 (PST)
Received: from [127.0.0.1] ([40.80.212.165])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b37ea818bsm10615296eaf.1.2026.11.24.13.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:49:03 -0800 (PST)
Message-Id: <b6063c41e563697340d000969f61ce23f962d73b.1795556940.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
References: <pull.2324.git.1795556940.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 21:48:58 +0000
Subject: [PATCH 2/4] doc: git-svn: add missing config options to the
 documentation
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The configuration options of git-svn are not treated like the other
configuration options in the documentation. They are not listed in the
config.adoc file and they are not documented in a dedicated file.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config.adoc     |   2 +
 Documentation/config/svn.adoc | 175 ++++++++++++++++++++++++++++++++++
 Documentation/git-svn.adoc    |  87 +----------------
 3 files changed, 178 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/config/svn.adoc

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index aa6360e230..c853578cac 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -610,6 +610,8 @@ include::config/status.adoc[]
 
 include::config/submodule.adoc[]
 
+include::config/svn.adoc[]
+
 include::config/tag.adoc[]
 
 include::config/tar.adoc[]
diff --git a/Documentation/config/svn.adoc b/Documentation/config/svn.adoc
new file mode 100644
index 0000000000..19df43cf58
--- /dev/null
+++ b/Documentation/config/svn.adoc
@@ -0,0 +1,175 @@
+`svn.addAuthorFrom`::
+	Append a `From:` line based on the Git commit's author string when
+	committing to SVN from Git (as part of `set-tree` or `dcommit`
+	operations), if the existing log message doesn't already have a `From:`
+	or `Signed-off-by` trailer.  Using this together with `svn.useLogAuthor`
+	will retrieve a valid author string for all commits.
+
+`svn.authorsfile`::
+	Specify the path to the authors file used to map SVN committer names to
+	Git author identities.  The file uses the same syntax as `git cvsimport`,
+	with an optional empty email address written as `<>`.  If set and `git svn`
+	encounters an SVN committer name not present in the file, the operation
+	is aborted until the entry is added.
+
+`svn.authorsProg`::
+	Specify a program to execute for each SVN committer name not found in
+	the authors file.  The committer name is passed as the first argument;
+	the program must return a single line of the form `Name <email>` or
+	`Name <>`, which is treated as if it were an entry in the authors file.
++
+Due to historical reasons a relative filename is first searched relative
+to the current directory for `init` and `clone` and relative to the root
+of the working tree for `fetch`. If the filename is not found, it is
+searched like any other command in `$PATH`.
+
+`svn.edit`::
+	Open an editor for the commit message before committing to SVN.
+	This is off by default for commit objects and forced on when
+	committing tree objects.  Used with the `dcommit`, `set-tree` and
+	`commit-diff` commands.
+
+`svn.findcopiesharder`::
+`svn.l`::
+	Pass `--find-copies-harder` and `-l<num>` directly to
+	linkgit:git-diff-tree[1].  Used with the `dcommit`, `set-tree` and
+	`commit-diff` commands.
+
+`svn.followparent`::
+	Track the copy history of each tracked branch to determine a suitable
+	parent for the first Git commit on the branch.  This is especially
+	helpful when tracking a directory that has been moved around within the
+	repository.  Disabling this feature may speed up cloning.
+	Enabled by default; set to `false` to disable.
+
+`svn.noMetadata`::
+`svn-remote.<name>.noMetadata`::
+	Remove the `git-svn-id:` lines at the end of every commit.
++
+This option can only be used for one-shot imports as `git svn`
+will not be able to fetch again without metadata. Additionally,
+if you lose your `$GIT_DIR/svn/**/.rev_map.*` files, `git svn` will not
+be able to rebuild them.
++
+The `git svn log` command will not work on repositories using
+this, either.  Using this conflicts with the `useSvmProps`
+option for (hopefully) obvious reasons.
++
+This option is NOT recommended as it makes it difficult to track down
+old references to SVN revision numbers in existing documentation, bug
+reports, and archives.  If you plan to eventually migrate from SVN to
+Git and are certain about dropping SVN history, consider
+https://github.com/newren/git-filter-repo[git-filter-repo] instead.
+filter-repo also allows reformatting of metadata for ease-of-reading
+and rewriting authorship info for non-"svn.authorsFile" users.
+
+`svn.pushmergeinfo`::
+	Cause `git svn` to attempt to automatically populate the
+	`svn:mergeinfo` property in the SVN repository when possible.
+	Currently this can only be done when dcommitting non-fast-forward
+	merges where all parents but the first have already been pushed into SVN.
+
+`svn.rmdir`::
+	Remove directories from the SVN tree when they contain no files.
+	SVN can version empty directories; they are not removed by default
+	when all files are deleted.  Since Git cannot track empty directories,
+	enabling this flag makes commits to SVN behave more like Git.
+	Used with the `dcommit`, `set-tree` and `commit-diff` commands.
+
+`svn.useLogAuthor`::
+	Use the first `From:` line or `Signed-off-by` trailer found in the
+	log message as the author string when retrieving SVN commits into Git
+	(as part of `fetch`, `rebase`, or `dcommit` operations).
+
+`svn.useSvmProps`::
+`svn-remote.<name>.useSvmProps`::
+	Re-map repository URLs and UUIDs from mirrors created using SVN::Mirror
+	(or svk) for metadata.
++
+If an SVN revision has a property, `svm:headrev`, it is likely
+that the revision was created by SVN::Mirror (also used by SVK).
+The property contains a repository UUID and a revision.  We want
+to make it look like we are mirroring the original URL, so
+introduce a helper function that returns the original identity
+URL and UUID, and use it when generating metadata in commit
+messages.
+
+`svn.useSvnsyncProps`::
+`svn-remote.<name>.useSvnsyncprops`::
+	Re-map repository URLs and UUIDs for users of the `svnsync`(1) command
+	distributed with SVN 1.4.x and later, similar to the `useSvmProps` option.
+
+`svn.brokenSymlinkWorkaround`::
+	Disable potentially expensive checks to workaround broken symlinks checked
+	into SVN by broken clients.  Set this option to `false` if you track a
+	SVN repository with many empty blobs that are not symlinks.  This option
+	may be changed while `git svn` is running and take effect on the next
+	revision fetched.  If unset, `git svn` assumes this option to be `true`.
+
+`svn.pathnameencoding`::
+	Recode pathnames to a given encoding.
+	It can be used by Windows users and by those who work in non-UTF-8
+	locales to avoid corrupted file names with non-ASCII characters.
+	Valid encodings are the ones supported by Perl's Encode module.
+
+`svn-remote.<name>.automkdirs`::
+	Recreate empty directories that are in the Subversion repository.
+	Normally, the `git svn clone` and `git svn rebase` commands attempt to
+	do this automatically.  If this option is set to `false`, then empty
+	directories will only be created if the `git svn mkdirs` command is run
+	explicitly.  If unset, `git svn` assumes this option to be `true`.
+
+`svn-remote.<name>.commiturl`::
+`svn.commiturl`::
+	Specify the URL to use when committing to SVN (the full path).
+	`svn.commiturl` overrides the value for all `svn-remote.<name>.commiturl`
+	entries.  This allows repositories created with one transport method
+	(e.g. `svn://` or `http://` for anonymous read) to commit via an alternate
+	transport (e.g. `svn+ssh://` or `https://`).
++
+Note that the SVN URL of `commiturl` includes the SVN branch.  To set the
+commit URL for an entire SVN repository use `svn-remote.<name>.pushurl` instead.
++
+Using this option for any other purpose (don't ask) is very strongly discouraged.
+
+`svn-remote.<name>.ignore-paths`::
+	Specify a Perl regular expression to skip matching paths when
+	checking out from SVN.  The pattern is applied on every `fetch`,
+	including automatic fetches triggered by `clone`, `dcommit`,
+	`rebase`, etc.  If both this key and the `--ignore-paths` command-line
+	option are given, both regular expressions are applied.
+
+`svn-remote.<name>.ignore-refs`::
+	Specify a Perl regular expression to ignore matching branch or tag refs
+	when fetching.  A negative look-ahead assertion such as
+	`^refs/remotes/origin/(?!tags/wanted-tag|wanted-branch).*$`
+	can be used to allow only certain refs.  If both this key and the
+	`--ignore-refs` command-line option are given, both regular expressions
+	are applied.
+
+`svn-remote.<name>.include-paths`::
+	Specify a Perl regular expression so that only matching paths are
+	included when checking out from SVN.  The pattern is applied on every
+	`fetch`, including automatic fetches triggered by `clone`, `dcommit`,
+	`rebase`, etc.  `svn-remote.<name>.ignore-paths` takes precedence over
+	this key.
+
+`svn-remote.<name>.pushurl`::
+	Provide an alternate read/write transport for the SVN repository,
+	similar to Git's `remote.<name>.pushurl`.  This key is designed
+	to be used in cases where `url` points to an SVN repository
+	via a read-only transport. It is assumed that both keys point to the same
+	repository. Unlike `commiturl`, `pushurl` is a base path. If
+	either `commiturl` or `pushurl` could be used, `commiturl`
+	takes precedence.
+
+`svn-remote.<name>.rewriteRoot`::
+	Create repositories from alternate URLs.  For example, an administrator
+	could run `git svn` on the server locally (accessing via `file://`) but
+	wish to distribute the repository with a public `http://` or `svn://` URL
+	in the metadata so users of it will see the public URL.
+
+`svn-remote.<name>.rewriteUUID`::
+	Remap the UUID manually, similar to the `useSvmProps` option.
+	This may be useful in situations where the original UUID is not available
+	via either `useSvmProps` or `useSvnsyncProps`.
diff --git a/Documentation/git-svn.adoc b/Documentation/git-svn.adoc
index 597697d42d..ff8a3c2d39 100644
--- a/Documentation/git-svn.adoc
+++ b/Documentation/git-svn.adoc
@@ -756,92 +756,7 @@ config key: `svn.followparent`
 CONFIG FILE-ONLY OPTIONS
 ------------------------
 
-`svn.noMetadata`::
-`svn-remote.<name>.noMetadata`::
-	Remove the `git-svn-id:` lines at the end of every commit.
-+
-This option can only be used for one-shot imports as `git svn`
-will not be able to fetch again without metadata. Additionally,
-if you lose your `$GIT_DIR/svn/\**/.rev_map.*` files, `git svn` will not
-be able to rebuild them.
-+
-The `git svn log` command will not work on repositories using
-this, either.  Using this conflicts with the `useSvmProps`
-option for (hopefully) obvious reasons.
-+
-This option is NOT recommended as it makes it difficult to track down
-old references to SVN revision numbers in existing documentation, bug
-reports, and archives.  If you plan to eventually migrate from SVN to
-Git and are certain about dropping SVN history, consider
-https://github.com/newren/git-filter-repo[git-filter-repo] instead.
-filter-repo also allows reformatting of metadata for ease-of-reading
-and rewriting authorship info for non-"svn.authorsFile" users.
-
-`svn.useSvmProps`::
-`svn-remote.<name>.useSvmProps`::
-	Re-map repository URLs and UUIDs from
-	mirrors created using SVN::Mirror (or svk) for metadata.
-+
-If an SVN revision has a property, `svm:headrev`, it is likely
-that the revision was created by SVN::Mirror (also used by SVK).
-The property contains a repository UUID and a revision.  We want
-to make it look like we are mirroring the original URL, so
-introduce a helper function that returns the original identity
-URL and UUID, and use it when generating metadata in commit
-messages.
-
-`svn.useSvnsyncProps`::
-`svn-remote.<name>.useSvnsyncprops`::
-	Re-map repository URLs and UUIDs for users
-	of the `svnsync`(1) command distributed with SVN 1.4.x and
-	later, similar to the useSvmProps option.
-
-`svn-remote.<name>.rewriteRoot`::
-	Create repositories from alternate
-	URLs.  For example, an administrator could run `git svn` on the
-	server locally (accessing via `file://`) but wish to distribute
-	the repository with a public `http://` or `svn://` URL in the
-	metadata so users of it will see the public URL.
-
-`svn-remote.<name>.rewriteUUID`::
-	Remap the UUID manually, similar to the useSvmProps option.
-	This may be useful in situations
-	where the original UUID is not available via either useSvmProps
-	or useSvnsyncProps.
-
-`svn-remote.<name>.pushurl`::
-
-	Provide an alternate read/write transport for the SVN repository,
-	similar to Git's `remote.<name>.pushurl`.  This key is designed
-	to be used in cases where `url` points to an SVN repository
-	via a read-only transport. It is assumed that both keys point to the same
-	repository. Unlike `commiturl`, `pushurl` is a base path. If
-	either `commiturl` or `pushurl` could be used, `commiturl`
-	takes precedence.
-
-`svn.brokenSymlinkWorkaround`::
-	Disable potentially expensive checks to workaround
-	broken symlinks checked into SVN by broken clients.  Set this
-	option to "false" if you track a SVN repository with many
-	empty blobs that are not symlinks.  This option may be changed
-	while `git svn` is running and take effect on the next
-	revision fetched.  If unset, `git svn` assumes this option to
-	be "true".
-
-`svn.pathnameencoding`::
-	Recode pathnames to a given encoding.
-	It can be used by windows users and by those who work in non-utf8
-	locales to avoid corrupted file names with non-ASCII characters.
-	Valid encodings are the ones supported by Perl's Encode module.
-
-`svn-remote.<name>.automkdirs`::
-	Recreate empty directories that are in the
-	Subversion repository.  Normally, the `git svn clone` and
-	`git svn rebase` commands
-	attempt to do this automatically.  If this option is set to "false", then
-	empty directories will only be created if the `git svn mkdirs`
-	command is run explicitly.  If unset, `git svn` assumes this
-	option to be "true".
+include::config/svn.adoc[]
 
 Since the `noMetadata`, `rewriteRoot`, `rewriteUUID`, `useSvnsyncProps` and `useSvmProps`
 options all affect the metadata generated and used by `git svn`; they
-- 
gitgitgadget

