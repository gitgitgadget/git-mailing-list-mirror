Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A11AA1D5
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786173947; cv=pass; b=bboSBpv3YajSDy9QCnwYJywG0J3TUTyhnNYoyCjRhGZ7elthANFEzwSckQgHQXntRcKkWFlm6c0LBJ1ok+3qtOiFSXtkWEGwbkCFw4pUaaqjPkJaTqotlYoA4lcEVzr/xQtuJHRcM/hFdIH2H55x+iFs/4B5UyL5W5HcScPvdPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786173947; c=relaxed/simple;
	bh=RutLOovQMir3+84HDDkU96AQ3hBzqLVxOKTn4H7x4jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNpgkXoeOKBst4ZPWX5Pz0Fmk8TIprmcA7u9Aqp+JSR1rzlmDuydM6yRBsLJhEITQr+v9tU4mTzwf7XQHjHcukMVOAHhlbSfkmhLVTuQx5BkKmtvceQukynA4VaTNwnufBVgl7a1S4lpQ1JXurEUZ8Vb3PGRUOvCgFASxF6gzMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS+OYWf6; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS+OYWf6"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-48a0ca07c38so190174b6e.2
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 00:25:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786173944; cv=none;
        d=google.com; s=arc-20260327;
        b=D7pN0KEsFMzX3ZsGNDcT4k/jUJfmS5mOg4gaWccCN3F7KQkpwitlZZOChuMqjks/x4
         k6k4CsWMqk/VE5XJM9dmvzndQPcrogbEfzTnDqA+021Ad7KIidgJQH5Bpv8P1laLbiH9
         4oyBxIrH0F6JGs+9KAua51BkoW8oZ/VLSCw2vyd57YIr3SKYUra1bN//totoXuqITFav
         erQzu4YogxKjhCG2W0raupsHnlGSBaa0Az1tT0GM9kAkcEzNsvJAmRsGAUPMaOhbeYQy
         Mv8IMc5zEaYO9Sx6gRnaIew6lhOeH9GJYxmKN4e99n9gMMnfEuLCJYA9GvuC0P542UNa
         WREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KyfYAP7wjzFEN2qG+GU1nNJUpnJmTU73WBG+ynKSYY8=;
        fh=dzZik3sWO5Hm7VdeOg6TogxYFNxNltXRHvX8714ZSR8=;
        b=Ho9N4AT4zL31mbeYcNlV4rmXpRman+c75gH8LwiIymvlmDrS3ePvsQqOrRiYHQhv/0
         37vAg8Ausv+MFXstRA1lEfgVJUQkEe1N5ttzj/PJ32yreaDGDXUPcS08LfhIZRbLr1AK
         vCtWd5qMuf0CsSC/gM6gLUZZdBVPAr5D2vLxLAaYSfrYRo6q/Dlw8eqSiXjfuM74lCJD
         jF0GhZU0t0Y4t7ZJqi/ldc6KA15jl+o383+ZUJyy0+Ddv5VVggqRF8MeIlyxFPAIXaWa
         t47gT/1HQQuVbUZ4At5c8ng6+XP6bzxnXupY8rj+KmlvLXkmzOA1S/u2kD6TpeCPOp3i
         TvXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786173944; x=1786778744; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KyfYAP7wjzFEN2qG+GU1nNJUpnJmTU73WBG+ynKSYY8=;
        b=FS+OYWf6KFtcQSFzyMI2BE684JF6yhHwJsdXlDFKw7zHQzttptdXApPam2ac1FGReU
         pMgcRRWNvh0Y34xMVclWIi+SFbyuUOo2aM0uB38eW+DRd4MIYBzjyENo+0qNoBX/2ddC
         0MWwN41vZYOvppy5HgHNf90OHOxjwpBFBr8LUH6+z+ukMbu7Pyay591+yclXgaK2UjMY
         oTHc49TbZLNciJCqwBmc+Vh18ixjkZlXWq8uoDNhC/Zklm6hIzgH5slDd0zwFrhmWJSB
         flsfbmVZ4VJ56i8THiCAXzC8LSNn4guy9Wd7RcKuCY9OK+VITznuEj03ZTNUfNcryJTh
         usYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786173944; x=1786778744;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KyfYAP7wjzFEN2qG+GU1nNJUpnJmTU73WBG+ynKSYY8=;
        b=RWOfCA1UtG5kssv0FyT50pQyTy/Z48y1C86fNyFwHXrVLANRsKQHJj6867Jm7WDFU4
         WPe8ikNFRXFH8EZMQ2HEpgs9IPivKeKlLrl/fEbVTfzfXSt1E5WLx5l2xJYhIw8lR6lF
         Y9U1Ty4UPoQoXFjzbUbq4OFLMmPsZYW3VS3vQJL+gCYRINPrSb/OhDEZ2y3+Nu03Ufz7
         mFaVdTc156mvzptu621zp+9JUQpy+l0fSCAy202WgTmHFhzVcvNBaCicgqeO8qM4+6pn
         gxOIWaCSKIum3Qz+jI+7dGogfSHfjqju1wXmRnORpo16pa8dQ80bgDR9P5HIrOeDwQ1s
         mXFA==
X-Gm-Message-State: AOJu0YzeOe1O+dAr/2VVmYet9Xkzbp6ZzuwbVhCSi6QvT0N9CsJNqcuf
	Ycmkm0UgTr36/5K9tggGzxOPwTuR5WDWJPzoV5yVDyBGLrMtGksQOy/S4hGd2SE0O6kqcqMtLbE
	o4CG1vRF+Q6ajYTSS3xZ9+bb89kpqDes=
X-Gm-Gg: AR+sD10IiQGnjZhx6LAdgSLL/0naafoEPj4iphi0m7I7N8SWl1aVtkmNA7nN1nQENQQ
	Gr7d4BeXH20fLhle2uoTMMQC7V54ZDiXb0y4ueJahkuGkaXg1EnrgBfxMf8DzTmYAPzbRLyXmfY
	VvKW31QVBlmHtpuoLbtMZggz7RxUsB70r0HcMAaWgMkzDpV4TnFt29MHDtkmg8vFZgqQq5Xwghm
	s7ve2/U4GpW540uSKKf9PeVLZCrDr0wNUobCLqzULYpjc6VzspYB1A5zfeXLFLvSibIiqzp2keO
	LAA0lgDpvFxBqKIqFU3hBbOeD3YaTxPO4INKReiWHExgF8DrNSIdflBQfgXEZDww+G4dXzk9qN+
	WfQhHZkNwfwf5t6DxapZho8slyb5dIvZaw+y/e+qS2szJzDdhWBSVRnEgmZSNpOzlmUomvMkN0w
	==
X-Received: by 2002:a05:6808:1910:b0:495:f519:70f0 with SMTP id
 5614622812f47-4afae01bf6emr16839085b6e.19.1786173944607; Sat, 08 Aug 2026
 00:25:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716165517.433849-1-christian.couder@gmail.com>
 <20260804100355.1299498-1-christian.couder@gmail.com> <20260804100355.1299498-8-christian.couder@gmail.com>
In-Reply-To: <20260804100355.1299498-8-christian.couder@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 8 Aug 2026 00:25:33 -0700
X-Gm-Features: AUfX_my2Z6fucSqrrioTuzsSam6fTots9FWEWtGJyjr4TYVEFxVfbONwOlxte-8
Message-ID: <CABPp-BHoxLkYJmoJ1N5owJ5-S+yr-4JkuectxSVG8oa6PESkWA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] fast-import: introduce 'struct fast_import_state'
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Jeff King <peff@peff.net>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 3:04=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>

> -static void note_change_n(const char *p, struct branch *b, unsigned char=
 *old_fanout)
> +static void note_change_n(struct fast_import_state *state, const char *p=
, struct branch *b, unsigned char *old_fanout)

A really minor comment, but you've taken several lines (some of which
were already too long) and made them much too long.  This wasn't the
first or the last, but at 118 columns it was particularly far from the
80 characters per line guideline.  Could we change to

static void note_change_n(struct fast_import_state *state,
              const char *p,
              struct branch *b,
              unsigned char *old_fanout)

?

The actual substance of the patch looks good.
