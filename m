Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF893F8EB9
	for <git@vger.kernel.org>; Fri, 26 Jun 2026 14:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782484806; cv=pass; b=gL5JCiSjaSINfEZArLaAkl30zJWxC6I7ERDu9RvNAvlKLin/eoF/07mgfz87g9i3TEJW+HchGXyZxDQYiB9QHjZUHFMmY6n0B7y08E/Tcf0oEvarNQdUWcna8yZWNkjr9i72szbHSkDPM6n+mutNLDJgpiPu+zWFksmfkQl+7qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782484806; c=relaxed/simple;
	bh=GT5vLFkHRgZpe6htWkt7QoLfWXriy25X+uT2geL+3cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=leSbxbpda5n55JeX7qnkWMqkpETvCTLgNf/sPfCjKTsruK6mRh5i265kOG5L6zIM1iNtbddVwqOEEPri837VrFJOdOWmMRmVd+ZsR1lPzvfaNXXrKg4ETkwgkVSlRCkdAHxtIS8z2bx+9rFbC9Vw4FxnnfPFawciZdMO1CquVCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Giaz9lfX; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Giaz9lfX"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-663c66669ddso1207017d50.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2026 07:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782484803; cv=none;
        d=google.com; s=arc-20260327;
        b=s4HHodYLgZfKYVVsJLkjPUE/zuGtg7OI2LqFrK2z/Cq/TMgAfoeEcRom3YEjjc9wbo
         VPbnomb8j/Gnioo/LC94XnxGeZ9ThejYhZ/g7PPtiuTHqvc4z1zXfPOTPMf56zquXOfM
         k7SLSyBi2xSlM662YSgZoTdY0S4jdycKWtgJoMvs8ZOFhZ+ecKLFthFtvgIeI+APoEYv
         yHEV4poNvL0Ia3XaWmdQBN6p2govz4AZOCdqTEe2VD0cwYBKWkvGf0l+JaosjSShrgib
         VdOHRZIuSza1ACYgUF5q+YubM0KREC7mtCkaC9R+W1tMYjBX22jf5e8PKhEWt8f1kjKS
         O5+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IaqwG1un3oA+LTiNz9A7G55psFITnX3EIypgBNoMwB0=;
        fh=2AfLKhU48RUpBVtyokDZ+Nt8KkC+R3g1zS2ZrGKtVmU=;
        b=Llb34aJE53fOz0fJ6Sh3MXHMX8GvyE4mlBXmyw2699JmU3/z484OeU1y7syqjLngF3
         lMGD8wHgRYijTcICz9wYcS0CWsM2LZlIYU6qfwk8PaLWSv9mduS1zImNkt1rewlXCCOG
         CTqi7NCNnzhBZxrUaEbUXU4Byvv4X1h5xIOFXVRhb3YsTOCpc1wF8kjzvOk0W7IFBNQv
         tjHgZieTAPuaSxxkYp9RLGYtEPVvcUxckYxlTZVMR2wfTsCE5W9AZRWG4ZGMWuvUn4a8
         ydkWR7nJegC2rGYKGdTxEWNDS/yXzu4PthPBL2/SodrCMwrdXPV7nkRSfgfSuI+/qZbO
         SeDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782484803; x=1783089603; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IaqwG1un3oA+LTiNz9A7G55psFITnX3EIypgBNoMwB0=;
        b=Giaz9lfXBmeonb5HTEZRXeqY+lcO2y8UIZVcKz3vfeWspOrwd3es6DfkJrETHfFKWW
         jCC92g7qGe+fDp5yEHi8xxMN/lc/ideTEfJSnX3SaE7/k5sRFMaEUw5G8Byjz8Kgf1Lx
         Scsm2C+W6lNDNRCPzdBJxTYn/78uS0y5XK1U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782484803; x=1783089603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaqwG1un3oA+LTiNz9A7G55psFITnX3EIypgBNoMwB0=;
        b=coUg3admPkyTpswfJL9Zdol85TZp5A9Wpyo7VlZuAx+fdxEKYS0dl1xXucj2bmsmOp
         enzjtcuSBCtjyM2x6ZX6BeACF0dQmQR05it13TNAxLj7SF1wSRObOMjHoccsj+mAUq1v
         D5oUwoR6ASYd2+vEy61XRTSPIyOGbzPTYjPiIUIZQpryYIk53kogKwXd+u83OURm+OKq
         VwcBQWyXXPLgfPpMdC0qCC6i9WpgsVG1H9LsVw/wskUZ/702otkXUgYUkH3I5yVRTirL
         2CBk6U8XRr6vSUINi4g1/Bat32AaTgm1nNhUPU4OFpIb7SkynHvHFwYc6mmMSuj8k2xT
         VQcw==
X-Forwarded-Encrypted: i=1; AHgh+RpVJeVFiwpQGiGkialuKJTgZYj8xmQmPNQOAYOHrCd6WV6S1KQyYo7PAYjyrMBZpsOTwIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/rd6Mk2GaCxGyqsNFhvUvXu9BpYJCQM4zRUDfQZOxMt7Bptx
	C+1e9/BIVXUSxDjdr1pJLRnn0FGbw+KIdQRo6g+JPJCceq34hw8uxjO27BWxIHgz5p3uiRldcuF
	1zuz//OUZ7vNm4eZPKMjOUpoflMEp3ddoJ5xay8yC8g==
X-Gm-Gg: AfdE7cmtpwDVxBd2j4KgQPUp5X/SNN/BAP3asC5XkwuCNcEGgXt3p+jcShbIJbojp2U
	JbSvzVDs6W/M1y3HvuoPfltSs0N/hVNsb+Oci67sekEyg0zeCnVK31c1DjaeuLeB506gjdbAMoC
	14k1LPGRIanL1N//pSMIXYHWES8XUwbJubnX064T6iNSRxgVE8j69+tqjg61yNN1F/NrYh7+zQk
	2GXLqYE4lRba67mfLc26ZfDt/oO57UZIvtYT5hnyz2FDoN0X19Kxh4iFkpVR0E4vHdVF0Cf7A==
X-Received: by 2002:a53:b2ed:0:b0:664:ae6a:ef2 with SMTP id
 956f58d0204a3-664ae6a114fmr442817d50.80.1782484803559; Fri, 26 Jun 2026
 07:40:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
 <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com> <f3572a8a89c74fad54a9e53be6f0e34daa2d50c2.1782479286.git.gitgitgadget@gmail.com>
 <5edd5912-80b2-4372-b921-52c20e496276@gmail.com>
In-Reply-To: <5edd5912-80b2-4372-b921-52c20e496276@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 26 Jun 2026 16:39:51 +0200
X-Gm-Features: AVVi8Cfi0KB8lK6a8ZIxIGruj_JWLY1AKWdQei3bPxvsfFBWu0T-X30viTswEWE
Message-ID: <CAL71e4ON=rewXC+xnWHYg-tmWAW6KZ2mp8tKMKyv1Cr3ZePHLQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] commit-reach: terminate merge-base walk when one
 paint side is exhausted
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 16:35, Derrick Stolee <stolee@gmail.com> wrote:
>
> > -             if (min_generation && generation > last_gen)
> > +             if (generation > last_gen)
> >                       BUG("bad generation skip %"PRItime" > %"PRItime" at %s",
> >                           generation, last_gen,
> >                           oid_to_hex(&commit->object.oid));
>
> You mention in your own reply that this is broken. This also looks
> like a stray change for this patch, so perhaps your end state is
> correct despite this patch causing failures. Will inspect soon.

I did not intend it to be a stray change, but rather a natural followup
to the idea that we could fold all of the halt conditions into the same
place. I am happy to either revert that part for v4 (to keep the change
simpler, but not fully unified) or fix it properly - I think it should be easy
since this was just human error, not a sign of a fundamentally tricky
problem.

> > -     test_paint_down_steps 45 2 25 3
> > +     test_paint_down_steps 45 1 25 1
> ...> -  test_paint_down_steps 81 80 81 81
> > +     test_paint_down_steps 81 9 57 10
> These diffs are satisfying.

Agreed! It was nice to introduce the steps counter to the
test suite, showing that the patch reached its intended goal
which is clearer than just having benchmarks in the messages.

Thanks again,
Kristofer
