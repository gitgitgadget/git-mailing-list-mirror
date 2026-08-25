Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04014381E88
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787642383; cv=pass; b=iZ2TaT3Kor3HL9PNFyix2Rg6KS3U+MEQzWjQMOvcXuqiuoHzW3yOTYFI9BcAlgiJPepGFVc6VKZ3U6iLWloI7RhvpzQjpJfYV2l5YzYa/PzjlZ6oYKUf6lRlUY0i6CPMsvqwT0W3ppUc3cDjNO10N+Xc4aG7QVXX/+LFzOCPtO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787642383; c=relaxed/simple;
	bh=J0zGK6jPdlde4ILh1elEpMTv+gOIpcVIlTyHqjw30Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIUsTjjLCKGeK9WrIDa/omF0IqyR87tQOiH0xQyt67ur0wF5NFjKxpDkchtGPIDBZotb6Fg1hJBLs3KGzZdhAxWxRarul3BxPQugFfL+00QLhk+/E3hLsT58bNLXaFVHvjegsDWBoiMkBWaVfEQcUkUQpgsUQlTZ+7yFarNd+i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABEP+7Du; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABEP+7Du"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-495c49f8eccso3792238b6e.3
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 00:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787642381; cv=none;
        d=google.com; s=arc-20260327;
        b=UNpVDsjbGH0Y8aJj8mt9jpR7Jt4sqiyavbrxmE/E81lGwmtOl9ikYq4dzmeTm81Rsc
         FXeyOC9fL3aLtR9DmUVSTcCeCY0FDG6ALZQcDnesc8Fm6+gstzxCG7AqIe329/JXHBfn
         S2wFnFv8sKRzSE+4/DV4Ce8v/jqd/iqo6jj+Qy6T51xNB9OVeNgZxTeqf9hr8wX6HYUq
         o26XZxAX0OOdmEJO9aFJSJ35SsgUmTYntsw9B6kWVMNT1J9DboUYI+w5jDOAI8SR7tN2
         AX2qSsCR8kVhyjvf1toB3W681ReQkVjPYrZIYMkbfb/Te+jZf4mQR//FwQa2E/IPjtTf
         phag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9Q8E2w1PHnVWEEing4Z/zbabzRnRW5NEo5CkckHBFBo=;
        fh=pLHtt8ITKbD1WJo/+LvpesKZGEhN/R2QQZc+Jh7gImg=;
        b=fJoAm4pwdCdZb+f/5e4gSPZC4flUSgJISzPwNrNt5vvrZNhoi26lA2gU+3iOjy6VAM
         reGKRj0NC9V7rgFl30H9w7royqmlngqdTeUv4Pvc3Hi8iwzM11g2DygYui+XcJts0dzt
         oBAOfd+n7qhWGaus8qWdWYfGXfJ36LKaEas+9KRMM9ptaKtssZAE/RSrFyZlKse6XEG4
         9gyaYoFalH4bbEwwCYPylfBNZYKCCF/ISfKo2yOaKEi+mp4k8lHT6p4pQnA3aebsXNgt
         x70QrEhiQCGM1Lpy5RnXt3dFDe8M2WLrHIXhrzi+uuL0ttpq9h2CddhwON7cP329Fwv1
         QmHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787642381; x=1788247181; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Q8E2w1PHnVWEEing4Z/zbabzRnRW5NEo5CkckHBFBo=;
        b=ABEP+7DubQCvGXkwV29zs7m9tS/tZuNWfO6SOQ97TDKoodSabuJ1L5Wq+7RpfCxctZ
         mDq5LMnsSRoc0qlvrrjmfw6WsDZEwGj3s+xUoXsM1tcguuHBepfpr6WwSx53NATvcvDX
         ys2t6QHei9Pg6FJaADmBu2/i4CmQZ66DFUr5DU1wviP0nTEfYrvO2RNQ4EyFo02wX9Oq
         g/LmYRAsWHL2CHiXfJQMnxnN8WpbSAodwuPDAzqTBA+EyjWxLs9xg3xM35j+7C0mXso+
         dO8NE9wbLAuHkggcwZPAa2EK6RtekkWaFutG4WfbtDLxaCBuMtrIyImKs5v8GiYRGSL1
         Xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787642381; x=1788247181;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Q8E2w1PHnVWEEing4Z/zbabzRnRW5NEo5CkckHBFBo=;
        b=sOI7kJmqZ2oii621J4y1WnxKy0U/u25TokWxbZmnMpfP90+ZeFWmKORuHQ6z4cq3p6
         BGbW+yjffzTnPKhAJx1drW6+uxqgd2qdwvZhlI3PtZmsBgxQPWMwuWSbsZoF2d0OO3Xz
         xauqTHfo025fVFVB4/OkLVgB71XZhOfK/vxnZbvOqZ2RLBBM+Ez4ZXMy466d/tq267Vm
         e8eMqgkrVKCV9pAlNo7V62jLPuiHABpSucfiVPInKntPeB8KN1EVXdJFHKiSPsQ7HPUc
         FxBWY0V4gXOqkHQ3GPxbkySuMwfCJ+FkLD1O03W0qnKwOAsgkAVipLO2fEerW5TCV/kj
         tvjg==
X-Forwarded-Encrypted: i=1; AHgh+RpfafCCtoGwfeIvY6kohKYLTZ3Tz8fn/vQzxWlB3q35Zb5k+Htc/ztDODG3qExsRatEB5A=@vger.kernel.org
X-Gm-Message-State: AFuF++ln88XWA8qVkKGxC27+bmmEh2vSAObBpkIPSvSXsZknqavpX2b1
	PH8Mqa+SoSqJMJ15VyrCJKxSTxd5hN+aeM077wEsk8Svb9tu0QmSNyAijYbHdhecPbQnhY3OeVz
	hs2pXHTv42CTqGPx21hBhTMdS5MNQW+g=
X-Gm-Gg: AR+sD10Lrw4Ncs1kmj20YsTLGrYBeoM9Kv998XLwdp4IQr4vB6Q68DmXYMjVU5f6LnC
	3ni+E9v5GzMWFYd7tNUE87gqBzRVAHl5usOgUHK82Q42qXLqt0AsT+MdpLiXrDc3OGqUAL+qxsy
	qv7h1xelIZGakdi26YBwpRELsA4eHWTTHBp4qXuEjP2UPOPoUgsWTfamgyDrzGSx9Y8UPBodjyX
	1YcgJ6WNgxcVI8+dtavY2BUtgxzs/sa6E18gDqgtJ2YKFmEmN0eU/evHCX7WeC6oS0R8lP0pK/k
	EMkdyx9hgIZxVZf99XO2B+vrPMCAQmgez/ang4jRvCUNXLzkhtoume8rJuPbny4hVdG/YCzE9BF
	lry08mBVu3RE1ERVuY8VFlxbcQWwW6FpS2WU8g18DIPEyd7IgHkPbLZfOZtdC
X-Received: by 2002:a05:6808:11c4:b0:496:11f1:f2b3 with SMTP id
 5614622812f47-4b3507778afmr4057200b6e.20.1787642380787; Tue, 25 Aug 2026
 00:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2207.git.1787092446.gitgitgadget@gmail.com>
 <5792c08f4ee0f9627ab1432d91299fe676e0a2f5.1787092446.git.gitgitgadget@gmail.com>
 <20260824045529.GB142844@coredump.intra.peff.net>
In-Reply-To: <20260824045529.GB142844@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Aug 2026 00:19:29 -0700
X-Gm-Features: AcwNN1WuRGlVbH3ruBasTJdFvfTLzQTZHA2vzW52Mn0VmN7WfRi37tV8RJuD3xw
Message-ID: <CABPp-BHxEJ31fxt-hD6XrVfUwPuw+f3zMmhfX86hyCSakj-YbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] packfile: recover when a multi-pack-index names a
 removed pack
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 9:55=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 18, 2026 at 10:34:06PM +0000, Elijah Newren via GitGitGadget =
wrote:
>
> > Teach find_pack_entry() to recover.  After the normal multi-pack-index
> > lookup and the regular pack fallback both miss, check whether the objec=
t
> > is nonetheless present in a covered multi-pack-index (bsearch_midx()).
> > If it is, its recorded owner must have become unavailable, so scan that
> > index's packs directly for a surviving copy.  The bsearch gate keeps
> > genuine misses (i.e. objects absent from the index) on the fast path, a=
nd
> > because the recovery lives in find_pack_entry() itself it also fixes th=
e
> > OBJECT_INFO_QUICK callers that never reprepare.
>
> You don't even have to pay the bsearch() again. We'd already have looked
> in the midx earlier in the function. We just need to distinguish three
> cases:
>
>   1. it was not in the midx (or there is no midx)
>
>   2. it was in the midx but we could not load it (pack invalid, or
>      object in the bad_objects list)
>
>   3. it was in the midx and is available
>
> In fill_midx_entry() we return a boolean that lumps cases 1+2 together,
> versus case 3. It could return a tri-state that would let us distinguish
> all three. And then your fallback would kick in only for case 2 (case 3
> already returned with success, and case 1 means the midx does not even
> mention the object).

You know, I considered putting the logic in fill_midx_entry() as well
as putting where it is.  You'd think based on that, that I'd have
thought about just changing fill_midx_entry()'s return type to get the
best of both worlds.  You'd be wrong though.  ;-)

This sounds much nicer; I adopted it and made fill_midx_entry() return
MIDX_FILL_MISS / MIDX_FILL_HIT / MIDX_FILL_OWNER_UNAVAILABLE in v2.
