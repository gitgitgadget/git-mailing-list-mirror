Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2687C433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 14:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbiBPOuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 09:50:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiBPOuM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 09:50:12 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BDF2A22BE
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:49:59 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so5199753ejc.1
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=wiXDPFiQG3g+2n/SCkAbP4s/kAjbObApsbUIy71fMJY=;
        b=PONCvzUdZoiN7M2kU5QJds+8l7frZOgikSx1/tssUg6Fc+b/XTQqJxuPS9hMxx5A9g
         B6PTIXYDyXNKITz8oQodox1NoMDjhuDRANJAPqqeD07nELFye0Zhf3RkNZd5j3o9swwn
         Gi9pA7MPNDRLwZpzpNnYwmY1+ZjYBWNwXw3uzpLA9JpEyROlV9TSqAf7XLRWbqnUJ6Kj
         Djuqte3uI3uG4kkUMXgo4NArLbINHYSn4fqiLNJov3Dd+Jg3CK1KP3Lm7tSk48nwbKiD
         9eazUfp6rNzM7VPi8c2i7PBZFT1+3+6yT2lsqSWiL3+MbGH7Le6pU0GVz+UL2ShVzgOk
         t0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=wiXDPFiQG3g+2n/SCkAbP4s/kAjbObApsbUIy71fMJY=;
        b=AEUE53wdpVeqcaiSsw9442hdHHrDDGbgjhqP2cwxd/8rf32TUTrczGPySjUdyyhgwn
         cB4GdY99Yw7yitzvdY4xMjFT0PCZ28KNvjAZpqWNtJ2pZ/RANiIsUmB46SB0HsFIzzC1
         KVCsukdYB6ioH1apy8NRIz8uL+tBWPmBPqFTupPsCGFdPpmgePo8HudE0HnFqB2Z/Dbt
         GfAhK4GMOrDWx9nM7mtkg8PKESASeCq9rZRAi45GHqcsozi5D224DeCQKVijepwYE5j/
         l7ni6TOHTp9x82WG50JvKOnAP+hQ/d/5rL4pAhqx1j0uFBzzP7VhwOu07Ed0cBVyizMk
         rz9g==
X-Gm-Message-State: AOAM531NK+Op2APgCJNa7/6fbYlGqe/PTQX2pLZSG31ZD9PSd9DF/b1+
        ZXoZD1Ke/J0etJ/4Gt23tWs=
X-Google-Smtp-Source: ABdhPJyWC0RDk5bXB7X8B3a9Eil0FlVhAbfBxwQzSqe06n9pmmBZxYG5YQhe5kwoWN5D5xltnOiRBQ==
X-Received: by 2002:a17:906:7d98:b0:6bb:b32b:d3bc with SMTP id v24-20020a1709067d9800b006bbb32bd3bcmr2515946ejo.126.1645022997280;
        Wed, 16 Feb 2022 06:49:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ee30sm1720041edb.4.2022.02.16.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 06:49:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nKLcx-003NBO-Di;
        Wed, 16 Feb 2022 15:49:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v2 1/4] xdiff: fix a memory leak
Date:   Wed, 16 Feb 2022 15:38:08 +0100
References: <pull.1140.git.1644404356.gitgitgadget@gmail.com>
 <pull.1140.v2.git.1645006510.gitgitgadget@gmail.com>
 <3fcb6c8036794a16c4aa9285e3ef70da02e2bc80.1645006510.git.gitgitgadget@gmail.com>
 <220216.86tuczt7js.gmgdl@evledraar.gmail.com>
 <10c8dfa8-ab98-4a46-8baa-97857bb914b0@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <10c8dfa8-ab98-4a46-8baa-97857bb914b0@gmail.com>
Message-ID: <220216.86h78yuar0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> Thanks for taking a look at this patch
>
> On 16/02/2022 10:28, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Feb 16 2022, Phillip Wood via GitGitGadget wrote:
>>=20
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> Although the patience and histogram algorithms initialize the
>>> environment they do not free it if there is an error. In contrast for
>>> the Myers algorithm the environment is initalized in xdl_do_diff() and
>>> it is freed if there is an error. Fix this by always initializing the
>>> environment in xdl_do_diff() and freeing it there if there is an
>>> error. Remove the comment in do_patience_diff() about the environment
>>> being freed by xdl_diff() as it is not accurate because (a) xdl_diff()
>>> does not do that if there is an error and (b) xdl_diff() is not the
>>> only caller.
>>>
>>> Reported-by: Junio C Hamano <gitster@pobox.com>
>>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>>> ---
>>>   xdiff/xdiffi.c     | 33 +++++++++++++++++----------------
>>>   xdiff/xhistogram.c |  3 ---
>>>   xdiff/xpatience.c  |  4 ----
>>>   3 files changed, 17 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>>> index 69689fab247..758410c11ac 100644
>>> --- a/xdiff/xdiffi.c
>>> +++ b/xdiff/xdiffi.c
>>> @@ -315,16 +315,19 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpp=
aram_t const *xpp,
>>>   	long *kvd, *kvdf, *kvdb;
>>>   	xdalgoenv_t xenv;
>>>   	diffdata_t dd1, dd2;
>>> +	int res;
>>>   -	if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_PATIENCE_DIFF)
>>> -		return xdl_do_patience_diff(mf1, mf2, xpp, xe);
>>> -
>>> -	if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_HISTOGRAM_DIFF)
>>> -		return xdl_do_histogram_diff(mf1, mf2, xpp, xe);
>>> +	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0)
>>> +		return -1;
>>>   -	if (xdl_prepare_env(mf1, mf2, xpp, xe) < 0) {
>>> +	if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_PATIENCE_DIFF) {
>>> +		res =3D xdl_do_patience_diff(mf1, mf2, xpp, xe);
>>> +		goto out;
>>> +	}
>>>   -		return -1;
>>> +	if (XDF_DIFF_ALG(xpp->flags) =3D=3D XDF_HISTOGRAM_DIFF) {
>>> +		res =3D xdl_do_histogram_diff(mf1, mf2, xpp, xe);
>>> +		goto out;
>>>   	}
>>>     	/*
>>> @@ -359,17 +362,15 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpp=
aram_t const *xpp,
>>>   	dd2.rchg =3D xe->xdf2.rchg;
>>>   	dd2.rindex =3D xe->xdf2.rindex;
>>>   -	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
>>> -			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) !=3D 0, &xenv) < 0) {
>>> -
>>> -		xdl_free(kvd);
>>> -		xdl_free_env(xe);
>>> -		return -1;
>>> -	}
>>> -
>>> +	res =3D xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
>>> +			   kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) !=3D 0,
>>> +			   &xenv);
>>>   	xdl_free(kvd);
>>> + out:
>>> +	if (res < 0)
>>> +		xdl_free_env(xe);
>>>   -	return 0;
>>> +	return res;
>>>   }
>> I wanted to test if this made some diff test pass under
>> SANITIZE=3Dleak
>> that didn't before, and my usual quick way to discover that is to run
>> the tests with something like this for testing:
>>=20=09
>> 	diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> 	index 758410c11ac..7811ce2a1d3 100644
>> 	--- a/xdiff/xdiffi.c
>> 	+++ b/xdiff/xdiffi.c
>> 	@@ -368,7 +368,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xppar=
am_t const *xpp,
>> 	 	xdl_free(kvd);
>> 	  out:
>> 	 	if (res < 0)
>> 	-		xdl_free_env(xe);
>> 	+		BUG("needed freeing");
>>=20=09
>> 	 	return res;
>> 	 }
>> But doing so has all tests passing, so either this code is
>> unreachable
>> or not reachable by any of our tests.
>
> Yeah, it is fixing a leak in the error path. The only possible error
> is an allocation failure and we die rather than returning in that case
> so the test suite is not going to tell us anything about this patch.

Indeed. I meant that comment as "here's the first thing I tried, and
when that didn't do anything I went digging further, and...".

>> More generally I think this patch is taking the wrong approach, why are
>> we trying to the members of a stack variable in xdl_do_diff(), when that
>> variable isn't ours, but is created by our caller? Why aren't they
>> dealing with it?
>
> They are not dealing with it because they do not initialize it - it is
> an "out" parameter that is used to return data to the caller. This
> patch changes the logic to "whoever initializes it is responsible for
> freeing it if there is an error". By doing that we localize the error
> handling to xdl_do_diff() and can leave the callers unchanged.

Yes, I'm saying that we're needlessly piling on complexity by continuing
with this pattern in the xdiff/ codebase. I think it's fair to question
the direction in general.

>> The main issue the memory handling is such a pain here is because of
>> that mixed ownership.
>> The below POC (and seems to pass tests) shows a way to do that,
>> which I
>> think in general is *much* simpler. I.e. sure we'll call free()
>> redundantly some of the time, but that'll be safe as long as we
>> zero-initialize the relevant struct.
>> The xdiff code is much harder to read & maintain than it needs to be
>> because it's trying to micro-optimize these sort of patterns.
>> E.g. with the diff below we'll now redundantly call the free on a
>> xe2
>> when we only used a xe1, but "who cares?" is my considered opinion on
>> that topic :)
>
> Then you should reread the cover letter and commit message and code
> comment in patch 3 that all mention avoiding a double free in that
> case. If you have any ideas how to make those clearer please let me
> know.

To use FREE_AND_NULL() instead of free()? Then double-freeing stops
being an issue, and we don't need to do the accounting.

> If xdl_do_diff(orig, mf2, xpp, &xe2) fails it frees any members of xe2
> that it allocated but it does not NULL them. If we then call=20
> xdl_free_env(&xe2) we will have a double free error.

Right. I'm saying that if you follow the chain from xdl_do_diff() down
we call e.g. xdl_do_patience_diff(), which then calls xdl_prepare_env(),
which will on failure call e.g. xdl_free_ctx(&xe->xdf2), i.e. freeing
specific things inside the "xe" struct that it specifically knows it
allocated on those codepaths.

If we instead stick to the rule that he who created the stack variable
is responsible for freeing it, we generally speaking avoid the need for
FREE_AND_NULL() over free(), but in either case the control flow becomes
much simpler and less verbose.

I.e. we do away with the incremental freeing because some function 3
stack frames down knows it populated 1/10 struct fields, instead it all
becomes:

 1. Do we own this variable? No, return -1 then. No freeing here.
 2. The thing that owns the variable calls free_thingy(&x)
 3. We created "x" with "x =3D { 0 }" so calling free() on all its fields i=
s safe
 4. We do just that.

It's a lot simpler at the cost of a tiny bit of redundant work, but in
these cases we're on the error path anyway, so it won't be a performance
issue.

That's how we tend to do it with all of git's internal APIs as far as
freeing is concerned, xdiff doesn't do it because it's externally
imported. But I think it's a better direction, and something that wolud
work for both git.git and libgit2.git (and the diff/code size isn't that
different).

>
>> By not trying to micro-optimize it like that the memory management and
>> ownership becomes so much easier to deal with.
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index 758410c11ac..6ad30a98b62 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -1054,19 +1054,19 @@ static void xdl_mark_ignorable_regex(xdchange_t =
*xscr, const xdfenv_t *xe,
>>   int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>>   	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
>>   	xdchange_t *xscr;
>> -	xdfenv_t xe;
>> +	xdfenv_t xe =3D { 0 };
>>   	emit_func_t ef =3D xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_d=
iff;
>> +	int status =3D 0;
>>     	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
>> -
>> -		return -1;
>> +		status =3D -1;
>> +		goto cleanup;
>>   	}
>>   	if (xdl_change_compact(&xe.xdf1, &xe.xdf2, xpp->flags) < 0 ||
>>   	    xdl_change_compact(&xe.xdf2, &xe.xdf1, xpp->flags) < 0 ||
>>   	    xdl_build_script(&xe, &xscr) < 0) {
>> -
>> -		xdl_free_env(&xe);
>> -		return -1;
>> +		status =3D -1;
>> +		goto cleanup;
>>   	}
>>   	if (xscr) {
>>   		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
>> @@ -1078,12 +1078,14 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xppar=
am_t const *xpp,
>>   		if (ef(&xe, xscr, ecb, xecfg) < 0) {
>>     			xdl_free_script(xscr);
>> -			xdl_free_env(&xe);
>> -			return -1;
>> +			status =3D -1;
>> +			goto cleanup;
>>   		}
>>   		xdl_free_script(xscr);
>>   	}
>> +
>> +cleanup:
>>   	xdl_free_env(&xe);
>>   -	return 0;
>> +	return status;
>>   }
>> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
>> index fff0b594f9a..4751eab9c12 100644
>> --- a/xdiff/xmerge.c
>> +++ b/xdiff/xmerge.c
>> @@ -685,7 +685,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_=
t *mf2,
>>   		xmparam_t const *xmp, mmbuffer_t *result)
>>   {
>>   	xdchange_t *xscr1, *xscr2;
>> -	xdfenv_t xe1, xe2;
>> +	xdfenv_t xe1 =3D { 0 };
>> +	xdfenv_t xe2 =3D { 0 };
>>   	int status;
>>   	xpparam_t const *xpp =3D &xmp->xpp;
>>   @@ -693,25 +694,25 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1,
>> mmfile_t *mf2,
>>   	result->size =3D 0;
>>     	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
>> -		return -1;
>> +		status =3D -1;
>> +		goto cleanup;
>>   	}
>>   	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
>> -		xdl_free_env(&xe1);
>> -		return -1;
>> +		status =3D -1;
>> +		goto cleanup;
>>   	}
>>   	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
>>   	    xdl_change_compact(&xe1.xdf2, &xe1.xdf1, xpp->flags) < 0 ||
>>   	    xdl_build_script(&xe1, &xscr1) < 0) {
>> -		xdl_free_env(&xe1);
>> -		return -1;
>> +		status =3D -1;
>> +		goto cleanup;
>>   	}
>>   	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
>>   	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
>>   	    xdl_build_script(&xe2, &xscr2) < 0) {
>>   		xdl_free_script(xscr1);
>> -		xdl_free_env(&xe1);
>> -		xdl_free_env(&xe2);
>> -		return -1;
>> +		status =3D -1;
>> +		goto cleanup;
>>   	}
>>   	status =3D 0;
>>   	if (!xscr1) {
>> @@ -730,6 +731,7 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_=
t *mf2,
>>   	xdl_free_script(xscr1);
>>   	xdl_free_script(xscr2);
>>   +cleanup:
>>   	xdl_free_env(&xe1);
>>   	xdl_free_env(&xe2);
>>   diff --git a/xdiff/xutils.c b/xdiff/xutils.c
>> index cfa6e2220ff..63fb2eee975 100644
>> --- a/xdiff/xutils.c
>> +++ b/xdiff/xutils.c
>> @@ -414,7 +414,8 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam_t=
 const *xpp,
>>   	 * ranges of lines instead of the whole files.
>>   	 */
>>   	mmfile_t subfile1, subfile2;
>> -	xdfenv_t env;
>> +	xdfenv_t env =3D { 0 };
>> +	int status =3D 0;
>>     	subfile1.ptr =3D (char *)diff_env->xdf1.recs[line1 - 1]->ptr;
>>   	subfile1.size =3D diff_env->xdf1.recs[line1 + count1 - 2]->ptr +
>> @@ -422,13 +423,16 @@ int xdl_fall_back_diff(xdfenv_t *diff_env, xpparam=
_t const *xpp,
>>   	subfile2.ptr =3D (char *)diff_env->xdf2.recs[line2 - 1]->ptr;
>>   	subfile2.size =3D diff_env->xdf2.recs[line2 + count2 - 2]->ptr +
>>   		diff_env->xdf2.recs[line2 + count2 - 2]->size - subfile2.ptr;
>> -	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0)
>> -		return -1;
>> +	if (xdl_do_diff(&subfile1, &subfile2, xpp, &env) < 0) {
>> +		status =3D -1;
>> +		goto cleanup;
>> +	}
>>     	memcpy(diff_env->xdf1.rchg + line1 - 1, env.xdf1.rchg,
>> count1);
>>   	memcpy(diff_env->xdf2.rchg + line2 - 1, env.xdf2.rchg, count2);
>>   +cleanup:
>>   	xdl_free_env(&env);
>>   -	return 0;
>> +	return status;
>>   }

