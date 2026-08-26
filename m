Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B1E280A56
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737634; cv=pass; b=Du8rbxK9IpDqKnUtNXcrsc7p/vFN9vR3z7BnpgH9MSwJcFwS1CsYr9IdTJriZ7waHNmAFbcNXKEEovI7UrpCjKiwBjkXxAUO/8grcxUjxEndzryNLlUY+RTHPk9ZLPN8cQudwbSoHtEvELJ50wzMM5Q/SIXs4NfvfiHZ9CuNKbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737634; c=relaxed/simple;
	bh=iZ82JC25TfQQTbwn9yW73SlPykir+B5uV99SZuR7KBg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGUNe3BIKPSfFp/0tQleAnKN1XCy7t96JlCL9/jDd6yc2P3AQGdwA48MuCOTOvT81vDXLJyHHvIDCrKOtSbm7+G/Dlo1oxGIUdMuieafIcWtRcrCRIqptxTFURPfhIA+20jAkE2FE/npnppWOoeJXvw+mZeen43QzZt9rt0PiTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcZYkBgr; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcZYkBgr"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-97c79f2db08so310214241.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 02:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787737632; cv=none;
        d=google.com; s=arc-20260327;
        b=rVNF5fhB7peVW9CFKZF8mZZiNArhqjLi122d8pN5clPnSDWiJaUsoYT0uOB3KPe6n5
         qcwoaIm4r9rArq+Ujq0yfbI6sRXWQGoKcMB5e5Td44O+eTaCam2VMEf+x9eoB/I70l8X
         aXZn3HMY/6Hlp5HmY3/3U8fmuB0ew1s9WK1KCai8mIrJX52EmTyX+gCJ7kXwPlRASDRu
         mHTJEM7mpradem4HDZhJ7MIMGLketHz4XWu7k0e6UbIdMvuuOGQixsLAYbmpl+da1rk5
         KLCETflbER6eIADC4+XByFZHPTtc6K1xohXLPWdZ6WMjv413kkiuwOdkaaUM8zSKxKxA
         Rk0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=hjzokfKEQZtNcCFLbTAcascJLCoPdIiNXqkrdTcRZH4=;
        fh=rF92/hKkNSqTOvJyQo6isjv9H80DGl/xHyflQ/yGv+8=;
        b=H3uNLOOtCGgpThWgcosg/9AIjfwlf9SsE+eHvmh4bZstKKiu/MnZfP40tHaIiLzDzD
         nXP2RBTuIne+RMPCpzIR39Zp7cn7VFguYyf6iF5saClv1QChYz8UPcTBHBScj7RlOTew
         iWg88yMOm13lWPKgbnoc5H5fLRA0ngmxIg3zhBgngqxiRZzhQp0MT/TOiLjjUKPadwRa
         swgyztL+DHH+pjjVenuvHvw3Z8Hii2QHf7u9EuHwvefqcEz82GuLkLYCNYesd9jIGZW9
         AIsvejjaLJSy5lsZNEiYPs/Q9ExuiJZ8i/LJySkljIwcW02V4mjtRTLi9vIIOjy5wJpm
         g1SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787737632; x=1788342432; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjzokfKEQZtNcCFLbTAcascJLCoPdIiNXqkrdTcRZH4=;
        b=ZcZYkBgrjaZbQ158/sN/eygNHlhNwiSd1zCD8StwPoy2gaGaG87RLIMWa2hWND3mq/
         SZd77qaRx3R8UyUkhhcuYBnKXEzPvrsE+YeWAQ0qqRCIvU6gukyX21RroCTemNGwUOOE
         tLj8pgyqfCo3jLWJI7GCuk1hRcVZ8g0A7vBoE3nqJYQyuPwZ1wpSW/Gn4IkWVJPWHImL
         1/FEArUe+P2evG4jY9XIckAqGr8FlyDDnBAkbFmMhVy8RtqHQaA9ZYwrcQPLtBgASZdV
         CFDWzmHJIHISjl1aK//i38N4Uuiumcv7BjwLBfbN56QGcsyD19fB0lttiX5vsxF5cCuC
         vtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737632; x=1788342432;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjzokfKEQZtNcCFLbTAcascJLCoPdIiNXqkrdTcRZH4=;
        b=m3MG3dZZhNZbZKXg0nbQ5RAjBPGR4/lH85I2ynIaRYY36Sv3nWXbbO5jDt+6XLZx2b
         642xcOBEXrd+21+g0w/BZnak0Dqxy9N2jLyeVxz/CZbD9FDqlv1WxkiumIu7kFi7vy7K
         muYC6n3H3WEoHbCdelMcHkrbb9YwXK05q8EWERvQajFjwE48fLXhejpICesHRciRmpyr
         h0U19VfXJwjccDzjhiUcTxveaEBGsSAJNRfAtYRSsWqk2tF+bZSsmfgMNWG8zGj8Zx2h
         TcZ4jlMB/75VKypkS8zGRnBIG11Tg/kPl1qy3lBwftZRV/vrFV4WFqluFHjZGkNBLTdG
         M0gA==
X-Gm-Message-State: AFuF++l78KZYNieFfbpKHr9sWH+arSkhs/8Be3XdekVNHv+UGna85A8F
	Q465weH1GP1t/RD1u07OmqYkx4r90hKatCVHeOOY2UiN96f3q38j7Tx+7aTB74rw7ZrbNEdOWA/
	rbbk7Hj6Y7hoPs2u2kzVi8J1Sei/SSMU=
X-Gm-Gg: AR+sD10TowLG4OgRLUOqdC4pcvkCFEjvaUr0FB/U0fxN1AzW/1eLdqbBx49914NiW+z
	aIVC6g87VCF4SezDnvFyXYjojfY0dTfo9P1LIjwTnjFpaRe03W1svCUxkNYcdfcF4o1sSJXhtwF
	mbk8gcW8f1WMTwsPbNk11iwE2ukaug172S/GX72exLcY4EdDvmjt//WSESI3hClRaJrH9DJVyTA
	Iu1+SmggavwNkbgYsS1/TGZ09IM7nTeIozB5nE66UQam2kiD3uI7zpPw3ehoVGyCPK1YyRPX7Ad
	Czyxz/wVHugIPS5IjQ7RQXnUve5AeHWRF2G8EPJXEV7Ev7Uj/vr4WYcsvhiJQKA666zyA6AbgCR
	KxXqyK8s7GHZvYh0sgttGo5gV6JeMH+k+lTs=
X-Received: by 2002:a05:6102:41a4:b0:778:5579:c661 with SMTP id
 ada2fe7eead31-782c0dfe6a6mr1945952137.7.1787737627174; Wed, 26 Aug 2026
 02:47:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 04:47:06 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Aug 2026 04:47:06 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260824225202.GA190620@coredump.intra.peff.net>
References: <20260824-740-optimize-reloading-the-reftable-stack-v2-0-9c9de2eb0af7@gmail.com>
 <20260824-740-optimize-reloading-the-reftable-stack-v2-4-9c9de2eb0af7@gmail.com>
 <20260824225202.GA190620@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Aug 2026 04:47:06 -0500
X-Gm-Features: AcwNN1VbHH-XcyZU6AtyBbtXOf2DcN9q5KtbbN5IJmEmLyYvcibV3QTObVcypmw
Message-ID: <CAOLa=ZRanhvBragQEcsLostB=4YGdDT8js7x8Ck5nJvLpsRZOQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] reftable/stack: avoid reloading the stack when
 already locked
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000003850850659f01a2f"

--0000000000003850850659f01a2f
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Aug 24, 2026 at 11:31:02AM +0200, Karthik Nayak wrote:
>
>> Benchmarking with a fixed, non-symbolic target OID in the 'refs/tags/'
>> namespace (since it triggers a stack reload when checking if reflog
>> exists for the given tag name), shows a consistent 15-20% improvement
>> with these patches:
>>
>>   refcount   master     patch     speedup
>>   --------   -------    -------   -------
>>   2,000       18.5 ms    16.6 ms   1.11x
>>   20,000     120.7 ms   102.8 ms   1.17x
>>   50,000     296.5 ms   247.1 ms   1.20x
>
> Much nicer. :)
>
> I'm not very familiar with the reftable code, so you can take my review
> with a huge grain of salt. But I think the idea is sound, and I didn't
> see anything obviously wrong. Thanks for working on this.
>
> -Peff

Thanks for the report and the review :)

--0000000000003850850659f01a2f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 54fe874b4a5ca491_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xT3RoZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTh2Qy80NXVuUE9PaExHc21zOVVycGNpRUFxb1U4VAphL3V6eW5OZFUx
UFJrSS9xNkRnN3hNTmRocHVhUkpTSTdRdWI0WnQ5RGI0NmZPWWRRVFEvaGNWRHhsT2NkNE80CmNM
VnpTOHlaeVRqRFJWNmtBYUExMlM0dGJLTXRVZWRrUjhGUmJJRjhFNExBbkF1YlVIWVo0VDlwbDhJ
NWkvamEKTDZ3NVpZVDdxYmtYMElMTE9vRWtTYjZxWGpWWDJKSEpqZmVjaklzUEVJdkxIWEpUUHJO
c05Wa3k4VFVQREV3ZgpHOStkdGl0RzVDSEdyQ2FsQndOaGcyN2VkdGFHVzJlVzFPeGlONFhSVmdk
ZHZwQU4xbVFHM0ZIN2RsU3M4SFoxCnFvamxDY21xSVJ1VVFsQVhPSnJOYytBQnNBVjFRaExnUWJ6
TjlnR0N4V0lDcUtrVy9tR0pkd1QwMSt0cEtrNTkKYnBKeElNWUZ0NlBra2dFZDZBTlJJVnA3eldH
VW5MbkVaNStxM3FpWUVsOGFPRVRpM1QxYmpqR0NoRkVLSWhHZAp5UFZLM1pBdklodG9JK204N1pY
VFJxWTZ4WkxmSHlOT1B4NWJkQ3ZWeW1hME5QS3d5a0gxSzFrTFBGTURsWk5lCjNydlRaUWFheS9P
Z0RLQXBhUXcrUDdURGxkNlE3N2tRS2c4NkNicz0KPTF6cWgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003850850659f01a2f--
