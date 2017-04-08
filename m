Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F134C20970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbdDHN0N (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:13 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36789 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbdDHN0L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id q125so2434233wmd.3
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A+VEY7PIAWds0ueqFbBNbV6Kyb7uM7wizlvtqwB9Kxc=;
        b=WMR4w3GsKRU5dNsU6eZhuQVqNeDedZ36lxXD7pywVa08kl2FzynDfEJo2vRH4bt0T2
         XsIDejUtNt2kq5uDyuDUv6pSigq7VLtJYwkX/HWxjvWBN/8+GgRPN4HEbcFAhPah1bsW
         DE4d+IjSs3KIZUDnquKylFZq4octI6aIQiK7grYUC1RFBKSvUeJbx8COMbwipoTr7WLA
         pNnE3VXQ/kcNDYYQcxICArxMsAX0I+g4wTJ/v2LZqOrKBWHAY4QjVD3Z1eMcF8499LWF
         O8eaoIcP4zPmeQMY2gPCfweddmYOcVhxGCAueb+3TX+2zqJhkkGEY2jLsxJGbdYK6X1N
         d1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A+VEY7PIAWds0ueqFbBNbV6Kyb7uM7wizlvtqwB9Kxc=;
        b=E7MYkU7EIO0zkpzi1GJQboZYhG+CNzNEHkuh+FgXKF9wyyCOJxGrcUNAtKOaloFvK1
         qvlrluIQqJXy3+FyZcbW0ETmhYXe5M7QH997iM4AtMPag3zflRQXN0TmW4azUo03CTPq
         pYoeovhTSVqkH77Dx+tgo0VVsj789xM1pr2brYFHJqExQ+tKvwKoFnthv2sfKjK302u9
         YBvI8MfXmHEWohMun00BpCT+vOQI4ns3oe5JIFFtck7c1/h7Xx4DUlqUiVY9f6RJNdYW
         3cX666Jc2N/lbUjOBRw2xfgXjj6CgxEod1GbW9wtjwzbAaoURKOjws1W05y9n0VybeMD
         Lgwg==
X-Gm-Message-State: AN3rC/5OefXFqWSOgsXl4vDxj3eYxKL+nCwBxBVCuCQvFXpjaRqAscHR0AgHKBi/7E2HCg==
X-Received: by 10.28.111.134 with SMTP id c6mr3210314wmi.128.1491657964795;
        Sat, 08 Apr 2017 06:26:04 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/12] log: add -P as a synonym for --perl-regexp
Date:   Sat,  8 Apr 2017 13:25:00 +0000
Message-Id: <20170408132506.5415-7-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a short -P option as a synonym for the longer --perl-regexp, for
consistency with the options the corresponding grep invocations
accept.

This was intentionally omitted in commit 727b6fc3ed ("log --grep:
accept --basic-regexp and --perl-regexp", 2012-10-03) for unspecified
future use.

Since nothing has come along in over 4 1/2 years that's wanted to use
it, it's more valuable to make it consistent with "grep" than to keep
it open for future use, and to avoid the confusion of -P meaning
different things for grep & log, as is the case with the -G option.

As noted in the aforementioned commit the --basic-regexp option can't
have a corresponding -G argument, as the log command already uses that
for -G<regex>.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/rev-list-options.txt | 1 +
 revision.c                         | 2 +-
 t/t4202-log.sh                     | 9 +++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a02f7324c0..5b7fa49a7f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -91,6 +91,7 @@ endif::git-rev-list[]
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
+-P::
 --perl-regexp::
 	Consider the limiting patterns to be Perl-compatible regular expressions.
 	Requires libpcre to be compiled in.
diff --git a/revision.c b/revision.c
index 7ff61ff5f7..03a3a012de 100644
--- a/revision.c
+++ b/revision.c
@@ -1995,7 +1995,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
-	} else if (!strcmp(arg, "--perl-regexp")) {
+	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 00d0585253..6f7c74e027 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -320,8 +320,17 @@ test_expect_success 'log with various grep.patternType configurations & command-
 			--grep="(1|2)" >actual.fixed.short-arg &&
 		git log --pretty=tformat:%s -E \
 			--grep="\|2" >actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			git log --pretty=tformat:%s -P \
+				--grep="\((?=1)" >actual.perl.short-arg
+		fi &&
 		test_cmp expect.fixed actual.fixed.short-arg &&
 		test_cmp expect.extended actual.extended.short-arg &&
+		if test_have_prereq PCRE
+		then
+			test_cmp expect.perl actual.perl.short-arg
+		fi &&
 
 		git log --pretty=tformat:%s --fixed-strings \
 			--grep="(1|2)" >actual.fixed.long-arg &&
-- 
2.11.0

