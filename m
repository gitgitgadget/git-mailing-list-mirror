Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231F51F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbdAZOwe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:52:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:61854 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752644AbdAZOwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:52:33 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1cOCnw0dDU-00zlYB; Thu, 26
 Jan 2017 15:52:24 +0100
Date:   Thu, 26 Jan 2017 15:52:20 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Segev Finer <segev208@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant
 config
In-Reply-To: <cover.1485442231.git.johannes.schindelin@gmx.de>
Message-ID: <3d451f2c357a3fd7f0b0e4b427548553d7d05306.1485442231.git.johannes.schindelin@gmx.de>
References: <2ff29a4d00e0e13d460122d8008e762361ca90aa.1483358673.git.johannes.schindelin@gmx.de> <cover.1485442231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tHQHE3POvCo3nb7R/Jix6K253xRN9NAt4O+xYRSTXX+cnsnvgL5
 VafRcdC5g4FRz/VYnUwfH1yDjjCMDhVR1AGBSKjs0zVhK4bx4CwxBxe6dcZhHHLq7bXmqKG
 GmDOd6dO65Sp89ZzAmhM0Y9xcRqEEWKerLkAWxwmdvySAG33xphtXqH/pvNK6JRZw5BytWq
 pu74MbAuDQCfBV1QLsdzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tOvS6RwSqPU=:XXORpTSweZXh4NsEMwkWf6
 chg6eAvd+Coik7BdJCcr7DV/xEo3fLRTWTYiK2Ukrc+nIIL4w60V4nRxXUTt0CTwNl5OLxAxa
 2Cn0J0iKkIOQkM+26UOM/mzEnEOM9gi4kPekKl3WZBY2sz83KnVWmPgV14194RdI/yc29vh2P
 tNqXCZnYq9bC8rqFMPxVOILelXIN0TWxIk+wAHbGFyqLNiFvqNydt48ah46XZtPwopKdzcB2H
 kxRVbtu/u3TgWd6VGedabPfGBf0cfrUwbkt0vMBBGVIQ5R3M9s0HtnJeuqOIWyT61QaH/0Y7d
 kjtCvRUQXz2IFG8p0RynUSCYx5VOpXLhoYs447J37qW+s3fzEBaCDYjlDLICqNrSMVJWia1wf
 5EkqUUGqtUqS+G3hjz8cwjvc06CC1V7xCbZ6/6XHI5qME44jE3B5TzRneP9hai7NwXNRocWxw
 bvxCIBmbhBtI0La9TUIxMXjTFpi0YZ+5pqmDDuPQHVcJbCa7mHvtiLhCxa43Hn9RhXq7VGC0K
 fETss8JX7YL2jKam5xKOwfe3BRgCR8l28hmkwV8Ipd+2mq+gRyeZohaGfpnwk94pp1z5NdJCj
 virlG9upb+ZGm2YhBTgLIIfnIae6b98jV6OUSE3p8eHkuqc80I6lE1teETmvaw+5601wpOfbZ
 AYScOgbTpCVsqjyj6/gVZM/g43FuzyQUiU6zBWtVnbdTa45g5zUcxQOCh9z2mS9LOGqayPdwF
 MVKcF5MKuLgygiazkB4AfobBG9menclcCRX5XC92/DRowIRSqkVJtTEnJPKRne3/JHz/KePr2
 tgNKTU6UYgXtWvVUspMo1qVmTD59K16W1Z8TWb2qjDKuFivumfLYy+KZVZi7QnZA9mk8dFX4n
 qkMQ8SQlr+niZ8CwKI2wfzKJqoiSTAICOr2fHrK7ITOUI9xdpzuZPJpJXY3umDWnug8yQX671
 NnhC6bNRZOgVSyboAjsn3ZwIXbRaU/oOuxKIIAgLyA3rRpCILsam834SCli/LBsLl5Nts6uWa
 Tm8RrOYlUbd8ywF7QGJ/3HmntgiE+1KuaBoWvD3yEojdTiUV3bG+FOdd/UHOptoT7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Segev Finer <segev208@gmail.com>

This environment variable and configuration value allow to
override the autodetection of plink/tortoiseplink in case that
Git gets it wrong.

[jes: wrapped overly-long lines, changed get_ssh_variant() to
handle_ssh_variant() to accomodate the change from the
putty/tortoiseplink variables to port_option/needs_batch.]

Signed-off-by: Segev Finer <segev208@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  7 +++++++
 Documentation/git.txt    |  7 +++++++
 connect.c                | 24 ++++++++++++++++++++++--
 t/t5601-clone.sh         | 26 ++++++++++++++++++++++++++
 4 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4cc02..f2c210f0a0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1949,6 +1949,13 @@ Environment variable settings always override any matches.  The URLs that are
 matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
+ssh.variant::
+	Override the autodetection of plink/tortoiseplink in the SSH
+	command that 'git fetch' and 'git push' use. It can be set to
+	either `ssh`, `plink`, `putty` or `tortoiseplink`. Any other
+	value will be treated as normal ssh. This is useful in case
+	that Git gets this wrong.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4f208fab92..c322558aa7 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1020,6 +1020,13 @@ Usually it is easier to configure any desired options through your
 personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
+`GIT_SSH_VARIANT`::
+	If this environment variable is set, it overrides the autodetection
+	of plink/tortoiseplink in the SSH command that 'git fetch' and 'git
+	push' use. It can be set to either `ssh`, `plink`, `putty` or
+	`tortoiseplink`. Any other value will be treated as normal ssh. This
+	is useful in case that Git gets this wrong.
+
 `GIT_ASKPASS`::
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
diff --git a/connect.c b/connect.c
index 9f750eacb6..7b4437578b 100644
--- a/connect.c
+++ b/connect.c
@@ -691,6 +691,24 @@ static const char *get_ssh_command(void)
 	return NULL;
 }
 
+static int handle_ssh_variant(int *port_option, int *needs_batch)
+{
+	const char *variant;
+
+	if (!(variant = getenv("GIT_SSH_VARIANT")) &&
+		git_config_get_string_const("ssh.variant", &variant))
+		return 0;
+
+	if (!strcmp(variant, "plink") || !strcmp(variant, "putty"))
+		*port_option = 'P';
+	else if (!strcmp(variant, "tortoiseplink")) {
+		*port_option = 'P';
+		*needs_batch = 1;
+	}
+
+	return 1;
+}
+
 /*
  * This returns a dummy child_process if the transport protocol does not
  * need fork(2), or a struct child_process object if it does.  Once done,
@@ -817,7 +835,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 				ssh_argv0 = xstrdup(ssh);
 			}
 
-			if (ssh_argv0) {
+			if (!handle_ssh_variant(&port_option, &needs_batch) &&
+			    ssh_argv0) {
 				const char *base = basename(ssh_argv0);
 
 				if (!strcasecmp(base, "tortoiseplink") ||
@@ -828,9 +847,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 					   !strcasecmp(base, "plink.exe")) {
 					port_option = 'P';
 				}
-				free(ssh_argv0);
 			}
 
+			free(ssh_argv0);
+
 			argv_array_push(&conn->args, ssh);
 			if (flags & CONNECT_IPV4)
 				argv_array_push(&conn->args, "-4");
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9335e10c2a..b52b8acf98 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -401,6 +401,32 @@ test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
 	expect_ssh "-v -P 123" myhost src
 '
 
+test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
+	GIT_SSH_VARIANT=ssh \
+	git clone "[myhost:123]:src" ssh-bracket-clone-variant-1 &&
+	expect_ssh "-p 123" myhost src
+'
+
+test_expect_success 'ssh.variant overrides plink detection' '
+	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
+	git -c ssh.variant=ssh \
+		clone "[myhost:123]:src" ssh-bracket-clone-variant-2 &&
+	expect_ssh "-p 123" myhost src
+'
+
+test_expect_success 'GIT_SSH_VARIANT overrides plink detection to plink' '
+	GIT_SSH_VARIANT=plink \
+	git clone "[myhost:123]:src" ssh-bracket-clone-variant-3 &&
+	expect_ssh "-P 123" myhost src
+'
+
+test_expect_success 'GIT_SSH_VARIANT overrides plink to tortoiseplink' '
+	GIT_SSH_VARIANT=tortoiseplink \
+	git clone "[myhost:123]:src" ssh-bracket-clone-variant-4 &&
+	expect_ssh "-batch -P 123" myhost src
+'
+
 # Reset the GIT_SSH environment variable for clone tests.
 setup_ssh_wrapper
 
-- 
2.11.1.windows.prerelease.2.9.g3014b57
