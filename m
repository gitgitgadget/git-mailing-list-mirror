Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6508747F
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747555109; cv=none; b=RTF4MCsBC+VJ7mMtLE1kbwUxBu7fIOKTeuc2X0gBtun3jOB5Vm1tqXFNidyJPkrGPxejQsiUuIKSuQYIvAF2ZsOnTI4lDaKvl11EtDvCC5uShfNddWVitLuZ7S3zveyrKTYwlsoH5MtiMZhFh2thUf9+vmnrMG+dyb73SzIM4Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747555109; c=relaxed/simple;
	bh=JLSZiASsS4cam16YjgakH4d1xLerOjxKR5WhqlGNsMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VBCqsHsM7nTOQz8x/I9SJfJGrNdugWjANzFZ1aAZA9NjS9NfxEm12hASuKXOairbL5X5axngWZkOw1FXZj4UdEGFORrhe8YfO1N3kjgCzISsRpWuYLuh2tOZkaUeutI7mWpbTG8YwFTz66EdrJaWnwrUdXEklJLAadfqYT8YArQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jryq4mY+; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jryq4mY+"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-47690a4ec97so37080241cf.2
        for <git@vger.kernel.org>; Sun, 18 May 2025 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747555106; x=1748159906; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JLSZiASsS4cam16YjgakH4d1xLerOjxKR5WhqlGNsMs=;
        b=jryq4mY+ov+7ooHQ+suiAd6LELrUbrLwR9WCY2LV8yPmIKdJwIeezqgi8C1j69hPX1
         FHLJJcXm0mHXzSaCMUxtMyv9YTTmYomJIF+VBr2m+Owx9/GtH7Znvt+d5vs+uEFPct0w
         lPAnknNx6EN2txrsKrNJgx/dqWgFcWGcZvKRUgE58LYc/KU5s7pj6laGvQhONuqG79LE
         Gs0MKnE+rAW+QTwj2W0dy4JuA4cCUqa9Ii+627PnSiKjTLrM6G0UG7S44gCQXR3YWKLb
         izn7PaZidq+5/GFa9bk2tBRueYxXTlWyTnDGy1Lg9kAEW08N6+Dl4/td3VlEs8kLVx94
         EcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747555106; x=1748159906;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JLSZiASsS4cam16YjgakH4d1xLerOjxKR5WhqlGNsMs=;
        b=Wun0jJ44R0y4IQuyX645OfI3Mj4nMUT02Nxj8+HQfhppcjdVMNsO9+REzJiGmffPg6
         RKoKePi1Br+n2+C5MFX0AnEYrrwVv9w8YWPXLKpJ8SeVDAvx81Fps7giu4tyA5GlAjql
         ANG+x633DDbKCRo1KYB1L51mF3JdY7o29otbxwcvtNPhK0frl+54msXkQOKVwbrDrpv4
         m3ix0QsmdIJ2Ebh2wBFuBejAHlaqIAeQmRfTenfS+jPHczOPp2dvqoy8EXFVWeOABEE9
         MpONKqloNlg/LBVpRuNmbH+CNEbMfdNbZtCyk5W/jfO2tDYILKO1ozmi3+ZWy6HWr7KR
         glnQ==
X-Gm-Message-State: AOJu0YwcBt1RCU6BrzJY1gVYch+rA07sdswUfiWI6R0NsrhiOLCf5rCJ
	b8zq+f7ote9kHEWwAVBuBOcvdsbvq39TkCbQyHSjhpH4+LyYbMBkzvWiu2ZWyA4bG3WjlXly9pH
	uX01nsYKfuQbpx60xEbaD9bMjQyLTSog=
X-Gm-Gg: ASbGncuhoH9tszb/9/dTEFpCgiSHdnx+gbbsUEcUueNe1VJZ8S8DU1JIonhP1nIhLd/
	vcst1IBq4xBTOM74g5Z8ycanOm7yfRmuPAxYXP55WTq0CRcz32hpEEwZxmlJXSV3wJ/IuposVjK
	pfGEslUjT6TE+KdX9ERb5P2lljJPKcrQWXlAp4YNprwVZdKOpMwYb4iV8pHD8ayomQcDqoYNxCJ
	FU=
X-Google-Smtp-Source: AGHT+IHqopRl6jskCa4JcA2A2Tc4wxeOBN7/6ri+4QM90IpMEvufXWyYvC3YqbzhJFsvesUZBECdcjnSyBrjuqF/h94=
X-Received: by 2002:ac8:690f:0:b0:494:9ffc:fcd7 with SMTP id
 d75a77b69052e-494ae3573b6mr152723581cf.12.1747555106275; Sun, 18 May 2025
 00:58:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLfLA_s_xYN1N41w=vaOg0WPTNo_9TGKvG6ZQDqqWmzFPA@mail.gmail.com>
 <20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250518075436.75139-1-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 18 May 2025 13:28:15 +0530
X-Gm-Features: AX0GCFvyULeT0RedxkOZwltbBO68kohJBMxF-CO6BJ1lPNQpVvMagNC-rGCtYVA
Message-ID: <CA+rGoLcUMzj1eaGct+r1wUF5K_nMLepFz3kbopVYyoQXLY_0WA@mail.gmail.com>
Subject: Re: [PATCH v5] submodule: prevent overwriting .gitmodules entry on
 path reuse
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, mlell08@gmail.com
Content-Type: text/plain; charset="UTF-8"

No separate change
just changed the commit message to the format

Added _order_ to the last line.

Thank you,

-Jayatheerth
