Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878BC433DB
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3162522B43
	for <git@archiver.kernel.org>; Sun, 24 Jan 2021 15:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbhAXPPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 10:15:10 -0500
Received: from mout.web.de ([212.227.17.11]:40639 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbhAXPPE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 10:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1611501187;
        bh=5r1epwdUhurK9a3QO3/DZ+mA+gdQAG4JoQRbpM1GB2w=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=B4mzhnynNd1md4tHJOnhTAnBJOL/OLrCABTKv/09oip+N+jhTf9WFqKK/U4F7ELBd
         U3+R7fJ8xCf6AABK6BC2sTtdKhUCP30yCu8/okInwgOiYqGTHaBLHqcdivbLgVkhxz
         vPvGGEVsvSmkkz0Lurk3MpzVji4/U35E/ZRa4RgY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([195.198.252.176]) by smtp.web.de
 (mrweb102 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MUF4Q-1lUk9R10E6-00R1rX; Sun, 24 Jan 2021 16:13:07 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, random_n0body@icloud.com,
        evraiphilippeblain@gmail.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH/RFC v1 1/1] git restore -p . and precomposed unicode
Date:   Sun, 24 Jan 2021 16:13:06 +0100
Message-Id: <20210124151306.23185-1-tboegi@web.de>
X-Mailer: git-send-email 2.30.0.155.g66e871b664
In-Reply-To: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
References: <A102844A-9501-4A86-854D-E3B387D378AA@icloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z5oLLSSRk67ZBQ/9HrkgUjAsO/q6YwqvQoS9Xjg7iezA/12zCkJ
 vUCATDtIuLHjKDYgxrS/HaVYlilSLCH+Ney7kNRTDskQjkqPBYbOiwpa0By3VlhgZ9Fet0n
 9gZd+6uymSYg3qmZg/ZRSQ+qErQbXcXF9A+cm7h2MqwXOKGWbGno7rN/R5jZUHu55bCO85e
 1dJ32AWWfVCRk8R78o00A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YO2ozr8+/Xo=:UHEqhpNeMCW5Z6T9AGJU/l
 U59SPhRfjkysX5OdXt+6XEvtDyL55smyJnegzqaZ1O3wI768IenlcpEXuDN3gFHwrdH5x2cYn
 M7H2ESwClcMPL5zKWKHoicJ8LHOfBIbKwYWDT2N/T9WFiEj+v/ahxAWdEjZEcl/rLQCiiJ2tF
 GQKS/VlBkW+lz+BS1n3rqVOHKjIvPHQvvNcZvNY8L/bSIiEeT/geJ43JWohb0pSD07UwL+oJ8
 mO01AZJ8SnBNe9EM5gcdd5FFkcZ+s0fEN266WAovYnCyTa9MiyyxRKstAyR88VauKMlrA9JQt
 VBwZnR/yce+S2eUTybt3YE8bOjMO1X0HZ+Ki6I+pk1JhDxL2E/QF9oLRkdquOsQrrpqRo5M6Z
 FCffGCO1E/E3HgGgSrjxnYd3zGc3QYE3i1M7CKHS9W/OPimOERgi4cUWvBhsV4BKg8VlOGQcb
 4jS1WaY8kzuaD7RuKj0ytlCLxmHLwK4bC9KpuoUvyl6H9PPGOeE6Gk7IWS9e9wr4rHfqNs4Uu
 apItrLBdkJS+GvzRtfZY2wKk79prMGInobb9ikJblvWLR2cU4VKeS6PxOcHDFU03NVDYJJS/Z
 KyR6s/NXtNufCmv8PcfD5gGcmRS8MlYe4TKXP3YphMrl4ZaewLC3krdwbSGB9cjVTXYA6iBYS
 yw4GoJQompHl9d2h7NosEW9xj2oRaKwj06ip+T+ErhvTVGPcnZZEK7LzTb5Nff7WzRHmeev0e
 EP+Qo7Ii5INXEGeDmKWcfC8fZAFwxBiVfPrmjnsLzbQLjnHUxq2du6WXH562e+5uCvVgzT9mX
 EqBM5ke6rdkp2rQ9kAELxn4Lgh4QaRy6S0y2BrwvQqMAbx+dZzbLv3dol0ur8ty6AX+lcox+U
 8dHb6D0sbSG/mZISJP1g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The following sequence leads to a "BUG" assertion running under MacOS:

  !/bin/sh
  DIR=3Dgit-test-restore-p
  Adiarnfd=3D$(printf 'A\314\210')
  DIRNAME=3Dxx${Adiarnfd}yy
  mkdir $DIR &&
  cd $DIR &&
  git init &&
  mkdir $DIRNAME &&
  cd $DIRNAME &&
  echo "Initial" >file &&
  git add file &&
  echo "One more line"  >>file &&
  echo y | git restore -p . &&
  echo "OK"

 Initialized empty Git repository in /tmp/git-test-restore-p/.git/
 BUG: pathspec.c:495: error initializing pathspec_item
 Cannot close git diff-index --cached --numstat
 [snip]


The command `git restore` is run from a directory inside a Git repo.
The Git needs to split the $CWD into 2 parts:
The path to the repo and "the rest", if any.
"The rest" becomes a "prefix" later used inside the pathspec code.

As an example, "/path/to/repo/dir-inside-rep=C3=A5" would determine
"/path/to/repo" as the root of the repo, the place where the
configuration file .git/config is found.

The rest becomes the prefix ("dir-inside-rep=C3=A5"), from where the paths=
pec
machinery expands the ".", more about this later.
If there is a decomposed form, (making the decomposing visible like this),
"dir-inside-rep=C2=B0a" doesn't match "dir-inside-rep=C3=A5".

The solution is to read the config variable "core.precomposeunicode" early=
.
Then, if configured, precompose "prefix" (and argv) and handle the prefix
over into pathspec for expanding "." into a list of path names tracked by =
Git.

[1] git-bugreport-2021-01-06-1209.txt (git can't deal with special charact=
ers)
[2] https://lore.kernel.org/git/A102844A-9501-4A86-854D-E3B387D378AA@iclou=
d.com/

Reported-by: Daniel Troger <random_n0body@icloud.com>
Helped-By: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--
 This may need some refinements, but we need to start somewhere...
 Are there any good ideas how to improve the commit message ?
 Should the code in git.c be "hidden" in a function somewhere else ?
 Other comments are appreciated.


compat/precompose_utf8.c     | 24 ++++++++++++++++++++++++
 compat/precompose_utf8.h     |  2 ++
 git-compat-util.h            |  8 ++++++++
 git.c                        |  9 +++++++++
 t/t3910-mac-os-precompose.sh | 15 +++++++++++++++
 5 files changed, 58 insertions(+)

diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index 136250fbf6..06e371660f 100644
=2D-- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -36,6 +36,11 @@ static size_t has_non_ascii(const char *s, size_t maxle=
n, size_t *strlen_c)
 	return ret;
 }

+int precompose_read_config_gently(void)
+{
+	git_config_get_bool("core.precomposeunicode", &precomposed_unicode);
+	return precomposed_unicode =3D=3D 1;
+}

 void probe_utf8_pathname_composition(void)
 {
@@ -60,6 +65,25 @@ void probe_utf8_pathname_composition(void)
 	strbuf_release(&path);
 }

+char *precompose_string_if_needed(const char *in)
+{
+	size_t inlen =3D strlen(in);
+	size_t outlen;
+	char *out =3D NULL;
+	if ((has_non_ascii(in, inlen, NULL)) && (precomposed_unicode =3D=3D 1)) =
{
+		int saved_errno =3D errno;
+		out =3D reencode_string_len(in, inlen,
+					  repo_encoding, path_encoding,
+					  &outlen);
+		if (out && outlen =3D=3D inlen && !memcmp(in, out, outlen)) {
+			/* strings are identical: no need to return a new one */
+			free(out);
+			out =3D NULL;
+		}
+		errno =3D saved_errno;
+	}
+	return out;
+}

 void precompose_argv(int argc, const char **argv)
 {
diff --git a/compat/precompose_utf8.h b/compat/precompose_utf8.h
index 6f843d3e1a..ce82857d73 100644
=2D-- a/compat/precompose_utf8.h
+++ b/compat/precompose_utf8.h
@@ -28,6 +28,8 @@ typedef struct {
 	struct dirent_prec_psx *dirent_nfc;
 } PREC_DIR;

+int precompose_read_config_gently(void);
+char *precompose_string_if_needed(const char *in);
 void precompose_argv(int argc, const char **argv);
 void probe_utf8_pathname_composition(void);

diff --git a/git-compat-util.h b/git-compat-util.h
index 104993b975..f34854b66f 100644
=2D-- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -252,6 +252,14 @@ typedef unsigned long uintptr_t;
 #ifdef PRECOMPOSE_UNICODE
 #include "compat/precompose_utf8.h"
 #else
+static inline int precompose_read_config_gently(void)
+{
+	return 0;
+}
+static inline char *precompose_string_if_needed(const char *in)
+{
+	return NULL; /* no need to precompose a string */
+}
 static inline void precompose_argv(int argc, const char **argv)
 {
 	; /* nothing */
diff --git a/git.c b/git.c
index a00a0a4d94..f09e14f733 100644
=2D-- a/git.c
+++ b/git.c
@@ -421,6 +421,15 @@ static int run_builtin(struct cmd_struct *p, int argc=
, const char **argv)
 			prefix =3D setup_git_directory_gently(&nongit_ok);
 		}

+		if (precompose_read_config_gently()) {
+			precompose_argv(argc, argv);
+			if (prefix) {
+				const char *prec_pfx;
+					prec_pfx =3D precompose_string_if_needed(prefix);
+				if (prec_pfx)
+					prefix =3D prec_pfx; /* memory lost */
+			}
+		}
 		if (use_pager =3D=3D -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &=
&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager =3D check_pager_config(p->cmd);
diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 54ce19e353..bbbc50da93 100755
=2D-- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -191,6 +191,21 @@ test_expect_failure 'handle existing decomposed filen=
ames' '
 	test_must_be_empty untracked
 '

+test_expect_success "unicode decomposed: git restore -p . " '
+	DIRNAMEPWD=3Ddir.Odiarnfc &&
+	DIRNAMEINREPO=3Ddir.$Adiarnfc &&
+	export DIRNAMEPWD DIRNAMEINREPO &&
+	git init $DIRNAMEPWD &&
+	( cd $DIRNAMEPWD &&
+		mkdir $DIRNAMEINREPO &&
+		cd $DIRNAMEINREPO &&
+		echo "Initial" >file &&
+		git add file &&
+		echo "More stuff" >>file &&
+		echo y | git restore -p .
+	)
+'
+
 # Test if the global core.precomposeunicode stops autosensing
 # Must be the last test case
 test_expect_success "respect git config --global core.precomposeunicode" =
'
=2D-
2.30.0.155.g66e871b664

