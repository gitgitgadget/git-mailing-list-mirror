Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792572861;
	b=b27DfUAGaLmv+oSlogMoVelJiCmJNpwZjSPub3gEi82PjiJN/YpH06pxh4zMlpbNDGjq
	 ff77TA2rK1JQVyifPHQ5Fqm4SATNLp/+zpEXIcLa/O2vpR0Zi2k89hMmlCB6jfckVellB
	 j20yNb4H9nCOSNgOluzerdTQbUYOdmvaLzYQkkPofoPkHKoBjyZcwXfTgBQ0StLY/zbgR
	 uJ9dhbiBPjJIW20fdD9CUCqWARr/qs4tRrdZUiHZXGrpDR2gaEPwAIlM2wyytGxr7CNRE
	 B6tnqMS4V++7byYoPIaUH+zvOCLMj0pyd7LjZBctsWQclVFCNAHrO9sWVDiz2VxKj1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572861;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ptfOWMRMcCbLGcSze3/oxRLukCmlUi9FhTdjSo8bin4=;
	b=bqOWGoDJmAMRMn5RjPcRPdTkMQepb0r4aXTYoAmz3c5zgOVRiFt/vltQ97q8katW5YPP
	 sM+oX9WMN41LF3H5t5sES9sW0PGJRctUjr0LIHsSaMDvbpZgZeLkOAzDhh17DSq5aocyF
	 lMJ6LP+I6JqsK7OhWZx/NUrCcMp0WzMp2c/+pyEcX2XzHPdbfaMvhOh+MF/Gy1HMswuxs
	 lq/dbaVx9FjSEoCKOucEstp/HEeb6w8HPdgcGxvEPax+091rUqICkNfSpryol6MV16xwH
	 T/Ds/U6OFbGvWKykKyL90/SSeBp0zSIqWuujSVGEeL1vztrgh5jJxrFZmHszjlKwfqg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="lZfDI/JO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBF606A321
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:54:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0FBF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lZfDI/JO
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b40fc523faso340039a12.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792572859; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRRgifd8EI/TMwNiNMX1sv/CeFxXjXHJnoeGi1dn21az/ePbktEAeUaKa29U+frVO8
         PV4kepilsvAvhowznDR7whyHkSAO7EjJAyYHn2wRBEtpi3Maud52bM364ABl+0WQ8Pc6
         Bes1658+R1qcsNL+lNiIjolqFCSbz+vYf07wZFBwo1vsCNzicGUk4hgkFVep6lHObCfk
         xaftuxlTGsFDauCWz+ZeJitUpabZmpu5EDSBqrFKgjdP4J1eoG6dMu4MBlLhuC4dz21p
         JGB0n5iO9Dr8INAt/c71CyWd5o34L+8ROCovcnaMVb7GlQEHx+anWzdiXscMDt93n7/9
         xOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ptfOWMRMcCbLGcSze3/oxRLukCmlUi9FhTdjSo8bin4=;
        fh=3lue+IHY1TPVS+JDqZExGSLj2iXTS2jEizh9HC34A9M=;
        b=RdT3FQcBHKVk2uFyZzz50gsCgcVoXcjmw8HUTZ4+DRPuLAWpx4oAnltUBQ297C8QrY
         tko9+cTKReat8jw+GCFbAD1so7k+rN8W4Rs9/7O5DMeyviCm1NpwQfB6zzE54ufgQ4AE
         StEOBuFbeoRts7xXUFoszMij93ebDktki2nyduXuJrNWfyjqqqVxbEoKi3ziZ7+LJsOl
         CfzIWa7yziY0nj8vcBmiWhYCsgdsRQG5tS80aUI4l3k6ymjy3zb60RMUMkYT1/9FrlDg
         cqKB0mDFpBLaNTBuiq3ToSexk/f/tvkMX4+wZPKDCBd2E77orVDpkjbsgESA4jNGmyDu
         VEyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792572859; x=1793177659; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ptfOWMRMcCbLGcSze3/oxRLukCmlUi9FhTdjSo8bin4=;
        b=lZfDI/JO+MrBTiC9KdoZOUA0ekB+hRv305TVqDNQ7TDp9ehuljpBkg91i8GAjdY0qb
         Sh8uL2yHfkaBMdMsx0enlZmFzwGs6bnucJIPnM7qJQ85Z/QRbM2dIl6aBPm7FQC7SsYM
         vchUZ6Uz454p5Q1vjSFtfSJzuwIeYO8DnqG7eecc4+JvXpPk19FSzljYtkEqHJj7g1Rx
         NqJ1BqhNDebibEFfuxxtDLx4XR8CZgMk6wS5FUqf6xSuUiOW/8N/yOkpGVT6sQjGvScc
         RiXsv8JspazW/pij4iLt8t5SnUAmDz3f+MXBBg3oCBIJF4lJGyO3lVvHiCluq3MtVER7
         XB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572859; x=1793177659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ptfOWMRMcCbLGcSze3/oxRLukCmlUi9FhTdjSo8bin4=;
        b=C2OOeeAcEHvO0E7gnFZ0dw1GZ7vitzHRFmPZVWV0dz9wnifDyLcA+aLA6HlJ54z0iT
         b7LzxWMEYE8CdlkHuVgESnWvXFD9JagETluZ65vjNm6itr5x0D3hClGMWC/QUBBHelRk
         +cs7+MKnoeESaD1eJxmC6zNdJ1FgB5y78tMM2yPmqlC++BifIDOtLIJilvQfKbGWC1kg
         S+pV92s6KfVFPnQktcbANwtAdUKM9BmSePXGGTXJfyaXJrfFLfC/5B0Vh4UKrgo/svRZ
         xyYv3c5/w80cdSH/weJHYif3BvPRlMgGznc0eIOevoNYbl4Pn4KnSWpA3CuGqWuvHYNW
         MSMA==
X-Forwarded-Encrypted: i=1; AKwUvBw77hh2/Q5nIBwJ8O5I6I3g6xZaE1t6D60qH1b05J+yQnt5dAwIBmjspDe9opDN+PeRq94=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW2j9VAEwbke8IZxrEGszEo1AyckZOTEQPufdlJFayrb3W/SrR
	umXF7WslTp/YIVynI44LYTorUXw2KpzuyzAjHl/6rKEJuxJMT6AGvixy/9/D6gLI0msQ2+UTCt9
	DY3spA1FiNjZQJufxZEtP7HsUF/ZEQvHfRg==
X-Gm-Gg: AYBFou2MKjxtQaqd31bnebSAll2iHRhfKIRbml13hSyw4ST3ZaymRfr8uWm+e8JRLMK
	Fg6c5EQ/g1WkDeIB0VsGCaumjtRj5luymdcRif8zlHG3FSDQovQ6fYTJFPj3o6sCq3ksadkmMnN
	B0yF/Lm5fQz6Fl91pO2VbQwk27ExHJNp+9Xn0lfnYGJPqm6gmodbD8DwFMlaXngU3Jpwjh9Hf+k
	gok3MUQwcwZx6Nc7mJWTKzoOgAE3sKk07IyvWbzP2pEUBQfzRib41kLfNLJvBlJNKWceMRNr+NA
	+3FmM6ZyPFJIcs9L0d+WqZX/FwjP2mirskwdtZyWszUvanp3OtVmRldvYbD84syOzNr0wfk7BRL
	57KWd6vuKp+xFMnewCeiM16Oqklr/ITuHBkjt
X-Received: by 2002:a05:6402:248b:b0:6b2:2337:9852 with SMTP id
 4fb4d7f45d1cf-6b408edd031mr863172a12.32.1792572859299; Wed, 21 Oct 2026
 01:54:19 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com> <b170b1f6d33d42b9441585fa8877a9e24d8d37a9.1792566469.git.gitgitgadget@gmail.com>
 <ath21xI1yLScKpuh@pks.im>
In-Reply-To: <ath21xI1yLScKpuh@pks.im>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 21 Oct 2026 10:53:43 +0200
X-Gm-Features: AclHuK_u1gwU90AvISGkLTSVIKYoBFCzhRmlTbXoy4Ye7Fa__-AKdM2lkOxLoSE
Message-ID: <CAHwyqnW9yRPabz2VCN27RoEw_kCmvGuKQwd-btuMK3vHJVnc8A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] imap-send: avoid leaking the tunnel command
To: Patrick Steinhardt <ps@pks.im>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >               imap->buf.sock.fd[0] = tunnel.out;
> >               imap->buf.sock.fd[1] = tunnel.in;
> > +             child_process_clear(&tunnel);
>
> This change plugs the memory leak, but the bigger question to me is why
> we never call `finish_command()` on the child process at all. Is there a
> reason for that?

Yeah, that's curious. I'll take a look at handling this better.


Harald
