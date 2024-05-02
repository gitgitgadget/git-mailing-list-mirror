Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B81CD39
	for <git@vger.kernel.org>; Thu,  2 May 2024 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649666; cv=none; b=l1VgFT1EdpSIUcuxlofYnzuiCqSaRFfm3qe3IC+InQeVgDDb6Q7ZpYN/LCPRpx4wvq2kj9CGDQVRpA/j9eBPE/+FN5MQVA2woTAvSngt69DMsbUDJjbHZhJvPPAyBuM534L/f5DfQsSnJ7rRhuqqaN1vz9yBP9Y/bRjBvPxKGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649666; c=relaxed/simple;
	bh=GU+5lFz/qs1W61HYblajq0o+KY5wZ9cdRN8etv6If5s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NEDcrO8SiCqHfs5H55ExcoN9oRx65uTiQhZHbMQHGxSw3f0yFqZ9H4w358cKch4SnwdNkB0HyKWbi4R8ABht1KX5sRb0V7cJRmnVWr2yqB8L1u9YNSM76wrk1VsvI2Bo9c/mtIQ1l14LUfWAz1685rspNs8BM4Dhc0fvjPvmCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZf5gYhP; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZf5gYhP"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-23cd15209fdso1987805fac.3
        for <git@vger.kernel.org>; Thu, 02 May 2024 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714649664; x=1715254464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GU+5lFz/qs1W61HYblajq0o+KY5wZ9cdRN8etv6If5s=;
        b=kZf5gYhPqjs6V/lbr/sQAaAfIIC7chdv1BCLi8j6GZBCoQbu40/5Bilxn1DCNZaNr+
         Ubk7WRBDw5kjaddCVTCpsLOLe6OtVPOVsX8/1CaUi9wMQb+9cLIBHNjSDV6m3CDGIWCB
         WRc3k2Z5MPplvNNX7r0W/ziAKIsMBNwqCkH4Nlk6/+iVWT2HIaOd6zn3M+G0ISYJNo4j
         bKpwVbikd0bAukceQgPCSwcO0zjYH6J3KUgaR0i5bg6zOtZutel+N7gnNQyJpcrvNzWi
         12geWUP8HzSOb/+sfX441gh+px0L/mmVC5RBeuGjfuwixLMU8ETPhUgHYzEcmp4g5Z7a
         UzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649664; x=1715254464;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GU+5lFz/qs1W61HYblajq0o+KY5wZ9cdRN8etv6If5s=;
        b=ihY/hv54CgoO5e1n7ROjro9oYMMpPmMsi7ucx2HqVBdLJSMXHQ2W8Z8cEeqRZ0n+tD
         rfKxCVps2Dr3bXsjBN/6v9CIwBmCh8vb4A0hGhnVjx5pnDO2mmRgYVb7FqKDQoqFJNHT
         GNPPa7jRtsAPy69JWXsQTwAt5K7rsIWwe/ty2Lk9dDGQswSs2YmdlW/TETS7+nUeQZap
         bFZ15eJVJ++igkG9gWoudeBRH0Q3nW/7YoahjrLabqGPNTTHI5E1GFeufpBO+LsAs7iT
         7l7WlSNFcAHpi2iDUeNnpoFXVbNDPP5aEVxpZomwl6GLLammByDNFGjwxrIv1qDvrzb7
         g0aw==
X-Forwarded-Encrypted: i=1; AJvYcCU41eWhxAJnWW/x/07daiKSTow2PS3JW5BSf4LxnP/AoaUNs85Cp/xUK3jsd9U+Zow78yDX/iCLkdh9itJeLIxqpDvq
X-Gm-Message-State: AOJu0Yx+cY10XEVAXd55y8ZcDRqB2/boFkjsz9zmy4eS4ysHLiun8kQ0
	L/JMfRnbIizHjOT1k1KUH4ZKKIjnJ3VvOgB4Dlt5oqQ+asbdHupa59ML767TcX/iSFq+sXP7P0h
	AHLVw8lota9BfZwsON6vOYCikrGs=
X-Google-Smtp-Source: AGHT+IEsQhEJJ4+MIdPoIqd2ER3taRg7BcfCDfHqEA7UHEzs5J4OzeYB2nCH4he+Sd1VMsbDIQl2SIAkpM0dH6f/Ikc=
X-Received: by 2002:a05:6870:b28a:b0:232:ff53:44fe with SMTP id
 c10-20020a056870b28a00b00232ff5344femr5833322oao.38.1714649663646; Thu, 02
 May 2024 04:34:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 May 2024 04:34:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZjNFFreAkolYMCd_@tanuki>
References: <20240426152449.228860-1-knayak@gitlab.com> <20240501202229.2695774-1-knayak@gitlab.com>
 <20240501202229.2695774-7-knayak@gitlab.com> <ZjNFFreAkolYMCd_@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 2 May 2024 04:34:22 -0700
Message-ID: <CAOLa=ZSJABxcW643hmpsot5M-_-h-_XHpNAgoof9HCXwj1zhKQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] refs: rename `refs_create_symref()` to `refs_update_symref()`
To: Patrick Steinhardt <ps@pks.im>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000001de26a061776fc73"

--0000000000001de26a061776fc73
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 01, 2024 at 10:22:28PM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The `refs_create_symref()` function is used to update/create a symref.
>> But it doesn't check the old target of the symref, if existing. It force
>> updates the symref. In this regard, the name `refs_create_symref()` is a
>> bit misleading. So let's rename it to `refs_update_symref()`. This is
>> akin to how 'git-update-ref(1)' also allows us to create apart from
>> update.
>
> Arguably, as we are already updating all callsites anyway, I don't see a
> reason why we shouldn't also update the function to accept the old OID
> or old target so that callers can make raceless updates.
>
> The only problem is that we don't have any users yet, and consequently
> we have no way to verify that it works as intended. So maybe this is
> better left for a future patch series, unless we have places where we
> can reasonably update the callers to pass in the old value, as well.
>
> Patrick

Yeah that did run through my mind too, but without a usecase, its hard
to justify a change and also like you mentioned harder to write tests
for.

--0000000000001de26a061776fc73
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d193f6ba72118f96_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZemVqMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWd4Qy85RDl6WEpMWTFKakpZMWdsL05BU1kyKytzWQovd2FyQm1EM2FI
OG1BNTBlcmRCVThhOTdJRHVGM3ZOdXhxOUxoMjBNU3VqYWNyeVBwMnM2YzhDSlhabWlPNzdGCmZY
WUNiQ3BwOU14WHB6R1k1dUl2SGxCbHZGK29uRWxJbkdFZi9pMDZPSUh3ek1NOEZvRGxSOGgrblMr
Zm1keGUKc2xlZ1ZmdGM0UjVVdkVVRlBsdndSSUE3Sk5ZU3BvUDJROFhMODIyV1RNR3BmclE4VVU0
cG40d0ltWitPVTZNeQpEak5jb0tlV2lpVmFwYUlqKzllVGthQ1pPTzJUcDlRSjY0M3FrYVlnTHlo
TXc2UzdBYUdXOGREdis0NVp6OFpyCjdGK1A4WGk2ZndIcEx5N0V3ODUwdCsyTk5lV2QxSXRKRFJh
YnBSNWRNbWVQSHVuSGRPN2IrNXFKUy9BUEJCZ3QKZlA4Ulp5VWlHSmw2RWtSNUxJSSs1cmhvL3pJ
NW5PWjNZSnlFOWRWZDZHdjVrNTNPeEZ4ZEVMK2pSUVQ3SmkxUApKL3NnZVJXVWpReEdlbkdOL3BO
MCtZbWxpNjVQSDhyWmhNZEU2cElLamc3Z0Z4K2xUYSt2VUdoWnRWejJqQVdyCnVRWDhGQ1pkR0sv
YVFRU01RZU5PbXowWFgzTHY2ZXpIRUNwZklGST0KPXRZcjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001de26a061776fc73--
