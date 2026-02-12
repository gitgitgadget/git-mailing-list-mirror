Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92442E0902
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770890860; cv=pass; b=RmS0zvNJkQrohw6liv7qNh+sjovSVZq3BtHDDMrD1MPLjAsmSOeJUpIO7bRbbBnGB69HQebsx2hFl0JXSuf1ryA8hBlEr+3bsBMYFxnHR7cfBjQx8jRiDa1FED4qe7R2RBiKkOvDLcr6Bs6oUa3atKETpKVE2bHhs7dQwEZj3a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770890860; c=relaxed/simple;
	bh=+VOSxYxAqZ3Pn+luXJvmQrHR2N456atTMYpphdSFeeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6xl9a9/XOnCT5QaJnVz8yGoAWQb1gJYvq3JveB1Kzz4YVNLPsNo3kHsCFAGrDradY7nOCtkJVLa5h6YSx34GXT+w/khvg9MlnZbgmWFc7/4hAUV1eTUJk63EUP8Z+5TLJ4xKW/4INMu8gzXJEAThNEHWN03wx2mRWrBnQ0GYiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYL5NoJL; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYL5NoJL"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba94dbf739so2881566eec.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 02:07:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770890857; cv=none;
        d=google.com; s=arc-20240605;
        b=Re67sinT4AFXEFdkw9Yc8A5XPPN378/xsqosuTFvdm1i0pufaaT6CJxf5XtuWhrE/V
         ortAAALNW7wlfnywVlkRDvdKqgTH1Zoc6czynjc/P4madMu/LAO1Tt7ctJhmyqSLMtyn
         uR0kKUKizgdDm/suaZ18qS4XZXCqLzSXnkFLXQCfslxwK5ASSbekJSG/GSSztkgv2sQ5
         vEtbp0ldG3vEjmAT/2waGoA0G8Sw/vLG6osJVBY1JZCVA65nQHn0GrrnhgufuYUZ1hFe
         bJfOuEaW3M7sOs2VSDHbgCBzF9xTTs7xlV+jn4NLfL5k+htXhtP4X4hJBkhEAPcI93tr
         uPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+VOSxYxAqZ3Pn+luXJvmQrHR2N456atTMYpphdSFeeE=;
        fh=/ocVQFHdlIpAVHaJWQ1HqzRdzS2NmWcJNYQbItpXA7I=;
        b=auw58z4rNJ14RWe5WzxVq8cHusT+yM/+gPQQ4hrHdLXQT3TJH1r5f7Vs3aHGXGnxC6
         GxgGHnjxWJXp9jpkfkW1J+m8dy3nd0ktxtyN9+H4MS1tlxaeg2/LjwdlboRYAGJVnRss
         Rtv/JT+1/CEYmmQ11MUHLcTAXisbq1dkeFebMQPmXtoZrgLMvBN/TAxxF2xGCcrqfxAu
         wG/YziGZwXP7ilRTxauxe62EtsKfMOljuU4PzVfdhCCRbQvdyEJnMRMg0/B5P201XFj7
         DSJTtTiP8GPk9af10/7wiOOrvnuQH63JNQ55x1W7hzH86/FBKiUKiAdjAY+yivntKKIU
         UhEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770890857; x=1771495657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VOSxYxAqZ3Pn+luXJvmQrHR2N456atTMYpphdSFeeE=;
        b=jYL5NoJLGfxi63w6XDaabrehMPDlcrD8FhhYyG5XDO9wuqRuU2cLuMc/5A9GVPSIAx
         nvm2vYItYeqXWj3+TTGCa0IVFyvvquRfAa7od7iMWF/gjTJ3XCv9FtNvnEFP1iEDyvgP
         8SB5NYlAJd8FpRfhDjYLHH/wYGC0jZDq/wO8dvkVG6EjsAy5GhL+nKQWA15fyGOqa5HD
         psKAtD4EEqUqgKHS9mjh1zWousQmfTgpx75xBxwWxJAZwXPrxbWSqHX2dvaZ04jYVRis
         EOkjfPpG2r4IRlJNfil/HYt2QAnCesUGQc7NP7VzCLqMn+pSYBt/QllxpDFp87ntZ/Bj
         7NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770890857; x=1771495657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+VOSxYxAqZ3Pn+luXJvmQrHR2N456atTMYpphdSFeeE=;
        b=M9vJ7WSd+h1mwzWUjTognaHk/f1z4rMTdhcdy61LWBRsyJKowwsREnTNdFI0tccvnt
         zcmrgleNEPA9IvAHAz2R/nxaop36OlKNuRnFWxZaaHzewTR7xsm4FaTW14C9FhDkhVaj
         xc1M1QmQl1RQVxVa6cl6rzc/2pe+yT0dVCNTvwnV35XjkUhw95f9Oatr2mhWmHzRarPw
         3AJUsQhvqYvQ6gaDsyBYCUB7iTHMK/vbf4GXA9Cj3l+Mx3S8BHyfMgXacg1Q1fehFgir
         0jOlrj40m/KbHtHgTs5JBZzX3aYXgesGw0GHp4r2hsC2WhGnSoGAIw64u6TItjp6WfCM
         hCOA==
X-Forwarded-Encrypted: i=1; AJvYcCWTw3VlmKVSToK1eZ0YMvlbKG467CZacb3MbkhrwmmRAoXyiDWcHfKPUtdg5L7whgOVKfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jJZeFOqgBCDndzqfqIZciFiq9A78VyXMUMUWWx8Li4egx2w3
	RNOn6pLJT+NMZT77qMQm8RH8+xLgzr9pITsIU3+E+PbBxaVEsI5puKKHQ0CFZcQgkYL7srYs4vu
	e0adJI0WBudkNeNqvJtVELQtMl0vig2w=
X-Gm-Gg: AZuq6aKawEhlpU5Fywoub3YCgq98UuN2zOccQf/x0nFgAWvbe7b9GhfSFDDQ/+jREwN
	4xBHucNFfwuLhUuZdHWfq2cFUqY0qrKRs6wesg1masI7zqnyNw+jE12OrdwjJDQY7LDhih801oV
	XCc8nf58JUPPapec/oivNm6zHU0ixZuKDxK9OqyHMoEAlTH3OHU13kQG7A7RCEkKQwXbR972EIP
	SvKU05orgKAY+YifuxJgTK1Dkw4qZtvy5u7vfx9z3wB8W8+5vI4y14eNm7p7JKah6ldCBzEyvOF
	8kdupeVRtY/BPNrtc+fAbAxNLwCMj/pku2D7qd2SG3E4y/So4lB/rfDv9uBTXPcIryl6xECGFeg
	6V/4=
X-Received: by 2002:a05:7022:212:b0:122:8d:3688 with SMTP id
 a92af1059eb24-12730533b6bmr636451c88.22.1770890856930; Thu, 12 Feb 2026
 02:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20251223111113.47473-9-christian.couder@gmail.com> <aV4v9WhL95Gcqr2t@pks.im>
 <CAP8UFD1za=FowTWBqjanyRFANKBsc-+LOcbSsuBzjeiK8T_fkw@mail.gmail.com>
 <aYxslPnqyKP-mgcM@pks.im> <xmqqwm0jush3.fsf@gitster.g>
In-Reply-To: <xmqqwm0jush3.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 12 Feb 2026 11:07:25 +0100
X-Gm-Features: AZwV_QgEywDwR_qKpUbgWuux_FAytoYpkFRUzCKnlbXdl0-FWDGMQ9XN4BT7dqQ
Message-ID: <CAP8UFD3XO65TpLyk1B8nCFKqR4b6=zeEAFnq_Cbi8Cwo+1CntQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] promisor-remote: keep advertised filter in memory
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 5:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Another alternative would be `accepted_filters` to stress the fact that
> > it's not the complete list of filters. I'd be happy with either though.
>
> So advertised is a superset, from which we chose some and becomes accepte=
d?
> Sounds very logical to me.

Fine, `accepted_filters` it is now.
