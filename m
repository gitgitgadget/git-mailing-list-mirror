Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794819778;
	b=r8/BDIV5HpclTyP9xiq9M25aECTyAjdS+UYBEgz/LQKlDGXOOKxPUvSXEpGffvOurH2z
	 LDp3KR9Ay/66oaaxGq8DQGiCe/aUQSdy2fQgssRvgJnt6TQr82esxILjiskdhbH0+1V2V
	 9vaGiZFjvDZ+EF9qNS6/tMfxLxpHEiBCqgatQPqr98bKSdWAPCDDkLKwcWI507R1I7+gQ
	 Eufo85Q12u00gBbAKN3e1mxMmFqtnrZ4UMnXYoP4bMOJ3/J8lZrDUF8sBqLIAubFpwMu6
	 87h2IP2LrXmZdHcNtVr6SEWZE6/AuKg6sPRcNkeljzUebZga0Hyux0tptz2l0K2fSEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794819778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=vli41wW3hR2giEstFxhFokZEhLS255AR+vJGKjhQVBs=;
	b=Ni5prxc3cZ7u4eKNmCGXI0EXphvpklRASC2t0JBHTl2WjktdS7RSlIPR6MEljAfDhux1
	 PP28q1VHAJ6GnCWJrb3bFcFtacwFTmFg+84nv4Mc2Ofbr/VLtEEZ+raJCegj/MOl/hHW7
	 msMf9cvL8Kc+PI29W8nrVIkJ1guFhv6SAIVjx7x/llQVUFXjVnEFE/ibjG4urPsjauJr4
	 jrjsnJctD0GHUbBIVY8Z1FdoZXx34BRuSbkcNZOoJ7Q7kEvpbs07DqH/1s/yqCPMsv7og
	 jkO5r6UR7iIgRV6x6zFJW6xUQPLVL3JpmwzVRnhzKkhS4mhavZJiD8jb6hAE8AQA9Cg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=jS+fvwAS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ABA606A32A
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 09:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4ABA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=jS+fvwAS
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0dba37a7fso28009427b3.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:02:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794819777; cv=none;
        d=google.com; s=arc-20260327;
        b=mAjfZWTUkWMOK2XM1MD8BJUX958c6+VLxL7DpNt+9UjjvanVK8RBfVfI1XqKgEhM5j
         niVHB35sInmaIwuRdvfNKY5nlsP5xXu1ZG1TzoZjeSWXH6yh5kx9gmcj4jQ/hxSRjS3s
         ZkUJHFK7NkIfJmIPjS6t0CrstOOF681tD5NNRBLqYLCQpKNf7VJlWsaU0Ph8UjQ7KGRH
         pF5TiVUKy1OoCF36upTkyP3/CmDWJs1SCQZIAgALLo8i4+BNj7fShocogc04IYqTp2mi
         pHvtfHimpxKZK7zxvDxd2RPhC8MYpI+R7psV+hPGI//cQTbDrJQpwQ4Hc2nmPFI14MKg
         vdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vli41wW3hR2giEstFxhFokZEhLS255AR+vJGKjhQVBs=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=GAayrEXWyQNJpE8qui3ARDqeRu2tpfXhNrW5Q1CUitXGfJ3QTp7wMjjUNv2n6ufL7b
         HBaj0wyG0pANOyFVuF2UX0M3QT/l0m/TI57O36MlQL4uEPrebc6tqDfJ8rBxjXTjpOYW
         1gy64TDU9mKa6CHP5aDzACnhP41tJeueDagb9JAI4PzElscvqigDCSB9jz1xig0+tKwh
         i9c6/aOd3geIfwUMi7tPToEzR/RO09l0EVxsaH8YHJId9c25rD777iceUZrGnqSzjnzS
         V/nde5jvfOE610wwE3CZ8y7uKPvsS2ksPm6Ji9qdbJrDK9DJN3F4aa++8tjZXXeHD2am
         X9nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794819777; x=1795424577; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vli41wW3hR2giEstFxhFokZEhLS255AR+vJGKjhQVBs=;
        b=jS+fvwASd2Bzjagbdd5hk7fWWwRbT9YYkIL7KrBquYYe/nvZTRHwmPPnLgRCQTid5S
         zdEBRcuX6X7N4whEzD0lsC9PvZhxDn45vjpm3SUqJTzzUw1aTDzmSDnYO9aMO/AviCxL
         8ItcBLuQqeqvI1uF0MGyBBuORvybHHv7dMp/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794819777; x=1795424577;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vli41wW3hR2giEstFxhFokZEhLS255AR+vJGKjhQVBs=;
        b=k8uX1OktnyMizK04uQEdsxFLt3XgTg1OnoHSk49jBqEj+owUPI8IahBAJM0D3Bx4az
         rdBUZtOeMajhx58SvEXV1mmSt93MvheZbp2oFgsKU8YD5lU+7TCY98jfxL8gnnH3AZm4
         BPMCDWGQgS+MtwvJsgVfkX8wG/v2KWnolnjv5uWp7pxdyE9/iYa5nVEi0rhVNwMZBln+
         oZASGdCR+80eVrehdTR3somzC0HN1Rf26v+KpotfxKvxeHjLjin7tTGylYyBaFrP5ahh
         RXji1yGzuF2Rdu76ApGMZso6t9nbDRocEmsot4XdhNOSOBQWOGGhfBXcifNnI26XJuhQ
         VjJg==
X-Gm-Message-State: APuU4Z8sUp+rfJt0slyeZf9iTsMaHDpc0nOD+woXUDfRF26dFOIxsfX6
	QXD99BGWZijOI8H0ybWbb9z9enLBcP0cul7G+1QRPsnWxVlSkfkq7SfMn0k7+pKw7hZR27QwQSb
	nHHV/lZ9DjPfPS+GGlL6hSleAEibd8kI4n+GJo2GUC4RZFTu4uLBzuOscbg==
X-Gm-Gg: AZFdTZfrybLVqSxiTBdceCWWgKXIKvcTWuwDvb8C5Nx3l0AasN5sf2Oe013l+gfZ67w
	Ei7dKvB7csRiaoLlE/xNDOCrfaYJe8u7Zbtib9q93z7irrjxdbg2o2vPk/JGYYY3O4dxD7jAfmM
	pMu87lxRTlcBqUFG/aZS0J3ZgLatohvbFiL+eTrInLbOg8Veuaeo2/NoUcM8YGS1bXRQlnJdLWB
	5Nf0YHRaSCGFTmn8ArKEv30Qt6Yu2Kdbf2+xAQWZnXdQJj/EfgJ5n9gkMvNBF/RN30qJkQEV05y
	QlBdbSS7XrY/FQCTseuGZXTWneZBk8l2PAQXkg0mZCSQXEv7L3zIwvjaY+nlrjyCKGF/kTEnT7y
	RapaslYGaVCey5ZuzafaxrsuT+4LmP3HwHU31NA==
X-Received: by 2002:a05:690e:1443:b0:67d:927b:5cb5 with SMTP id
 956f58d0204a3-67d927b61bamr3730599d50.62.1794819776664; Mon, 16 Nov 2026
 01:02:56 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
 <20261113-pks-repo-count-objects-speedup-v1-1-7ba4f29e74fb@pks.im>
 <CAL71e4NfnYLAXQT-wpb6ciJZwTrT51EZVsEs8VertN=xBmUD_g@mail.gmail.com> <avqk_DfxW1uKFXi7@pks.im>
In-Reply-To: <avqk_DfxW1uKFXi7@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 16 Nov 2026 10:02:44 +0100
X-Gm-Features: AclHuK9ifawxPDzdL88dL_j4Djr3rx_K1jPAnxv0GPCRcKOybxNwKUOhdZiZq08
Message-ID: <CAL71e4MKmEsP9xsZ7eg_LOFSCiwOjVU9H=rvOYkOFXV=3rMPxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/repo: only parse objects as needed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 07:38, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Fri, Nov 13, 2026 at 03:12:19PM +0100, Kristofer Karlsson wrote:
> > On Fri, 13 Nov 2026 at 13:50, Patrick Steinhardt <ps@pks.im> wrote:
>
> > Tiny nit: I understood the comment as saying that the code
> > depends on the commits being parsed already, but
> > repo_parse_commit() handles the case where they are not.
> > Since path-walk hands us commits from get_revision(), I
> > assume that is only a failsafe?  So this is just about the
> > phrasing.  How about:
>
> Yeah, it is. I was wondering whether I want to call `BUG()` here in the
> case where the commit cannot be parsed, as that case really shouldn't
> ever happen. But that felt a bit heavy-handed to me.

I think it would be a valid option, as long as their is enough
test coverage.  If there's ever a regression here that makes
this function be called for commits that have not been loaded,
the current implementation would mean surviving it, but at
the cost of extra unintentional work, whereas a BUG() assert
would make the regression more obvious.

It's not something I have a strong opinion on though, and I
think the updated comment will make future developers see
what the intention is.

Thanks,
Kristofer
