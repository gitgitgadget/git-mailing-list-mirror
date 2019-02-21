Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C10321F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfBUVlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:41:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37286 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfBUVlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:41:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so127374wrs.4
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLGD5GMRghrxsdvde09oPCsio/iX0+SA3TfPuUwkeTg=;
        b=icQCbyZD6/8s6BA4XaIw+Kh11f1+sUEgRHI8Nr7drkphbyk/xSft41HGx/jm4p9nqp
         +j5Air7i54FoogVBOct5nMh+H9GOnx7lsrTpPkto0nN11uxZeY5np5ZLeXaRffkTzh1a
         Ny3bGrrFHtomInZj7JfOGftB0KbkMHLEl3as897844TBMeyeLsXRhpMTQca8fVYvTdhk
         nPR6shMUsaZeC7guHJQUMXeYo0xjN8WwW3v0FZOIdhNiNGYzSw3jwYQGVvB5cVRNCTnq
         DmlRjxBvvF3B+0MJ0QcfSQoLIi7AG3mwuJJxNZ+qL3KHWD3l9TQgrvdlFY1MdFEFm4/m
         fDxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLGD5GMRghrxsdvde09oPCsio/iX0+SA3TfPuUwkeTg=;
        b=cnGkjjA95ep6IEf3TXyKgKc1l+pdfJnlhammj2DuY9rC3eWi1iDYgq3p9pwmNLlgJZ
         O1/74qku6SH6vG8R5n5ZPTuARtmc5i4SH5Na1neWBOeVUkV4VVD8Cz5HPc6OJ74bg9im
         LYJqf33LJ+Oi94HWbA88Ot2kcu7G7RZTVhYST2DRxvyOabIZ0Ait2dcBID3+OrYhBI18
         /hfGPLkthfy0lVov5NrlhpAAZvuQVPOyLhAWktj+pCKrao0BcxeHAm66Jw1n1pNKEby7
         EhZcwKMgQkXbE/4Iu/X/9qPZERrb/K47PwNk/ZEQEKfmNgt/NCiJyyR0ONXsvW4Qiwny
         eM4Q==
X-Gm-Message-State: AHQUAuZkqr6bKyfGbIsCEHAFp6LeMbSSS9kOopBD2aapJs5Kp4208JP8
        lCQazplhmAkKuiJz2rHOBp0RGbgT2i4=
X-Google-Smtp-Source: AHgI3Ia87ODGp2AZ8/M2iEAmlAbFaqPTGec1e57ntXgQiqdFIa4yr88jM2ixJb44IJCbN3B2Wkij5w==
X-Received: by 2002:a5d:6703:: with SMTP id o3mr402544wru.75.1550785269416;
        Thu, 21 Feb 2019 13:41:09 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17536972wrq.82.2019.02.21.13.41.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 13:41:08 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        John Keeping <john@keeping.me.uk>,
        Pratik Karki <predatoramigo@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] rebase tests: test linear branch topology
Date:   Thu, 21 Feb 2019 22:40:58 +0100
Message-Id: <20190221214059.9195-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190221151009.GA24309@sigill.intra.peff.net>
References: <20190221151009.GA24309@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests rebasing a linear branch topology to linear rebase tests
added in 2aad7cace2 ("add simple tests of consistency across rebase
types", 2013-06-06).

These tests are duplicates of two surrounding tests that do the same
with tags pointing to the same objects. Right now there's no change in
behavior being introduced, but as we'll see in a subsequent change
rebase can have different behaviors when working implicitly with
remote tracking branches.

While I'm at it add a --fork-point test, strictly speaking this is
redundant to the existing '' test, as no argument to rebase implies
--fork-point. But now it's easier to grep for tests that explicitly
stress --fork-point.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3421-rebase-topology-linear.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index 7274dca40b..b847064f91 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -31,6 +31,16 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
 
+test_expect_success 'setup branches and remote tracking' '
+	git tag -l >tags &&
+	for tag in $(cat tags)
+	do
+		git branch branch-$tag $tag || return 1
+	done &&
+	git remote add origin "file://$PWD" &&
+	git fetch origin
+'
+
 test_run_rebase () {
 	result=$1
 	shift
@@ -57,10 +67,28 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
+test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase failure -p
 
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* -f rewrites even if remote upstream is an ancestor" "
+		reset_rebase &&
+		git rebase $* -f branch-b branch-e &&
+		! test_cmp_rev branch-e origin/branch-e &&
+		test_cmp_rev branch-b HEAD~2 &&
+		test_linear_range 'd e' branch-b..
+	"
+}
+test_run_rebase success ''
+test_run_rebase success --fork-point
+test_run_rebase success -m
+test_run_rebase success -i
+test_have_prereq !REBASE_P || test_run_rebase success -p
+
 test_run_rebase () {
 	result=$1
 	shift
@@ -71,6 +99,7 @@ test_run_rebase () {
 	"
 }
 test_run_rebase success ''
+test_run_rebase success --fork-point
 test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
-- 
2.21.0.rc0.258.g878e2cd30e

