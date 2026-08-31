Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2833DE450
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168380; cv=pass; b=Oi5RMTOrvU+d4TBHgZGD6bH+2UDdVu5OYnCT2cXXDE2uSSI0ohLJd/5f+DK1mJqI2/m+WmNJXdOYYgiAIhuRAFUWKlP6Z6VJAbwUCdEB7raBR4DXqc04CiLq1gIm36BVqAnMbj3727SSmu2OV2+POUQpZucBtqAQ5aaD5ZB6NJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168380; c=relaxed/simple;
	bh=yLyONWOcCxkHJWzBkQIIfimHvTMGWYjxu5Re4YtI+CY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sTLp7O9aPwrTGhTm0BSX80gFwaZMjcV3kIrUaECXGbZl5dWQNeLJPZzxAfbIKSv194hWqGTGpuFE3KdU5I5zmtU+EB/2/PoopARTRpOfrj8FLzmMQaaASV6Aex+dT+FiTME1Wu8Z07iH7jgsqtf8uQDaP5XPimcc5oCZP+/eWL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o/APwkEj; arc=pass smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/APwkEj"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-97cb5850a93so1246807241.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2026 02:26:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788168377; cv=none;
        d=google.com; s=arc-20260327;
        b=NLH0QtoMaYu8cdegWUsCZUQLn73bVwobg9g/RrsE+j1LnWnYP//qwtz/LTQHtdC30f
         Wcco0HyyyysXKXJdkONDNMMwdyg906ZgVGqFKi+s933RSHQyW64Ex5i0gZCPuBORnF2B
         VRSSDhPj9MZ1C5J68eZ1elhMgTP85S8pmP35PxgXqxZAASQFyNqZohqbyvYzTvT1UXRB
         lbMOVC96JVqOjLIePkqkWH6NF2EaCSNQ/zYYx8jOt+tFHWMZC94f5lnbbXQQDY9q0Ugw
         K1zCOEGIWbbH0RpV0+OgG3tFlrUNwrEK/JBZ3kUFV302BJgOi/AOl6oNZvEF7XS8kaT6
         AWUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=yLyONWOcCxkHJWzBkQIIfimHvTMGWYjxu5Re4YtI+CY=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=pKkagaG+D9aRTclamQdCF94ADMUjSyiXAo3H3L0nBtrelGfPrLCK99SdQllOm09KMi
         Kn0xWT3D7Fd50WwMXOj8hWQ5T8QtWOLI1Ty4hW4stuJCKm1eyJaeGqF02Tl6ybjgqUK4
         KNxDW2omH//XHHvV1APahzn5r1Li7xdc064vfPVe0pWEAwUtSA+2r2hQrWXS47lddzmC
         4kjtrJaoG0dlR7VMZxSSZIgGiXK93A8qUqiOqi+2IQHbLPUUFAB5nrp9zhLcjrNU2QEa
         6O6/tZFdaH8nbikYnOS8YOqNyv9cmF+le48wDHbJfGgyCYeFZ2cMq6fj/IEUcLLEF6Tp
         vEyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168377; x=1788773177; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLyONWOcCxkHJWzBkQIIfimHvTMGWYjxu5Re4YtI+CY=;
        b=o/APwkEjgoNSzilzVAkAvF5KB1aI06gCYvlUkfN/scTu12hUGTPeCT72vVG5h/QsyE
         trK5uuQTyvMFdpcP7t5MepWph1uBd0mEJuQTIGkU04e1Fynz+vPkCfFLFYcNvyFAELcd
         INri5Gyucq0ofnMbsYwMXkLUGKykB9uviHYpqoby6R/fsC2dpUqItNm3ergHaG9bIxgs
         RV+u5olnFJnGQwwPuc99TFKNM6vfj5wiV+RslZu4M14JJoavGgUdTOgOMXiBap/aBJjj
         B8oWCQ3O/8S+lqkjrx/QhugxU3RmxmAnhTjiioOE29ocL6QKhRXdC+ovCu/XeBKsYj2p
         NM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168377; x=1788773177;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLyONWOcCxkHJWzBkQIIfimHvTMGWYjxu5Re4YtI+CY=;
        b=C8Jlhl05D62tmN9o4A+ZdplnYdNXhgZN5mXDWLRCk1WJSELkqGGLSQr1ORruY5GJko
         QPg9K4m58TTVDqQj97keMe7dNZH/gBmw2LViR26I9C9ZGSh+iUWZWMQ0GL06+Bm9yi8s
         hDYipC0jSksj6spG/ZudM1CtRXwPtCXXLvuzNEnH4lUIjg9prm5PxVz+RsvD91xXBqf+
         zr7Wik7LcTyNxrUlJJ0YyBEIfgxMHIxgN9SxuHpTGCotzNvLUz5smZa90F5mJqRqHySp
         RZN5BWE1JUxUbFmbdPVWfNvu4x0qbyz1LTDC9pQMW/enkzmNYEzcEiakU29koBZOCetM
         l3Jg==
X-Gm-Message-State: AFuF++m1MeJ8jaj2bXwafHUxhn9g9QbtpAllxnQESZrO/6VfkNFS2qX4
	AYVZnrPqifdFKKduahHRw9p1+I01jKQo86sOlBv4RF2G1KdbJBykEDN2VCaumE/p1lmSzxnB1AV
	R1K0yeM0NthOUCQgvwlwjCIo/smffHWwXFRYv
X-Gm-Gg: AR+sD107SsrVlbybawCd2UmryDk0cfimFHiCr1A33hELXx9brSpNfn5gEYILKpeAUV4
	Jku4g1k6FXbnbPVf0EJFp3eq3ii6DQSD0FvZTDXN4j23BXkfrsLtlZT9BHEvNBKcSXxk5bQfoqr
	ygdM5InE6WYP4WkbMQvqnh1kB3ohe31YutC+beXhL8JBtOD010HQAXN0dSx68gQNzaUW2fkcSum
	AA9LNTB6WXhn19qjHougQ+aegP5QmiJgtGkPOMo6SDARXt0Jwgi7lDG/G0k1/teKR3NHj8LnIJB
	oNRq13UgCgIoXtr02IFGfLUUdRmM2UObVEW+olWDU+JXQ7/i6EQ5nEqwrLeZ9vEDu5E161EmkZF
	jcvUXHt27u/pmFT0d0IwZleEP8DSRdtyFkWA=
X-Received: by 2002:a05:6102:c8f:b0:786:4822:308f with SMTP id
 ada2fe7eead31-789ef95b88bmr817658137.13.1788168377280; Mon, 31 Aug 2026
 02:26:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 05:26:16 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 31 Aug 2026 05:26:16 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <apUYiv36xvWe-oj7@pks.im>
References: <20260825-pks-odb-source-fsck-v1-0-b756de0bf24f@pks.im>
 <20260825-pks-odb-source-fsck-v1-8-b756de0bf24f@pks.im> <CAOLa=ZQwhpPMrgeLW8W0pezH8VFrqDiiAfet3G_jDRQDu_KQUg@mail.gmail.com>
 <apUYiv36xvWe-oj7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 05:26:16 -0400
X-Gm-Features: AcwNN1U-oahM5WzgxitahXM-ySEcghzKKjO9fijZ-zZfBoIyIAi_jR3uUraw8JU
Message-ID: <CAOLa=ZSVe2okfJZL-xt1PkADF67z8JZrtcFce+mecsoMaseKuA@mail.gmail.com>
Subject: Re: [PATCH 08/10] builtin/fsck: move bitmap verification into the
 packed source
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ed4877065a5464d3"

--000000000000ed4877065a5464d3
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 27, 2026 at 06:54:51AM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > The checks for bitmaps live in `verify_bitmap_files()`, which is called
>> > by "builtin/fsck.c". These checks are obviously specific to the "packed"
>> > backend.
>> >
>> > Move the logic into `odb_source_packed_fsck()`. As in preceding commits,
>> > this means that we now properly honor both "--connectivity-only" and
>> > "--no-full". Furthermore, we drop the dedicated `ERROR_BITMAP` bit and
>> > instead use the generic `ERROR_OBJECT` bit.
>> >
>> > Note that this change also adapts `verify_bitmap_files()` to be
>> > focussed on a single "packed" source instead of verifying bitmaps from
>>
>> nit: s/focussed/focused
>
> You can actually use both spellings [1], where "focussed" is more
> commonly used in the UK. Anyway, I'll change this to help our American
> friends out there.
>
> Patrick
>
> [1]: https://en.wiktionary.org/wiki/focussed

I usually follow the UK spellings, I didn't know the focussed <> focused
variability.

--000000000000ed4877065a5464d3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 70a2eebd48a03388_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xVlNMVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNjJBQy80c0lsUCtHMHphb0NUUHRIaEdCVnpYZ2dRRApEVWRLakQxUS9h
UlppdkErUzd4U1VlenRWV1lvYXN4SDQzbkQ0azMxVlhmbnV1dGNESHM3UlppTTBUaUtXb2c5CmNT
UU56WVY2ZnhNdnlBL1Avb1prM0g3UFhHMjFHQWhsRlVlTzg0QytEVHFmMlc2UHNrZnNsdTIzQVFX
TVcwQ0MKb24vZlE0YnFxUTJnUWVvMGxURWpvS2F4Rk5oVkVleHZ0d1VncTNFVGc0YVJsRXp0T1Mw
cGNnTTRxUXhvakRaeApPcnV1VThSKyt6aXVEWjFHVFZxSFo3dXdpanVBUkdqTHZWYXl1VW5OWjJR
ZlRnMVc3WGtaK3hmZFY0dnYyeGwzCnBYWWVhbHZGMFVoZDJYYS9HNDdzREgySExtZDUwUTFuUDA5
N0JOS050N2Rna1VNYUNJL0MzVzliMkllTytXZ0QKWnhCYjQ3SVJQamhnSFFlVmJZcUs0UUpQU1Fu
YXZ6ODdGS0g0T1kyTGh6T01NN2dBazFQTlZsY2VUN21ocmF6YQpxU3lWa1BJbys0bXhHeFR3d1Vs
eG1Db0ZWYXBUMmZQRkhkblpFbVBDVmt2TkZydXJDaEpSUzh0MWFxTWgwOE5KCnJuY1VTSmxHR05F
cUN4c0JBYk1zdXBLVEwyKzRRVmViaTlyYm9WND0KPVBpREoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ed4877065a5464d3--
