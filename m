Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792753094;
	b=chrHTwzYNlC4eEHdmOLVBnthcwglmaTkHEUj0HhO1osS5g0f+56PhueYF2Ow7jjQ/7hL
	 2CAhwkN1qN0sKwGHavnaNOxxdT7psJasybFjlj4AuE/o0tcbKvbV6arBhfLJgHVdCh6c8
	 YhA9bAWiJCLO5h9j0EuMqGp8Pqt00R8gOBzlBwkJM+IAUVBwRCEe4PH/It4/2W9Bm+7Ur
	 mUSKrXYs3m1GyVHo5Gn2aF9GF5RHUpjp5NIoF7iyUf4eTw5cXnAZY0nAr0PSRDxXMFxUi
	 O0XgC1m7vIYLZzdUuZ2C8rYYXxLoRRoPplEuFvoE26JPSqPQ0IDtHP9m53W5GTb+4DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=bRhe9TWNolsYsHRVf1P2eYNk83rBWddKquw9M8X/++4=;
	b=FlNENSYBhEjtsuNedjKEXbb9b4w/k1bGqu4ajK2AcB4os/LoDFPIgOYlX1rDlLTT7iVi
	 DGFP8GMsg0e/T1qOj5WmhwiB63bpW6Slt7XlyeVovUMIqEy6eY3AUwxODg+QP6TDUM73b
	 kTWuzdzx17BctGmwYkusgnmDZNnscC3K6baWSD6n5ILA2GUn3jK5ROFZ7vtAROM0SD4rb
	 vGYk23MUAtZSuKdX6KRMi5JgEu9udasL3iQy5hZNobNg6vgkTQOkDjnyqLFZIIARc5jFc
	 5UIGaFnUT3k6AGCBm2o8x0cagdYJ0ZYNf1aqybK7RKOMNcayQZ2UCLj3KKteb6lQf6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YDHzluOC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDA606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 10:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ABDA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YDHzluOC
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7cc53938a8fso491484137.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 03:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792753092; cv=none;
        d=google.com; s=arc-20260327;
        b=hMHHEttqWkoF19LkSZ+czzNVeY1uE7ADk8DxSbC54Js+pWa3e+FaWm2LX2M3DoWsge
         NjIl2QfMBIFLakMdKI4up6OYzWH17+G+NS8cgLOng6MKroNr8fQ5/zJCVpKq35MvcKjX
         bDE9cgyKi9snxN4400NqpAFqxxi5mjmwkzxwWWRawkXwdDnucgqcHyPvvBBh1xqVCNcK
         +n61oA7XsvIIaabD70KMtLwZSZD+Xbz7ICIxTz8dmYfEq+e3f8Ecn/o1ShhGh5HrP/xx
         VMrl3LaQwt8IBUR8BuZKG/c6rBmp9HitKaFesDAFb+FA+g43VWbbcaD8FmPJ1gWN8RfE
         h/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bRhe9TWNolsYsHRVf1P2eYNk83rBWddKquw9M8X/++4=;
        fh=Zi/PcTgeFwYOrOH0Qb2thAOIbcPUsmyXqoBq6d0qCxE=;
        b=V5XPZ9XTjV2ZHOuSwGcMfuEEswK5/C9FO69qeiHeQtXursNm74KIpx2JBA52BGDtYN
         jllAZu09jhMO4O0xxyXUVcjQzIHCVvjgp32l3iN58rvOfoJGr6DOaI5J5/3aczFzSIfq
         jy4hhMnHXluzWcWxevCwOM/nKhsCQhmjev0r2x5JXXWlBPHp3NeMC6eIgZSbivgQjGE9
         LcQGDmZ5LevYpxpNe7fDxizAjF3M/dSxNDw0coeswqI0cQDoypJ/kVGMVno0IEme8ix6
         2QE8cSHLMoDvmTIzwx0hiWoMkUW98i1sftDKQTSwluOg9tO+tAaI5XjrZgcJjF8AV/3A
         K1Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792753092; x=1793357892; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRhe9TWNolsYsHRVf1P2eYNk83rBWddKquw9M8X/++4=;
        b=YDHzluOCgCMJow9cDXdR2KSkubKRG7BRroHagNfQzUr/rddGMjRsIX3Xfibz+bDhr/
         A2QWUlkjLu4S4PaGi/G34+n+U8LkbcA3zH8jDIFbqyIY7lTeje5OzUlsUtHVUwiM9qGn
         bm+iJOr/P6r0Crtyu3fCTqH5g164jED0fZyZHhnx7no56AK25yHCY2PSRSAN+LUsmGiY
         qMRPwFvBX85Tt8bUhOPAY3SvnSIuN7P6ATj1ToTVopd+qx/Jgv57xcx4ITlHwXIUcL/4
         xn/EWInyCO+AMu6ExBqmBNVdzH/bCNIEHooaiC074oHhdB8oMwHkKKwXyvIHzxNCTvjO
         EMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753092; x=1793357892;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bRhe9TWNolsYsHRVf1P2eYNk83rBWddKquw9M8X/++4=;
        b=aTY+bcf0THYuZvxHtvTRYcOkvul5GBANeCAa2uTiQRRrx1hW+M9qxlPgp1S7yBSSxd
         iJC9WDmmnjrMnf1BggKxm8ubw5ewgt0LS2GG3L+mO1M57WHLQyV0AVni/wpQRL+WZfmm
         P/hv5bXdHkryZS/uXBxxCXbclZbNY4hoZKBfwua/1Nk8M6kmJ7mIyTnFeMVT+mlsPLa/
         xszc32iDjYGCbPWq07952LBKpv5z3xDhIf25A+3J7TJUmsnFnyS6h/LmgmsCSPlhBuQO
         3JeR52RzUHC2tZ9jhCBygqLFKwQ/bp4YI1KBTH0Xv8mE8h2JSqmW2BSurx0l8ODRsRj2
         jc/Q==
X-Gm-Message-State: AFq9FYItmJ78f89hpQyjPjNiEP5c2Gv7zmBTNvke2fH98RCIDWOHqrsT
	FMPaAATN2oSVXsL1tTp7MHVuKeibIGCLkjtVl4CUT/MjOIBW+X2hDGJXiZBCE7rKLcppXINAmYC
	KBMrNvC30zLeOoJaZwabUg/Wi6npia4w=
X-Gm-Gg: AYBFou23YuIV3a8GtjHLi1SKgVaOBif3iZbfuyF9+wRIdle4j0SMVZKwKp9KRtPkb/i
	8bkhvQ3nlNw5MRLa7jjg0dZ14GUHeDUjeC/4EwW04fL6kec9Bd7R6BIQpZOjFvePRtRvJiPSzXf
	td2A94/45v41mvmKjUK7YGpb3uOya/+zN+NQdnACoqVymfaI3U999X787Yz2hJfqL6aSod1V/gc
	fXDSUhS40y7VeFKg3VL+WXZDBGMWqsy9Bh1EVJo201hF4KDsw6ZE/nP0SEzt8bym5OJ5FbNLU78
	O3rh8xTSoNQtzVYfwebQZDWBpVXh5QEsl3baqOdJTJJlM570B3id1r3PYvSfT33Q2hstxqwqGwt
	9z2nZ/xzkeDuX6ncGB9O+27Rs79zT4lA9IPNz+w1lSgh+waVdW3e5WeAHOC16Zu5DwmNS9QXhwp
	1DiM3AE/AdSvIBjQ+EGCElRwjT9W8=
X-Received: by 2002:a05:6102:2c01:b0:7cc:80ba:5e5c with SMTP id
 ada2fe7eead31-7ccc31f0346mr857617137.6.1792753092390; Fri, 23 Oct 2026
 03:58:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 03:58:11 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 03:58:11 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atsBbPi_EuhRdNmo@pks.im>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com> <atsBbPi_EuhRdNmo@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 03:58:11 -0700
X-Gm-Features: AclHuK8qqOP_noQibWJ7rs1mIfyHJ3wlRgVBWQnI9sDxLTIGMUVCSCDgl7aSP0g
Message-ID: <CAOLa=ZTe6zeapUBwF2cS=w_gDQzm08RJkezD-jm9aV=7j1u6KA@mail.gmail.com>
Subject: Re: [PATCH v4] fetch: advertise fetched refs when backfilling tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003e1caf065e7fdb8a"

--0000000000003e1caf065e7fdb8a
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> on thu, oct 22, 2026 at 11:00:16pm +0200, karthik nayak wrote:
>> In 0e358de64a (fetch: use batched reference updates, 2025-05-19), the
>> fetch code was modified to use batched updates to provide a good
>> performance improvement. Batched updates are used both for the fetched
>> references and to backfill tags.
>>
>> When using batched updates, the references aren't yet committed to disk
>> when we start backfilling tags. For shallow fetches, the negotiation
>> phase while backfilling tags does not advertise the newly fetched refs.
>> This can cause the server to send objects the client already has.
>>
>> The issue always existed when the '--atomic' flag was used, as both the
>> regular ref updates and the tags need to be part of the same
>> transaction.
>>
>> Fix this by advertising the already fetched refs as 'haves' during the
>> negotiation. Do this by simply adding the tips to the transport's
>> `negotiation_include_tips` field. This also fixes the issue for
>> `--atomic` fetches since it follows the same route.
>
> Okay. Would the client have advertised _all_ its local references to the
> server before the batch updates? And with the new logic, would we now
> start to advertise all of them? Mostly trying to figure out whether
> there is a potential change in behaviour here where we may now advertise
> millions of haves whereas we previously didn't.
>

Yeah, we would, In the end, we only negotiation the OIDs, so duplicates
would be removed, but it is O(n) for the number of refs fetched.

> And even if that was the case it _may_ be the right thing to do. I
> mostly just want to see this discussed in the commit message :)
>

That's fair, I'll add that in.

>> Add three tests, two which validates that the 'haves' are filled when
>> backfilling tags for atomic and non-atomic flows. The third, to test
>> that upstream is still set and tags are backfilled even if a sibling ref
>> is rejected.
>
> The third test is curious. Does it have anything to do with the fix
> itself? If not, why add it now?
>

It was a missing test which ensures that even if committing references
fail, we still update the upstream information. I can move it out into a
separate patch.

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index b2decc6cfd..9867e8c2ef 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1697,9 +1699,30 @@ static int backfill_tags(struct display_state *display_state,
>>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>>  	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>>  	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
>> +
>> +	/*
>> +	 * References fetched before the tag backfill aren't yet committed
>> +	 * to disk, so negotiation cannot discover them. Advertise them to
>> +	 * the server, so that it does not re-send objects we already have.
>> +	 */
>> +	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
>> +		struct oid_array **include_tips =
>> +			&transport->smart_options->negotiation_include_tips;
>> +		if (!*include_tips)
>> +			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
>> +		for (size_t i = 0; i < fetched_tips->nr; i++)
>> +			oid_array_append(*include_tips, &fetched_tips->oid[i]);
>> +	}
>
> Curious. Why don't we have `struct oid_array` as a local variable and
> then simply `transport->smart_options->negotiation_include_tips =
> &extra_tips`?
>

Because `transport->smart_options->negotiation_include_tips` may already
be set when this function is called, so we only free it when we are the
exclusive setters of the field.

>>  	retcode = fetch_and_consume_refs(display_state, transport, transaction, ref_map,
>>  					 fetch_head, config, display_array);
>>
>> +	if (to_free) {
>> +		oid_array_clear(to_free);
>> +		free(to_free);
>> +		transport->smart_options->negotiation_include_tips = NULL;
>> +	}
>
> This could then become unconditional.
>
>> @@ -2077,6 +2100,17 @@ static int do_fetch(struct transport *transport,
>>
>>  		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
>>  		if (tags_ref_map) {
>> +			struct oid_array fetched_tips = OID_ARRAY_INIT;
>> +			struct ref *rm;
>
> This is just the loop variable, so it could move into the loop.
>

Yeah, I can inline it.

>> +			/*
>> +			 * Collect the tips we just fetched so the tag backfill
>> +			 * can advertise them to the server as 'haves'.
>> +			 */
>> +			for (rm = ref_map; rm; rm = rm->next)
>> +				if (!is_null_oid(&rm->old_oid))
>> +					oid_array_append(&fetched_tips, &rm->old_oid);
>
> Makes sense.
>
> Overall this version looks much saner to me, thanks!
>
> Patrick

Thanks, I'll wait a day for any responses and send in a new version with
the fixes.

--0000000000003e1caf065e7fdb8a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ef4749e4b3570630_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yYlBjQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3haQy80cWRUK0VkQnFJWkxyazZ1cmpidStIeHpocwpiNmhLZWRkaFBQ
b3FMVDhRS3JWQTZiMUp3MXdvT3NUYk5rUFZmdGltMmczTkEvU0dwbENCYWo5c0dXdXdZMG1RCmg2
Qy9DYkhJZW9XQzJFREN6MnRlbjlGbjdiZlpCNTJMWUg4cFRVRVRGV3J5UnJ6Umo4bWhxS3BxMGlQ
Y0VXTG4KUlFpTTYySHJnY0F1YVVQZGQ3QmJ5ZkI4Nlg1cUhzZDJUcTZxWmFlbVBEYWRLeUp2U2J4
V2VOVXpBV05UVDBDRwoyclROL0tabnJ5MFFnR1pTSjJoTHdzTFdhYmdBNVl4eGZGUzVRVGtWdWxa
ak9IbGxOVHVGWkRjRHpKVXY4alVyClpqdmxFS2RENWd6NDRNeFJsOTZzbHcyR2FQQXVZb0JnQWRZ
dy91ZDZ0U0RWMjFWQUlWNWlxZXErVlY4d2hzNWoKZFQrN1czcnQzTEJIeG93bksyd0NjYlB0QTc4
YW1aVkJNREYwaVd5TkJpM2dtQk5IaEV5VUhQVGs5QlJhcW5oUAo4RTB6THlxRnlqVU8xRzFKWlBq
VlU1V2l3NXQ0cGM1UkxtSzY0QWlrZEVkblp3WVFWc0QwRDgvZnZheVRTb3lVCk41WXUwbzJpS2Y5
TnlsT1JWcTJjaUZuOERraHYvK3lrTkpkSXg2ND0KPVNzOE4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003e1caf065e7fdb8a--
