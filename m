Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792793547;
	b=HCepzG69P6AcI9p5KxBdeunWkVP7z50mAeRaW2I3CaPSocYNPPP0S5QOh3tRWOqJLU7u
	 SVMPK2ALWyb9uhW+p4Do4/kRA0S4JzzKC61y6p+thPN/rgVVDDiiVNpTX7k3ko/I7i5bh
	 SqwtsMWTeJ4PXAJ37EEYuv4qbgMIu119i3IRD7sUZlFdYCjhlJK0/rlpWbr+sV7jLzipH
	 MXZ4qAXNI9uQj3gpZJg4RG6hgvSRMLNKDt7B2ORXAyJbrE3Vh3m9BOpIYpeShBX/O75WU
	 0qgJsHyKSDI2I82jv08DCKUrZ9iIlBrHyo5gY/yKGHlpMep7K6mxc0kP0GwMENfUGqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=ohuDtIhKWu+QqKglkS2frNrPvbpjrWImIf+8rk7+VdA=;
	b=I0fNT0bo/UJerMtB01MZOLiEKpxan5TmYcAA+Jk0sm8StrhAXjY6/w9nNwg7SuISm9c6
	 IhIF9kGeffjCUlBex0eU8Rwzfl8KCrp5UFi4lKamXdRRoP7tEVeZ53InCjJUuknXuFKxc
	 pLLeEJ8Ugfw+7BPjIr3grFdDaLbAwbSSvd8G7QgM8AGM/2wXmAG29RWxoiC9yoVkmZkxA
	 atXCJddAJnSfjwA6f7vdchlZ/U+U8AOnioR8J3MPHRnoUKX7ep95NFSduByixBi+Ai7pf
	 0ZGanOgVpTHZACGHAg1+DFM+Wy9bUT6pUFMjdwLPhGYETzDvl5F9zjV/z6PmGX2irtg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JNTkcKKj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89627606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 22:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89627606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JNTkcKKj
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so1999657e0c.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792793546; cv=none;
        d=google.com; s=arc-20260327;
        b=HZtqgLPOSqBJk16RbnTEsl9Yg1b+Dyhoo1S/NGSZOV/KeaEk8PJPtDf30X6Lm2iibu
         UbCOO7AHG2HszlSD27WXsR8irTrnpWTrR9wBb2CSXGvGIAckehBMYEnTr+TlyJxf0uZr
         jTDHGHcZe6owAuDamXaoktvHxIVHjOdjM7Ze90KjdG/wLljv4Qq7a6RT14607jmLU6qq
         x0ofXf3e3+f/ZZxiFs6ItuKfFmqB3gwzWYdXWysyPa+/JyZHdBHAIThYlOWf5idsT6f2
         t0hTDv9nMF/yzm5gmVkxhZm5qyqnymERN6xQ7gcmhQfTly9DYSmmJkhPB/rxwPvwmw89
         0Z1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ohuDtIhKWu+QqKglkS2frNrPvbpjrWImIf+8rk7+VdA=;
        fh=Zi/PcTgeFwYOrOH0Qb2thAOIbcPUsmyXqoBq6d0qCxE=;
        b=kQuIW0kq554t1Jr/W6FVrnNKhNNdva++CyrT1bwvALPSZUpvIfoFevLJaBRJ1dQGd4
         DiNzQrGX/1LkmMe7AYNlv//1MO/bGKC17xCdi43F3m7+yZ0iwGoVqiuo/r7DPBw7gdjP
         LMahCN+pR5BpOaM9bBFTYegT7i+/hatJq7K/jfoBkGboTov4baMpgc2oZGxKO3hQXbcB
         ex+lYx3ajQRd9Iw0DfaLn6ZsB4Ba5WgJVwvHLDPGP0xcqrRkWc0ezDUFtcXSac4F0WjX
         21JtvbleQM21vkUfFITJsDLo86EC0k5rHa2A2WHZVZqznaIZmqezWWhiD/GbVxcmbQsg
         Yt+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792793546; x=1793398346; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ohuDtIhKWu+QqKglkS2frNrPvbpjrWImIf+8rk7+VdA=;
        b=JNTkcKKjHURcbHs8XhAh4H38tiPgy35BsVq/iUFQqC7iQ1/RjMF+IkGOKoK5es0W19
         SrFvR08x8Gswsem9oJBLc+o10o/zfihqjlZq4r/RlbHvHWOAGu0aeHyUOKvoUgx+507I
         5N3cmSreuqnGODUUVNj5hGQE7MCieikGb53ACyuo6AF3knMnCB7ZPLog1AbwxjFYpOtX
         jedhdZmcbFcV35n2NEOa9337ysDfAcBt0hQrKoI6VSwggjcIaEeVqX58XJlewigSio92
         wdeFqxpyD771BucMoCkTWcL3ADfjPfVAcg7I+HHDG/rpaPOiCW7sZAfJn/H8HrDNYvZE
         X61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792793546; x=1793398346;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ohuDtIhKWu+QqKglkS2frNrPvbpjrWImIf+8rk7+VdA=;
        b=2CryTd33qbTCHVxTraXdPKsbxpKZll7xtX8uhFdXmBpiciQVlf8xpYAAy3D7+nl7RV
         jgym4spBRTe5DGne+9Uht4+o07k+kT64QBuoawwKrSmFrp+q0ebwxccgRRcR3fVPepmW
         esHDUl4GcDLZN3oo4yrCM68NcEdqClMLhAUfBW2yktA3/a0JMTZV1Nco4ZP9QztPPunp
         GEvMMYgkQR7oEy3vhxmJ9ucVVRgC10Xkwy5s6AVhpKDJI9DXgWNt4Hx/3VG/9cGDgpyG
         UNXYD8iVD0yotv3nMW8lxUrpbU0t9lWCxzoBP6+90nfFK3nKnqvUNK7b6BexrXcH/7mO
         3eSw==
X-Gm-Message-State: AFq9FYJpWjvx2E+Mz+WjiFXdO7f2nZ6TuaQ1yeROb2zKwmEeUAE9pJEo
	wxDZlfi7KfpfKV3osN51coc9To96ALCN0W0cGkaHXuNpvOWRL6BOPhdGn9yVJdNSFOk6kItH1m4
	qqGaFCgC8GDQnTCcARGuAYDjE2wkOL1TBAQ==
X-Gm-Gg: AYBFou0b3S6HeI5dEIEkZCYcvxD5o/XE3YSvtKq+/tl1NR/31i1g2roDwJXhbTsIRgi
	MSR9F5plALCVzYoJo2kVCpUicw/WYZWzbv9SoICzbXuO4yqMx7FUyPgGXCOmzpNOFTn6sqqOqnb
	DeKhuBZTJYdclGkovasdXuVStVneK6PdMRZC5y4RZqPgqzR+vMB4j/ra+cgct60n29bpXcxRMNa
	jzNcUSgI8XQSVE+rcPBEWx7yir7nObHkQQdP2D+AjsliPQmNBi/Fhp9uLmVidzaOw8k86zy8zoZ
	4ANwpjn1iT1jI64ELagIE/+oxsCtX9FRiK19edl3cOWCu7NzIJj7GKhBELdF718X4qDq0u8kSqV
	ZwU8DlrojHoJadVvv5extqQs9CPNFaOAKLAFZoxaMQ6YxmckvsAjFAMK5ggcuyzidGS/KdtWTJs
	0JnjZN1X/Dhk06VwOHWegwVmXM+w==
X-Received: by 2002:a67:e708:0:b0:7b4:9eba:69dd with SMTP id
 ada2fe7eead31-7ce5ceccf90mr139648137.45.1792793546448; Fri, 23 Oct 2026
 15:12:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 15:12:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 15:12:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZSnhGwBevejqv1Nzw92q6tt6zMDM528qFb7xqY1-6mxrg@mail.gmail.com>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
 <20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com>
 <atsBbPi_EuhRdNmo@pks.im> <CAOLa=ZTe6zeapUBwF2cS=w_gDQzm08RJkezD-jm9aV=7j1u6KA@mail.gmail.com>
 <attMR_XBdfkO3SHx@pks.im> <CAOLa=ZSnhGwBevejqv1Nzw92q6tt6zMDM528qFb7xqY1-6mxrg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 23 Oct 2026 15:12:25 -0700
X-Gm-Features: AclHuK_VI1wQaJF7x6cj_yWE1TT_QS1Pw6PXzfPVQT1eJZaQ_5YYQqtQ6cQSZqk
Message-ID: <CAOLa=ZQQwYyufEWm_cS3o9t7SDfCwDSMKU7rsnctCojc4=FoGg@mail.gmail.com>
Subject: Re: [PATCH v4] fetch: advertise fetched refs when backfilling tags
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000007e0b8d065e894638"

--0000000000007e0b8d065e894638
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> On Fri, Oct 23, 2026 at 03:58:11AM -0700, Karthik Nayak wrote:
>>> Patrick Steinhardt <ps@pks.im> writes:
>>> > on thu, oct 22, 2026 at 11:00:16pm +0200, karthik nayak wrote:
>>> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
>>> >> index b2decc6cfd..9867e8c2ef 100644
>>> >> --- a/builtin/fetch.c
>>> >> +++ b/builtin/fetch.c
>>> >> @@ -1697,9 +1699,30 @@ static int backfill_tags(struct display_state *display_state,
>>> >>  	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
>>> >>  	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
>>> >>  	transport_set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, NULL);
>>> >> +
>>> >> +	/*
>>> >> +	 * References fetched before the tag backfill aren't yet committed
>>> >> +	 * to disk, so negotiation cannot discover them. Advertise them to
>>> >> +	 * the server, so that it does not re-send objects we already have.
>>> >> +	 */
>>> >> +	if (fetched_tips && fetched_tips->nr && transport->smart_options) {
>>> >> +		struct oid_array **include_tips =
>>> >> +			&transport->smart_options->negotiation_include_tips;
>>> >> +		if (!*include_tips)
>>> >> +			*include_tips = to_free = xcalloc(1, sizeof(**include_tips));
>>> >> +		for (size_t i = 0; i < fetched_tips->nr; i++)
>>> >> +			oid_array_append(*include_tips, &fetched_tips->oid[i]);
>>> >> +	}
>>> >
>>> > Curious. Why don't we have `struct oid_array` as a local variable and
>>> > then simply `transport->smart_options->negotiation_include_tips =
>>> > &extra_tips`?
>>> >
>>>
>>> Because `transport->smart_options->negotiation_include_tips` may already
>>> be set when this function is called, so we only free it when we are the
>>> exclusive setters of the field.
>>
>> Ah, okay. But if it was set already, what does it contain? And is it
>> okay that we essentially leak the fetched tips to our callers now if it
>> was set?
>>
>> Patrick
>
> So it is set when the user uses the '--negotiation-include' option and
> provides their own tips.
>
> When I wrote this code, I didn't include the free'ing that you see here.
> But it triggered the leak sanitizer for 't5509-fetch-push-namespaces'. I
> assumed it was due to my code and added this logic, without digging too
> much into why my path specifically triggered it.
>
> So, the transport does free the `negotiation_include_tips`, but only for
> transports which supports smart_options. Meaning, we should only add the
> tips for transports with smart options. As the other route doesn't use
> it and as such doesn't free the array.
>
> Thanks for the pushback, I'll fix it up in the next version.
>

I need to not send emails in the middle of the night. Seems like I'm
still wrong here.

The issue seems to be that for 't5509-fetch-push-namespaces' the tests
which trigger the leaks are those which use a remote helper and seems
like the transport with remote-helpers don't clean up correctly. So
while they support smart options, they don't do the necessary cleanup.

Seems like an existing bug, will add a precursor commit to fix it.

Karthik

--0000000000007e0b8d065e894638
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3baed07237314cac_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yYjI4Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMThJQy85R2xFTWM4MVk5TzFFNWQ5ZjkzSDlkZTZFeAppcDdCZDZyVWVF
R1MrWU9WMmtQRVY0N0V4TFZuQm1JZGJwcUlGd2NyUlNUY3owVGh5Zm5KMlljQTdPdG9FNXNQClBi
VTNkWkxLQWJXanoyam1TZTdmWEpDajZxYlNQTWd1SWNvVlJjbVRrbVdRcmt4UDFSWUg1djVySFNQ
d3YyZGcKSFk2dWF2SFdDQmRVQkZxbHorYnNDMXVoL2lOQWRYTkZSb09CMVZZdnhRMEgvWFpJVlNV
aDl6SGJra0FrR2IzYgpabTRHN0tLTTNtK1J5ZUdlanFEeEpsMzErMVdBSEpEUkJjMHp0aVhGL2Ns
Tm5MTW9aWDhid2ZoLzYyNzd3RzRJCmMvUzR3RmVNenpTdi83bWUzT0k2cmoyekFLbUQxV3ZpVkRW
U1luUm9NR0d6OXVDSVR3UEtiQnJGbnNDTFBWdHcKcUNaVDMyemhqaHVJdEEydHJ6b3FlZnlSZ0xO
c3VpTS9Ydi9jR0FzYjZHOXloM2Z3VGRINSt2WDNSeUNoU050Nwo1NUJnd1BwcnNnWjNYSkRHV0dk
U0JYOE1VbmlWRllMTWZEZVBuWmRzUllQZ09SME9TRXZ4dHpVODlIcXJ3ek1LCk12cE1pNmx3Y3BG
TmdEUFM4SnUxb0xsbWJSNXRQZEdYM3VWRFQrTT0KPWRQSEMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007e0b8d065e894638--
