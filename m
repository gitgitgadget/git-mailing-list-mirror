Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFD232ED2C
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769597515; cv=none; b=FcocPoj6+/qJ/VxbTWVlHdDl2Akzucu3WiiDF7wZU5nV4zXrMDa7XkxViCSPLrsLzHWAE0p3HNfzjahNy3T7au1BHWHV/qL/NwTWRytPO271PR2PC1weZYAEjfXeSJ1eKEYRUxzZa2uxyoI9hbKdPINSgn0/PjyrdA5r9hZqiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769597515; c=relaxed/simple;
	bh=xkzHwrk95GRiWPOeHTw+0x+FDAEW0IhkXuYNYTafXLY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fx9IkJ7cn9Wpp8iQg/+lfAzxXfhfC7bp4J02R7lnnm7GR0vre5k7VX2uBUAaKjaFyvsS8g4rZip499AakLRkTxLSOqJq2A3QhRp6/nFPIsD+lulgfHHSnAGeLzdxF6MVVju+tqPoKSsK0ijWPKZQXgAZyk+pLy8p25zb5c3izjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0IE+x7y; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0IE+x7y"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so11669925e9.3
        for <git@vger.kernel.org>; Wed, 28 Jan 2026 02:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769597512; x=1770202312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Zz/FxBGdeZvAaJO7pmiL2tIq+WK+gembwBsYlib2uQ=;
        b=G0IE+x7yanLXjqb1zSbwnT2D9FIRoumL/y4rirrxkP7TTi/fMtXScY+1zMyp9KB0Iw
         74Unb+jWX/2NJmlArC3toxs23eIdtmrstfOUw4JDtWFjSKV+gY4eYGboqxT1xFqF7bkN
         7hIwpJcnaHZf1CkYu/g9huMRoBKdEtbSBm9ACZOUAP+LGFDRLws7NS18dAuMx+umXd35
         4BSmKQlSwoUidijXX3PSj4oYnTZCUSD+CRXnMdaR4Rvy0GKrZSOoJ33h8z2AUFbIDMo9
         CPMATNsaFPRaTpr52sr04gGYtRi4qjwrktQBnMv0KX0GDDCEvGmfTTtUsC752ZVIOaVB
         QwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769597512; x=1770202312;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Zz/FxBGdeZvAaJO7pmiL2tIq+WK+gembwBsYlib2uQ=;
        b=wur80/vIqrrtW7zoOVucDWm6AyVD91S2xmygvACkPwFTBQOaaTv25yRMNmpPUoJSnd
         sLV7jFSRPRmtIwyJplAkDEbHz055+KBc+7w215+Sjdk2dHwVMnhbLbs2nvD+VJiQ4F4L
         EznCNdH8iLlo2bn4OcPyjLVBKku9TJQvdLQj8AMsnyZihPK1sNCMVC+ZIehIthpUIyeT
         c8Yss779dnlkobYUK9E2IN57i1HCtMbqOdt/IpKABKkZpr9QEWHtdC9Og+5CyXHtF1TX
         KAwQRA8KwCkFebC5WiMW0xTgwUhUrW5WTIK5aGivfAK65lPCStNPJcSJVF2plqjMcqWV
         vfWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4SGXdlwjaqC/81Y8NsCJCbYX2JMGE6KZRYbcMhMfI2rK0gsrmYavRRfOuhgylUsS2aZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yFTfZiAVXvX9tqwgY27zVXuqu47sFoTegY2niW1YYD24d51c
	YNrZDy+uQxwzZ2C/VRU1o6N6kh8gO2GIWhPuBdTwCACQ5BR/djIJ2Mbe
X-Gm-Gg: AZuq6aJRDjSjgOKn7vtSiq+neJm5jGXM6iwkWPn0MKxXF3O5cbS+ZD+n+hBUoFER2KW
	EpovGxD1Y0JI17rX2TvliB1VzOtUJ4K41Dy3vWbHSmR+ClzgLSFYKlo4jCo7Aa+HD4cvcLQo3VK
	TxEELuAEJOB8WUqmPRByhG1ryKr7dk/gD1ebWHewHR2UMyf5zVedMbKm8NRsrKQ45w862cxrhQa
	N1y8UDB+xExERYOKanaweaxhH2iBOKs8bwWEjGWLcPiZtnaM0nCpWRVMtaza5HxzmjOt4/j7A7J
	fhhbjE0mVWTNDJVnPbBesfVx5O2tPGiVUg6xrFMCKRPZQW5Wp5Fwdw+0/nszAJ50O6gZ6SGR1mM
	QR1Dz51PmLaJLxMs1CyodVFvyIU+eJmUFz1OhaXXmA6IcRnld0QlzTv0eDBbPZGZ0Vff85DFV3p
	hK1N/OkTtprEIhjtk4ZFcWPqyOWvJbYHsertNZMy9VzIjiD3Lo4pLRB7nWnqd4XoPJpg==
X-Received: by 2002:a05:600c:6748:b0:47e:e970:cf28 with SMTP id 5b1f17b1804b1-48069c60743mr58998765e9.30.1769597511339;
        Wed, 28 Jan 2026 02:51:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cde00e8sm57768295e9.6.2026.01.28.02.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 02:51:50 -0800 (PST)
Message-ID: <79ea1b9c-47cd-4702-bcb2-05417adf9eae@gmail.com>
Date: Wed, 28 Jan 2026 10:51:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 07/10] xdiff: replace xdfile_t.dstart with
 xdfenv_t.delta_start
From: Phillip Wood <phillip.wood123@gmail.com>
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.git.git.1767379944.gitgitgadget@gmail.com>
 <d74722538b693fb26e8684f9dd3fbc319a2a575e.1767379944.git.gitgitgadget@gmail.com>
 <e9a031fd-072d-4810-b7e0-0d64ffedce10@gmail.com>
Content-Language: en-US
In-Reply-To: <e9a031fd-072d-4810-b7e0-0d64ffedce10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2026 16:32, Phillip Wood wrote:
> On 02/01/2026 18:52, Ezekiel Newren via GitGitGadget wrote:
>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>
>> Placing delta_start in xdfenv_t instead of xdfile_t provides a more
>> appropriate context since this variable only makes sense with a pair
>> of files. View with --color-words.
> 
> So as dstart and dend must be the same for both files we now store the 
> values once in xdfenv_t. 

Except it's only dstart that's the same, dend is different because it 
convinently stores an index, not an offset from the end. Having realized 
that, moving them to xdfenv_t makes less sense as having to calculate 
the dend index from an offset from the end of the array each time is a 
pain and sooner or later we'll make a mistake.

Thanks

Phillip

> That explains why we start passing xdfenv_t 
> around rather than xdfile_t in patch 5.
> 
> Thanks
> 
> Phillip
> 
>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>> ---
>>   xdiff/xhistogram.c |  4 ++--
>>   xdiff/xpatience.c  |  4 ++--
>>   xdiff/xprepare.c   | 17 +++++++++--------
>>   xdiff/xtypes.h     |  3 ++-
>>   4 files changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
>> index 5ae1282c27..eb6a52d9ba 100644
>> --- a/xdiff/xhistogram.c
>> +++ b/xdiff/xhistogram.c
>> @@ -365,6 +365,6 @@ out:
>>   int xdl_do_histogram_diff(xpparam_t const *xpp, xdfenv_t *env)
>>   {
>>       return histogram_diff(xpp, env,
>> -        env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
>> -        env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
>> +        env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
>> +        env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
>>   }
>> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
>> index 2bce07cf48..bd0ffbb417 100644
>> --- a/xdiff/xpatience.c
>> +++ b/xdiff/xpatience.c
>> @@ -374,6 +374,6 @@ static int patience_diff(xpparam_t const *xpp, 
>> xdfenv_t *env,
>>   int xdl_do_patience_diff(xpparam_t const *xpp, xdfenv_t *env)
>>   {
>>       return patience_diff(xpp, env,
>> -        env->xdf1.dstart + 1, env->xdf1.dend - env->xdf1.dstart + 1,
>> -        env->xdf2.dstart + 1, env->xdf2.dend - env->xdf2.dstart + 1);
>> +        env->delta_start + 1, env->xdf1.dend - env->delta_start + 1,
>> +        env->delta_start + 1, env->xdf2.dend - env->delta_start + 1);
>>   }
>> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
>> index 06b6a6f804..e88468e74c 100644
>> --- a/xdiff/xprepare.c
>> +++ b/xdiff/xprepare.c
>> @@ -173,7 +173,6 @@ static int xdl_prepare_ctx(mmfile_t *mf, xdfile_t 
>> *xdf, uint64_t flags) {
>>       xdf->changed += 1;
>>       xdf->nreff = 0;
>> -    xdf->dstart = 0;
>>       xdf->dend = xdf->nrec - 1;
>>       return 0;
>> @@ -287,7 +286,7 @@ static int xdl_cleanup_records(xdlclassifier_t 
>> *cf, xdfenv_t *xe) {
>>        */
>>       if ((mlim = xdl_bogosqrt((long)xe->xdf1.nrec)) > XDL_MAX_EQLIMIT)
>>           mlim = XDL_MAX_EQLIMIT;
>> -    for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart]; 
>> i <= xe->xdf1.dend; i++, recs++) {
>> +    for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start]; 
>> i <= xe->xdf1.dend; i++, recs++) {
>>           rcrec = cf->rcrecs[recs->minimal_perfect_hash];
>>           nm = rcrec ? rcrec->len2 : 0;
>>           action1[i] = (nm == 0) ? DISCARD: (nm >= mlim && ! 
>> need_min) ? INVESTIGATE: KEEP;
>> @@ -295,7 +294,7 @@ static int xdl_cleanup_records(xdlclassifier_t 
>> *cf, xdfenv_t *xe) {
>>       if ((mlim = xdl_bogosqrt((long)xe->xdf2.nrec)) > XDL_MAX_EQLIMIT)
>>           mlim = XDL_MAX_EQLIMIT;
>> -    for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart]; 
>> i <= xe->xdf2.dend; i++, recs++) {
>> +    for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start]; 
>> i <= xe->xdf2.dend; i++, recs++) {
>>           rcrec = cf->rcrecs[recs->minimal_perfect_hash];
>>           nm = rcrec ? rcrec->len1 : 0;
>>           action2[i] = (nm == 0) ? DISCARD: (nm >= mlim && ! 
>> need_min) ? INVESTIGATE: KEEP;
>> @@ -306,10 +305,10 @@ static int xdl_cleanup_records(xdlclassifier_t 
>> *cf, xdfenv_t *xe) {
>>        * false, or become true.
>>        */
>>       xe->xdf1.nreff = 0;
>> -    for (i = xe->xdf1.dstart, recs = &xe->xdf1.recs[xe->xdf1.dstart];
>> +    for (i = xe->delta_start, recs = &xe->xdf1.recs[xe->delta_start];
>>            i <= xe->xdf1.dend; i++, recs++) {
>>           if (action1[i] == KEEP ||
>> -            (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, 
>> i, xe->xdf1.dstart, xe->xdf1.dend))) {
>> +            (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, 
>> i, xe->delta_start, xe->xdf1.dend))) {
>>               xe->xdf1.reference_index[xe->xdf1.nreff++] = i;
>>               /* changed[i] remains false, i.e. keep */
>>           } else
>> @@ -318,10 +317,10 @@ static int xdl_cleanup_records(xdlclassifier_t 
>> *cf, xdfenv_t *xe) {
>>       }
>>       xe->xdf2.nreff = 0;
>> -    for (i = xe->xdf2.dstart, recs = &xe->xdf2.recs[xe->xdf2.dstart];
>> +    for (i = xe->delta_start, recs = &xe->xdf2.recs[xe->delta_start];
>>            i <= xe->xdf2.dend; i++, recs++) {
>>           if (action2[i] == KEEP ||
>> -            (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, 
>> i, xe->xdf2.dstart, xe->xdf2.dend))) {
>> +            (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, 
>> i, xe->delta_start, xe->xdf2.dend))) {
>>               xe->xdf2.reference_index[xe->xdf2.nreff++] = i;
>>               /* changed[i] remains false, i.e. keep */
>>           } else
>> @@ -348,7 +347,7 @@ static void xdl_trim_ends(xdfenv_t *xe)
>>           size_t mph1 = xe->xdf1.recs[i].minimal_perfect_hash;
>>           size_t mph2 = xe->xdf2.recs[i].minimal_perfect_hash;
>>           if (mph1 != mph2) {
>> -            xe->xdf1.dstart = xe->xdf2.dstart = (ssize_t)i;
>> +            xe->delta_start = (ssize_t)i;
>>               lim -= i;
>>               break;
>>           }
>> @@ -370,6 +369,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, 
>> xpparam_t const *xpp,
>>               xdfenv_t *xe) {
>>       xdlclassifier_t cf;
>> +    xe->delta_start = 0;
>> +
>>       if (xdl_prepare_ctx(mf1, &xe->xdf1, xpp->flags) < 0) {
>>           return -1;
>> diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
>> index 979586f20a..bda1f85eb0 100644
>> --- a/xdiff/xtypes.h
>> +++ b/xdiff/xtypes.h
>> @@ -48,7 +48,7 @@ typedef struct s_xrecord {
>>   typedef struct s_xdfile {
>>       xrecord_t *recs;
>>       size_t nrec;
>> -    ptrdiff_t dstart, dend;
>> +    ptrdiff_t dend;
>>       bool *changed;
>>       size_t *reference_index;
>>       size_t nreff;
>> @@ -56,6 +56,7 @@ typedef struct s_xdfile {
>>   typedef struct s_xdfenv {
>>       xdfile_t xdf1, xdf2;
>> +    size_t delta_start;
>>   } xdfenv_t;
> 
> 

