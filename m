Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB1DF1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 03:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbeIGI2q (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 04:28:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35578 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbeIGI2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 04:28:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so13483215wre.2
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 20:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ID3IAohOjB1sTmhD9Z6OoDO1Ob7WscGXxY36qr2Oz9c=;
        b=ExRmQghda0GlKz9fH024xyTyLYAQobQkgRp8NPGAM97/vxcWr9lVzjSJWo2+7khy2j
         zMOxAdfcDiXoVCwc5jIQeqYneALPzQ4QI1Z0w67iwhqeQBBViNCor0Ri0KCjx1MOHiNu
         CZy1tYb15pqhfsAvjezqk5f0ixjXopKdhbaeHh0wPtvdKj4/ZOQVcCp4u1VKKs/J4dHT
         WOFFXNwVfleG8ks7sYU98g8rCSe7IhkK6vnLxOiSVdGhU2wy3ACMzvgz+rY7UhOhb8D9
         WlYO3x3K9rjzSn6sl3AWkHI0UJeOSNn/JlzSxPMB2Q1aV086WGBZcvU1zlTJ17xAabPw
         bn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ID3IAohOjB1sTmhD9Z6OoDO1Ob7WscGXxY36qr2Oz9c=;
        b=pQ/sv8DMJ1+CG2Xxudktn+GrgOlxwNU0tnaaMaDV6yhM8JlrS3U6Jrto6EqV8Wba2x
         V2tFPsvqJxLvINrPoTCTCUEBEbnfUUAp3HW74r0CGamN4OwpmfJdMFpM2QJ082pxpTJb
         6nN+93z9+6UjjwzKFi/eBGfVB5yMw5m2n8FS5l0anifRk8bTMO+k9MPm3t/pYUteiYWS
         9IHm5686gQj9fdX0SP+C6dA2M7lObadoyxMAzI0/qxyQedP8H2oYygI+y9oaDFqV43Fm
         lGUvHsTPcYa6bXFd3aRnxAvlUXZFeH+vM1Z+poXHkiF346dLHtxvw3NPaFf5kix61Ber
         aooQ==
X-Gm-Message-State: APzg51DXq3YZVPV26RqjGWWSOQzO0IfU6LCqMq01sylM0r7un6LEd6Uq
        vEp/R+8F/WLgRajZReKX1qg=
X-Google-Smtp-Source: ANB0VdaIYGQiKUEWt95kbhDClBZ7FqS8w2aCGcqC0XAFiJ3FIZ5wApqFE6AgpN99l3rZECr8jQn0Og==
X-Received: by 2002:adf:9187:: with SMTP id 7-v6mr4626820wri.215.1536292190148;
        Thu, 06 Sep 2018 20:49:50 -0700 (PDT)
Received: from localhost (x590e1a0d.dyn.telefonica.de. [89.14.26.13])
        by smtp.gmail.com with ESMTPSA id d1-v6sm16163717wrc.52.2018.09.06.20.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 20:49:49 -0700 (PDT)
Date:   Fri, 7 Sep 2018 05:49:42 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: [RFC PATCH 5/5] split-index: smudge and add racily clean cache
 entries to split index
Message-ID: <20180907034942.GA10370@localhost>
References: <20180906024810.8074-1-szeder.dev@gmail.com>
 <20180906024810.8074-6-szeder.dev@gmail.com>
 <87va7ireuu.fsf@evledraar.gmail.com>
 <20180906151439.GA8016@localhost>
 <87lg8er6ir.fsf@evledraar.gmail.com>
 <87k1nyqzq2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1nyqzq2.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 07:53:41PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I got 436 OK runs with that and 3 failures before I gave up and ctrl+c'd
> it. And the 3 failures were:
> 
>     t3903-stash.sh               (Wstat: 256 Tests: 90 Failed: 1)
>       Failed test:  55
>       Non-zero exit status: 1
> 
> So it's back to failing on the same test as before your patches.

Ah, what a pity :)

Luckily, the tests in t3903 are mostly self-contained, and copying
test #55 into a dedicated test script still works.  Then running it
repeatedly is much faster than running the whole t3903, and failed in
a reasonable amount of time.  I could then eventually narrow it down
to the diff below, which fails rather reliably, in fact I've yet to
see it succeed.  Unfortunately, 'git stash' is rather busy with index
operations, and I couldn't figure out yet what exactly goes wrong or
how to turn it into a proper test.


diff --git a/git-stash.sh b/git-stash.sh
index 94793c1a91..04fa2a4f43 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -328,6 +328,7 @@ push_stash () {
 			git diff-index -p --cached --binary HEAD -- "$@" |
 			git apply --index -R
 		else
+			GIT_TEST_SPLIT_INDEX=yes \
 			git reset --hard -q
 		fi
 
@@ -671,6 +672,7 @@ apply_to_branch () {
 	set -- --index "$@"
 	assert_stash_like "$@"
 
+	sleep 1
 	git checkout -b $branch $REV^ &&
 	apply_stash "$@" && {
 		test -z "$IS_STASH_REF" || drop_stash "$@"
diff --git a/read-cache.c b/read-cache.c
index 8f644f68b4..9f39f29221 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2761,9 +2761,8 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 	}
 
 	if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0)) {
-		int v = si->base_oid.hash[0];
-		if ((v & 15) < 6)
-			istate->cache_changed |= SPLIT_INDEX_ORDERED;
+		/* always split, to make it more deterministic */
+		istate->cache_changed |= SPLIT_INDEX_ORDERED;
 	}
 	if (too_many_not_shared_entries(istate))
 		istate->cache_changed |= SPLIT_INDEX_ORDERED;
diff --git a/t/t9999-stash-vs-split-index.sh b/t/t9999-stash-vs-split-index.sh
new file mode 100755
index 0000000000..bc2b7ccf6b
--- /dev/null
+++ b/t/t9999-stash-vs-split-index.sh
@@ -0,0 +1,20 @@
+test_description='stash vs. split index'
+
+. ./test-lib.sh
+
+test_expect_success 'stash vs. split index' '
+	sane_unset GIT_TEST_SPLIT_INDEX &&
+	git config splitIndex.maxPercentChange 100 &&
+
+	echo foo >file &&
+	GIT_TEST_SPLIT_INDEX=yes git add file &&
+	git commit -m initial &&
+	echo bar >file &&
+	git stash &&
+	echo baz >file &&
+	test_when_finished "git checkout master" &&
+	test_must_fail git stash branch new_branch stash@{0} &&
+	git rev-parse stash@{0} --
+'
+
+test_done
-- 
2.19.0.rc2.140.g09cf9e37c9

