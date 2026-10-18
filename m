Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4432A3D9043
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 23:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792365700; cv=pass; b=hBS+ErVyJ2V7RbEzVx8/bCz4Xbyc9nDfL07UArXPrPTYh2AIlcUDbrb61q0Pd2U84tO1LArK42DMt2snQlp/7tNoXOEb0etRQlptHMqpKUiK8ecGI3VwlAi13vND9XNkY526feRJmF9jCbSz1kUWTxch2MetXcpLFWrvZLh8KDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792365700; c=relaxed/simple;
	bh=PqBr/WxeWlBFgW67i92btU+q9BOgRHBrmLN/Jroh6uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaNWdnDKV9RlO3RqN1i3NpMjpS0jb3UZugJeEwXB5qJ30kcP4ceqODNuCVuDXLiTLgLQzrqG/RaheeSAPi+WnzLT3wbIhaX580Z25E4wTjyFa4pjcqLfUN2DIoBJdd3Si2MQPdGKE0aOrzpGJ0M8ttAhmzEjutt3h5xAxuVsZdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtFWC/pa; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtFWC/pa"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso2164880a12.0
        for <git@vger.kernel.org>; Sun, 18 Oct 2026 16:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792365697; cv=none;
        d=google.com; s=arc-20260327;
        b=ggXepmDDIDxJ/jCshQkz1lv7ePaU+PM6jThrT7cvhgXyiuCsx/sS99OJQFIBuL9oej
         RggGQVQQBRNegg7FDUQvGArh2UWVTdnG6ekcm73z56tVcUBSBEKM4Aly1v7m5jqOoqje
         F82wx/pifbsoW0MmwuDnzuz8CEvYiAaV8k3TmR4ao3ZBtuLBSEbrLKhjc62cPK6KPvR5
         rbRf/EDa8wEWT3d3ZvpgoLP1HKpJlZKLg/CBoBuNllcvfayGuceDQkicsMPqR6YyXMhX
         +jdTIZ5Hv43HxItC/eMjclLuiWLQ+0+X1fd0DVr7v9jqJJNyPNfjzSCvw1H3V0icSeWy
         OgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PqBr/WxeWlBFgW67i92btU+q9BOgRHBrmLN/Jroh6uE=;
        fh=mZzcbI29Q0FXv9AgiY2dxGOMELohUBeNDnPoJNvUXyo=;
        b=MvosmJ4OFp2Ydd7tMbq0uocKPIZuElVCOqlczpJHP31KA4kil0piV98aU389Dt82Vi
         J9mEj9m3U+Os9muec4r0WZUvlJnSH/ut99uFWizsSd9UqOmGcu1pwtWeEb3vpwL3jj/d
         yyOGaqqghsv9Os5QnRvB2yTDYk32UPQqhRxiJbl17Ge6k5KH2aF4xJaurBvbPfxVWWpP
         jHnULAZXxhq3G9mjfv6Oo3dsUVp4WyMD1VUljx7tkgpQjuN3lNxrMsAOL/jk4KDBumwJ
         zNg7FrGQx9qPD66DP/3PW6uLFiUmep3t2fbDORxNDrT742WLwiGAMDvygmNwNbiqTwLV
         9KdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792365697; x=1792970497; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PqBr/WxeWlBFgW67i92btU+q9BOgRHBrmLN/Jroh6uE=;
        b=jtFWC/pa7OT4ReA8CV5hhe788oUr3c3CSKwOY9/Qc5S7xXTB/n6AmVkgfD44oKgevu
         sSvfk3hsiUqaRnh+U2mQagcGJHdDF+k0K39pVSmMTkT9r1fPb3mDWP0/c6FStXH1LQX9
         DbtqJTsLMl37/TJCnsNrCeFkfOjemvn5F9wjNrYpJRqeeHjvRo4pzp4sqImYxBadMTGT
         h5p8v+TfkF/RIwJ8uMqG+uzwTQ6+UAIHfoJ+lgaJksGLwEUYvzYTV6j5gYlKC7g4yVgq
         Lwe3UqYVnaXcl3UUo7Ao2T/ahrs0GXDZW/mlWfmHJXbKyS/x/s7mbIN9AN22LnOCIg/D
         OBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792365697; x=1792970497;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PqBr/WxeWlBFgW67i92btU+q9BOgRHBrmLN/Jroh6uE=;
        b=wpEKffgzuhVlDCuofx22BJGNgZ8BFG7uWEvInD8Qiuf8sT3p+a5nEnEFrhdQhjbZ09
         oEKskADMhpHxcDQBdt1yLRjBsKJSW4UuWjodFzpI4qGI5VhvWN0J1ylQqIKc49TljWQP
         5K6SzWWuS9PcKwUXy0geTagVYUL57wcN9gK9P+VhSueGGquIvJqpmFXxIO0bd9p3Iutl
         buv94zokZhDQ5x8H16EltelIipIu7dVkK65U2UKOclnegFH79DJG2uL+3lg/GcCpOXpi
         3p2OTZO4jCvrcXsMrttT0couIGW9CR0YQ6XOeaT6j6VilY15wLnQyYygJlOs13PdXQz9
         gNtw==
X-Gm-Message-State: AFq9FYIAkjkjaVTdrMZW3APp0U+S6c5zqPcxCyIRaaqjMUGplSAHRFVu
	uxbsdJuM3/7FpfZ/39X32MJrcHiK4dR2sc0eyN8G1m+YmgFzrdHDUsjX2fh9ba54SZcN+7cFr6x
	dMZPHmwqWG5Xr/zbuikGjcSsyk6zVf5U=
X-Gm-Gg: AYBFou0AALf0A+pd7qKUYH+BPamrKCWFC0RSnCM+KJDY03ZnksiXmGcuO5F4MAJv88d
	ev03ydwJ1MpNQZYE5a1xE5cwpOPvucxiAsA5XY0MMhew70Bl8r2Pth7COS1R3TVKoy+/75YtaYP
	0mqIL+thrybaNVFXGItGrPSuC3iHRTo4ZDGkGLwDqUh38T8/13ScOslPsr6y0W/XMbHVa+uCSE+
	d8lbDNEqy4KBZo03QBUJqWOfQRcIzZkn2gQPOB7M+YWJOEyXRmLS+K/nb6SnV3zIfr81ifymCB0
	qG48OfZNaHr/QSpekc1fx/VP9LMFkEancZLNfQjG23FB/voDzTDBG/Bd/PXrMm9gBYnVtuWy1hR
	htuzD9AktmLIzew==
X-Received: by 2002:a17:907:6d12:b0:c1c:4a80:30c4 with SMTP id
 a640c23a62f3a-c419d05f871mr376243866b.11.1792365697384; Sun, 18 Oct 2026
 16:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018205227.1440-1-kerylefondji7@gmail.com>
In-Reply-To: <20261018205227.1440-1-kerylefondji7@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 19 Oct 2026 00:21:25 +0100
X-Gm-Features: AclHuK_Qw0tR4IWzmIvgUcdsmlmvoflyZcEIwSGeirlCl_8YGEVj1DLcjq9QUmQ
Message-ID: <CAPSxiM8QCzayAZEaWwWrfpk=GNQrxiHYy4N2LJrHBV9PA0Preg@mail.gmail.com>
Subject: Re: [Outreachy] Microproject: refactor archive-zip.c to use Q_()
To: kerylefondji7@gmail.com
Cc: git@vger.kernel.org, phillip.wood123@gmail.com, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

>
> Hello everyone,
Hello Keryle,
>
> I would like to check if anyone is currently working on or has already submitted a patch for archive-zip.c, specifically regarding the pluralization of the "path too long" error message:
>
> return error(_("path too long (%d chars, SHA1: %s)"), ...);
>
> I checked lore.kernel.org as well as the commit history with `git log`, and it appears to be unclaimed. Please let me know if it is fine for me to proceed with this task.
If you check lore.kernel.org and it is not present, most likely no one
is has worked on it before so, you can work.
>
> Thanks,
>
> Keryle
Thanks Usman.
