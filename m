Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E88251F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfEHANY (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:24 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36737 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfEHANX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so805085wmj.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXRWMsZT/qc/53u+nOt5zasjNqocie6lPJeJXK8vOk8=;
        b=J21oC9acuCZ1l/OXeofTvN5RX3kCc3Gii/coVULbuc4ndAtVVY9nguuBZIIARSRlQP
         HUgSj4mGXCH74EhjNYLlZHybLpwHoJsJHgF/wZj8RRAIHXhKSA2dLV0KtKTQokM8MeGl
         eMUWr9gbz9DcrCM0je5BZPfSwJt+E+gGpXBxB9ArNo0DRiJ9HL/bv4T5813fyguZYamZ
         g/mhbK2VpmxIGo2MbQCPz2Pyr2Ao2YByJta7WGFkissVVB3+VIqMutnXulBlJ3XU/xex
         BVkqqsTCBDTZfAxD9KbF6P7JaaLLfNqc/OuTmUeWMsPa/zdpeWO86op1fgRIGzAVQE73
         /w1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXRWMsZT/qc/53u+nOt5zasjNqocie6lPJeJXK8vOk8=;
        b=Cv3ICZg4Uux905uFcPD7Xzd+5tgmmCtmnOPtXHuF2JEUeiWu80f+3BueBfZkIMGHNW
         LVF3kASmaZqhoZx3q8/pxlLNZrpm0qsFFiBfMuELRF1Q25vl4yoLT74nMT4vJdfTTP2d
         XLXnpNXqZdmMfsiOjn01LyUeTpWEQp4rQDU9GPRXP0jljjpGTBiEx4SEYP5ZwbaI1TNk
         3umbCLcE1NXYr90uf1WbNW0llq/oJ9CfggYYhKShe3rxHJxutjPyIdl26dfXXsXuaU+7
         qzsrbCy46qI9iZQdbmdWISSBlDvzHts8MfXnwLqjRlMsadvdvcZRS08SmJ5qx0kSnuJS
         D+Og==
X-Gm-Message-State: APjAAAWs2T3R6XK9S/3a3QQGbYX5o8xiDAi8oT461avUDq6hjkhsMWkU
        o2h+3XhW2/+Wx0WbfVdb+Mx/FEsbreg=
X-Google-Smtp-Source: APXvYqxZfucE6ZeyRCSUn5bFGIUlahT+hrMOz7EMNaDLzhg/hyDBgvQFsBdJRkKudNx9EFAiDa9Ypg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr792112wmk.66.1557274401244;
        Tue, 07 May 2019 17:13:21 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC WIP PATCH v8 10/13] rebase: don't rebase linear topology with --fork-point
Date:   Wed,  8 May 2019 02:12:49 +0200
Message-Id: <20190508001252.15752-11-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression introduced in 4f21454b55 ("merge-base: handle
--fork-point without reflog", 2016-10-12).

Before that change having a linear history on top of an upstream
master would with --fork-point (aka argument-less rebase) tell us
there was nothing to be done:

    $ git rebase
    Current branch master is up to date.

After that change "rebase" will always redundantly find that it has
work to do (it doesn't):

    $ git rebase
    First, rewinding head to replay your work on top of it...
    Applying: [...]

Whereas equivalently running:

    $ git rebase @{upstream}
    $ git rebase $(git merge-base --fork-point @{u})

Gives us the old behavior of doing nothing.

Now, why did we have this regression? Fully digging into it yields an
interesting combination of causes:

Way back in 1308c17b3e ("Allow rebase to run if upstream is completely
merged", 2007-07-04) "rebase" learned to not do this redundant work
when asked to rebase on a commit that was already an ancestor of the
current commit.

Then in 1e0dacdbdb ("rebase: omit patch-identical commits with
--fork-point", 2014-07-16) a rebase bug was fixed for a case where the
history to be rebased was divergent by entirely skipping the 2007-era
logic if --fork-point was provided.

But here's the critical thing, *only* if the --fork-point was
divergent. At that time "git merge-base --fork-point A B" would return
nothing if the two commits weren't divergent.

Then in 4f21454b55 ("merge-base: handle --fork-point without reflog",
2016-10-12) which introduced the regression being fixed here, a bug
fix for "git merge-base --fork-point" being run stand-alone by proxy
broke this use-case git-rebase.sh was relying on, since it was still
assuming that if we didn't have divergent history we'd have no output.

Finally, when "rebase" was rewritten in C a combination of
9a48a615b4 ("builtin rebase: try to fast forward when possible",
2018-09-04), 103148aad8 ("merge-base --fork-point: extract libified
function", 2018-09-04) and 92d0d74e8d ("builtin rebase: support
`fork-point` option", 2018-09-04) faithfully re-implemented the
then-buggy behavior.

So let's fix this. It's easy enough, we just stop explicitly excluding
--fork-point from the can_fast_forward(...) test we're doing, which as
discussed above is faithfully ported over from buggy shellscript-era
logic.

I'm not bothering to fix this in the legacy rebase mode. As discussed
in 9aea5e9286 ("rebase: fix regression in rebase.useBuiltin=false test
mode", 2019-02-13) it'll be going away shortly after 2.21.0 lands.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3421-rebase-topology-linear.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
index b847064f91..1754537789 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -55,6 +55,21 @@ test_run_rebase success -m
 test_run_rebase success -i
 test_have_prereq !REBASE_P || test_run_rebase success -p
 
+test_run_rebase () {
+	result=$1
+	shift
+	test_expect_$result "rebase $* is no-op if remote upstream is an ancestor" "
+		reset_rebase &&
+		GIT_TEST_REBASE_USE_BUILTIN=true git rebase $* branch-b branch-e &&
+		test_cmp_rev e HEAD
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
-- 
2.21.0.1020.gf2820cf01a

