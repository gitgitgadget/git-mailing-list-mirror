Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15539C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 03:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiKXDrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 22:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiKXDra (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 22:47:30 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F6DB21
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id cl5so635063wrb.9
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 19:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=jryhdvXO5oogpifAalaLfO5haujwD/s/MJgrTiifznC8NbT3Pig2aR4rkx0za1/heY
         LnnklLAfCZK+metYjALHFSjF2khfmk3XaIs4SIejh4Xigfa+VVda0vXTm99aET2QWNfW
         mfswDS1ZzFFvB22lIJDmkcfGqiPDwkOf6X7Sp+WZKFJLfPjT1ax9WJ5Mz0uX8jrvQ+Ku
         OhXrg9bBsWZP2o1WiOFX5f1Yast7ax5+Djv69UQ2lf0z377intVZ7Dty3ff/f3rNun+h
         QlAFd4H8qe4xOH3nMxt8Dbzjzb09mKdbnfBsev048WTP3RYxZq6Qp9Z6P9mbS6/rkg8+
         9jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG7afdG0COHOmfVOMrCXQbc2WjB03eSnuN/yf/YSMAs=;
        b=WeDijd14trg4fMfpzVVnaZMLNtRAzVV+ixygJPuHjHZjTGvtI/qreyqxfjENQ4KDHa
         JFDhB51WD9zbyT+C1JiYXWIwP1uOgldx+hQ/o/hgbv00iWbbl8D5qq0923+O++k09ZGW
         XQnUiCxNo03oRM5HgZpONalvXNXqpfL8g9AHfW8eBz9dcbQRdItFg6KEb2wapFp6/73O
         XEBp4kwYgGcquxE6aImhlOlSJta4C69iXSbGOBv5EOCWU+aA4fxq7G49DDnZTJzg7JTa
         ViptpdfNORLG0MbPDsf4g1uraK0JzSMSf+0Vm2PfiFuiwDXbzVIAWDSmXYXMUK1wc2uS
         3irA==
X-Gm-Message-State: ANoB5pltE8/CWMXN+B0q1I6WLatkRSeeAyPuVt9Ql4Ne/mr6EA8YivOl
        2Ft/2dMbntbf3peBzyNP74vxskN0B28=
X-Google-Smtp-Source: AA0mqf4h03ZsVlvqRxeDR4T+fQ17M+B16kYWV9N8pukZ3o0kfbHaOizZKyqrtWsDHKDDQ2SZhxlMfg==
X-Received: by 2002:adf:e50b:0:b0:240:e14:cfa8 with SMTP id j11-20020adfe50b000000b002400e14cfa8mr18581635wrm.63.1669261645432;
        Wed, 23 Nov 2022 19:47:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d4002000000b00241727795c4sm107491wrp.63.2022.11.23.19.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:47:24 -0800 (PST)
Message-Id: <446777d300d73498bd7da709fad75731a13d0d59.1669261642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
References: <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
        <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
From:   "Yoichi Nakayama via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 03:47:20 +0000
Subject: [PATCH v6 1/3] git-jump: add an optional argument '--stdout'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama <yoichi.nakayama@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Yoichi Nakayama <yoichi.nakayama@gmail.com>

It can be used with M-x grep on Emacs.

Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
---
 contrib/git-jump/README   | 10 +++++++++-
 contrib/git-jump/git-jump | 25 ++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 8bcace29d21..3211841305f 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -79,6 +79,14 @@ git jump grep -i foo_bar
 git config jump.grepCmd "ag --column"
 --------------------------------------------------
 
+You can use the optional argument '--stdout' to print the listing to
+standard output instead of feeding it to the editor. You can use the
+argument with M-x grep on Emacs:
+
+--------------------------------------------------
+# In Emacs, M-x grep and invoke "git jump --stdout <mode>"
+M-x grep<RET>git jump --stdout diff<RET>
+--------------------------------------------------
 
 Related Programs
 ----------------
@@ -100,7 +108,7 @@ Limitations
 -----------
 
 This script was written and tested with vim. Given that the quickfix
-format is the same as what gcc produces, I expect emacs users have a
+format is the same as what gcc produces, I expect other tools have a
 similar feature for iterating through the list, but I know nothing about
 how to activate it.
 
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 92dbd4cde18..babb3b5c68d 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -2,7 +2,7 @@
 
 usage() {
 	cat <<\EOF
-usage: git jump <mode> [<args>]
+usage: git jump [--stdout] <mode> [<args>]
 
 Jump to interesting elements in an editor.
 The <mode> parameter is one of:
@@ -15,6 +15,9 @@ grep: elements are grep hits. Arguments are given to git grep or, if
       configured, to the command in `jump.grepCmd`.
 
 ws: elements are whitespace errors. Arguments are given to diff --check.
+
+If the optional argument `--stdout` is given, print the quickfix
+lines to standard output instead of feeding it to the editor.
 EOF
 }
 
@@ -64,11 +67,31 @@ mode_ws() {
 	git diff --check "$@"
 }
 
+use_stdout=
+while test $# -gt 0; do
+	case "$1" in
+	--stdout)
+		use_stdout=t
+		shift
+		;;
+	--*)
+		usage >&2
+		exit 1
+		;;
+	*)
+		break
+		;;
+	esac
+done
 if test $# -lt 1; then
 	usage >&2
 	exit 1
 fi
 mode=$1; shift
+if test "$use_stdout" = "t"; then
+	"mode_$mode" "$@"
+	exit 0
+fi
 
 trap 'rm -f "$tmp"' 0 1 2 3 15
 tmp=`mktemp -t git-jump.XXXXXX` || exit 1
-- 
gitgitgadget

