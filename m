Received: from mail-ed2-f36.google.com (mail-ed2-f36.google.com [74.125.228.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26234E9C08
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612021; cv=pass; b=VR3fH+7v8R+PVPY/tJgYn8BQR3/gkcE+/bKgauJuOU/YCvS7goQf+Rlbsti8akyMPA2KDvblgO+RY9qsV/0FO32pQNBr+4r3ZNaUrbVwjwUFYE7vx3mhtefO7nqawrlXYKf7uA1WPZs/+Yp3S1CbbrLHX0OvGZAt2PCH0Y5CoXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612021; c=relaxed/simple;
	bh=g2n8RpM69o9fhq8trtWptzh++DaOP1Fzd3kzLEpkk2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bardQtugnfTRmMPCSxPpC70uHmpbgRcm9zsHtnlI6KYLJRYea65WBt5daiunMEzKjCvtHtbiYGS6lz5tXKJhhHW+qr8wV2WZm9g7fz37XTDvrr2y+yqto+6p0d6FaKgtVI+Okw6C97NfSQxvnz0F2ajGx/VqYocB/YTlF5+lRI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mmy46gVf; arc=pass smtp.client-ip=74.125.228.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmy46gVf"
Received: by mail-ed2-f36.google.com with SMTP id 4fb4d7f45d1cf-6ac62c88c7cso3002564a12.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790612018; cv=none;
        d=google.com; s=arc-20260327;
        b=OxSVIbbALgJGfFUgt92qsdkDfejio7SBvzHQdx5K8Bb5KSoPHBFbkYRa0YbWyHFkMW
         vcVPdxDvc9RK5sEsQRz+5Oo4VuX5M0muzQMNISJHh931bAEVDyuFRfV2EFCi9JZveWA1
         fjYU+6+87a5GaCai69adSrC01l8laGQ7ZpD9l9loXGfQJMLt+p3y4hyEFoOg45QoL52S
         2qmw0ZM2WJDR4rbcf8hjxKJC0SDFDtxMOdzUlLqHkBypzmsEzg9ncc3Jdh5a05XUfcBK
         C019otfdFr0xCAWTMrcyQMubhuiKGGuThjOfKn48p5tm8q58vgRTzaLJjsINka4IohHA
         sEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=g2n8RpM69o9fhq8trtWptzh++DaOP1Fzd3kzLEpkk2s=;
        fh=JDlQWswoHst9RY/oImP03kV3/rrP+Hqyo0sZFx+597Y=;
        b=Qc2PQ/cRbSotFRuahkWAB4NRv4QJnxPEcou6ZZRsVFzo6EX7Hdm4j6TeqPokA4rYht
         xRB2pr174si6WXInBBEDOI80U2khfzPIrETOB6VgfmGL9PyHO42iFLV3WJQV2P0xvARY
         DPNKWCJyg3d/n8ab8EMLdchw3cA5bLVjngqqreQIqUWdW2ZFQ5jD0lRVqkYYqmaGeCMp
         tCTXisy2lSUU78wviUi09bcdQ5SPwtdxC6fwFm95UZGkAFDQOCUXaRpAsOPAx++qRMVV
         35X6x/fMmgqfVtXXRx0cujnJj7fv10OSbdC212zemjJcJC0Wy9pb/cghS8uHvBbnM88q
         BOzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612018; x=1791216818; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g2n8RpM69o9fhq8trtWptzh++DaOP1Fzd3kzLEpkk2s=;
        b=Mmy46gVfrHYIxUG+3vUOrneSN2+vnXzXf9GvY5Qo8Ox8llyM0iGVQ0Mgadkx1fb07e
         jVWn7RTgOdHy8FCXmPWBWeqW9j5R9f+/CsqEcS/EUfBWrlq6zlNeVBEwPLQd58HWFb2+
         jfc0ELe10/0E227MdXyLI25+aAlXnuM83ufYilthzogfaqOGkPghdiqpzKA7Xpvwltsy
         GvPQoCwT4iKC/v6FEdWezo9nXKHFurUS2+C8F6ND2SuAdIz/SQUyCV5JJ76oUNwRGoVS
         u5cqaQoSMAQLOHyLCfsXDkalmEIHMah9HbSl7oAVMoz+JPuTM9CYiJH+wPdWkUwt2NHs
         P48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612018; x=1791216818;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=g2n8RpM69o9fhq8trtWptzh++DaOP1Fzd3kzLEpkk2s=;
        b=MOeiGwDCpU4Kzf4UfLcf04A2xhZlnxXEgwX2/4VIhVuWtXDgynve6HHu1Ilw7xO7Xd
         +jeTwLnR5veX7QL0Vj4yH/Xgklv+f4SDk1qtPyY7SuiokgnMGG4JZOCnfJnpsN/GAwoQ
         HtHHmKPejJGbFRGrARP6/DozVghX8w42sLjVPbNUOyRYkAxxk4s1mHwKbU9PqzJrMQT2
         sAu2hcV4vbGi9QkvxRhoHqiEYpRwUKHaaKk4wLSal1V4mbRS/Ng4v3LxjZVv+9s/NaSk
         3zNS2vNQtuduSFDm6oSuP/ylS0e92PyXK1D1iG7WUP62fgxqObb0Z1SkDQ5+owoMW8RU
         LmoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzg2tVzVIcfGeB1SmQ76xSaoEyAR6fVxetzNJdsOpvewZ3ubDGwtvS26JCDDNNbtbHsDiY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXEeGsYTrt68oeztMCvPOhbLViAUmcT1etiO02pVuJ1HW63Ydz
	WDw9xlkOHHmC1zNTsV6mF1xPXcj9HX3rYchhyQlU4lkMfwla/4vWhMnhMHCnrxpE2wAq8aTJbwc
	pkko6Ww0hJYfamMQ1XZXrO1Pp8u8bpE0=
X-Gm-Gg: AYBFou1ZolkjVFZx3EnEmvnR0fyNOxXTNiDITWxSgpDiffQE2Pf4i5hT//cCFjpL89/
	ae1CkpQ/5WuqZGSOJ6Sc0dWJvO+w6iW7x71NBXWT/896VS0Qka5G1FAZxoCcCI26yrneqOy8/WN
	V6xAgnXW1hLqACLHhESFoAdHgzVhHeOCotzivaZ74iajkpaK30rmMM1ptQ1lMpUMIUpoQYYBMDR
	sUWZoQQwJLkeM4eFt+xf1DXtH4SNe6TVGFcooLWBcf6L5CDMTeFYUvnLL58C19/VEalbMeAyJRW
	cN/xyYa2u5yUvoBLfm7Dvi+zUYH9fX0x4AFphPremyilf/isjqC2mBs=
X-Received: by 2002:a05:6402:1d55:b0:6aa:7fb:7678 with SMTP id
 4fb4d7f45d1cf-6aae8a518b4mr7090282a12.6.1790612017552; Mon, 28 Sep 2026
 09:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2403.git.git.1789223882471.gitgitgadget@gmail.com> <arpeDzeXlnZRwj30@pks.im>
In-Reply-To: <arpeDzeXlnZRwj30@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 28 Sep 2026 18:13:00 +0200
X-Gm-Features: AclHuK9gGcbwo-2AEFYHhh0l96Duvb4HkZWFVuOcKTPquiVcE_K5TWMOyeGMHtc
Message-ID: <CAHwyqnXJqABaN1JvfF7R0P9FbK1ptt66kaO98=sJDw-p3x=nXg@mail.gmail.com>
Subject: Re: [PATCH] ci: only warn about perforce/git-lfs/JGit on platforms
 that need them
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I wonder whether it makes sense to have these warnings in the first
> place.
>
> Part of the reason why we have these checks is that we allow the
> installation of these tools to fail, and if so we know to gracefully
> continue anyway. Tests will be skipped, and the pipeline will be green
> in such a case. But is that even a safe thing to do? I strongly doubt
> that we'd start to notice such failures anytime soon, so it very much
> gives us a false sense of confidence.
>
> So I'd suggest that instead of warning, we should make the whole build
> fail outright if we fail to install any of those tools. And once we do,
> these warnings here become quite useless, because we know that the build
> would fail on platforms where we expect the tools to be present. And on
> platforms where we don't, the warning is pointless anyway.

Fine by me!


Harald
