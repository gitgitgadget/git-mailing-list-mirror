Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48CBF1F744
	for <e@80x24.org>; Sun, 26 Jun 2016 05:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbcFZF60 (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 01:58:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36648 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcFZF6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 01:58:25 -0400
Received: by mail-lf0-f67.google.com with SMTP id a2so25669768lfe.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 22:58:24 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds0cK6eFskILaS3+OLoo+cakDShLoSkXxLa0yEhVSHE=;
        b=pPpA0rP+na6DoqwrPcaszWTiiMQRF8KIfKNJ8EnzCdhGtf5tEFUQtBnDThVRwbYz0V
         PDWgazcBCKx2WVd6ZLfq5Zk7O8Ie1WolartMfxKA945mNFw6r6YWtiYJmbuXg8jUZi95
         szAwoB6FXo21Onhci+mqAoMQDoej1xN2196Fn72RhINagfqMn+567Gr/kdf52coYZu4y
         c8+NLOm/Su1RsU+iz889boIesJZC3utX+TvvJwLWWnx22dfgqw0yaE24zF0SZp1q3gDd
         H0eJeZuExDEKyWm3N3F5YTyjmOATrIbhSVJm7JRnL1kmtfzefx2Fc5buJ7HBGHp6vISu
         5Bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds0cK6eFskILaS3+OLoo+cakDShLoSkXxLa0yEhVSHE=;
        b=dWF6GpoqxsqhP8ZjIPpB2Jk1FmRiKg1Xm3PqERoA0Gb2BJdt2Bm2NcHV9NDYFFM6I5
         AR9HK5U5OOUGNFe1kbWQgxAzOsB78x8Qv7xAkmXO4CU+43zSRbqtCyUddD0YxvYH1q0b
         EaGcsR2E5+nIJY6+xDYUDsmgmvCMDMj2WAkYwerVJ4utnWN5NkS9aVVSqJFCKHjRWVu9
         RJpk2x42C7XCxxuUBfo7RENpAQHyu63uFmnYbMfT017chcKBHTbdyAVh4O9PSaMti0EP
         vjahy0cwHWTmo1PwlFI0GkKtpsFKgziF1SmPHphNtjBI4XE/IZzv8FPGUS4IoHZroHmX
         QU2g==
X-Gm-Message-State: ALyK8tIdn7V9gC9GQPX/VmWrvuPb1mRSoJeO5NqnPhkAVTPhnOGey5viCnjIfKE2iiC+BA==
X-Received: by 10.25.18.234 with SMTP id 103mr4093357lfs.118.1466920703728;
        Sat, 25 Jun 2016 22:58:23 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g24sm2123775ljg.20.2016.06.25.22.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 22:58:22 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	marcnarc@xiplink.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 1/5] git-fetch.txt: document fetch output
Date:	Sun, 26 Jun 2016 07:58:06 +0200
Message-Id: <20160626055810.26960-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160626055810.26960-1-pclouds@gmail.com>
References: <20160605031141.23513-1-pclouds@gmail.com>
 <20160626055810.26960-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This documents the ref update status of fetch. The structure of this
output is defined in [1]. The ouput content is refined a bit in [2]
[3] [4].

This patch is a copy from git-push.txt, modified a bit because the
flag '-' means different things in push (delete) and fetch (tag
update).

PS. For code archaeologists, the discussion mentioned in [1] is
probably [5].

[1] 165f390 (git-fetch: more terse fetch output - 2007-11-03)
[2] 6315472 (fetch: report local storage errors ... - 2008-06-26)
[3] f360d84 (builtin-fetch: add --prune option - 2009-11-10)
[4] 0997ada (fetch: describe new refs based on where... - 2012-04-16)
[5] http://thread.gmane.org/gmane.comp.version-control.git/61657

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-fetch.txt | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index efe56e0..cbf441f 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -99,6 +99,52 @@ The latter use of the `remote.<repository>.fetch` values can be
 overridden by giving the `--refmap=<refspec>` parameter(s) on the
 command line.
 
+OUTPUT
+------
+
+The output of "git fetch" depends on the transport method used; this
+section describes the output when fetching over the Git protocol
+(either locally or via ssh) and Smart HTTP protocol.
+
+The status of the fetch is output in tabular form, with each line
+representing the status of a single ref. Each line is of the form:
+
+-------------------------------
+ <flag> <summary> <from> -> <to> [<reason>]
+-------------------------------
+
+The status of up-to-date refs is shown only if the --verbose option is
+used.
+
+flag::
+	A single character indicating the status of the ref:
+(space);; for a successfully fetched fast-forward;
+`+`;; for a successful forced update;
+`x`;; for a successfully pruned ref;
+`-`;; for a successful tag update;
+`*`;; for a successfully fetched new ref;
+`!`;; for a ref that was rejected or failed to update; and
+`=`;; for a ref that was up to date and did not need fetching.
+
+summary::
+	For a successfully fetched ref, the summary shows the old and new
+	values of the ref in a form suitable for using as an argument to
+	`git log` (this is `<old>..<new>` in most cases, and
+	`<old>...<new>` for forced non-fast-forward updates).
+
+from::
+	The name of the remote ref being fetched from, minus its
+	`refs/<type>/` prefix. In the case of deletion, the name of
+	the remote ref is "(none)".
+
+to::
+	The name of the local ref being updated, minus its
+	`refs/<type>/` prefix.
+
+reason::
+	A human-readable explanation. In the case of successfully fetched
+	refs, no explanation is needed. For a failed ref, the reason for
+	failure is described.
 
 EXAMPLES
 --------
-- 
2.8.2.526.g02eed6d

