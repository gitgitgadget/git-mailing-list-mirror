Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25EB31F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBHP5K (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:10 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39203 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBHP5I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:08 -0500
Received: by mail-wr0-f194.google.com with SMTP id f6so5227533wra.6
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySgEMHuYiBglpTXX9qnSznRYpx/xK7hMVvq9GMB74gg=;
        b=Q9AIxRfrMooEUgCr1p/NfYrSDTF32GkM2BMONLMrOUvw+oaxDV/YRpxn+CPbqoRpH+
         Vq7vGlyf0/Dq/0yLNixY4RngvxvThQn7qc2rwdtg81vTO05P9v1b1IY2q39ohDK+3ytv
         /GLdE5Mk2HQ79nJrRVq4ZgjMZGqQXetMFwmReeL80OG5FyLALoleMpNH8UsAy4Wxz+0N
         FojeztD+9HGHbDykqBUsWHBvpTn6E0MlLI7r2qN4saPr+w3KBjZ7vap17Cxz1kkKQVmV
         u4gy0riHsxc09GZNxuo3WQtZdB9sA+SQydWlxMGUBnTtFMUpl3QVBdb/hyGFxLk/mWxT
         KfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySgEMHuYiBglpTXX9qnSznRYpx/xK7hMVvq9GMB74gg=;
        b=E/9ZHccd+nWowmdY2gBt7yVj/IDMaTpKHLg21IpmhmP8VnPQfKQjldPAulQrgl9UA1
         uPLI/l2UXvqtbcQLPPygNOb+TVgKgH+G0lGbXpbmls4AnsRNsuA3cUzzx/qhvBrbkfKq
         wpZoH/OlklHVzVLm3hqXCIn1/7+x9+ZBzpBTz6F4LP8l3d68glPFqPnCZbnkvBb34Rro
         rwk1dIcY1xrJKOEB8IVhI84CBrMAqXEEaLuA6DwHsQo1UKnrvHUszcj8YApjiO8bZPG/
         Ko1zIRMejGuC/Qm9woJeAM0U5PSkAv1yjkVwOq2lIZbclVE/ebOuLEu0mwPycN4IRfIG
         0yqw==
X-Gm-Message-State: APf1xPAtzmLf0lsOV3z+nynH9pM0QOf39tvNAMxuSluWJCNQ8kF5LGSW
        5y/hUE61ZB4utrP7c6Eh7ZY=
X-Google-Smtp-Source: AH8x225Fafph9cIICxy4lP24looGOoQk4El2oLa5jFnm/tt4rWlY3JvcMFwFLnyaYj3i4Y3P+MPZ9g==
X-Received: by 10.223.166.133 with SMTP id t5mr1250278wrc.106.1518105427566;
        Thu, 08 Feb 2018 07:57:07 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:06 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/9] 'test_i18ngrep'-related fixes and improvements
Date:   Thu,  8 Feb 2018 16:56:47 +0100
Message-Id: <20180208155656.9831-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180126123708.21722-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second version of 'sg/test-i18ngrep'.

To recap, this patch series fixes a couple of bogus 'test_i18ngrep'
invocations (patches 1-4), tries to prevent similar bugs in the future
(patch 8), teaches 'test_i18ngrep' to be more informative on failure
(patch 9), and a bit of cleanups in between (patches 5-7).

Changes since the previous version [1]:

  - Use Junio's "last parameter must be file" suggestion instead of
    trying to read stdin in patch 8.
  - Squashed together the patches validating 'test_i18ngrep's
    parameters (patches 8 and 9), in the hope that this way I can
    better explain that the two checks are not redundant but
    complement each other.
  - Followed Simon's suggestion and dropped the now unnecessary curly
    brackets in patch 2.
  - Dropped a subshell in the last patch.  I initially used it to
    prevent the variable $f from leaking into the tests, since we
    can't use the 'local' keyword (yet), but other test helper
    function don't seem to care.
  - Fixed the placements of single quotes and '!' in error messages
    and redirected one more error message to stderr in the last patch.
  - Fixed a couple of typos in commit messages (the one Eric pointed
    out, but later noticed maybe 2-3 more).


[1] - https://public-inbox.org/git/20180126123708.21722-1-szeder.dev@gmail.com/T/


SZEDER Gábor (9):
  t5541: add 'test_i18ngrep's missing filename parameter
  t5812: add 'test_i18ngrep's missing filename parameter
  t6022: don't run 'git merge' upstream of a pipe
  t4001: don't run 'git status' upstream of a pipe
  t5510: consolidate 'grep' and 'test_i18ngrep' patterns
  t5536: let 'test_i18ngrep' read the file without redirection
  t: move 'test_i18ncmp' and 'test_i18ngrep' to 'test-lib-functions.sh'
  t: validate 'test_i18ngrep's parameters
  t: make 'test_i18ngrep' more informative on failure

 t/t4001-diff-rename.sh        | 11 ++++++---
 t/t5510-fetch.sh              |  9 +++-----
 t/t5536-fetch-conflicts.sh    |  2 +-
 t/t5541-http-push-smart.sh    |  2 +-
 t/t5812-proto-disable-http.sh |  5 +---
 t/t6022-merge-rename.sh       |  6 +++--
 t/test-lib-functions.sh       | 54 +++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh                 | 26 ---------------------
 8 files changed, 72 insertions(+), 43 deletions(-)

-- 
2.16.1.158.ge6451079d


diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
index 226a4920cd..872788ac8c 100755
--- a/t/t5812-proto-disable-http.sh
+++ b/t/t5812-proto-disable-http.sh
@@ -20,9 +20,7 @@ test_expect_success 'curl redirects respect whitelist' '
 	test_must_fail env GIT_ALLOW_PROTOCOL=http:https \
 			   GIT_SMART_HTTP=0 \
 		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
-	{
-		test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr
-	}
+	test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr
 '
 
 test_expect_success 'curl limits redirects' '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1f1d89d7ad..d936ecc0a5 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -719,9 +719,11 @@ test_i18ncmp () {
 # under GETTEXT_POISON this pretends that the command produced expected
 # results.
 test_i18ngrep () {
-	( read line ) &&
-	error "bug in the test script: data on test_i18ngrep's stdin;" \
-	      "perhaps a git command's output is piped into it?"
+	eval "last_arg=\"\${$#}\""
+
+	test -f "$last_arg" ||
+	error "bug in the test script: test_i18ngrep requires a file" \
+	      "to read as the last parameter"
 
 	if test $# -lt 2 ||
 	   { test "x!" = "x$1" && test $# -lt 3 ; }
@@ -740,21 +742,20 @@ test_i18ngrep () {
 		shift
 		! grep "$@" && return 0
 
-		echo >&2 "error: grep '! $@' did find a match in:"
+		echo >&2 "error: '! grep $@' did find a match in:"
 	else
 		grep "$@" && return 0
 
-		echo >&2 "error: grep '$@' didn't find a match in:"
+		echo >&2 "error: 'grep $@' didn't find a match in:"
 	fi
-	(
-		eval "f=\"\${$#}\""
-		if test -s "$f"
-		then
-			cat >&2 "$f"
-		else
-			echo "<File '$f' is empty>"
-		fi
-	)
+
+	if test -s "$last_arg"
+	then
+		cat >&2 "$last_arg"
+	else
+		echo >&2 "<File '$last_arg' is empty>"
+	fi
+
 	return 1
 }
 
