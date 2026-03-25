Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1253533710F
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441795; cv=pass; b=MqXCFQo2qn3iVbSnhnY/MG/dbAGNAWwFns/zHnLdTe1AyNls/zepNnhXVe49VhEm3j6au4RfqHlpaj67B69NQODgj2SuHE+IVh4Gn60WxsEL6wUP5nJdn6a2edXCYT8GNqHGsNu46GcpPMpwhl9cOX76FTedWTg8VAyRP5/JP+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441795; c=relaxed/simple;
	bh=F69AZHCoZ1EhAXqWIEHO0mmxHYjGQu2N6oicc6Hs70A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXvZqYd4im55PD5u5lBI7xvhtgjNn4NQ/90kOdCIC1yXxeUazDGCHnfm59SLb8hk9Gz2F+FyTjvjzinTaqx3/wWueEeIVWhzCl1p1+zw3TVBxVZREhNfIT1WF3HNdAtSMlyYju6RmMQcdrXX2QLOu9aal+9yiTrWcRfsKrSou7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHLN3hlY; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHLN3hlY"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7947cf097c1so49479997b3.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 05:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774441793; cv=none;
        d=google.com; s=arc-20240605;
        b=K7XM+2pA+bhMQkoueFoWfj1Re8NNrADmutdLcx6VhPQT1zU4W0y75zSV6Hr+Z+hVWF
         r9ZUIS3APqr7YitKoQTpdWWfJ4IocjH79PxZCKdot8jY2K6ae2quqtSRKZ5khkpj39oC
         u8nf2pPsISYNGl+VhM6zE2EGQewVkRDYl4Hvs6tJ4iDZN1dLTXJwcxNg+4T8GVI0q5Cb
         87ufhkKHpYfU7I0/ixCiecVDG7fvTs3Rqt4q8OcAgi1feg30lZ2hde5LHJ6WfsndTLa0
         EkxUjG6olMAWe1vZFy6Tu2xzGTGZJy1PtnvTfrE9YA/sb8WZWy/ifkipZyajIiZ52UMY
         7ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R6UZphxD71bGIxUWogshiU/bZq1eBJR6kUsJX8CS8wc=;
        fh=leqxNc3jF/t+mFa40l5qBhn20FaXqhR4DCSsWbMYFEs=;
        b=ZRPNw51OS3SnIgNeZvS7UX7Xa4tuRxYR5SA+usGk0W5M1Ci7DPePjoeOcaFcbbJ239
         hVGvhByRwBBJ7qvI/fNCac6oVlI3wbS1mnQC9POR/tngBjJixU/PA2Ak8XTaLNsxFUzS
         KP7pXKcsJtOAHXKkEeShE4Th9U6iE6Tdz/SzMUjQusy9iaG4OXP94ZTsPIflB5WA0/T2
         Md11igCH8VYvz57ii1DA9aPKqVMC+yj29Fnjal9drvh1nW9hVYuosD52o2qvLJifGlAY
         xBPTGKPI0HcFjiahdLkFUOKndPsHCJEW/CEApZfQ0hzcRB9Yi2GzKuhUaQsFOdFTjLP/
         Bo+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441793; x=1775046593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R6UZphxD71bGIxUWogshiU/bZq1eBJR6kUsJX8CS8wc=;
        b=hHLN3hlYBVacrrvRUoM6OZi5Pk+EoPw6hft40TRyPIOB0BtUp0hwepM/YdjUiK3gA4
         UqoJmlsL8Csh/C2vCHY95KYfEtti3Ky6kDfPyi2FL3japXHx6O+VKhS3Du5+y1nm4A4A
         TQx0neljt11NyLWUaELpVlyZrmHCLa77wJF24NmZos7nOnqIFihbQUFxyury+i42KBuR
         ouYQjgMiK8E3I4sY4Iod1TQvWx7akdPugE9clSzT3+ApXb+VuU1yR4xhI4c6FztOe6Ij
         W/IyudeG1K1MXECHwRpYg9jTiO9Hr9n7vUnN2bYGfAvU8fAcvztvoIM78yyUKSiG7F/M
         jV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441793; x=1775046593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6UZphxD71bGIxUWogshiU/bZq1eBJR6kUsJX8CS8wc=;
        b=pO6G4l0SYf4Xv9T+8zZHnxe9Aneo8VSukE0aSjKBKltIBNcY1nXqVnoLB/qcS2sEHC
         LdnxlWJms+Atlh8uud+t7hFWbAmos7jU7o/UbF51tUhL+Mb2QRmpc9zjxEMfaU2tzD3L
         lQIY+KEwKTnheobPE9Dxe2+DC1DywjgnzVxKf6h7i8ChBNngXOP9C5YibKnKWvWE3zUo
         iciVSxN6r3PpUmfZIZlnPtdDGcDIj0qes2Vu6JioeW89ciG+QdlbCNiEWKIDoqZo+Jw8
         zUKAoDOuDHJAigpacS2X0oQDMmmq9MrE677NVC+x+rDgjOZOsAn8WD/S4LFw0fLFpq+g
         QWjw==
X-Forwarded-Encrypted: i=1; AJvYcCXuv7PiRamWEA9m/R1AL+rkgh8tNtodblrfFGVlBUi8CsE2Ls3aj3kee62jlsyaH4dERyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIk3AlhqyM+RUv8YLM8FxddWDFUhzCECWb86+M1QepsN3SIUT
	PoILaK0AG2Ym8W+OL8GXsql5jj5hMYQM67Y7jy0hveDR7kox9CFuEN8LM86xvewr72wRL17+Ykt
	UbbDnkVKgyVmIju5qKB9TcN8cODdry+U=
X-Gm-Gg: ATEYQzwul9QUR0rdXUzjhtgOjT60do3ui9101pbBg8EFn59gaz7mrCgYipH1HfwgfcW
	R7j009nwt92F0HcSxrcNQ4L3qpSYemvOZV10D1Et8TPoOXlTL9M5Zwz3nYmFHYW6gBeiQAG1nzl
	2g3nIAR9B7/w9fO4BByJmJzBaXrYA8aFVoMr0RBbwE7X/Q7LNTOXMK9JACn477+S1cKcz60FmQ4
	LX0dUGsG/SkQxsl9a0SdEW/4EGAyjBG/Z4wTiRC0XCGYFMsGN15QSEwY5Ct/FMu8PPMxoeWulCn
	FZWE7SEEITsbEGbRmgBPmM8yTbsHG/+YcjOG/MTw6CVPdi6nvsSM36HdzQerAl2H0hEQn37JlVj
	ivSIoqmFPFHQ+8GpZrDGKW+HajVPqpJoGIw==
X-Received: by 2002:a05:690c:34c9:b0:79a:5fb9:62cc with SMTP id
 00721157ae682-79acf2f148bmr33798687b3.13.1774441792954; Wed, 25 Mar 2026
 05:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com> <20260323215935.74486-2-pabloosabaterr@gmail.com>
 <6b299cf5-acfd-4a56-87e7-db26743a3271@kdbg.org>
In-Reply-To: <6b299cf5-acfd-4a56-87e7-db26743a3271@kdbg.org>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 25 Mar 2026 13:29:37 +0100
X-Gm-Features: AQROBzDQu1D-BMQ_P-gCUGOv2n9QncMhxMcMou_80g6uzfdg2kpzu4_Q9vCVinE
Message-ID: <CAN5EUNQBRp2OQHQ32FFW5vPKUO9jHu5chijA3FTatR7jnyzO1g@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 1/3] graph: add --graph-lane-limit option
To: Johannes Sixt <j6t@kdbg.org>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Johannes Sixt (<j6t@kdbg.org>) writes:
>
> Am 23.03.26 um 22:59 schrieb Pablo Sabater:
> > @@ -3172,6 +3174,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
> >
> >       if (revs->no_walk && revs->graph)
> >               die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
> > +
> > +     if (revs->graph_max_lanes > 0 && !revs->graph)
> > +             die(_("option '%s' requires '%s'"), "--graph-lane-limit", "--graph");
> > +
> >       if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
> >               die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
>
> You help translators if you make the new error message format string
> exactly identical to the one that we see in the post-context.
>

True, I'll make the messages the same in v5.

> -- Hannes
>
