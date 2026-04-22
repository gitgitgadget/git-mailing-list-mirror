Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7793CF676
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860423; cv=pass; b=OvyakPKNSi/9hQYrao9X69uOrtwW6Vu+qKq9XTEle+AfY2mGZSF2CWfFxOaMBWayF1co2agvIngTUGft7shSLxLyOLzEFoFeJ0VDXab9jmsEDwLG3ueSbqhiNfbrCzikuicBudG+a0c7V8zPRUcndFjiadOgGTYHtPAToxrOYg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860423; c=relaxed/simple;
	bh=F203Fesxl2MgBPTg2wKwJouMqWCp/CxQq7Tn+F0sz2U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VMTcFSnQiKGEBToFBFKxQoZMooOfhP0ZFrlkdYmnn4tzlSvHlpftRknI+OZPKJ6V0KMi9+dmOsjMomGvCJ1obTD/MokNRarApH6KenXmO46ePIy2iMM6NiqjKuk0PwONi24KjnlD1TG3kJFpOBAdpaf2ViATbpAKlkvThguG8EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgb8Euw/; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgb8Euw/"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94de664b541so1435135241.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 05:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776860421; cv=none;
        d=google.com; s=arc-20240605;
        b=R+DN9SI9jATchKs5qtr2NlzjQnQSRHojdkywtzHTFNoyr9rd515e7UGITrZDlvexX9
         0r21x3Huj3323cMZkDcEUvOSkclAKYExKr1CxL9lNqLxt1eWcvh6HmADn/EuvDwzyeg+
         U7EPBxWmZCmlwdQaW+Ouke9+v+rza0X9yDwdTSpFmeo3uNdqoN7vc3qWeJp2EHL7rC29
         UdokMcjJ+TEqCAZFzEuTrk6wLRRmS4nXQgvoonzDqaR5xVmQwfs1zQ8WMaByuahqzFe2
         qqjQd/JVNQyGgs/R3xHpNNEqW519e3UsYuecCxf0Dx1T9W3lu3D2RDhIZzrQ6g/WXAbD
         /2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=+YYF5Ux55cZSEsGe/ha3kTPm7wLorAaPgV/ublOmZHE=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=kUvf4sNsGcJpIakV2dg3XuY1mv0Erjb1K2plvQ0MJzr9vyGtlKagaqOzIQqsgJ5diw
         pYWxq6zgUMIMR1T5//JeBgNSpI7VQhISXjfYEOlzQLn1Lpo+S5GDHyXmmMzG0vR9CZge
         PC8IJ/LEVHlhgjJ2ks9w+XDP9aZoWxRw17fn6QWgwpxOX5VPAkPTo20G6ePCczp4mS4a
         gt2V0YnT1BIwTTwKRLxODbRoA/E5iTLC2oRVvKmEyvmy3R/8fmpTP5KSPUileQuh7ph/
         91RdI+RkUmG5sLoZCZup2X9Nen74WeIHVkekvDM1WTT7N7JPfNiGp7w/dmN3QLIizp6e
         1EVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776860421; x=1777465221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+YYF5Ux55cZSEsGe/ha3kTPm7wLorAaPgV/ublOmZHE=;
        b=lgb8Euw/WuJv61x5kUMIAEg4dKca7hnFEG9bPwfK4VvEdcJLxV3ZoLtlZdy1W+UvO+
         qTTeveGffGmwnKEu1uo6j0OhPfTkjQOcQipsOB7yowW0X43umS7XVQcZsqRsYBMi80LH
         oxhse9aUEFykM0lfkgEtc62BvpUGCL2Ip++SKOaBWSHKJfKjiI1sEcB7TwLSn3n8OPfw
         jzFCe98R8CDu8qYnBnM0Q45RtsVI5YdTVLGn/qVXzRJBy71L7CtCMcAtBsAb1Zo9X+OA
         T/IspBOUyrjsmtvEF50lhoWTU92qxDOHdLYKpR/XUL6+BRT5k+eDunzyPy7vCDdUp3AS
         R8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860421; x=1777465221;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+YYF5Ux55cZSEsGe/ha3kTPm7wLorAaPgV/ublOmZHE=;
        b=i/seFhzJlUO9AYbh5KQ0VeiXnb1P4JsmBaSOv9L488535iQ2Zsg/bx+T4jIIOr3hzL
         WUJ9DwttNmKExjRSw2cc1TpwBpdjyp775/oiyE1U/4HO2vWHCXxdgebrC5ueakth/87F
         Gjz1kRtgoTxEmPnYY8zgIlMJbcYcrW5j1w4mkXrHZrfaanhJ56bqQsTgkUs6qcxy+7e9
         oec4ahP4TZtsUZuKuOkr9xAXFpLQcto7RkxyjJMrH3lVxSmZYCL11wd8uTkoWE+WLKZb
         bQd2CfxkywYHPv1t8BaqIUrtZwobjRAIKa/VTrf2wSVz6yWegVnaQxzlyadCO/+KSzb2
         embw==
X-Gm-Message-State: AOJu0YwJ86yL4Dtaa5WCiRBE+9A7Q1ftYa5/RbpKmjPiHwiWfHpg/JOn
	RoLvv9Cg5KONdteVkXxIaMKbF07XXb5XHSTpeL9hE4T1wXQHAiQwX2dg9stmBcRDTZJVyWLKaem
	XBfV1TClZStbPDysjfLjvAgI52nJa/CE=
X-Gm-Gg: AeBDievfv3urosf3dWcvBRSpBxOID9/9WCpPhtcFKRJaWOw1GBw8HJ2J75mo652nVD3
	vnBUAANAd6717Ak5hFMIkTcpw9uinMBFClrRGiPDYLCAzSVOmtt0iIriHBQTjWB/Qgf7PSENG8r
	nFhde3V7iKQGtU7CwzpQXOTWaUDOia/rs572ahZM3b/kFpRMlR6TsDJogrlCJE1F3QG0nkCdLGX
	eDT7GewkWwa4V3u5CBrWFO6TacPON5sUEucA5WQd+8LSRrB0PCNRffINfflez8pFVF2alirlXNs
	K2AfcmUWAG1R9Nv1l+YqzgkfjDw5izI6p9I+ooll2bqIHrJNrYd8
X-Received: by 2002:a05:6102:26c3:b0:60a:9cac:d286 with SMTP id
 ada2fe7eead31-616f4f7be9cmr9778386137.12.1776860421133; Wed, 22 Apr 2026
 05:20:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 14:20:20 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Apr 2026 14:20:20 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aeityL_05KDRZF98@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-1-513e354f376b@gmail.com> <aeityL_05KDRZF98@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Apr 2026 14:20:20 +0200
X-Gm-Features: AQROBzCO7RHDyH35qyh1BQoL7wkE0LcRRknzbclzkKESuhi2WyrzL8zfrCqG25c
Message-ID: <CAOLa=ZRHVUYYLE6JHJ8hJBOp7teTAZgz2vB+chMA6kr0RNb7zw@mail.gmail.com>
Subject: Re: [PATCH 1/8] refs: remove unused typedef 'ref_transaction_commit_fn'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000037b01406500b8e74"

--00000000000037b01406500b8e74
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Apr 20, 2026 at 12:11:59PM +0200, Karthik Nayak wrote:
>> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
>> index d79e35fd26..2d963cc4f4 100644
>> --- a/refs/refs-internal.h
>> +++ b/refs/refs-internal.h
>> @@ -421,10 +421,6 @@ typedef int ref_transaction_abort_fn(struct ref_store *refs,
>>  				     struct ref_transaction *transaction,
>>  				     struct strbuf *err);
>>
>> -typedef int ref_transaction_commit_fn(struct ref_store *refs,
>> -				      struct ref_transaction *transaction,
>> -				      struct strbuf *err);
>> -
>>  typedef int optimize_fn(struct ref_store *ref_store,
>>  			struct refs_optimize_opts *opts);
>>
>
> I'm in general not much of a fan of these typedefs -- there's not really
> much of a point why we'd need them in the first place. We don't use them
> as a type anywhere but in the struct definition for the ref backend. So
> we could just as well move them in there, which would also ensure that
> they cannot become stale in the first place.
>
> Patrick

I do like them, when reading `struct ref_storage_be {}` with these
typedefs, the interface is simplified and I only need to know what are
the different functions which need to be implemented without being
exposed to the details of each of the functions. The details are
available in the typedefs.

I'll leave it out of this series though.

--00000000000037b01406500b8e74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 27b26e7b94979796_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ub3ZRSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meS83Qy93TjBqb0pjMmY4SmlDK2xGb0hpU2RKczVoRgpRazI1VUdWMlhX
QWlHNXRpOFN6UEF6cGkvU0VETHNjS20rbms3eG1ZdGQybUJIUFFQOWZ5Rm9HaDlGbCtpZFF3Cm43
TFVCNzBPbzc5V3RBcmFFTGNvRkI5OVZGNkQ0L3VGV2JYemh2TFhieDZiOTNVa2ZvSXZlMXVpOFoz
NW44NXAKT3krOTdUUUxweHIzV3dJR3BFYUovRG1Id2o2VkZvMURPV1UvV0p3L2JJdnVkRUM5KzBs
VmE2SldmdGRqU2E0Qgp1bDNEM21adjhOb3BRRGY0emRzQndaNWZlR0hZajJwSGpFOWt1U2t3QUI5
U2trbzRXWTNBZjB0UXRHN2w1aTVVCkhXSE0xK1dpUlFHSDFyTHoxTVg2MzNvdUsrOFFVZUM2NXJa
QjI5SzFraHJjbjBsZncvYngvODJkVi9HNnV0OFYKWk5ESGpvR3BXcVZkMFNtMHNpYkJLczgwMVpC
VnUxcFZqTDA4VXczZ0Z5Q0MwTXFzSDNHdm9JS04yWi93M1dzUgpmNy9xRnRzUUxJcGd5TXM1ckE2
ektNZC9abkdFbTNWOXY2VVNhNUtwekVGQThoRG4rWnA0dDVJZ1I1cVAvWGZXCkdjcGFmRzlndnAy
STRuNEZMTllVSzh4NlU2OUhNSHVtcnlTbHpwRT0KPU9zNlIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000037b01406500b8e74--
