Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792523319;
	b=R223o+EDlTdemuYmUO+Ka0ZomI8ZaoG6oqKdzQxgJ9SI+p9/JwybVVeS07L7wkJcAMKF
	 hsbHt4BjEZLnaXJEt+2qcPE1E7NHhuFYrlIILylevH0pfB17LWMJZ/e7Dj8IXmdBmLpid
	 OaFVhSFepoyNVTa2CnViMF51jcaxyrXNrqyJ1N7BkdsgQ/pH9PgHeDTeMuC86ziJwVvz9
	 Gwv++v3013iYdqjpQ4xQ5YFJ9A5HNa+gJm3nHYl4fcZYUMIKS6ayyHFAXXYSP4VrYJRsa
	 Mnm68UcbFbiEJ0OJubZiigDXk7jGcxcyebIXUwmMzWFs1IwXqSHov0AI8JsYeIBFb5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792523319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=5xRTc8LXwddqKHCTHlf9CwZIcH6SfW7c2vvA1W4PBhc=;
	b=PxSGRyY7lslXZK0CYlFROy0e8sKWMoY50xCfMiDyaTVnClkC8rAChp3Z0QzAScmJkfKj
	 p19vMAwASv5xxSBUe9hYoLvKFFtvjfZKAt1cL673lyFKhNW+yq0B2IfssWSPZ/DFrUM84
	 tpdItYg7SPdkGtwlufLzoEiJGztEsxwGOSl6VW+eKnNSUsSrXX9GQheYpYrXrdDlHlKx2
	 DBc3olhgJCIjH36lRTGxHk9i8/9BcbEkgQUNs6QyXwieL71dNyjoacV3Gm3dz+4uJzoUc
	 ZmRqlebMFpUFQB3opwBobktK3ov6wbPTswFZnUWN+MFLtV4Bc2fE55+7RikGw964nHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iSROs3+3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C03606A32C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C03606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iSROs3+3
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-9909e82513fso646773241.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 12:08:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792523317; cv=none;
        d=google.com; s=arc-20260327;
        b=ASpaqiV2mwZ+2/YRbnsRREewhV0+E2DBsioLvIINiMPiUZuZlBCAx7LGk/45LnInvk
         d4UbeWVm6ntpOuls/aN9sTW7cBVLRmHoBzOsJ6A/pxJOTPLBY35ZbnRaOkMk3xLnXkL6
         bUSRsayp6wyu0WU6kVovr8O86/CZ+lCQfwVRtIdGXKCbknzv+8lFf1ke1VDxGDBSNxhW
         KpdzpxdvCzou2skSiqO4Lp1+HwDeyfVUqkq2BU46wmMEUD0Ezs2bU+iU/aG6IpB15J86
         Omn2YsIfFQjPhBvQ/cAZpZakaReD4V7tIy0TQSTpuHBR7vWGY7BBjHEj2RfBQwYrp+CQ
         rEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5xRTc8LXwddqKHCTHlf9CwZIcH6SfW7c2vvA1W4PBhc=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=fSqfID1av9lcSFwH1zSbd4q+pgO+6R+zj7fCi/LZFWtIm140V2VRJml2IHVxpUBzFd
         q7vXOb9zGq0ipGNkdrdS9qiZN5QW4rK0yE3JJaSIqokVSPxU57MU7jy2r67p+o/vgKxj
         vyVwbw0J+8OX1VtJI9wRIXGAH/T4Y7XsjlP2U14ILD1vSoQ8QY6mWVdFN7Uf4K9qk2b6
         alOQfsEysl0bMekXjoXoOENW+Upaf27a/mnwTCKHmDZg/mECXFsPk6PvTF2aB+ijg/Hy
         KKHqH9tWJYqb2gjyemzNPteWQu8bNE5QPZ/jL63un88NNGrUHKZmfCRt8goffz1XNDx1
         RVoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792523317; x=1793128117; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5xRTc8LXwddqKHCTHlf9CwZIcH6SfW7c2vvA1W4PBhc=;
        b=iSROs3+3BhEGB5avxlzKwWyexUocj2BmLjiaUsQzsu34SkUWf3mmQFwkCH1v+Q5kKD
         dMZ58lRyhppbG85ChiF2HpfahImTDl8YWFzlF3IqJv4bIIuENx9U4umRstibPoeoTZTo
         eRfBG7Ci2y27tbchXDyxRcDE9f4grkpxiLHoZR7E84YxjSasVdnWnH2C9NbPstV041ka
         svxM8B0qrEO8Pok4QJ3OeArrO/vQweN5ZqAmUik6qCD5t/ybSEQzwUGCnV9vgZg1u7v8
         AzpuRcK5QrOy1ulvPQZSFnYjEnW7uvIEOGEbx9X5rTdRr2Bf6f/q0/KHbqNrL4S3GuQd
         tLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792523317; x=1793128117;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5xRTc8LXwddqKHCTHlf9CwZIcH6SfW7c2vvA1W4PBhc=;
        b=k7kplzplD+CAkbUX69wzP30xa+GAkLj29bOLBoVxgFa8x+3Y6GtSo742FodIespJAY
         5TP19r8JRnqrtUiGpQi4OVmxp4MobUERFUg2IDSfuOjDVnYHqluyAyf/69UmTI0DUokz
         SWxTwmb/Goci3UxrHnOMUcecNapaERNsxIUou7tcmWkRPmYFX1+BJrqhUBhXtsSZyjKg
         mz+q4yF8fYRLVe++LclvS83doay1etCA7qrY2bNyd6/DDgIsDadm3vdZLxG1yHSrmSOy
         Yi9eSmrt4rqDAba7CLV/7JB4wXULCuV7WZLeN7kHoaWdp1NQ6CjyPYXyFTFShqZN03+J
         GcSw==
X-Gm-Message-State: AFq9FYJkB3IuujX7kDMI5nD5FBSwtcj9TkKmu5t9VrEJbkz10nkDijAS
	2ZRjwL1Pe3Ydw+efqPE2vsG4/EAPoir+twt2t7yuZtDB/o3Oyi9reTXFstye7aSI+1Jn1N7xE/z
	GqyD3hnQdhgokqd01MRGqlJj7kRg8BuM=
X-Gm-Gg: AYBFou3XstEgLeK8bastFdp6BIG4+JQsVTuSBmXBhDoH4CrswuR+lujjFHAFBEtZFp3
	VG3PVrakBBhZiAj8dlJlALmxbOTptV/ykBrTLoQTPbZ1W+Cm6EJF/vkDQgUKDNsJdWMb489IdSR
	gspW1l8UcfdKpDr8lT/YyU8qAm8NoF9sJooxCjRrP1xmjpyKHdpnZnkU2eaO5Ql1yDtS6QddOqC
	OTHx4Qtl5bFe9F2Fxqj129ImsQZsMybJb0GqE9zTEY0BLSIrinVHhOXT+rhGukfVDOENj7lTSNN
	2KjkvWwzKJ/9qti8TMEsD2SFL+gVpdqj9kSnSQV4VdEWzk9qfx+5AnT3iVol+2g1nJtkjXkw2QA
	5NcxXb+gEJxYksNnwt104fPUQUndPjXv+eb0PiKUpYUXPsw==
X-Received: by 2002:a05:6102:3f8f:b0:7a3:b2c2:2e70 with SMTP id
 ada2fe7eead31-7cc92767380mr35505137.11.1792523317481; Tue, 20 Oct 2026
 12:08:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 15:08:36 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 15:08:36 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <atcrZHZkvitoFJMR@pks.im>
References: <20261019-b4-pks-odb-extension-v1-0-143a5963b77f@pks.im>
 <20261019-b4-pks-odb-extension-v1-3-143a5963b77f@pks.im> <CAOLa=ZTbYQvnKBodYm4Bmk7Veb=tt6oDJwWqb+AfXdiuLxcdrA@mail.gmail.com>
 <atcrZHZkvitoFJMR@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 15:08:36 -0400
X-Gm-Features: AclHuK-CeBeNPZZnEe_NV46MkrAP5QwhcxC-a02d97mvuJBYmLLoJotl9xvp-WY
Message-ID: <CAOLa=ZT=prBjyG3aOcnZJiqJ_2x4n8hcE1P3-UkJa7ynLpvVYA@mail.gmail.com>
Subject: Re: [PATCH 3/7] setup: allow overriding object storage format via environment
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000973648065e4a5b2b"

--000000000000973648065e4a5b2b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 19, 2026 at 05:34:39PM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/t/t0001-init.sh b/t/t0001-init.sh
>> > index c7c464d3a2..5e7c25e42c 100755
>> > --- a/t/t0001-init.sh
>> > +++ b/t/t0001-init.sh
>> > @@ -869,6 +869,32 @@ test_expect_success DEFAULT_REPO_FORMAT 'extensions.objectStorage with unknown b
>> >  	test_grep "invalid value for ${SQ}extensions.objectstorage${SQ}: ${SQ}garbage://payload${SQ}" err
>> >  '
>> >
>> > +test_expect_success DEFAULT_REPO_FORMAT 'GIT_OBJECT_STORAGE_FORMAT overrides extensions.objectStorage' '
>> > +	test_when_finished "rm -rf objstorage" &&
>> > +	git init objstorage &&
>> > +	(
>> > +		cd objstorage &&
>> > +		git config set core.repositoryformatversion 1 &&
>> > +		git config set extensions.objectStorage files://objs &&
>>
>> This commit does test the payload for the files backend. I do wonder if
>> we can make a matrix for tests
>>
>>    {config, env} x
>>    {valid backend, invalid backend} x
>>    {valid relative path, valid absolute path, invalid path}
>
> There's more to this test matrix: GIT_DEFAULT_OBJECT_STORAGE_FORMAT,
> "init.defaultObjectStorageFormat", "git init --object-storage-format=".
> So that would result in a matrix that covers 30 different combinations,
> which I feel might be a bit excessive.
>
> That being said I do add lots of tests especially in the patch that
> extends git-init(1), even though they're not layed out in a matrix. I'd
> propose that we go from there and extend these tests in case there's
> anything missing there?
>

That's okay, I only was curious if we'd miss anything. The matrix is
easier to think about.

> I think the one thing that's missing is exercising invalid paths. The
> question though is what an invalid path even is. Right now for example
> we use `safe_create_dir()`, so we won't create leading directories. I'm
> not sure whether that restriction is a sensible one, and because of this
> I shy away from seemingly casting it into stone via a test. But if we
> eventually start to create leading directories, then there isn't really
> any path that I would consider invalid, right?
>
> Patrick

Yeah that's fair. It's all good then.

--000000000000973648065e4a5b2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 3b00f8493840e7dd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yWHZESVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2p3Qy85Zzc2V3ViREtZQUJGNFh0TzhmK3Nqd0JaOQpkNlhrS2w4ejlZ
Vmgxa2NmUUJvQlE1Z3J2YVl6NzV2R3l2cXRzYVdhOFlqeE05dGx3YUl1Wk1aa0FyRHhDeHlnCkI1
L2dQYVM4eTQwYjdoeXZYSmNTTSt4SFdtU0gvSGZ2Q042WHh6UUV1Wit0aFRHOEhwc2xIb0F4Tklw
Q1Zpa3UKeEtNczhQc25MSXVKRkVHVzM5OGdSbk40OEN6TWdnZUU4amlQek1tR1FSeStab1JoSW1p
YWdBbGxDS0kzUy80cApJYVZuK2Q2R2d3cmsvNkZxYmpiTlZFQnl6WVVXQnl5d0NiOGdGcncvV1Y2
NTEzVVFveGkraHVSMDkxcHI5MTVqCldETldQa2pLK2liWGR0WFpVV2s2ekEySk55Z04yOTI2M3Bs
cy83T01nY2V1K01vWi8zYkM2Y2RJQ2s2UDM5Mi8KTWJSUnJUUzlGWmhMMmRUNzVtVkZqRm5pTG01
dHpaSnF6b0xVYTdHTzVwK3NseWhRcmlzMVExeFlyTGVSclI3bAphWkR2TW5IdDBEVGg2OXRjejdT
d2hCbWI1TnBESmFaQ1NPbGZmdUdYeUIvL0FMaHozNjNSSUFseXhVVVliTTZjClJUMkpLUG5kNEor
eEg1aTNJR1ZTM0UyV2RWMDh1V0pDVW1EUU5FYz0KPWIxRFYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000973648065e4a5b2b--
