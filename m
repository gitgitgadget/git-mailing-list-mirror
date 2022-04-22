Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD095C43217
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 18:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiDVS7c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiDVS6f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 14:58:35 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E106A13A4F7
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 11:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1650653415;
        bh=ikR4tRh1gvIzF7XyijWyKJNxQck1DX8kWMdy3I9hCwE=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=q2LqpbUIgvAL95+WoiZwFibpK2Y1B/NUQe47p2hU7QMgQaD1KmI4sV2+HN+GAQF1Y
         PIghNz0+d1rZ2Gf02GQHT3VUQV8XRwDAKfUEGc6evDOd+NobJAqow+aBjfBu28lgz7
         FPcCk+0BM9AmsPs24hyM2pK53HOcei6aT0vtXZKQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.144]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1oAgBn1m3t-00keF5; Fri, 22
 Apr 2022 20:44:42 +0200
Message-ID: <340c8810-d912-7b18-d46e-a9d43f20216a@web.de>
Date:   Fri, 22 Apr 2022 20:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: Corrupt name-rev output
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Thomas Hurst <tom@hur.st>
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net> <xmqq4k2otpkb.fsf@gitster.g>
 <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
 <779eb30b-fdb9-81fb-5d43-c8d388c5cb5a@web.de>
In-Reply-To: <779eb30b-fdb9-81fb-5d43-c8d388c5cb5a@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q6Ara6+3/eBKPR78pMkCYeaEzBMfHKDUqKRXN+0Gh8hb8Azdo9o
 /ciBVfR/LjEDNhTBbBTqj5Yy/8LyXRVpaClT0q7C4r9W66j1hCbsiKrRKAXVcTmyZnUMegH
 0T77a6oRhxwicpimJXjPJYw455VwQKzQpnmS3XtoPu1mH7sU7zPRU0/aS7RlvX47MSPf6eo
 Vc4OQuMZQFgK5CmIsb9yA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KWnU8oxY9W8=:DnkC42kN1SXuzPdKi9WuV1
 UfTJh2leW4YS9O2ZfXbri6U9pjOjLVjJdj3tM5PIjxgBtmRvetymOMXnT6X/bV9aG4C5x9XyL
 WCsj4w2PbGyQtnpaQXk2i4WXTB8kfDG0phxKma+ahrNn5gg+X4aDSj9vIDC4hAa+IUNz0pGar
 6gkDlQaJ14v+1dM3TR4AXfyQEFHRf7+6rubta4EOaDQLvLbixgE6dlWCabwyF84cCUJcosNp7
 WTpogu267ingIBFgyQnmapKB9k1tChItp8r5WxgEouaXWzOA1BbUi+MbhfEWVyDFtOnQKjUVU
 apMmWFJPAtFPW59bwswodlrgwaLJiJ3EsdSO8X+/0a412kvVf8CI0RDso9Trw4jpi1zKy29v8
 LCmIuG11pd2JgTM6+dsdgilDYIjlCWw0EKZN+k1a0SZIPLgVi8Pb8+NhDTxUQW5oWCf1hzHo2
 3zVUUObVn4oxKjQxiasmAI255AZ0HMmfX+ApszSvA0OEN6aX0m0xsoJ9WF7hEPTX30OvoElvd
 iv5djqvwC4MltTOuN7kqSnq4hdmrSSNE1lw1ub0zjxlXnQFOTqiS582IoVe7M170Axqbhwq6G
 /xYlfb6/0OqQjOBs/qlJO3GSG1GF9VAyOM8mYXDQ4PW2e9oo/XqqZyW2ACnFYpqc4CAtKF9JY
 PZyLHWieJKUSC4VsoXs+BX13G/qrkosgG6NddZlLS5FJPeDxPOkSfnysK9NPQzVRyDR3imM1A
 qs6Kp1k1Tqdm+yLfR5Ktp+Kh3ReeG/s3v38fRJFUlgGxvlhcSTzWHkHpydttCgf2TjOtSxcMi
 euaL3RRGNMwuty18368wzFpXc8Fe4P1DTKCPuvp83IY58tjXAaEHGxGoHozdIPqjwR/LHeotX
 dDO+lRmcdbWWKw2rapp3sEFXJ9x0ziqnk4QbXbOyBBuD20lA3ALDEGXTWW7Z4JlHIqZabPgPT
 bMhxk2A60h5kyLWuK+afZ4tR4Jdq1TzVBnl0IpkE3dW8a1TnFCtzQDOuMZTPDRb8+fcPfVM8l
 +qRzCF1CzY/65JLBp+E8BI7Rna75iUQw3Rx9bSWUycPPnkyuTO101i+JmUWb6lj4oQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.04.22 um 19:55 schrieb Ren=C3=A9 Scharfe:
> Am 21.04.22 um 04:11 schrieb Elijah Newren:
>
>> Reverting 2d53975488 fixes the problem.
>
> That's a good band-aid.
Or perhaps it's all we need.  I can't replicate the original reduction
of peak memory usage for the Chromium repo anymore.  In fact, the very
next commit, 079f970971 (name-rev: sort tip names before applying,
2020-02-05), reduced the number of times free(3) is called there from
44245 to 5, and 3656f84278 (name-rev: prefer shorter names over
following merges, 2021-12-04) brought that number down to zero.

I can't reproduce the issue with the hardenedBSD repo, by the way, but
e.g. with 'git name-rev 58b82150da' in the Linux repo.

=2D-- >8 ---
Subject: [PATCH] Revert "name-rev: release unused name strings"

This reverts commit 2d53975488df195e1431c3f90bfb5b60018d5bf6.

3656f84278 (name-rev: prefer shorter names over following merges,
2021-12-04) broke the assumption of 2d53975488 (name-rev: release unused
name strings, 2020-02-04) that a better name for a child is a better
name for all of its ancestors as well, because it added a penalty for
generation > 0.  This leads to strings being free(3)'d that are still
needed.

079f970971 (name-rev: sort tip names before applying, 2020-02-05)
already reduced the number of free(3) calls for the use case that
motivated the original patch (name-rev --all in the Chromium repository)
from ca. 44000 to 5, and 3656f84278 eliminated even those few.  So this
revert won't affect name-rev's performance on that particular repo.

Reported-by: Thomas Hurst <tom@hur.st>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index c59b5699fe..02ea9d1633 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -18,7 +18,7 @@
 #define CUTOFF_DATE_SLOP 86400

 struct rev_name {
-	char *tip_name;
+	const char *tip_name;
 	timestamp_t taggerdate;
 	int generation;
 	int distance;
@@ -84,7 +84,7 @@ static int commit_is_before_cutoff(struct commit *commit=
)

 static int is_valid_rev_name(const struct rev_name *name)
 {
-	return name && (name->generation || name->tip_name);
+	return name && name->tip_name;
 }

 static struct rev_name *get_commit_rev_name(const struct commit *commit)
@@ -146,20 +146,9 @@ static struct rev_name *create_or_update_name(struct =
commit *commit,
 {
 	struct rev_name *name =3D commit_rev_name_at(&rev_names, commit);

-	if (is_valid_rev_name(name)) {
-		if (!is_better_name(name, taggerdate, generation, distance, from_tag))
-			return NULL;
-
-		/*
-		 * This string might still be shared with ancestors
-		 * (generation > 0).  We can release it here regardless,
-		 * because the new name that has just won will be better
-		 * for them as well, so name_rev() will replace these
-		 * stale pointers when it processes the parents.
-		 */
-		if (!name->generation)
-			free(name->tip_name);
-	}
+	if (is_valid_rev_name(name) &&
+	    !is_better_name(name, taggerdate, generation, distance, from_tag))
+		return NULL;

 	name->taggerdate =3D taggerdate;
 	name->generation =3D generation;
=2D-
2.35.3
