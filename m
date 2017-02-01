Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD2331FAAD
	for <e@80x24.org>; Wed,  1 Feb 2017 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752088AbdBAMBd (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 07:01:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:49258 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbdBAMBc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 07:01:32 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZU7V-1ctRHm14sn-00LE8z; Wed, 01
 Feb 2017 13:01:19 +0100
Date:   Wed, 1 Feb 2017 13:01:16 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Segev Finer <segev208@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] connect: Add the envvar GIT_SSH_VARIANT and ssh.variant
 config
In-Reply-To: <cover.1485950225.git.johannes.schindelin@gmx.de>
Message-ID: <9780d67c9f11c056202987377c542d0313772ba2.1485950225.git.johannes.schindelin@gmx.de>
References: <cover.1485442231.git.johannes.schindelin@gmx.de> <cover.1485950225.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:j8Wi+MpuknK/JWMAsp3TRSBgAs7XAt8OM+/fcQ9sOsFoRnRRO+C
 oVMM8LP4ANwo1W/ifubzz8U5w3XrW6olZAtuYYPtidJtXrxJtjO3cZof+gCFQlhlaOwBIfw
 GRlK+PJRBdbtXEWWPoeKJ1fH4A+vwjz8Z2PhzfXil0wGKvv57QkzCzuSLqfPaZgGY6ERPST
 yPc6dins70bg595FSj2GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2NPiScq1nZc=:PCOLCpfWn5FXYwgG8JT3Xy
 kaRVWd3ORmzBALcCUzAXqK2H64k2M7v5F0dxVlUSVL3tNQ44KipnrCrFmUEizlvLtshGI5/Lc
 hP/F4QIpNngGu/XI1Mb6nS3eNTqVfsCezrfl462kQrRlddlQHdXLgDpabC+xSf64HtgCG4e92
 23CeI84AaPTiDVbYOZiu/a4I1rJqzn0aFqndbBJenf6O8FdQp7fhlhsjJcPjxecnvZGx+ai0p
 jW0EGhCuZLImWUaCiGEfXL7bnGpiE/pK3TjQsrPOWbQIw7uXAt+8GdNdOTS6CE1O/WQwuW+bb
 KjoxXXDOi97CPCyh3yROvEdtFjn9yT3rK9rt9neJyItJeK+qflPYHSFcvxnt8z5VjMJ/X0FlJ
 PkE866LD5p7O33ci+/dQ2r88WMC9Un/UmXD9EfdFVQibHXQZoQrbfwZsFlaItQj6NfEo+dHQw
 gysztiAR8RoP4IcL0kzRlaqooFfvW3KY6YA1dzvYlxnA/mJBv5ZJj3LkdEdxhL6HctPBgJpCw
 2EgOAg8NB7eKGRv2RKUl5jDv9OfOU2YrJlBmFVfQjFUlF/gZnXgmS4AV3WHBQXuZVaygLYO3z
 IdS3OIi7vto2HbO4BMUr9jzHn8onb0mFlKp5qDErUbGwN63r1nLV3/dr0rMkpdyjVRGFioMDV
 zsRu/uUKiEAX9yDFIoWLyxQueNr6KMcMLCLD+lR5vikdhC327qAeegRjL2+Fm7lmy7zq8eHLJ
 +/oyg012Aat5Qs/hzwGaioWroSlLLc7rKvCHFX5QyV1qE4orkWBlRKADyv+uyc/ivuNgRURTH
 wLMF2YUFeuIpKatX8h6UpvnoH5OJKbmlfXsh2ZCXLtNWr+Xi+9/uEHjwAdVO2lafBjpcc8NkB
 25S/U4kcbT4kByulXu30QjL/emskKoHaF+3V0BRgZVPspa1DndRPVa+VKdfRbqsVgtj/8uXw5
 7Aq0LIw5rBhKUwZQ8Wp4bpLYexgSctis1gpEAA0KRRtG19K7vWTwNOUMde1tZHbaaOrQf9jtp
 zwQ6IgxsUTBQUu8FQbM+37AjWpdB68OYGLN6deGCjofVatP/+0lgRZ+1O0VeEX6psQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Segev Finer <segev208@gmail.com>

This environment variable and configuration value allow to
override the autodetection of plink/tortoiseplink in case that
Git gets it wrong.

[jes: wrapped overly-long lines, factored out and changed
get_ssh_variant() to handle_ssh_variant() to accomodate the
change from the putty/tortoiseplink variables to
port_option/needs_batch, adjusted the documentation, free()d
value obtained from the config.]

Signed-off-by: Segev Finer <segev208@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt | 11 +++++++++++
 Documentation/git.txt    |  6 ++++++
 connect.c                | 11 ++++++++---
 t/t5601-clone.sh         | 26 ++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4cc02..b88df57ab6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1949,6 +1949,17 @@ Environment variable settings always override any matches.  The URLs that are
 matched against are those given directly to Git commands.  This means any URLs
 visited as a result of a redirection do not participate in matching.
 
+ssh.variant::
+	Depending on the value of the environment variables `GIT_SSH` or
+	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
+	auto-detects whether to adjust its command-line parameters for use
+	with plink or tortoiseplink, as opposed to the default (OpenSSH).
++
+The config variable `ssh.variant` can be set to override this auto-detection;
+valid values are `ssh`, `plink`, `putty` or `tortoiseplink`. Any other value
+will be treated as normal ssh. This setting can be overridden via the
+environment variable `GIT_SSH_VARIANT`.
+
 i18n.commitEncoding::
 	Character encoding the commit messages are stored in; Git itself
 	does not care per se, but this information is necessary e.g. when
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 4f208fab92..a0c6728d1a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1020,6 +1020,12 @@ Usually it is easier to configure any desired options through your
 personal `.ssh/config` file.  Please consult your ssh documentation
 for further details.
 
+`GIT_SSH_VARIANT`::
+	If this environment variable is set, it overrides Git's autodetection
+	whether `GIT_SSH`/`GIT_SSH_COMMAND`/`core.sshCommand` refer to OpenSSH,
+	plink or tortoiseplink. This variable overrides the config setting
+	`ssh.variant` that serves the same purpose.
+
 `GIT_ASKPASS`::
 	If this environment variable is set, then Git commands which need to
 	acquire passwords or passphrases (e.g. for HTTP or IMAP authentication)
diff --git a/connect.c b/connect.c
index 2734b9a1ca..7f1f802396 100644
--- a/connect.c
+++ b/connect.c
@@ -694,10 +694,14 @@ static const char *get_ssh_command(void)
 static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 			      int *port_option, int *needs_batch)
 {
-	const char *variant;
+	const char *variant = getenv("GIT_SSH_VARIANT");
 	char *p = NULL;
 
-	if (!is_cmdline) {
+	if (variant)
+		; /* okay, fall through */
+	else if (!git_config_get_string("ssh.variant", &p))
+		variant = p;
+	else if (!is_cmdline) {
 		p = xstrdup(ssh_command);
 		variant = basename(p);
 	} else {
@@ -717,7 +721,8 @@ static int handle_ssh_variant(const char *ssh_command, int is_cmdline,
 	}
 
 	if (!strcasecmp(variant, "plink") ||
-	    !strcasecmp(variant, "plink.exe"))
+	    !strcasecmp(variant, "plink.exe") ||
+	    !strcasecmp(variant, "putty"))
 		*port_option = 'P';
 	else if (!strcasecmp(variant, "tortoiseplink") ||
 		 !strcasecmp(variant, "tortoiseplink.exe")) {
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
