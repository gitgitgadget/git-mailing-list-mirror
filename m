Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795122261;
	b=WhWFhl97IahOwxsnFFENRsiNFXoeJuGsB0V6RRQyHmKbNcAcxEacO55z17KTrB4cFTEs
	 yzBg+1/6j4jB11jH1JFH1fr70ngDrJLDndzX3L9FGeNNKpDTrxC0Cjzl/KdUgRUm/3Uus
	 E6jy9EtFFoaljLOnTqXmFLvKdxWRkeJ2a7z7oiAZ/OPcvqwMbe7vFwuoIZmYRf8fUtMMh
	 6Wz+NAblrJM2rySi3L+T+qkDvQ0twuhndGezdMRPrENTv0vvWhMKaGLLGuIYIbWq8PcoN
	 b2IhEpSVeLNgtgtRHzx2HxZ3mskC6NUfYmBPe14q6k7uJ7icHSzCPl2AHmQumOPEpHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=t7HSAhgcqhYKViUWnj1DAE93P5rDwfCGFlqgJAlg4s4=;
	b=0gXbgeBDUjEmZG4LPLN8CV/3Il8uifixfKmqupWTCoeY1uUVHyqT62eLzd6JUPlsl2+m
	 KCz6GpTGFULeYHZ68lN8Cn7iMXRWDI4vKarEqBebWCS3QJc5C+Y4nLeiFago5L7YtqLAc
	 lyZ5FpXvYF4WKhAgF+X39ARNzVKnj4Ec7Iu8+HYaEciIa1dGLqhi6gbpimY+UjnVvCaxB
	 PVp35ouzqBNrRW7gtUec3dp9+Ki+fhAQwZ5FkzcISPXMsSii5d+JH4DGgZEbSZnSApdO3
	 jB6ScfKPiVZciBRbYQlw8RmI4Lc5jqjtaC7vtEx5YhjAIwv2KJ0oRaBrpYJwGWXSj8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zBbF4/q4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63965606A905
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 21:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63965606A905
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBbF4/q4
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6d290b10a35so81591eaf.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 13:04:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795122260; cv=none;
        d=google.com; s=arc-20260327;
        b=SueDSNS6hH8BwfzvDqJf3UnIRBPHj5RxhJAVtBJh8HmR/t9M72BJza0A3c3T9ts0bY
         KnYn//b+ImUg3wXkKz/hYqqALIR2QTDfeCBD6m1cx0XyASY389fQ/dAtpEO2F7+Ed86k
         bHLkbhp397W8xOL82GfsuYZuM2l9+bUCslHPiUvvzFeKroIeBX7TYFzAS0AQG8fKOYpn
         Uh0aLlFwEcmod/w9Qs5pMX8VaHfZdCmeSlZxiXk3Pdpp0Dl1lbHPYcOv4S5PzrNJcQby
         ceeAY/gpAPPMN4lCqsJj+naPCo4DG37L1A6zT64u/IrkEVIrRmEZh45t6FjAkv/v3nJt
         TPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t7HSAhgcqhYKViUWnj1DAE93P5rDwfCGFlqgJAlg4s4=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=Cu+22qc12WBF+yZmXVmZOsGK1zdGf8MNhodlJRHV75UHjuPm1JeJAA31D0THu8mbFd
         CG79CalelmDTDUETpcqFRLP2zWVJWAV9Qx6EiIuOmEummTdNW2malRbrYEuSK6Pqn2BF
         DWbt/YMKvkeTnGyi7L88Xr6yv4k8V1dBTNkE90FprbI7oYFHe7OeCgKzwIo1B1OeOUFa
         mrmz+rr5YHbDA2N0eXdqt6FqtpGGDDQ3nLk5e0CH/Z9Qy7wx9uXEd6w8afEH12GrW26l
         +uYqbdw6x94OUCx/KKyS/2VfmVdIsM4kDWvzq9tFbhTn+AOBQGPLodNvhsToEX7bdBCK
         sDiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795122260; x=1795727060; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7HSAhgcqhYKViUWnj1DAE93P5rDwfCGFlqgJAlg4s4=;
        b=zBbF4/q4tjTSUz2A3T4phC9gGj4gWMPNqc7GM1CncBUntZM6F4cy1gV6Nt4e7cH/Um
         zpvIQRkpC3chpOjM5FAyJLlehs9JoyQtItqxRUid7BaBZYxXN52LQLq3XC5Hlf9K+DQ7
         6n9O+RaOA/7o/TWikHtgyd6qVQTApP1TnkPcPrXsXNxuirqhtLLkyrlxJZZCT6J3b3Lc
         Hw+fzF7yIYtdKV6DUt4fduyJcQgaOwf+9yMmjfS1DEdqG1gponC2RexmMJfYWbOV4iRe
         tULAx/LxrBcYo0CAC3chaMX7GwM8OFGTX+HBVFtSUuU20NPowc2SQmaFWV9AZ2005I/c
         fPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122260; x=1795727060;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t7HSAhgcqhYKViUWnj1DAE93P5rDwfCGFlqgJAlg4s4=;
        b=2AKHiCorMN2O31FQNh0cl/iZfHWAraWUf4F/JEOEFM0/Cl875+ibDokdrirRzclgPZ
         EcOWXgqD8i2uD6xqivvMY0HBhNzjfL0b6qEqkW6yfoYB8aiWYpsLLdxy2z+sVTxLZt8w
         c3M1xJAXmtOpEd9jqG9SwYcYhxeOFNgJkwyBmOVpWVWRR6m8BPh8SDzglAfUwUDSPCC4
         0t25ME9BWzsuOOxZtOdEUq29JzaO+LWGJzBGJD/nXC2/sz0ItyjXC6HYASnkc8631UIg
         8pY0OJ9ZF81IF4qIJv8UXbTzLnO8SSvMsE82+t9INyO5CAjbplNLndy0qJf3mmq85jyu
         v9OQ==
X-Gm-Message-State: APuU4Z/A5nhUN+L7oO7ovCF17K3ypJlmuvWSEdmBg/e1qQ7QvrDYVNuC
	H/gAHNA32EioY7zYFn11j8BmZWeaqbtPl/FYG7hOAJDKZ0Yir+rrwwXqSMW6XDuXIdLhPdJl60M
	VYSmPfqH8xnviiPCd2cxhwBCNtJybUAU=
X-Gm-Gg: AYBFou10MEKQ5ngmCMvUadrJ03mOh2Nv+vKKvQoQLkujmLiE/mQ8IKLVPJWr/yNL3bm
	zK1l5ON5qTx9zDx6wTz6PcMDhzkJf6CNC4/HzeMGelzAWjRMclGREZP4sriqLpN+JEg1sCCBL7c
	avxUGbohP6oO+XDN+Cc2nF0fcx40nvG7Jp3S/xG6C8L/o5+ZJrGHzol5IM5aAIzo7Z7c4X4KV5p
	0wORiL3f7LMHgmhOwQLTo6mp6hbjFKPjWmd2XgzP0tpUvMYMTzzjX+MisaWYzif9SI3KnCOswed
	1BipZzhDNTmC8bFTdMcxr5lOS9A9Lb2vQiLAbdMBaBtAgQMTIq5CM0gH1iN/nybxvpcbA+iQeLV
	4Ijq/Y96JmG/sInTiy82/Xa0JdNLqPzlVsnw=
X-Received: by 2002:a05:6820:a710:20b0:71b:193f:2eb2 with SMTP id
 006d021491bc7-71b39599300mr571141eaf.79.1795122260197; Thu, 19 Nov 2026
 13:04:20 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
 <20261118-master-v2-1-3f2aaec15d31@gouders.net> <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
 <ghse0x9sgm.fsf@gouders.net> <CAHWeT-ZNoDWqTMfCdQg3PZ2bbLD9PTVqeFMms_1dFj8dbReSCg@mail.gmail.com>
In-Reply-To: <CAHWeT-ZNoDWqTMfCdQg3PZ2bbLD9PTVqeFMms_1dFj8dbReSCg@mail.gmail.com>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 19 Nov 2026 21:04:09 +0000
X-Gm-Features: Aa3M54oODN16H2YyLvrREk7DpR172HgxCadMjAHwNN8PJx1miGs7E6UpyTazvlQ
Message-ID: <CAHWeT-YX8FOacV7YypyZ-qmr3Q2T0TEF=_Qy2bVE7jcS0OWvNA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Andy Koppe wrote:
> Dirk Gouders wrote:
> > There is only one user in pretty.c that uses the wrapper.
> > I can change it to use the _counted version and we could then drop the
> > wrapper.  Junio's v1 already included such a change and I could steal it
> > from there.
> >
> > Would that be OK?
>
> No objection from me. I would change the make_line_colors_self_contained()
> function I'm proposing in [1] to the _counted variant anyway if the original
> display_mode_esc_sequence_len() is going away, to avoid the performance issue
> with the wrapper.
>
> [1] https://lore.kernel.org/git/e9f88b533dfbd10528c9151e2e87207419d0253d.1794905511.git.andy.koppe@gmail.com

ps: I guess you might as well just drop the _counted suffix then, and
basically just add the len parameter to display_mode_esc_sequence_len().
