Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD8E31F453
	for <e@80x24.org>; Thu, 21 Feb 2019 21:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBUVlO (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 16:41:14 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:39925 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfBUVlN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 16:41:13 -0500
Received: by mail-wr1-f52.google.com with SMTP id l5so116199wrw.6
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 13:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hh961CJQ1uFECSxOyL9rl5Fqv1o8hWa3t6aeioUOcmo=;
        b=Ss3HMXAnkqMQTr4Ie+72L6LU2rkZRDYQDgAoLKMGxmRksx7InQqW4Cpx93uZjLV4Oj
         1y7PAA3yvaAFA+dR5AeQepEVjIP9jtoebPWN4y5gfbTiW9pOHetPx9QgY0TIR4oYg4sI
         alLiHf5/hhkaSjo2kfl3hz6gk3yf3RMB2xtApYzpc+1c3v0CZDpNHy20ipo3PY6ajtjQ
         cP4YO+htU+f5eN/YboaZfl0zyXAPmpOkU6nF5lxRP30rgc78oLNXJHqqjWDvvsm9fkYM
         rCTyH6IKnp8tZh3ZzasiGk8xvsCK0yozR4lKqRq0CvDRuiOgNmCAlDxuqg5lUjjj5T7u
         vb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hh961CJQ1uFECSxOyL9rl5Fqv1o8hWa3t6aeioUOcmo=;
        b=Qr4r/3zz58ngbbujvh6AdGqse6KMHaCP7KrggjSXn43TkRVE2vHJLlktZ3TSBDzJMA
         Ja1ynOZz6e0Ay8jsWWIXD8NyHeEGwVuE0N4vzSUjK4lVZwmRWWITuFAfauJ6qjFO6wAA
         g1zfgLZ4wAFNZ8CCOtukJa7VUmHo+CQXfPNg+jwjNhx9AuAROs822bvsGWKY0UO57zK5
         DlBLN3hwmCm2BPZJn8DNoZDmDha3H8zgZQHgD2Q04+a6xlYW7dVU3HupP+VM45QtVQpI
         vw2rSoMEtmmJKLZ/xllcbA7RuE+uJ0P5CytTtWW8TazkRTeisYt02tFrsiQEDPT86EAj
         v/9A==
X-Gm-Message-State: AHQUAuYsP0bRaO2Wb0zarYSAm4TeEC40a2plwpRTIG2D2u7ApyyoPpcy
        tZUIA19J0syLaOubFf5O/edlR3CxeeE=
X-Google-Smtp-Source: AHgI3IYm6gbe1zr2YpwMSM6XYPkYhikGN2eNb0U1wusHH/2HcoZNI9p3BtI3CmyG0OVECj1d1WCaFA==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr401865wru.21.1550785271040;
        Thu, 21 Feb 2019 13:41:11 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k6sm17536972wrq.82.2019.02.21.13.41.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 21 Feb 2019 13:41:10 -0800 (PST)
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
Subject: [PATCH 2/2] rebase: don't rebase linear topology with --fork-point
Date:   Thu, 21 Feb 2019 22:40:59 +0100
Message-Id: <20190221214059.9195-3-avarab@gmail.com>
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
 builtin/rebase.c                  |  6 ++++--
 t/t3421-rebase-topology-linear.sh | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7c7bc13e91..7a16b8051c 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1664,9 +1664,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * and if this is not an interactive rebase.
 	 */
 	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
-	    !is_interactive(&options) && !options.restrict_revision &&
+	    !is_interactive(&options) &&
 	    options.upstream &&
-	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
+	    (options.restrict_revision
+	     ? !oidcmp(&options.upstream->object.oid, &options.restrict_revision->object.oid)
+	     : !oidcmp(&options.upstream->object.oid, &options.onto->object.oid))) {
 		int flag;
 
 		if (!(options.flags & REBASE_FORCE)) {
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
2.21.0.rc0.258.g878e2cd30e

