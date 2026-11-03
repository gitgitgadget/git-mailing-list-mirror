Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=157.230.60.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664090;
	b=U31NvLTDTzgloE8nteHNZ8NXRwEi6BqXgOQmErM3MCH6Mid3OFsAJSe1+2F5gyBWFGUa
	 KnBb9/NzyeK4VW3ZBCL4rTcXte9RgNYmvAa5bPQDwiiQxeIl3lFNqTKPKAtcqloLu54wB
	 +orOx7T1i0Bvu9dvlxpt10E87jCHzzpWdZLbSo95yaveoio3HH/OoxdcGG23jjNiVNmLs
	 dzDIxz1a6LnfxWHZBXx+FAX1HxwIRHxvNUsCSc8vdTdVJcZZTi8U1x8EDgMkuHGFzRBty
	 hbOSjRTKOY/2Ms1RxiZEGrurOFW2t0URBcCyZp+mzu7tqXebkLRhh5eCvvEHrRV8Bdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664090;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To;
	bh=vk2X7opUeWps5tyfM4SSexDuDk/4dRxackYeie7TR2s=;
	b=Do/RlCzB4evqMUFkL45TyOfJ45p0hUgyjwdD8VT90TU8eRX5ehAVWzlKDqOehbIzZYtb
	 RKdevLHk9ek52UJQYkaNZMKKpfu54wkFrkbxWu0HqBFQHIAo9c4Xekr6srEU9pshOj1EJ
	 Mv3eTAi9pXQ+7vbjZu63GaHICoX7+JX//8k1SVpsCp4zep0rq5cBlr3PvdXF9RmAkYOod
	 EC7s/ExWcFcufDd8KekXsZnzJXtuVNhyukVXxQdGZLLMej+igVUDX1Gv2YNPNPOgUjB23
	 bsbQKX/B6SADsoqGLSGWenmHegeOUTBlviYhb4D+QR/luvbSSJ/nX9vXbA57xTJurNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lfurio.us;
	spf=pass smtp.mailfrom=lfurio.us;
	dkim=pass header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=HoCeQ0QK;
	arc=none smtp.remote-ip=157.230.60.252
Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C78606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 00:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08C78606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lfurio.us header.i=@lfurio.us header.a=rsa-sha256 header.s=default header.b=HoCeQ0QK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1793664082; bh=+MvQDLPn4czNJKVlKXodqoux4YCUMVPkH0lRWIC5FMs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=HoCeQ0QKiIug2dczyWPE+LHQsDq3wigHD92SROB7aIs1rBEnu1IA8gtK0ZDBxFgj0
	 ZtxC7Vmwx+2n1CbTx/wsOLph+PpLYQeN8qNqByiVMqWcR79TG+QzQvZlDm21OJNDIz
	 e0yzXwCYXQlrE2Mxm5jS8qRopqpcA51sM4lHxTX8=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 9EBF361512;
	Tue,  3 Nov 2026 00:01:22 +0000 (UTC)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 19:01:10 -0500
Message-Id: <DML4UIOWA70L.2102KB7HQNX3O@lfurio.us>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided
 commits
Cc: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>, "Harald
 Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>, "Ben Knoble"
 <ben.knoble@gmail.com>
From: "Matt Hunter" <m@lfurio.us>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <CAHwyqnVtN79Y7SAWb4YFRCqCO6+Jq9-9tZ9Jho4ec8pjVJR00Q@mail.gmail.com> <73E9A266-5224-43CC-ABC4-83FBC6B77F13@gmail.com> <CAHwyqnVbgHOvCbXjWAuV7CkXranyBAocfobH8Jerf_96iWzYkA@mail.gmail.com> <CAHwyqnWPhgT54M2LL7SxSm0qufSaYDD-gGAJVTdOqaKy-CTA-A@mail.gmail.com>
In-Reply-To: <CAHwyqnWPhgT54M2LL7SxSm0qufSaYDD-gGAJVTdOqaKy-CTA-A@mail.gmail.com>

On Mon Nov 2, 2026 at 4:15 PM EST, Harald Nordgren wrote:
>> On Mon, Nov 2, 2026 at 5:47=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com>=
 wrote:
>> >
>> > Anyway, I=E2=80=99d be curious
>> > to learn what motivated Harald, as it might be useful to my
>> > own workflows, in which case I might be able to review more.
>>
>> For me, it's simple:
>>
>> If we take this branch, and I do some other changes, and then rebase
>> against the latest master. Then when I run
>>
>>     git range-diff
>> pr-git-2401/HaraldNordgren/range-diff-matched-only-v3...range-diff-match=
ed-only
>>
>> I will have to scroll through 311 unrelated commits before I can see
>> what I actually changed. I want those gone.
>>
>> ```
>>   -:  ---------- > 282:  b2608c4076 t2104: avoid suppressing git's exit =
code
>>   -:  ---------- > 283:  5e106cb22b pack-write: make index-pack output
>> comment hash agnostic
>>   [...]
>>   -:  ---------- > 311:  ebdc087dc9 The 13th batch
>>   1:  ee195c14fc =3D 312:  f01d7e30ef range-diff: add --matched-only to
>> skip one-sided commits
>> ```
>>
> Well, in this particular case `--left-only` solves it.
>
> So maybe that's enough.

Wouldn't invoking as

    git range-diff origin/master
        pr-git-2401/HaraldNordgren/range-diff-matched-only-v3
        range-diff-matched-only

address this case?
