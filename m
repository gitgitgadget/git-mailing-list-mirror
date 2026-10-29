Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268175;
	b=qHNf1vKF2CnkYD8FL0gyWnkI7Do6ViOk7r1ECJC6zBhO2OXjCqOeC32hC+qep9+RfDdj
	 a66ZGa05uI5+UC9obVrvb00aOjFb5MTGZFl8TaTchag8akGCQaamZ6c96fwe5gCQePRr2
	 gO1DEVV5WO2jE1PlQBKt2yNgCoa0JVQDUk9OIzFkFM5w3c9P5kQHbinvYR+effM9nrQtQ
	 FYQUhdCIBc8izAOWx5mjXRHCzxJYtI12aqOtrR/tYcojheeEGq0Dw3BGgZYkNMswdbSTb
	 KXfRWHy7+8Z6Rx2HuCtk7DHfVCjBnAhgRBsCsKatcJVHV5hSOsP0XnT0ZOuMzdY6FdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
	 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=NoEGuzUHD7aL/osoPwdeB5Bx+8Jwglt2g/V+qz0MX+U=;
	b=F2PElZaisCrnX/zqtKKzl8lRPrRMaCW9tLAkyZznUyf4eRAMs4Vm3y6QkOMMgYrH7K1x
	 KrVU8mX8Jcs9leRn3TEq2fo/DE0Q4YIpKIAcTYIrDA6hjMyp5jwrSXz6SjhRwdN/6MRGs
	 AcbnFgha5+Z0G5nQ5sG4g+Vmi8692qsiotsijm53FrA6dyZd5LSJzqLBUEMkC9kPmdRlm
	 IA+2z5aGZLvMo9XI/lpZogYEnwdykxoEyda6D04zsb6lqf50CywmdfXy1hn/j9fTGwbIe
	 w8JEQGpiLhGDj0C6h1F8fxYcUCHsWhofDVOaY2IUPwVs9qiK8q9CRHYRr0PRgpCo0+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAY5BYFZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD301606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 10:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD301606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FAY5BYFZ
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cb6dc850c7so614702137.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 03:02:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793268174; cv=none;
        d=google.com; s=arc-20260327;
        b=OwEmeh1/lTOsdSftLdfBf/oqG8Jk0GaXOLjHwom0M9p59QR8HKuXA/Snf7CoDwWS0j
         jmvkivqKaD95nTHruhXAUp0ED90gqzA0rz9xhYGtEM9jB1N0qIFBDdBaVzYresfZyTll
         JwoDGWSucV29gU5DkkllufP+qTqHTdTdrk/DUNWPc6Dh7fZhJUrddHEHTvqMU3WgYf0K
         rKsp8tdyu/aJv8h86LUjUFx3dPrLpB9vxx/VvqfubDyWmeABvE8lyE8xAxsj06XaHbRL
         icNV894+wapQtwS8xcufjnqxXslh7I1fOmczGx0Ow5efShvbL7z501dy9sc/jk9dwC6l
         pAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NoEGuzUHD7aL/osoPwdeB5Bx+8Jwglt2g/V+qz0MX+U=;
        fh=GGWEzrIIQ6cHJJb0qSNwyEDctpXMUll4R1Dn3XJ2gys=;
        b=Cs0CqB+bC0SioXdMfY7d54PjxCmPinRz3uaGtt5M89jeezb5mYDXdMmIxqMHoQYgwQ
         ebqJUGUzqQQqRkBbDWTpkhM9A3wJ1X7eWaLuExXWcvN6hpP8VKYfF465aia3XVeTDdXI
         F5MCIea/klBNuN/reeUFT/kCuf0Np+SEY3iVfCDvmnfWcspkLoM8vixouJnn84Vc/FLf
         JP247STE3zBTZyyIUuyk3wAyPQvjlcqkpfg3FroKkYJNjaE91Z3KM7Zk6ikzecdUOxGN
         4u0Jno+1W+PHKeTovXJ5gpEH2aq/pkINcKLnEUbeJ1zjpGwZO8iKN1mNpPvLxTI+4XFV
         /X6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268174; x=1793872974; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NoEGuzUHD7aL/osoPwdeB5Bx+8Jwglt2g/V+qz0MX+U=;
        b=FAY5BYFZVjjlg6nCWMKFOeerVI9d19CYN42Z6lBmspwY6gRLBvNT0yCtMN7bOqob22
         p1p5u85EX2Ua7beqnwDBvIir0DF+Wj986jkZQ16XSUYJDxf/ETxC+7EUNRkXNhY42qhw
         kR/3uZ+/yiQ0EyCuXdZBPTwBGLftF9KX8dB79o5TfcTgHIzhhftf7D7G4zUv8nBAnBwz
         TdrolGoaRae+nDYFqMS2m2dGyM88ISq2jHAlpugy0AuchHtpQzJoqWcuuUFpcstWDn0l
         cdSbJQeR4gaVmSBahKe46TzKuejilEYgmtDyztQEWnxNqtdb1A1D0IseyxAl76WDblsz
         C78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268174; x=1793872974;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NoEGuzUHD7aL/osoPwdeB5Bx+8Jwglt2g/V+qz0MX+U=;
        b=oQK7pvTFMd4G3/NPxMlsmKQbSAGsIO9AS6yEVDSWaeqZxbVOXkGYV4vQlh4iKt2wK6
         ZYzTAydz13NuJk0VsEbwI3TxIqeWUaPHA60aT3ttu2KTr/pDFihy991ziTgDfeXgQQk9
         miDuL+JHnTtbSAkjy3eNqO0lXwthiRvPh6TYU22LLzdxBdawoDNGfIFoRKBnibRCyOZ5
         hF/6P43KpEmGTa7j6DtzUUcdurGWRLRMCXfFZXcl1WCF/2nTWKFeY5ew93reLLrXAjU6
         UtGpHOp8Y7AWacuf70WCImEeX73EfgMCPXxzRH6shjE/Ldr+elf0QmLlxF0HSDdI//H9
         mIQQ==
X-Gm-Message-State: AFq9FYJoxpXjgf/Y7bk5QmB9xhJav9JcNfMvvK/Zduy1O1lVKqPcw+hY
	ZxmD2gk7Hc8gkb1cZuB1whcs3MuVgf+o0jRs5ZPWQVAU8coxYZ6mpIpxiU29ktFXU+x0xrUs/gF
	y75DEnXB2FY0TYE5GfbRq3bkYeMZkwxA=
X-Gm-Gg: AYBFou04PA1mKumXoAHb1XpBNTb5YSZuujMUuFbBvenl0cB/zQxuLy8s14t78GnbdG6
	PaZsX3gqOrrUf4VISRS3RvKvuPhF/wfQrUfv0J5rGNxxr71ZISV4E4SloIuTrVNMv16G/dbRJTz
	b+vckX3BWnMYJGeh4JibQjZfRWd9VjrY+sMZFOAqBowpXsiwBD/8VOb3PnYA6OxdBUI9wuT+z8i
	vfxrR0KPAWH3yugoLP+iw2tfThqszq8z4ZuqKHbCQCY9CHJp4egf6ffD4HX/To+KKbdRvSvySe7
	LU7Amd3PlbWD8w1QhOR4lbD/4/hdDIjdNHybDxQFWfT0aEd1y6LyUk2TCf+tSbJkQYYaY55biGh
	Q/kn4Ug/PPzIVYhmFuxUBIDVUqc5UAhiOfoNAA8nnc9Z81e8j7dVMkAi4NMOCbxfxNg4GWKg+bL
	j1kqzzH2MHlp0nVauURxyHcmy85UE=
X-Received: by 2002:a05:6102:4422:b0:7cc:9d47:9c9 with SMTP id
 ada2fe7eead31-7d03a6567eemr2189058137.35.1793268173661; Thu, 29 Oct 2026
 03:02:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 19:02:51 +0900
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Oct 2026 19:02:51 +0900
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <auL-r__SD8m3it5h@pks.im>
References: <20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com>
 <20261028-799-shallow-fetch-with-tags-v5-1-7c43cc9ae810@gmail.com>
 <auHfmzP3aXyonp3C@pks.im> <CAOLa=ZTCwvUJNj6c1G8dU778ejwO5WvVL9F5C-Db=P4Au5=mQA@mail.gmail.com>
 <auL-r__SD8m3it5h@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 29 Oct 2026 19:02:51 +0900
X-Gm-Features: AclHuK9GwA_82llS3UD6td3nAiw-NhhsmS_0xQf97K7MYvX89f0LYJefXe8TnTU
Message-ID: <CAOLa=ZRr2X58KqC75uqqrb73ALuP=KRPkNMuEM-oAqPkfe4X1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] transport: add `transport_options_release()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>, 
	=?UTF-8?Q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000007a8888065ef7c8ec"

--0000000000007a8888065ef7c8ec
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Oct 28, 2026 at 04:18:11PM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Wed, Oct 28, 2026 at 10:47:59AM +0100, Karthik Nayak wrote:
>> >> The `git_transport_options` structure is used both in 'transport.c' and
>> >> 'transport-helper.c'. But while the former specifically clears any
>> >> associated data in the structure during the cleanup of the transport,
>> >> the latter misses this.
>> >>
>> >> This means when using remote-helpers, data allocated for the structure
>> >> leaks. Introduce a new `transport_options_release()`, which acts as a
>> >
>> > Nit: "a new transport_options_release" reads a bit weird. I'd either add
>> > "function", or drop "a new".
>> >
>>
>> Fair enough, I'll drop the 'a new'.
>>
>> >> common path to release memory allocated with the structure and use it in
>> >> both files.
>> >
>> > Why didn't our CI detect this leak? Don't we have tests exercising this?
>> >
>> > The patch itself looks obviously good to me, thanks.
>> >
>> > Patrick
>>
>> We don't have any tests which exercise this it seems. The tests in the
>> next patch do, which is why it hit the bug!
>
> That would have been great to point out in the commit message :) Thanks
> for clarifying!
>
> Patrick

Let me push a new version with all these fixes. Thanks for the review

--0000000000007a8888065ef7c8ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b2bd3c47e618462a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yakdja1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMExuQy85UHJuQXhVeE9aTUZSL1VscUlBRG5NTDR6UQovUWJHQm8zUUNE
Qy9RTGJZTC9jNXJVRnMzUGxoc1VRUlNhdUJqeTNpaUVKbkRQRkxndHVaV1pwUmNUNDRUZ1dOCklG
UHRsNEFtQy9ZQmk2b2xseUc3R05UdjFpaC9rZkQ1b1RVYWU3dVVUTnl1YjlhdmRLMkNtWnlhTTJp
dkNnQnMKa1FJSkxYZlBCdm1jdHBjUnovMk1vdVJZbGxsSUpqNWoxcDFBSEVIUEZXTGgwRHNaOFUz
am5KcEp4aVNJTGgzSApPdURCeVRSSzAxRGZBRTVFKzR4RlpZZ0FiMTdGazVzMVg1MTVNdTZNYmVh
cEVZWHJxRE9FYWY5WVVyY0ZMTzVICmJEN2VCbEZaVVROSmhzVUlHYndmOHNIV3c3ZFhzR0dhNUJO
djlZWXRDRFkxaDZEdHBObjBsZjRMZDBDc0VOTGQKSGl6NFFrYmpMZWIzUDk5NW5pa1pkdkdRMDhS
QkU2N3hVZm5Yby9wOEpuTEVrcHEyU1NLdXBBWEMyQzdRN0dhQQo5OXpGZmJuZCt2ejFVTk1zQXNx
QjZZcFpzdzZTK3dMUkNJU1RjbEJ5T1pnd2JDZG1HYmpyVlJ3KzNEdkhHQkpYCkpwRWNQbi9UT0tI
V2c4ejFzeGpEK1V1VG4xV0tmVGJMbW9LaEpMMD0KPTRpSlkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007a8888065ef7c8ec--
