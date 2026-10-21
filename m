Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792577153;
	b=UVmzdYbZwEHzA8UoGsuocJFwUB7QlFpXnPHfnNUSN6M4bnCj77GNuua/X9suTJmaxddj
	 8tA3Y3tmCbHHmg0f0X5Lsa9UQhITvhJ2gCI+Y4Tgo/cYazaVVQmScnX+uap/zXhByJXW5
	 qv70RqNjWG3Q/azE1pDGLgtbw9lWviS6t7GchmEuM2/VJ9Gy2IsYYtmF2FGQDvxV1SHBD
	 qTvI/VhszkwrSrRos3PJ3eT3yMQXyUJIPEYPCfojBPTwyNNHD9I2oMYoDVvPhCGy7noQ4
	 EErNfdtz/tOc0obqwwMe4+baDUQLr2hJrJgY0fPHMvXKKrhyMXFn/x9ze34SE8R8mIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792577153;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=61Pbf5uqbiD0yI5GuBu+w1pmDat6YlMO/7yBv6F1HSY=;
	b=xPIOM2EJcIf/MOdVu0GIGuAGLDKdd5p1cQR/WJPqUqdO5/PK+UPenGIyih3nFbcFMzJB
	 b4mNZQwf8YyILAduPvrIPMMyJjKpo8BQgiGf4PYdRZQgMcfUGt0PxPixqi/kFzCLow2/u
	 5xotBN5a9bRRgtRQVP/hAK8yp2jgYH02jvu15CDIGo1zn3cye2MQKwJAjmAPNJSzG/X10
	 LpEuyKvvheaqZM5OXyvMahIKbFUyiM/F58UIx+lQDsCWxOJJvetBeRgT1tULzkjMurDBC
	 boAesvdQ50Ilm5H5laXC7KiHXDVDeIKUfHnAqfHRocviRRYs3WBAa31WSWJA50ofPog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EqlzP9yB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D704606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 10:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D704606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EqlzP9yB
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5ead5ff47caso297543e0c.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792577152; cv=none;
        d=google.com; s=arc-20260327;
        b=R8dgh+R/LWHjRm9iGv9cLcmA4p7NvYzlQVpGvWN1AJ+Fc/vjiT2xOvrKgcwqPudsQw
         XQq3jcooiJhW4+7VmRZmoJztoL+4W4/tIGpu8l343xSTqTxLM9dlNta39qCjjf70WJ4q
         qsjCnP170Wpf9vT0H/4kaaSNsqjgJJC8elI4BXwkG34wZxOvm/4CF/356zQz28dClC/m
         4EnTjHzapUVvcFOSLcsbt4/eu8uVCIM0lfOMgLj1xe9uhb+oFPfiK03pw97/p2pAvcoa
         HpKyk+HfFk0VVyKIIw0wo4LuPcWERlY3vXZWPpzKvHE+bcwVs+qlSMaIDylXFN1N+02n
         junw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=61Pbf5uqbiD0yI5GuBu+w1pmDat6YlMO/7yBv6F1HSY=;
        fh=9OET9sE+5UxZNi5AuGGv4kYRtgn0LLjWgtV3HLUDCXA=;
        b=rgyrLVtdLxLQNLkZMJrnoTuABqZHMOX7FHBMYgcsyD4UFVoK9zx/4N94pWZ3rfYe25
         dB8Ys1/DbhNYYZ8gxgKf28/JPYSyVC7TypAQqtRKNvzs0h5LNGSl+AlhSlqjVmT9z4da
         5cOKY4ac4gt8LVnO0w5glUFqSnxMOCNRypRcOo3uMBpdAScw7Ys8bbsF4DNiuKSfHHNF
         ue67zw5xoUPmYqmpF0cvRsZm4jTIv7sPiJF/XAgOHLYcM01cWL4+SRv5FCw3olS6DEvH
         LViE3UPcB3BopRvmDWTQ/mIVurn4d5vQQf0BX5KELhXeUVnRbCrLpLzN6pGpBBbl2Cpf
         mkEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792577152; x=1793181952; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=61Pbf5uqbiD0yI5GuBu+w1pmDat6YlMO/7yBv6F1HSY=;
        b=EqlzP9yBcz44BvPJjd/sliu4tTcKsbbgUYMVPqElq5lenIYO4tJCz/xPn2pTWV6bbH
         2U4Gea+BgtNgS8BA457mxU9R3WHVIqWGxcPDg8/fasnZN9ZLq11iZv8L/pwC6gDw2ufs
         jc6j2R3jhc8q4F1Uq+b5qaVASwsa8Drwa4wM5NvHqu9W1CGogvWZYiUwuibVEx2KhBdM
         BgWhpD7hRqTGvxjNIszQ8BRDJio4soE4MwDKnbtBzK5gQcrsKYsfMkiaslFiizlTnZQv
         ZleevHqxEX//q2HLLhEdWurVQnxa6szG4qawiRQquZdyW+kyJcxJKflnfUf58XuR1JAV
         84mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792577152; x=1793181952;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=61Pbf5uqbiD0yI5GuBu+w1pmDat6YlMO/7yBv6F1HSY=;
        b=x7IhsIQ/4arDP+vKlzNemuXjW2SqEnAV9hcrQ+8TRvnhxMO+iZzJAUJTV8b1yuwevq
         y1jaKqGtfM0iEudZhYdw8eGP3QAA7ZUDDwjgZAG73RyJmaAqmRNhx4zmXmqhMlxdCtUW
         ff7Bh5vSAOJQ0gDhGT3ObGSz+efGP55vr9msraaQJvT496vODYK2hCXcd14SEYAyh/Kd
         NikYE3RAGxv4FEjAihjtSVC4ghutgVKI5kVIw2s3wm1JVXK7n7AWG06PZ2htON0YL3p9
         zu54TXBWPL0WoVCqAk8bppHER7lPIUgc7u9D6EbCxbIiRijJs4+FBu591XoNPinOhYDd
         5XuQ==
X-Gm-Message-State: AFq9FYJYO7mFOj2GHsCuuUIaPkgka2ZKqRROHcqyCDVSWvQpdzr8NQWN
	mxCJ1RhZRWlAZ4bguXArFRYVPesrPuTcKaGkxfgaZKMtiP46MuZ3VqiR1ZmzVF9lbqMJ0Hwl6aE
	5rhh50BVKvxqbyY/JT+HF3jque+yscCM=
X-Gm-Gg: AYBFou39cP88562k1Az9450nRxCcjvdarVURxx96Xno6YcIZNzbjqwPzGJ7Jv4s1XNf
	7SY7Xmb3r6Ol1zHbwnvar3vM44z2P5sd3cWmct3GzfZqom/oCIV3FzyvMIcT7QaPOmwYwVYz4H1
	g/lJ3Ck9ug6Zci8FtnNyNaxVOPUeJVbxWIFU/z23o73y8ab5dVdLXoMBd6d6JTlOuJSxHN3/EIN
	YQiT7tIiM8z7wJrkIE6jHdSSEmglEiA/XDVnXxxbrRvh/ATaG6n4nbkRAtqVRg2BQgM/APwJGcq
	wlRwVAqkAbBflJiW037E6BV+AZqLdJgikPh0JEaKJ4CVVd9eyMQ45TWs8NpGsOdUJgAR/s/qIET
	N4x9KKzAlmfpUwMNhRlBD6IM8hTI9qkB3GvH1Mb3MtgUuHt+c5kOMOgIDjajrOv0E8pcJKM0Wsz
	ipeqyNkEGZRpt9H5JdgUc2fWLVW/o=
X-Received: by 2002:a05:6102:91b:b0:7cc:2b48:cb1b with SMTP id
 ada2fe7eead31-7cc927397c1mr563026137.35.1792577152288; Wed, 21 Oct 2026
 03:05:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:05:50 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 06:05:50 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atftdOihoUHTdvfu@denethor>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com> <atftdOihoUHTdvfu@denethor>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 06:05:50 -0400
X-Gm-Features: AclHuK96rj7ZtAU7QpIhX8G7wI8zSXEvK8DGdQP92N3Kl8zaHCWCw9wJ2H6Q3Dk
Message-ID: <CAOLa=ZR-mg6ah4VwStR3SJvT1uWdW5uv7q9x486FN7UawkJYeg@mail.gmail.com>
Subject: Re: [PATCH v3] fetch: commit references fetched before backfilling tags
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="0000000000006535e2065e56e4c2"

--0000000000006535e2065e56e4c2
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> On 26/10/15 11:24PM, Karthik Nayak wrote:
>> In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
>> fetch code was modified to use batched updates to provide a good
>> performance improvement. Batched updates are used both for the fetched
>> references and to backfill tags.
>>
>> When using batched updates, the references aren't yet committed to disk
>> when we start backfilling tags. This means in situations such as shallow
>> fetching the negotiation during backfilling tags, the newly fetched refs
>> are not available for advertisement in the 'haves' section. This can
>> cause the server to send all objects the client already has.
>
> Ok, without the earlier fetched references committed, the backfill fetch
> may ultimately ask for objects it already got. Make sense.
>
>> The issue always existed when the '--atomic' flag was used, as both the
>> regular ref updates and the tags need to be part of the same
>> transaction.
>
> So IIUC, you are saying that this problem already existed prior to
> 0e358de64a, but only for atomic fetches. Furthermore, this patch doesn't
> fix anything for atomic fetches as they can only use a single
> transaction.
>

Yup, there's nothing we can do for atomic fetches with the current
approach.

>> Fix this by committing the previous batched update and initiating a new
>> one for backfilling tags. Use a separate error variable for tracking the
>> reference updates: One, it ensures that errors from the regular ref
>> updates don't cause a total failure. Two, if starting the transaction
>> for backfilling tags fails, only those updates are not made to disk. The
>> initial error is now printed straight away to clear the buffer for
>> further errors.
>
> Naively, I think it would be nice if it were possible supplement the
> backfill fetch "haves" with the non-committed references in the pending
> transaction directly. That would avoid having to commit the references
> in the middle and probably also fix it for atomic fetches too, but I'm
> uncertain if that would be a simple or reasonable thing to do.
>
> Committing the intermediate state here does in part fix the issue, so it
> may be a good first step regardless.
>

I've replied to this with Patrick's email, let's continue there.

[snip]

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index b2decc6cfd..34fc37b58a 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1923,6 +1923,7 @@ static int do_fetch(struct transport *transport,
>>  	struct strmap rejected_refs = STRMAP_INIT;
>>  	int summary_width = 0;
>>  	int follow_remote_head;
>> +	int commit_ref_ret = 0;
>>
>>  	if (tags == TAGS_DEFAULT) {
>>  		if (transport->remote->fetch_tags == 2)
>> @@ -2076,6 +2077,30 @@ static int do_fetch(struct transport *transport,
>>  		struct ref *tags_ref_map = NULL, **tail = &tags_ref_map;
>>
>>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
>> +
>> +		/*
>> +		 * As negotiation only reads references from disk, commit the references
>> +		 * fetched so far, so that the backfill negotiation can advertise them as
>> +		 * 'have's. Otherwise the server may re-send objects.
>> +		 */
>> +		if (tags_ref_map && !atomic_fetch) {
>> +			commit_ref_ret = commit_ref_transaction(&transaction, false,
>> +								transport->remote->name,
>> +								&rejected_refs, &err);
>> +			if (err.len) {
>> +				error("%s", err.buf);
>> +				strbuf_reset(&err);
>> +			}
>
> It looks like we log the error and continue even if committing the
> transaction failed. Is there a reason we would want to still try to
> start the next transaction?
>

Since we use batched updates, some refs could fail, but we continue as
we may have still applied some updates and we can continue doing the
rest of the work.

>> +
>> +			transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
>> +								  REF_TRANSACTION_ALLOW_FAILURE, &err);
>> +			if (!transaction) {
>> +				free_refs(tags_ref_map);
>> +				tags_ref_map = NULL;
>> +				commit_ref_ret = -1;
>> +			}
>> +		}
>> +
>>  		if (tags_ref_map) {
>>  			/*
>>  			 * If backfilling of tags fails then we want to tell
>> @@ -2099,9 +2124,16 @@ static int do_fetch(struct transport *transport,
>>  	if (verbosity >= 0)
>>  		summary_width = transport_summary_width(ref_map);
>>
>> -	retcode = commit_ref_transaction(&transaction, atomic_fetch,
>> -					 transport->remote->name,
>> -					 &rejected_refs, &err);
>> +	/*
>> +	 * The transaction may have failed to initialize, meaning there is nothing
>> +	 * to commit. Carry forward with other operations in such cases.
>> +	 */
>> +	if (transaction)
>> +		retcode = commit_ref_transaction(&transaction, atomic_fetch,
>> +						 transport->remote->name,
>> +						 &rejected_refs, &err);
>> +	retcode |= commit_ref_ret;
>
> hmmm, the error paths here are confusing me a bit. If the transaction
> failed to be created in the first place, wouldn't we want to stop
> earlier on?
>
> Thanks,
> -Justin

Not really, since we use batched updates, the backfilling tags
transaction could fail to initialize but we still want to set upstreams
and set HEAD.

--0000000000006535e2065e56e4c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3820854acc9b2ce2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWWpud1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTFEQy85Z0diUjVTT0JJUkExRVRWNldITUhDR2tLVApzYjhjYXAveiti
dEZuVCtMdXkwdlhLY0hLcVpEcDRQN0V3K2tmVnZuajBuZHBWQy9YMGVWNmxYckpKRjhCajdRCjFh
U3JybU9RQ3o4RE5jVlNLS2xwVUdKdVdtUUlic3RvbzJQL3JrVUhQajV5WkJHNVBIWTg2a2NQSUtD
eXY1TXUKV3RtWDBvak5lRVFtaXRVNTA3MHlYOUphY0pBSGlKOUoxWE9xU1hqd3JySUkxMVlZTzZP
Y2poZjkrMVJ3NGJ3KwpYaUp3QS9sL2gxYjUySU0rQ1crODIzMXhYQVU4MUJoMXlmNTJLbXRMQkpG
NzVpZ24yc0JIbVFCc3pzRnB6YWNkCkZtaDlpdVo3ZWZ2NmxPUEYya3paTCtQWUhicm52cVVLd2hs
VHd5Skd5Y3BnSlE0ZXlKRjZOVVFDRmdMc21HSWcKS1QzR21wbmZoWW5md2labWl5M0tkZ1RDNDBF
emNDMGtHSVhzOFF0S2g5UUJ4VWxYa282YTBsTDBVd0pOWkFCUgpOTlU5NTVJOUZ3MHdzYzNPSm9y
SjZRYU9BbEtmWnhoL3F3d0xTTEhlVzJYMkF0VkxXVnpnem5KWEVkS3h3elZaCk52Sk12eXZrYkt4
N3FUc0ZKcTEycDI0UWhENjdrbzM3RmhrWHo0TT0KPWxEMm8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006535e2065e56e4c2--
