Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F120345740
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787690807; cv=none; b=CIKg3yiY7707N5AESftDTWI4f6ulqeUi5N8sAw7vRqziDgZU3RrHcLX2aS6vchBQfcDezG02kQpXydSuOPjm4c0YfWyfkOTiPdWvSW8KKC1YXtJe7+RIIFPAlW8mzk7tqvgkeq+vMZVvN9ldw+UTx//Trsp/zy6J0Vvn7csSzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787690807; c=relaxed/simple;
	bh=LMKM0e0SujBcEz4n4GuvfQlZzx+V2lo73P+g2tEJ1lc=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BtQ2FOctGi+koRy3Gy8uFQsWeA+7jjDZn46rTTiEuAecm3o6hXBgYT/fQWGobM5sK9DsCyp/FwivNW2vKVJj/pvRKBOK844QUZM7w1X2+YCIEWSysT1dOJg0sryLMpUpeH7ndNqU1FdvLWm6qVXpe6I43GkCAxJUWXVR9clXE1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmUlZRnf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmUlZRnf"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c0ecfaee7so2024151cf.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787690804; x=1788295604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nAVY2LYjmGmhREeiCM/zu0+L23YVaWEMQgkeY15BcpE=;
        b=UmUlZRnf+ChdBuULBrOWyTvA+CxzLOQIAIo7Vc5IFm9difH/SfPORiGB/zpeSpiP/f
         rNxJ3XTEtPJUiQnJNHimQEHxi5Wmuv8Qxm4c3EarTANEq6vwYQ43CNLAlge0b9gWy/9l
         eltQzKSqpdAeQVcWgE+ggjCBfuYOiN27UnBmYLxa7uJEnLkYilyC5rO4wmfJN2+As/il
         P/zP1ic68jlqd8GkEUZFX7QXNiUGlbzxnLeQlCgFfPBsb66lSFUhPzUigmjIUqtrAFzu
         NFHjonzgCW8VqcC/olXxnVkQLPHDeKxw8VipVPWH8EQLaK8zY4pHEjFB7yKMpAGUNFxB
         wFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787690804; x=1788295604;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nAVY2LYjmGmhREeiCM/zu0+L23YVaWEMQgkeY15BcpE=;
        b=UxxXaMimJZzx0tR5X7F1jSt0I2MyYRmpfM2ev4R1yrgcH81RQSAP4E1fVZJxD/wE9Q
         i5inPvRlxp/kOlOMzNLVPOteSMDihiSF/OMJNjiK40Rt7sVT7tmi30lsjMhGsu8Eb/N0
         tgHFWZKPz2E9UBkPDe72tbTgfU/XLMLXfEfRH2k17m+K2bj6Zbk6/bSux08vzfMNr7Rt
         IJ7ZzEwGySTN4K1ChivB6imbkdMXjgTbRKO0GFygexEuYlPJYpPMgNRNz+2FM0Tw40vR
         qf7Yi30AarjrUg9xHJU3lbILpBE2srv5GRHKxRDp83gs9ZGPfRmCarly7/gutaJwq+Am
         cIBg==
X-Gm-Message-State: AFuF++lduEUlpygvI4RVwfH4wyq86GiiUS4ZxG25eBNMFxMJyTLkxeSp
	F+/5xApDLSKHsfzBc470wiazBRJvhb7h9ZclLQRwHW3RetMOMh13KuuSqewTlBO3
X-Gm-Gg: AR+sD133Tgfd2ziiwPSKb/KTcr3kglorhBusDiUK4dSe3YvDqoOm+OHf7LvBruuRn3h
	0D4I7HH6mKz2LmXf/QMmTSIK/1D0XsQ2zKJL9FiyFeS2i8DYpAT1btaRex6XIx6eYpwwv6dtODn
	iDwNLNdnZulTHuNhKmEumVA24RqXgrFlCA1bM7BerLPH0ua0Leu6KL+IByFj93T6sBQXYbvChst
	5BRnFDL0G3pbzniz0JWcmhv2zfR+RBccbC0ataRcfCo2p+XSfLJlitdDKRy8F+sWEhe2vyqMSRb
	NDPXJgeDxMUQDvxpuhtElZOuvyxuL33XBpfgxq95I9+j+7mI/5vMw1AdEP1hi2cAxDRoq6nnoYI
	7uS7//gYsk0JYM++6MJQsupDXYpujYcrHZ6jnkfI6X1bein2moZqN0Y/rsvrbxj25TRH8y8/jdN
	C/7tIXv3MYOjy9PNI6WP538cWn/+h+2pI+QaGWF104q4/4mMwdMgQenneel5uKhxioTGzhoQ==
X-Received: by 2002:a05:622a:2b49:b0:52d:cf84:abf3 with SMTP id d75a77b69052e-52e42266fe6mr20368761cf.4.1787690803921;
        Tue, 25 Aug 2026 13:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.217.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc65093bfsm7603276d6.29.2026.08.25.13.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 13:46:43 -0700 (PDT)
Message-Id: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
From: "Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Aug 2026 20:46:42 +0000
Subject: [PATCH] builtin/whoami: add new 'whoami' command
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Andrew Pleeter <andrewpleeter@gmail.com>,
    anpl1623 <andrewpleeter@gmail.com>

From: anpl1623 <andrewpleeter@gmail.com>

Add a builtin 'whoami' command to inspect and display the resolved
author and committer identity along with the commit signing
configuration (GPG/SSH key ID and commit.gpgsign status) used when
creating Git commits.

Support optional flags (--author, --committer, --name, --email,
--signing-key, and --verbose) for targeted querying and scripting.

Include documentation in Documentation/git-whoami.adoc and regression
tests in t/t0015-whoami.sh.

Signed-off-by: anpl1623 <andrewpleeter@gmail.com>
---
    builtin/whoami: add new 'whoami' command
    
    
    Title:
    ======
    
    builtin/whoami: add new 'whoami' command
    
    ------------------------------------------------------------------------
    
    
    Description:
    ============
    
    SUMMARY
    
    Adds a new builtin git whoami command that inspects and displays the
    user's active author and committer identity along with their commit
    signing configuration (GPG/SSH key ID and commit.gpgsign status).
    
    MOTIVATION
    
    Users often work across multiple environments, profiles, or repositories
    with different global/local configs and signing keys. Currently,
    verifying what identity and signing key will be attached to a new commit
    requires checking several individual git config and git var settings.
    git whoami provides a simple, direct porcelain command to verify this in
    one step.
    
    CHANGES
    
     * Core implementation: Added builtin/whoami.c using Git's ident.h and
       gpg-interface.h APIs.
     * CLI flags supported:
       * git whoami (default overview)
       * -a, --author (author identity: Name <email>)
       * -c, --committer (committer identity: Name <email>)
       * -n, --name (name only)
       * -e, --email (email only)
       * -s, --signing-key (signing key ID)
       * -v, --verbose (detailed identity and signing breakdown)
     * Documentation: Added manpage in Documentation/git-whoami.adoc.
     * Build integration: Added to Makefile, meson.build, command-list.txt,
       and builtin.h.
     * Test suite: Added comprehensive automated tests in t/t0015-whoami.sh.
    
    EXAMPLE OUTPUT
    
    $ git whoami
    Author:    Jane Doe <jane@example.com>
    Committer: Jane Doe <jane@example.com>
    Signing:   /Users/jane/.ssh/id_ed25519_git (format: ssh, commit.gpgsign: true)
    

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2388%2Fanpl1623%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2388/anpl1623/master-v1
Pull-Request: https://github.com/git/git/pull/2388

 Documentation/git-whoami.adoc |  48 ++++++++
 Documentation/meson.build     |   1 +
 Makefile                      |   1 +
 builtin.h                     |   1 +
 builtin/whoami.c              | 201 ++++++++++++++++++++++++++++++++++
 command-list.txt              |   1 +
 git.c                         |   1 +
 meson.build                   |   1 +
 t/meson.build                 |   1 +
 t/t0015-whoami.sh             | 181 ++++++++++++++++++++++++++++++
 10 files changed, 437 insertions(+)
 create mode 100644 Documentation/git-whoami.adoc
 create mode 100644 builtin/whoami.c
 create mode 100755 t/t0015-whoami.sh

diff --git a/Documentation/git-whoami.adoc b/Documentation/git-whoami.adoc
new file mode 100644
index 0000000000..80670f10e9
--- /dev/null
+++ b/Documentation/git-whoami.adoc
@@ -0,0 +1,48 @@
+git-whoami(1)
+=============
+
+NAME
+----
+git-whoami - Show current user identity and commit signing information
+
+
+SYNOPSIS
+--------
+[synopsis]
+git whoami [options]
+
+DESCRIPTION
+-----------
+Displays the author and committer identity (name and email address) and
+commit signing configuration that will be used when signing and recording
+Git commits.
+
+OPTIONS
+-------
+`-a`::
+`--author`::
+	Show author identity.
+
+`-c`::
+`--committer`::
+	Show committer identity.
+
+`-n`::
+`--name`::
+	Show name only.
+
+`-e`::
+`--email`::
+	Show email only.
+
+`-s`::
+`--signing-key`::
+	Show commit signing key only.
+
+`-v`::
+`--verbose`::
+	Show detailed identity and signing status.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..3476e41f29 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -163,6 +163,7 @@ manpages = {
   'git-verify-tag.adoc' : 1,
   'git-version.adoc' : 1,
   'git-web--browse.adoc' : 1,
+  'git-whoami.adoc' : 1,
   'git-worktree.adoc' : 1,
   'git-write-tree.adoc' : 1,
   'git.adoc' : 1,
diff --git a/Makefile b/Makefile
index d4b775953d..3af620d73d 100644
--- a/Makefile
+++ b/Makefile
@@ -1517,6 +1517,7 @@ BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/whoami.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
diff --git a/builtin.h b/builtin.h
index 4e47a4ebd3..9e38298274 100644
--- a/builtin.h
+++ b/builtin.h
@@ -284,5 +284,6 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix, struct repo
 int cmd_show_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_pack_refs(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_replace(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_whoami(int argc, const char **argv, const char *prefix, struct repository *repo);
 
 #endif
diff --git a/builtin/whoami.c b/builtin/whoami.c
new file mode 100644
index 0000000000..3830f76c93
--- /dev/null
+++ b/builtin/whoami.c
@@ -0,0 +1,201 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "builtin.h"
+#include "config.h"
+#include "gettext.h"
+#include "gpg-interface.h"
+#include "ident.h"
+#include "parse-options.h"
+#include "strbuf.h"
+
+static const char * const whoami_usage[] = {
+	N_("git whoami [options]"),
+	NULL
+};
+
+int cmd_whoami(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
+{
+	int show_author = 0;
+	int show_committer = 0;
+	int show_name = 0;
+	int show_email = 0;
+	int show_signing_key = 0;
+	int verbose = 0;
+	int ret = 0;
+
+	struct option whoami_options[] = {
+		OPT_BOOL('a', "author", &show_author, N_("show author identity")),
+		OPT_BOOL('c', "committer", &show_committer, N_("show committer identity")),
+		OPT_BOOL('n', "name", &show_name, N_("show name only")),
+		OPT_BOOL('e', "email", &show_email, N_("show email only")),
+		OPT_BOOL('s', "signing-key", &show_signing_key, N_("show commit signing key")),
+		OPT__VERBOSE(&verbose, N_("show detailed identity and signing status")),
+		OPT_END()
+	};
+
+	struct strbuf author_info = STRBUF_INIT;
+	struct strbuf committer_info = STRBUF_INIT;
+	struct ident_split author_split, committer_split;
+	struct strbuf author_name = STRBUF_INIT;
+	struct strbuf author_email = STRBUF_INIT;
+	struct strbuf committer_name = STRBUF_INIT;
+	struct strbuf committer_email = STRBUF_INIT;
+
+	char *signing_key = NULL;
+	char *gpg_format = NULL;
+	char *ssh_default_key_cmd = NULL;
+	char *resolved_key = NULL;
+	int gpgsign = 0;
+	int is_ssh = 0;
+
+	argc = parse_options(argc, argv, prefix, whoami_options,
+			     whoami_usage, 0);
+
+	if (argc > 0)
+		usage_with_options(whoami_usage, whoami_options);
+
+	die_for_incompatible_opt2(show_author, "--author", show_committer, "--committer");
+	die_for_incompatible_opt2(show_name, "--name", show_email, "--email");
+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_name, "--name");
+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_email, "--email");
+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_author, "--author");
+	die_for_incompatible_opt2(show_signing_key, "--signing-key", show_committer, "--committer");
+	die_for_incompatible_opt2(show_signing_key, "--signing-key", verbose, "--verbose");
+	die_for_incompatible_opt2(verbose, "--verbose", show_name, "--name");
+	die_for_incompatible_opt2(verbose, "--verbose", show_email, "--email");
+	die_for_incompatible_opt2(verbose, "--verbose", show_author, "--author");
+	die_for_incompatible_opt2(verbose, "--verbose", show_committer, "--committer");
+
+	repo_config(the_repository, git_default_config, NULL);
+
+	strbuf_addstr(&author_info, git_author_info(IDENT_NO_DATE));
+	strbuf_addstr(&committer_info, git_committer_info(IDENT_NO_DATE));
+
+	if (split_ident_line(&author_split, author_info.buf, author_info.len) == 0) {
+		if (author_split.name_begin && author_split.name_end)
+			strbuf_add(&author_name, author_split.name_begin,
+				   author_split.name_end - author_split.name_begin);
+		if (author_split.mail_begin && author_split.mail_end)
+			strbuf_add(&author_email, author_split.mail_begin,
+				   author_split.mail_end - author_split.mail_begin);
+	}
+
+	if (split_ident_line(&committer_split, committer_info.buf, committer_info.len) == 0) {
+		if (committer_split.name_begin && committer_split.name_end)
+			strbuf_add(&committer_name, committer_split.name_begin,
+				   committer_split.name_end - committer_split.name_begin);
+		if (committer_split.mail_begin && committer_split.mail_end)
+			strbuf_add(&committer_email, committer_split.mail_begin,
+				   committer_split.mail_end - committer_split.mail_begin);
+	}
+
+	repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign);
+	repo_config_get_string(the_repository, "user.signingkey", &signing_key);
+	repo_config_get_string(the_repository, "gpg.format", &gpg_format);
+	repo_config_get_string(the_repository, "gpg.ssh.defaultkeycommand", &ssh_default_key_cmd);
+
+	is_ssh = gpg_format && !strcmp(gpg_format, "ssh");
+
+	if (signing_key && *signing_key) {
+		resolved_key = xstrdup(signing_key);
+	} else if (is_ssh) {
+		if (ssh_default_key_cmd && *ssh_default_key_cmd)
+			resolved_key = get_signing_key_id();
+	} else if (gpgsign) {
+		resolved_key = get_signing_key_id();
+	}
+
+	if (show_signing_key) {
+		if (resolved_key && *resolved_key) {
+			puts(resolved_key);
+			ret = 0;
+		} else {
+			ret = 1;
+		}
+		goto cleanup;
+	}
+
+	if (show_name) {
+		if (show_author)
+			puts(author_name.buf);
+		else
+			puts(committer_name.buf);
+		goto cleanup;
+	}
+
+	if (show_email) {
+		if (show_author)
+			puts(author_email.buf);
+		else
+			puts(committer_email.buf);
+		goto cleanup;
+	}
+
+	if (show_author) {
+		puts(author_info.buf);
+		goto cleanup;
+	}
+
+	if (show_committer) {
+		puts(committer_info.buf);
+		goto cleanup;
+	}
+
+	if (verbose) {
+		printf(_("Author Name:      %s\n"), author_name.buf);
+		printf(_("Author Email:     %s\n"), author_email.buf);
+		printf(_("Committer Name:   %s\n"), committer_name.buf);
+		printf(_("Committer Email:  %s\n"), committer_email.buf);
+		if (signing_key && *signing_key)
+			printf(_("Signing Key:      %s\n"), signing_key);
+		else if (resolved_key && *resolved_key)
+			printf(_("Signing Key:      %s (default fallback)\n"), resolved_key);
+		else
+			printf(_("Signing Key:      %s\n"), _("none"));
+		printf(_("Signing Format:   %s\n"),
+		       gpg_format ? gpg_format : "openpgp");
+		printf(_("GPG Signing:      %s\n"),
+		       gpgsign ? _("enabled") : _("disabled"));
+	} else {
+		printf(_("Author:    %s\n"), author_info.buf);
+		printf(_("Committer: %s\n"), committer_info.buf);
+		if (gpgsign) {
+			if (signing_key && *signing_key) {
+				printf(_("Signing:   %s (format: %s, commit.gpgsign: true)\n"),
+				       signing_key,
+				       gpg_format ? gpg_format : "openpgp");
+			} else if (resolved_key && *resolved_key) {
+				printf(_("Signing:   default key (%s) (format: %s, commit.gpgsign: true)\n"),
+				       resolved_key,
+				       gpg_format ? gpg_format : "openpgp");
+			} else {
+				printf(_("Signing:   enabled (no signing key configured)\n"));
+			}
+		} else {
+			if (signing_key && *signing_key) {
+				printf(_("Signing:   disabled (key: %s, format: %s, commit.gpgsign: false)\n"),
+				       signing_key,
+				       gpg_format ? gpg_format : "openpgp");
+			} else {
+				printf(_("Signing:   disabled (commit.gpgsign: false)\n"));
+			}
+		}
+	}
+
+cleanup:
+	free(signing_key);
+	free(gpg_format);
+	free(ssh_default_key_cmd);
+	free(resolved_key);
+	strbuf_release(&author_info);
+	strbuf_release(&committer_info);
+	strbuf_release(&author_name);
+	strbuf_release(&author_email);
+	strbuf_release(&committer_name);
+	strbuf_release(&committer_email);
+
+	return ret;
+}
diff --git a/command-list.txt b/command-list.txt
index 21b802c420..0276bc2a53 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -210,6 +210,7 @@ git-verify-pack                         plumbinginterrogators
 git-verify-tag                          ancillaryinterrogators
 git-version                             ancillaryinterrogators
 git-whatchanged                         ancillaryinterrogators          complete
+git-whoami                              ancillaryinterrogators
 git-worktree                            mainporcelain
 git-write-tree                          plumbingmanipulators
 gitattributes                           userinterfaces
diff --git a/git.c b/git.c
index e5f1811b6b..83629178c9 100644
--- a/git.c
+++ b/git.c
@@ -680,6 +680,7 @@ static struct cmd_struct commands[] = {
 #ifndef WITH_BREAKING_CHANGES
 	{ "whatchanged", cmd_whatchanged, RUN_SETUP | DEPRECATED },
 #endif
+	{ "whoami", cmd_whoami, RUN_SETUP_GENTLY },
 	{ "worktree", cmd_worktree, RUN_SETUP },
 	{ "write-tree", cmd_write_tree, RUN_SETUP },
 };
diff --git a/meson.build b/meson.build
index d86f2acd2b..0daf395752 100644
--- a/meson.build
+++ b/meson.build
@@ -726,6 +726,7 @@ builtin_sources = [
   'builtin/verify-commit.c',
   'builtin/verify-pack.c',
   'builtin/verify-tag.c',
+  'builtin/whoami.c',
   'builtin/worktree.c',
   'builtin/write-tree.c',
 ]
diff --git a/t/meson.build b/t/meson.build
index 181d61a8a0..8c111148da 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -87,6 +87,7 @@ integration_tests = [
   't0012-help.sh',
   't0013-sha1dc.sh',
   't0014-alias.sh',
+  't0015-whoami.sh',
   't0017-env-helper.sh',
   't0018-advice.sh',
   't0019-json-writer.sh',
diff --git a/t/t0015-whoami.sh b/t/t0015-whoami.sh
new file mode 100755
index 0000000000..2a2d9b6dd3
--- /dev/null
+++ b/t/t0015-whoami.sh
@@ -0,0 +1,181 @@
+#!/bin/sh
+
+test_description='basic sanity checks for git whoami'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success 'default output format without signing' '
+	cat >expect <<-EOF &&
+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	Signing:   disabled (commit.gpgsign: false)
+	EOF
+	git whoami >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git whoami --author' '
+	echo "$GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>" >expect &&
+	git whoami --author >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git whoami --committer' '
+	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expect &&
+	git whoami --committer >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git whoami --author --name and --author --email' '
+	echo "$GIT_AUTHOR_NAME" >expect_name &&
+	git whoami --author --name >actual_name &&
+	test_cmp expect_name actual_name &&
+	echo "$GIT_AUTHOR_EMAIL" >expect_email &&
+	git whoami --author --email >actual_email &&
+	test_cmp expect_email actual_email
+'
+
+test_expect_success 'git whoami --committer --name and --committer --email' '
+	echo "$GIT_COMMITTER_NAME" >expect_name &&
+	git whoami --committer --name >actual_name &&
+	test_cmp expect_name actual_name &&
+	echo "$GIT_COMMITTER_EMAIL" >expect_email &&
+	git whoami --committer --email >actual_email &&
+	test_cmp expect_email actual_email
+'
+
+test_expect_success 'git whoami --signing-key when signing is disabled and unset' '
+	test_config commit.gpgsign false &&
+	test_unconfig user.signingkey &&
+	test_must_fail git whoami --signing-key
+'
+
+test_expect_success 'git whoami with explicitly configured signing key' '
+	test_config user.signingkey "TEST_KEY_123" &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	cat >expect <<-EOF &&
+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	Signing:   TEST_KEY_123 (format: ssh, commit.gpgsign: true)
+	EOF
+	git whoami >actual &&
+	test_cmp expect actual &&
+	echo "TEST_KEY_123" >expect_key &&
+	git whoami --signing-key >actual_key &&
+	test_cmp expect_key actual_key
+'
+
+test_expect_success 'git whoami with signing disabled but key configured' '
+	test_config user.signingkey "TEST_KEY_123" &&
+	test_config commit.gpgsign false &&
+	test_config gpg.format openpgp &&
+	cat >expect <<-EOF &&
+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	Signing:   disabled (key: TEST_KEY_123, format: openpgp, commit.gpgsign: false)
+	EOF
+	git whoami >actual &&
+	test_cmp expect actual &&
+	echo "TEST_KEY_123" >expect_key &&
+	git whoami --signing-key >actual_key &&
+	test_cmp expect_key actual_key
+'
+
+test_expect_success 'git whoami with openpgp signing enabled without explicit key' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format openpgp &&
+	cat >expect <<-EOF &&
+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	Signing:   default key ($GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>) (format: openpgp, commit.gpgsign: true)
+	EOF
+	git whoami >actual &&
+	test_cmp expect actual &&
+	echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" >expect_key &&
+	git whoami --signing-key >actual_key &&
+	test_cmp expect_key actual_key
+'
+
+test_expect_success 'git whoami with ssh signing enabled without explicit key' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	test_unconfig gpg.ssh.defaultKeyCommand &&
+	cat >expect <<-EOF &&
+	Author:    $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+	Committer: $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>
+	Signing:   enabled (no signing key configured)
+	EOF
+	git whoami >actual &&
+	test_cmp expect actual &&
+	test_must_fail git whoami --signing-key
+'
+
+test_expect_success GPGSSH 'git whoami with ssh defaultKeyCommand' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format ssh &&
+	test_config gpg.ssh.defaultKeyCommand "cat \"${GPGSSH_KEY_PRIMARY}.pub\"" &&
+	git whoami --signing-key >actual_key &&
+	test_grep "^SHA256:" actual_key
+'
+
+test_expect_success 'git whoami -v / --verbose' '
+	test_config user.signingkey "MY_SIGNING_KEY" &&
+	test_config commit.gpgsign true &&
+	test_config gpg.format openpgp &&
+	cat >expect <<-EOF &&
+	Author Name:      $GIT_AUTHOR_NAME
+	Author Email:     $GIT_AUTHOR_EMAIL
+	Committer Name:   $GIT_COMMITTER_NAME
+	Committer Email:  $GIT_COMMITTER_EMAIL
+	Signing Key:      MY_SIGNING_KEY
+	Signing Format:   openpgp
+	GPG Signing:      enabled
+	EOF
+	git whoami -v >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git whoami with environment variable overrides' '
+	test_unconfig user.signingkey &&
+	test_config commit.gpgsign false &&
+	cat >expect <<-EOF &&
+	Author:    Custom Author <custom.author@example.com>
+	Committer: Custom Committer <custom.committer@example.com>
+	Signing:   disabled (commit.gpgsign: false)
+	EOF
+	GIT_AUTHOR_NAME="Custom Author" \
+	GIT_AUTHOR_EMAIL="custom.author@example.com" \
+	GIT_COMMITTER_NAME="Custom Committer" \
+	GIT_COMMITTER_EMAIL="custom.committer@example.com" \
+	git whoami >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incompatible option combinations fail' '
+	test_must_fail git whoami --author --committer 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git whoami --name --email 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git whoami --signing-key --name 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git whoami --signing-key --email 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git whoami --signing-key --author 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git whoami --signing-key --committer 2>err &&
+	test_grep "cannot be used together" err &&
+	test_must_fail git whoami --verbose --name 2>err &&
+	test_grep "cannot be used together" err
+'
+
+test_expect_success 'git whoami outside of repository' '
+	nongit git whoami --author >actual &&
+	test_grep "<" actual
+'
+
+test_done

base-commit: 593c42fe075be0c8cd5239b3a2f21c610cbc9798
-- 
gitgitgadget
