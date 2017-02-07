Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A91E1FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932098AbdBGUBj (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:01:39 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34730 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbdBGUBg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:01:36 -0500
Received: by mail-pg0-f53.google.com with SMTP id 14so41395530pgg.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lwwNokx7YpYqiyMv2iT7PvHumSUOnL8gF/Ftn1tc4sE=;
        b=pu1hvdUor/WUIjFhjx9jwcPUGXxXWsyIJJqvYhsiGy72OszHCD88xTmHQu7RD9nHFN
         4XwB/BeVfq1FwXqL3/Jgy6SlmZ4Af/cBzI+/DCD7+4vj2Jr5UJKuQ0X/Pq0vaTBDASjI
         nD0rvW2VuaWR+RQU8i6LNXnhJJXTYs/OS8aN5g88qDdpVieI/g5BNrKOLzETkEmyL5Fk
         uAYP7tnperJNJ+NgE0qLOcyJJ3Bkrnu3VlJKmJSjSqBuLhTHkOBTyNqjC3n+Az17Yld1
         fowktUdJKWbl9VbQF4MnxBMG9r1254OcDKmXsn+rXZRzb8xbe5LAfLQdJ+hpINjbzxbx
         qwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lwwNokx7YpYqiyMv2iT7PvHumSUOnL8gF/Ftn1tc4sE=;
        b=ZBVGkEbeax7J6I0X4ayQibNaJ9x7k5jpF59+/I34Uaq6FP9Q2vnIWWz79cZpxGdczb
         fjJjYMaKU6/sNI37ngLFY13l3gyyTQF+o/+YlFS/fnuP+7aVE70nZrgDW0cofQTIxnxz
         bQFXs0j4UCRBjjqq1+t9cis1gVrZEfFQ++1rgwuoxn/mMGM0puAcrrTaq6WOz6MhdX4S
         uxxlVryKV8UAv8TIfhYxpkwRTjSZbXB59IHj9M0dy9xbNj22BPvR2SBu08BjUhsgJqzk
         6ohP6/EuJN1dQl52k1PSy2Vmz+pTjKOPrqNzGYvPxBpjETPZG4LyEAI0ogdWO5RQ2Iwn
         jo7Q==
X-Gm-Message-State: AIkVDXJ2k0h7AhEqY5xD2Pa8H90VWhE5YJoDPzMkTBh1nLlR6jtCvnJfbIhswM24f6DE/A==
X-Received: by 10.98.33.66 with SMTP id h63mr21817360pfh.142.1486497695630;
        Tue, 07 Feb 2017 12:01:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id t15sm13697526pgn.18.2017.02.07.12.01.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:01:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Karthik Nayak <Karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
        <CAM0VKjmhO9NQLz9TDv5M3OhxSBt-JdjaouVT0pTA-a6mGaF4_A@mail.gmail.com>
Date:   Tue, 07 Feb 2017 12:01:33 -0800
In-Reply-To: <CAM0VKjmhO9NQLz9TDv5M3OhxSBt-JdjaouVT0pTA-a6mGaF4_A@mail.gmail.com>
        ("SZEDER =?utf-8?Q?G=C3=A1bor=22's?= message of "Tue, 7 Feb 2017 01:24:09
 +0100")
Message-ID: <xmqqlgthzs6a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> All failing tests fail with the same error:
>
>   fatal: unrecognized %(refname:strip=2) argument: strip=2
>
> That's because of this topic:
>
>> * kn/ref-filter-branch-list (2017-01-31) 20 commits

Ahh, of course.

Let's make sure the series won't escape to 'master' before the
"strip" breakage is fixed.  How about queuing this on top of the
ref-filter topic?  

It seems to unblock your completion-refs-speedup topic and makes the
test pass ;-)

Thanks.

-- >8 --
Subject: [PATCH] ref-filter: resurrect "strip" as a synonym to "lstrip"

We forgot that "strip" was introduced at 0571979bd6 ("tag: do not
show ambiguous tag names as "tags/foo"", 2016-01-25) as part of Git
2.8 (and 2.7.1), yet in the update to ref-filter, we started calling
it "lstrip" to make it easier to explain the new "rstrip" operation.

We shouldn't have renamed the existing one; "lstrip" should have
been a new synonym that means the same thing as "strip".  Scripts
in the wild are surely using the original form already.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-for-each-ref.txt |  2 ++
 ref-filter.c                       |  3 ++-
 t/t6300-for-each-ref.sh            | 12 ++++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 2008600e7e..111e1be6f5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -107,6 +107,8 @@ refname::
 	enough components, the result becomes an empty string if
 	stripping with positive <N>, or it becomes the full refname if
 	stripping with negative <N>.  Neither is an error.
++
+`strip` can be used as a synomym to `lstrip`.
 
 objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
diff --git a/ref-filter.c b/ref-filter.c
index 01b5c18ef0..2a94d6da98 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -112,7 +112,8 @@ static void refname_atom_parser_internal(struct refname_atom *atom,
 		atom->option = R_NORMAL;
 	else if (!strcmp(arg, "short"))
 		atom->option = R_SHORT;
-	else if (skip_prefix(arg, "lstrip=", &arg)) {
+	else if (skip_prefix(arg, "lstrip=", &arg) ||
+		 skip_prefix(arg, "strip=", &arg)) {
 		atom->option = R_LSTRIP;
 		if (strtol_i(arg, 10, &atom->lstrip))
 			die(_("Integer value expected refname:lstrip=%s"), arg);
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 25a9973ce9..c87dc1f8bc 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -59,18 +59,26 @@ test_atom head refname:rstrip=1 refs/heads
 test_atom head refname:rstrip=2 refs
 test_atom head refname:rstrip=-1 refs
 test_atom head refname:rstrip=-2 refs/heads
+test_atom head refname:strip=1 heads/master
+test_atom head refname:strip=2 master
+test_atom head refname:strip=-1 master
+test_atom head refname:strip=-2 heads/master
 test_atom head upstream refs/remotes/origin/master
 test_atom head upstream:short origin/master
 test_atom head upstream:lstrip=2 origin/master
 test_atom head upstream:lstrip=-2 origin/master
 test_atom head upstream:rstrip=2 refs/remotes
 test_atom head upstream:rstrip=-2 refs/remotes
+test_atom head upstream:strip=2 origin/master
+test_atom head upstream:strip=-2 origin/master
 test_atom head push refs/remotes/myfork/master
 test_atom head push:short myfork/master
 test_atom head push:lstrip=1 remotes/myfork/master
 test_atom head push:lstrip=-1 master
 test_atom head push:rstrip=1 refs/remotes/myfork
 test_atom head push:rstrip=-1 refs
+test_atom head push:strip=1 remotes/myfork/master
+test_atom head push:strip=-1 master
 test_atom head objecttype commit
 test_atom head objectsize 171
 test_atom head objectname $(git rev-parse refs/heads/master)
@@ -636,6 +644,10 @@ EOF
 test_expect_success 'Verify usage of %(symref:lstrip) atom' '
 	git for-each-ref --format="%(symref:lstrip=2)" refs/heads/sym > actual &&
 	git for-each-ref --format="%(symref:lstrip=-2)" refs/heads/sym >> actual &&
+	test_cmp expected actual &&
+
+	git for-each-ref --format="%(symref:strip=2)" refs/heads/sym > actual &&
+	git for-each-ref --format="%(symref:strip=-2)" refs/heads/sym >> actual &&
 	test_cmp expected actual
 '
 
-- 
2.12.0-rc0-144-g99fe1a5456

