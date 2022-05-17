Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D14BC433EF
	for <git@archiver.kernel.org>; Tue, 17 May 2022 16:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350832AbiEQQV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 12:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiEQQV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 12:21:26 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CF72CE27
        for <git@vger.kernel.org>; Tue, 17 May 2022 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652804462;
        bh=6BH021DDUl/DGkoo7EpyqSgqvk+IumqtaCrQg6d9G2w=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Y2bsZjsfeGr+wlLVXHsM2yimvY+TumeeK1dUx3+e9CHxvuEo3Em1VrORItVYBEveK
         bYOk2i9QMaF2E0k56KmlXVxJvKIJ/uKmqmMbyPPphDMOYy0FP4tInVVYV8dD44UjOG
         gSN3PMapy1unb26UV9aLDXVyvjdnmVjlDCzvlKbs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([91.47.145.161]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MW9rM-1oNPxU1S4Q-00XzcT; Tue, 17
 May 2022 18:21:02 +0200
Message-ID: <dece627d-ccf8-2375-0c50-c59637e561d3@web.de>
Date:   Tue, 17 May 2022 18:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: Corrupt name-rev output
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Hurst <tom@hur.st>
References: <Ylw+M5wwUYKcLM+M@voi.aagh.net> <xmqq4k2otpkb.fsf@gitster.g>
 <CABPp-BGd8194tPo97Zmuu2xX_aqHYfBrVUX0F0r6EPAaUA3U2w@mail.gmail.com>
 <779eb30b-fdb9-81fb-5d43-c8d388c5cb5a@web.de>
 <340c8810-d912-7b18-d46e-a9d43f20216a@web.de>
 <220517.86sfp878zr.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220517.86sfp878zr.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qTP2sjl04PCjlpx9Y+7Iso2l6j+mYQnaF1jBaSetljdYcEnM5Fb
 dQ1vBdMuZJNfnqZ6mRnSLrs52hCtMh0ot4bFUj8qlbkdcfcfmpEXu3W418HH/3/yEtO07+w
 7llxnuEFaSD8zRz6rHgtZ/6FhF+9eqRaPFeARlSO2ih/8TpFsLuV1lozn0mpaUjdO4Cn5r+
 ybA8gKuHL2sSkzl27jGqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GO/CNdoCEho=:MHl8GZyp/2NPl47FkNhvY1
 v+wDr/g5EcUr/X1xexcFHVSkiTmDxHLdpG4lKRdm/fNrVWWuUVdtVlETKwLBcnxYEZwKVLx0R
 /z0L89LbB6brlHefnCXVp2zyfGZs5XETPz7+1WaBhkinf2xAIqsT8Fxvjs20/tXXnAFM+eOoj
 PyyMXBMThjdRn/HKvouLo8lcTCG+sT2NntawDsPyswUylCGq4IZXSLbJWG2+dpAUVyasO18yB
 b1G2cM+8qLlotUVSjTXdeqArYUY+bldW1leKw+yD9jW/our+ZT3gzqXQbtitP0UlAv9ttwlZ5
 fZXtJ7gq8ShdNI9BI+hBJI9yrkqC29pNRphi/bUbEGTuHb2TZDxtkGrcdxfe8Cdyh4HCyr6+1
 PO4UCUqQ7juWYn8aq+7OguTyxCq9n18Nn+DgPZONfbLcR0DZAkyaIbZmGT01AHD/98Km+LoCM
 gsqMXfWwiKv1bY94wBwXkvrxQAvX0AJZOwNCJtFlA/lgnBL+f2UVXFB3DaAWzBRzVqGIO8fOL
 +4t0yW0rlKWYkrco5ovoZ0CaGozRVbkaX/gBO4gyXD7njgIiq5+zajg7YOArp3FK/6e1Rcl64
 iLd9JardqYxDm7dvzPUgFApEkUhvZWN3xjMvLzY9T0JjjQ2I66VIOQg4vXO9cGF4iBnt+IOa/
 ut2sVcxbaK+9JUMj35OmH21OpdcRb+UDur/oLY40fUPhYrT0mvw0tJ/TwwKKpo1oE+XRA8AwR
 ZsFFfnxVarocSJpvuCsCUqjiw3tm/MffutrsRmPxXpvGTAL4KIQQJIjse/mU7ZUq//tA8rqJ8
 kEkkQ4czMb/YtN2wKxfRTJHvbH9cSOsY1Vdfnktk/2MnRbJM992st7KQp+70J6YGMlIVYzY9Z
 Dx4dWIG8j00XP1MsUtOyToLKpg34QBj4fj00uZpAEHebWRb5Nf3ttxqX7tkSBxH4uRvYSR/Hp
 iz2wtmASQJ5CQaFICSZiuCqrwJw4KW9eoczc7sdh5sG3mMiHFi3pIJKEahOUT6u8b3WWfjzcz
 KTkFTGlTWYs1lYSiYQxBKEbZsEEhhvVcssbg/owOYHbQEMjpTVev/TL6Wi/q89dbJAHGwWgT8
 6D0/NIuz75+BNRNnQ0J6nEGau6BdpvAbRhx
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.05.22 um 12:15 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Fri, Apr 22 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 21.04.22 um 19:55 schrieb Ren=C3=A9 Scharfe:
>>> Am 21.04.22 um 04:11 schrieb Elijah Newren:
>>>
>>>> Reverting 2d53975488 fixes the problem.
>>>
>>> That's a good band-aid.
>> Or perhaps it's all we need.  I can't replicate the original reduction
>> of peak memory usage for the Chromium repo anymore.  In fact, the very
>> next commit, 079f970971 (name-rev: sort tip names before applying,
>> 2020-02-05), reduced the number of times free(3) is called there from
>> 44245 to 5, and 3656f84278 (name-rev: prefer shorter names over
>> following merges, 2021-12-04) brought that number down to zero.
>>
>> I can't reproduce the issue with the hardenedBSD repo, by the way, but
>> e.g. with 'git name-rev 58b82150da' in the Linux repo.
>>
>> --- >8 ---
>> Subject: [PATCH] Revert "name-rev: release unused name strings"
>>
>> This reverts commit 2d53975488df195e1431c3f90bfb5b60018d5bf6.
>>
>> 3656f84278 (name-rev: prefer shorter names over following merges,
>> 2021-12-04) broke the assumption of 2d53975488 (name-rev: release unuse=
d
>> name strings, 2020-02-04) that a better name for a child is a better
>> name for all of its ancestors as well, because it added a penalty for
>> generation > 0.  This leads to strings being free(3)'d that are still
>> needed.
>>
>> 079f970971 (name-rev: sort tip names before applying, 2020-02-05)
>> already reduced the number of free(3) calls for the use case that
>> motivated the original patch (name-rev --all in the Chromium repository=
)
>> from ca. 44000 to 5, and 3656f84278 eliminated even those few.  So this
>> revert won't affect name-rev's performance on that particular repo.
>>
>> Reported-by: Thomas Hurst <tom@hur.st>
>> Helped-by: Elijah Newren <newren@gmail.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/name-rev.c | 21 +++++----------------
>>  1 file changed, 5 insertions(+), 16 deletions(-)
>>
>> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>> index c59b5699fe..02ea9d1633 100644
>> --- a/builtin/name-rev.c
>> +++ b/builtin/name-rev.c
>> @@ -18,7 +18,7 @@
>>  #define CUTOFF_DATE_SLOP 86400
>>
>>  struct rev_name {
>> -	char *tip_name;
>> +	const char *tip_name;
>>  	timestamp_t taggerdate;
>>  	int generation;
>>  	int distance;
>> @@ -84,7 +84,7 @@ static int commit_is_before_cutoff(struct commit *com=
mit)
>>
>>  static int is_valid_rev_name(const struct rev_name *name)
>>  {
>> -	return name && (name->generation || name->tip_name);
>> +	return name && name->tip_name;
>>  }
>>
>>  static struct rev_name *get_commit_rev_name(const struct commit *commi=
t)
>> @@ -146,20 +146,9 @@ static struct rev_name *create_or_update_name(stru=
ct commit *commit,
>>  {
>>  	struct rev_name *name =3D commit_rev_name_at(&rev_names, commit);
>>
>> -	if (is_valid_rev_name(name)) {
>> -		if (!is_better_name(name, taggerdate, generation, distance, from_tag=
))
>> -			return NULL;
>> -
>> -		/*
>> -		 * This string might still be shared with ancestors
>> -		 * (generation > 0).  We can release it here regardless,
>> -		 * because the new name that has just won will be better
>> -		 * for them as well, so name_rev() will replace these
>> -		 * stale pointers when it processes the parents.
>> -		 */
>> -		if (!name->generation)
>> -			free(name->tip_name);
>> -	}
>> +	if (is_valid_rev_name(name) &&
>> +	    !is_better_name(name, taggerdate, generation, distance, from_tag)=
)
>> +		return NULL;
>>
>>  	name->taggerdate =3D taggerdate;
>>  	name->generation =3D generation;
>
> I haven't dug into whether it's a false positive, but with this change
> GCC's -fanalyzer has started complaining about a potential NULL
> dereference:
>
>     builtin/name-rev.c:230:50: error: dereference of NULL =E2=80=98name=
=E2=80=99 [CWE-476] [-Werror=3Danalyzer-null-dereference]
>       230 |                                 generation =3D name->generat=
ion + 1;
>
> This "fixes" it, and passes all tests, but presumably a better fix
> involves the callers of get_commit_rev_name() (or that function itself)
> deciding if they're OK with NULL here earlier?:
>
> 	diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> 	index 02ea9d16330..1d3a620ac72 100644
> 	--- a/builtin/name-rev.c
> 	+++ b/builtin/name-rev.c
> 	@@ -209,6 +209,7 @@ static void name_rev(struct commit *start_commit,
> 	 		struct rev_name *name =3D get_commit_rev_name(commit);
> 	 		struct commit_list *parents;
> 	 		int parent_number =3D 1;
> 	+		assert(name);
>
> 	 		parents_to_queue_nr =3D 0;
>
>

It's a false positive AFAICS because we set the name of the first commit
to go into the queue with create_or_update_name(), then go through its
parents and set their name as well before putting them into the queue to
traverse ancestors recursively.  I.e. everything we pull from the queue
must have a non-NULL name, right?

This begs the question why a free(3) call would make a difference to the
analyzer -- it doesn't affect NULL pointers after all.

Another good question is whether we should remove the validity check and
use commit_rev_name_peek() directly instead of get_commit_rev_name() in
the loop since we know it must be valid.  This might save a few cycles
and perhaps calm down the analyzer.

Ren=C3=A9
