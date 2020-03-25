Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E5C54FCE
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 01:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29132073C
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 01:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="loO9Wpt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCYBfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 21:35:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:32992 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727229AbgCYBfE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Mar 2020 21:35:04 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A0264607A4;
        Wed, 25 Mar 2020 01:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1585100102;
        bh=yMb9RwUIG0+SgAzj2DyjZZ1SmlQplx5SnanSgjPNht8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=loO9Wpt+BCyRz8i0khbMOpWcKamxph//GLmevkQ/3zXfE3aDKTqXN+VAhNeOrj1fY
         DdC5x7X7yPIueyPHIXZCZmjEltCO1ZOB7Hkg4Fm7M6lGXZDGEsfgyk5S8V6+OsTzrg
         q5aHfx0UDqqbe2Vbon76heqK0IgMHhyjaqWqDJxi79QhQCgYpinfc0i7MBYzh/Y5Hv
         2iJTYlvq2j9YKH5MEz6hNNMBlw6lBVn7a7GsBcQBqDvKIZhOWyXUNGsiLlcfooLRKG
         sF4izYReqaTHY4dVo/fMjSuNH19dvOdv0XnzTGP/nIKoRU6cxLXEkbAcyZsH2S/pis
         24Y6623ly84hklJtdt1R7xM6mAU9oScFSlroGFIHzl2xHNIiw1CZqCJw07ISqKOYI7
         wJ6frZrtvoJ4PaaX0CAfYg79IddmCThESAMbLo7lbaaLZAtiWsPnsUXc2sMnMiLJsG
         ogXgTxZOQ/iQhCJgMsCmHKqP6qDx5qt+9SEXAG5c999I99eKQUb
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [PATCH v2] docs: add a FAQ
Date:   Wed, 25 Mar 2020 01:34:34 +0000
Message-Id: <20200325013434.219775-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.0.277.gb8618d28a92
In-Reply-To: <20200325013434.219775-1-sandals@crustytoothpaste.net>
References: <20200325013434.219775-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is an enormously flexible and powerful piece of software.  However,
it can be intimidating for many users and there are a set of common
questions that users often ask.  While we already have some new user
documentation, it's worth adding a FAQ to address common questions that
users often have.  Even though some of this is addressed elsewhere in
the documentation, experience has shown that it is difficult for users
to find, so a centralized location is helpful.

Add such a FAQ and fill it with some common questions and answers.
While there are few entries now, we can expand it in the future to cover
more things as we find new questions that users have.  Let's also add
section markers so that people answering questions can directly link
users to the proper answer.

The FAQ also addresses common configuration questions that apply not
only to Git as an independent piece of software but also the ecosystem
of CI tools and hosting providers that people use, since these are the
source of common questions.  An attempt has been made to avoid
mentioning any particular provider or tool, but to nevertheless cover
common configurations that apply to a wide variety of such tools.

Note that the long lines for certain questions are required, since
Asciidoctor does not permit broken lines there.
---
 Documentation/Makefile   |   1 +
 Documentation/gitfaq.txt | 338 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 339 insertions(+)
 create mode 100644 Documentation/gitfaq.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8fe829cc1b..59e6ce3a2a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -30,6 +30,7 @@ MAN7_TXT += gitcredentials.txt
 MAN7_TXT += gitcvs-migration.txt
 MAN7_TXT += gitdiffcore.txt
 MAN7_TXT += giteveryday.txt
+MAN7_TXT += gitfaq.txt
 MAN7_TXT += gitglossary.txt
 MAN7_TXT += gitnamespaces.txt
 MAN7_TXT += gitremote-helpers.txt
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
new file mode 100644
index 0000000000..ce447e2524
--- /dev/null
+++ b/Documentation/gitfaq.txt
@@ -0,0 +1,338 @@
+gitfaq(7)
+=========
+
+NAME
+----
+gitfaq - Frequently asked questions about using Git
+
+SYNOPSIS
+--------
+gitfaq
+
+DESCRIPTION
+-----------
+
+The examples in this FAQ assume a standard POSIX shell, like `bash` or `dash`,
+and a user, A U Thor, who has the account `author` on the hosting provider
+`git.example.org`.
+
+Configuration
+-------------
+
+[[user-name]]
+What should I put in `user.name`?::
+	You should put your personal name, generally a form using a given name
+	and family name.  For example, the current maintainer of Git uses "Junio
+	C Hamano".  This will be the name portion that is stored in every commit
+	you make.
++
+This configuration doesn't have any effect on authenticating to remote services;
+for that, see `credential.username` in linkgit:git-config[1].
+
+[[http-postbuffer]]
+What does `http.postBuffer` really do?::
+	This option changes the size of the buffer that Git uses when pushing
+	data to a remote over HTTP or HTTPS.  If the data is larger than this
+	size, libcurl, which handles the HTTP support for Git, will use chunked
+	transfer encoding since it isn't known ahead of time what the size of
+	the pushed data will be.
++
+Leaving this value at the default size is fine unless you know that either the
+remote server or a proxy in the middle doesn't support HTTP/1.1 (which
+introduced the chunked transfer encoding) or is known to be broken with chunked
+data.  This is often (erroneously) suggested as a solution for generic push
+problems, but since almost every server and proxy supports at least HTTP/1.1,
+raising this value usually doesn't solve most push problems.  A server or proxy
+that didn't correctly support HTTP/1.1 and chunked transfer encoding wouldn't be
+that useful on the Internet today, since it would break lots of traffic.
++
+Note that increasing this value will increase the memory used on every relevant
+push that Git does over HTTP or HTTPS, since the entire buffer is allocated
+regardless of whether or not it is all used.  Thus, it's best to leave it at the
+default unless you are sure you need a different value.
+
+[[configure-editor]]
+How do I configure a different editor?::
+	If you haven't specified an editor specifically for Git, it will by
+	default use the editor you've configured using the `VISUAL` or `EDITOR`
+	environment variables, or if neither is specified, the system default
+	(which is usually `vi`).  Since some people find `vi` difficult to use,
+	it may be desirable to change the editor used.
++
+If you want to configure a general editor for most programs which need one, you
+can edit your shell configuration (e.g., `~/.bashrc` or `~/.zshenv`) to contain
+a line setting the `EDITOR` or `VISUAL` environment variable to an appropriate
+value.  For example, if you preferred the editor `nano`, then you could write
+the following:
++
+----
+export VISUAL=nano
+----
++
+If you want to configure an editor specifically for Git, you can either set the
+`core.editor` configuration value or the `GIT_EDITOR` environment variable.  You
+can see linkgit:git-var[1] for details on the order in which these options are
+consulted.
++
+Note that in all cases, the editor value will be passed to the shell, so any
+arguments containing spaces should be appropriately quoted.  Additionally, if
+your editor normally detaches from the terminal when invoked, you should specify
+it with an argument that makes it not do that, or else Git will not see any
+changes.  An example of a configuration addressing both of these issues on
+Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
+which quotes the filename with spaces and specifies the `--nofork` option to
+avoid backgrounding the process.
+
+Credentials
+-----------
+
+[[http-credentials]]
+How do I specify my credentials when pushing over HTTP?::
+	The easiest way to do this is to use a credential helper via the
+	`credential.helper` configuration.  Most systems provide a standard
+	choice to integrate with the system credential manager.  For example,
+	Git for Windows provides the `wincred` credential manager, macOS has the
+	`osxkeychain` credential manager, and Unix systems with a standard
+	desktop environment can use the `libsecret` credential manager.  All of
+	these store credentials in an encrypted store to keep your passwords or
+	tokens secure.
++
+In addition, you can use the `store` credential manager which stores in a file
+in your home directory, or the `cache` credential manager, which does not
+permanently store your credentials, but does prevent you from being prompted for
+them for a certain period of time.
++
+You can also just enter your password when prompted, or you can place the
+password (which must be percent-encoded) in the URL.  The latter option is not
+particularly secure and can lead to accidental exposure of credentials, so it is
+not recommended.
+
+[[http-credentials-environment]]
+How do I read a password or token from an environment variable?::
+	The `credential.helper` configuration option can also take an arbitrary
+	shell command that produces the credential protocol on standard output.
+	This is useful when passing credentials into a container, for example.
++
+Such a shell command can be specified by starting the option value with an
+exclamation point.  If your password or token were stored in the `GIT_TOKEN`,
+you could run the following command to set your credential helper:
++
+----
+$ git config credential.helper \
+	'!f() { echo username=author; echo "password=$GIT_TOKEN"; };f'
+----
+
+[[http-reset-credentials]]
+How do I change the password or token I've saved in my credential manager?::
+	Usually, if the password or token is invalid, Git will erase it and
+	prompt for a new one.  However, there are times when this doesn't always
+	happen.  To change the password or token, you can erase the existing
+	credentials and then Git will prompt for new ones.  To erase
+	credentials, use a syntax like the following (substituting your username
+	and the hostname):
++
+----
+$ echo url=https://author@git.example.org | git credential reject
+----
+
+[[multiple-accounts-http]]
+How do I use multiple accounts with the same hosting provider using HTTP?::
+	Usually the easiest way to distinguish between these accounts is to use
+	the username in the URL.  For example, if you have the accounts `author`
+	and `committer` on `git.example.org`, you can use the URLs
+	https://author@git.example.org/org1/project1.git and
+	https://committer@git.example.org/org2/project2.git.  This way, when you
+	use a credential helper, it will automatically try to look up the
+	correct credentials for your account.  If you already have a remote set
+	up, you can change the URL with something like `git remote set-url
+	origin https://author@git.example.org/org1/project1.git` (see
+	linkgit:git-remote[1] for details).
+
+[[multiple-accounts-ssh]]
+How do I use multiple accounts with the same hosting provider using SSH?::
+	With most hosting providers that support SSH, a single key pair uniquely
+	identifies a user.  Therefore, to use multiple accounts, it's necessary
+	to create a key pair for each account.  If you're using a reasonably
+	modern OpenSSH version, you can create a new key pair with something
+	like `ssh-keygen -t ed25519 -f ~/.ssh/id_committer`.  You can then
+	register the public key (in this case, `~/.ssh/id_committer.pub`; note
+	the `.pub`) with the hosting provider.
++
+Most hosting providers use a single SSH account for pushing; that is, all users
+push to the `git` account (e.g., `git@git.example.org`).  If that's the case for
+your provider, you can set up multiple aliases in SSH to make it clear which key
+pair to use.  For example, you could write something like the following,
+substituting the proper private key file:
++
+----
+# This is the account for author on git.example.org.
+Host example_author
+	HostName git.example.org
+	User git
+	# This is the key pair registered for author with git.example.org.
+	IdentityFile ~/.ssh/id_author
+	IdentitiesOnly yes
+# This is the committer for author on git.example.org.
+Host example_committer
+	HostName git.example.org
+	User git
+	# This is the key pair registered for committer with git.example.org.
+	IdentityFile ~/.ssh/id_committer
+	IdentitiesOnly yes
+----
++
+Then, you can adjust your push URL to use `git@example_author` or
+`git@example_committer` instead of `git@example.org` (e.g., `git remote set-url
+git@example_author:org1/project1.git`).
+
+Common Issues
+-------------
+
+[[last-commit-amend]]
+I've made a mistake in the last commit.  How do I change it?::
+	You can make the appropriate change to your working tree, run `git add
+	<file>` or `git rm <file>`, as approrpiate, to stage it, and then `git
+	commit --amend`.  Your change will be included in the commit, and you'll
+	be prompted to edit the commit message again; if you wish to use the
+	original message verbatim, you can use the `--no-edit` option to `git
+	commit` in addition, or just save and quit when your editor opens.
+
+[[undo-previous-change]]
+I've made a change with a bug and it's been included in the main branch.  How should I undo it?::
+	The usual way to deal with this is to use `git revert`.  This preserves
+	the history that the original change was made and was a valuable
+	contribution, but also introduces a new commit that undoes those changes
+	because the original had a problem.  The commit message of the revert
+	indicates the commit which was reverted and is usually edited to include
+	an explanation as to why the revert was made.
+
+[[ignore-tracked-files]]
+How do I ignore changes to a tracked file?::
+	Git doesn't provide a way to do this.  The reason is that if Git needs
+	to overwrite this file, such as during a checkout, it doesn't know
+	whether the changes to the file are precious and should be kept, or
+	whether they are irrelevant and can safely be destroyed.  Therefore, it
+	has to take the safe route and always preserve them.
++
+It's tempting to try to use certain features of `git update-index`, namely the
+assume-unchanged and skip-worktree bits, but these don't work properly for this
+purpose and shouldn't be used this way.
++
+If your goal is to modify a configuration file, it can often be helpful to have
+a file checked into the repository which is a template or set of defaults which
+can then be copied alongside and modified as appropriate.  This second, modified
+file is usually ignored to prevent accidentally committing it.
+
+Hooks
+-----
+
+[[restrict-with-hooks]]
+How do I prevent users from making certain changes with hooks?::
+	The only safe place to make these changes is on the remote repository
+	(i.e., the Git server), usually in the `pre-receive` hook or in a
+	continuous integration (CI) system.  These are the locations in which
+	policy can be enforced effectively.
++
+It's common to try to use `pre-commit` hooks (or, for commit messages,
+`commit-msg` hooks) to check these things, which is great if you're working as a
+solo developer and want the tooling to help you.  However, using hooks on a
+developer machine is not effective as a policy control because a user can bypass
+these hooks with `--no-verify` without being noticed (among various other ways).
+Git assumes that the user is in control of their local repositories and doesn't
+try to prevent this or tattle on the user.
++
+In addition, some advanced users find `pre-commit` hooks to be an impediment to
+workflows that use temporary commits to stage work in progress or that create
+fixup commits, so it's better to push these kinds of checks to the server
+anyway.
+
+Cross-Platform Issues
+~~~~~~~~~~~~~~~~~~~~~
+
+[[windows-text-binary]]
+I'm on Windows and my text files are detected as binary.::
+	Git works best when you store text files as UTF-8.  Many programs on
+	Windows support UTF-8, but some do not and only use the little-endian
+	UTF-16 format, which Git detects as binary.  If you can't use UTF-8 with
+	your programs, you can specify a working tree encoding that indicates
+	which encoding your files should be checked out with, while still
+	storing these files as UTF-8 in the repository.  This allows tools like
+	linkgit:git-diff[1] to work as expected, while still allowing your tools
+	to work.
++
+To do so, you can specify a linkgit:gitattributes[5] pattern with with the
+`working-tree-encoding` attribute.  For example, the following pattern sets all
+C files to use UTF-16LE-BOM, which is a common encoding on Windows:
++
+----
+*.c	working-tree-encoding=UTF-16LE-BOM
+----
++
+You will need to run `git add --renormalize` to have this take effect.  Note
+that if you are making these changes on a project that is used across platforms,
+you'll probably want to make it in a per-user configuration file or in the one
+in `$GIT_DIR/info/attributes`, since making it in a `.gitattributes` file in the
+repository will apply to all users of the repository.
++
+See the following entry for information about normalizing line endings as well,
+and see linkgit:gitattributes[5] for more information about attribute files.
+
+[[windows-diff-control-m]]
+I'm on Windows and git diff shows my files as having a `^M` at the end.::
+	By default, Git expects files to be stored with Unix line endings.  As
+	such, the carriage return (`^M`) that is part of a Windows line ending
+	results is show because it is considered to be trailing whitespace.  Git
+	defaults to showing trailing whitespace only on new lines, not existing
+	ones.
++
+You can store the files in the repository with Unix line endings and convert
+them automatically to your platform's line endings.  To do that, set the
+configuration option `core.eol` to `native` and see the following entry for
+information about how to configure files as text or binary.
++
+You can also control this behavior with the `core.whitespace` setting if you
+don't wish to remove the carriage returns from your line endings.
+
+[[recommended-storage-settings]]
+What's the recommended way to store files in Git?::
+	While Git can store and handle any file of any type, there are some
+	settings that work better than others.  In general, we recommend that
+	text files be stored in UTF-8 without a byte-order mark (BOM) with LF
+	(Unix-style) endings.  We also recommend the use of UTF-8 (again,
+	without BOM) in commit messages.  These are the settings that work best
+	across platforms and with tools such as `git diff` and `git merge`.
++
+Additionally, if you have a choice between storage formats that are text based
+or non-text based, we recommend storing files in the text format and, if
+necessary, transforming them into the other format.  For example, a text-based
+SQL dump with one record per line will work much better for diffing and merging
+than an actual database file.  Similarly, text-based formats such as Markdown
+and AsciiDoc will work better than binary formats such as Microsoft Word and
+PDF.
++
+Similarly, storing binary dependencies (e.g., shared libraries or JAR files) or
+build products in the repository is generally not recommended.  Dependencies and
+build products are best stored on an artifact or package server with only
+references, URLs, and hashes stored in the repository.
++
+We also recommend setting a link:gitattributes[5] file to explicitly mark which
+files are text and which are binary.  If you want Git to guess, you can set the
+attribute `text=auto`.  For example, the following might be appropriate in some
+projects:
++
+----
+# By default, guess.
+*	text=auto
+# Mark all C files as text.
+*.c	text
+# Mark all JPEG files as binary.
+*.jpg	binary
+----
++
+These settings help tools pick the right format for output such as patches and
+result in files being checked out in the appropriate line ending for the
+platform.
+
+GIT
+---
+Part of the linkgit:git[1] suite
