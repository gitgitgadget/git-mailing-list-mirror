Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FDF23D2A3
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 22:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768169136; cv=none; b=mEO0ukPPs8tMy3BCRTSZYXSTzqiKRqVyVP7OLUIRogCQ+j8Ok/w+8Pqy2528njTWMu3qfeNFk0jM+QRazxoqsvpgJTtQANx33NTl8ZBURZy7NMDli+IWncN5laZTlmi6nF7m69chqAMnnj4OoPUtO5FuqenvuC4EiGH+46278IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768169136; c=relaxed/simple;
	bh=uuJWCMC+ki1O5dFiuI/nTsX4NmEuqAEk+ttwMbUFY+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f2n7mDjhuEAOQEFRTyTDdV2beY/uhDI4yJaUUNl1i1L+DDE1pLZqVCFDIS6EU3kx7qKj+ERhNUeoMRxZBkCZzdINR5NcTUOnrZHljWzJqvfbOKYHrsMSrt21OYPtPYXLQlfWa8OhvAoavpB3FmaJ/yzSXG1f7wp59oEMnc61HcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRP4JlTx; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRP4JlTx"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8907fb0188fso51633036d6.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 14:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768169134; x=1768773934; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uuJWCMC+ki1O5dFiuI/nTsX4NmEuqAEk+ttwMbUFY+Q=;
        b=NRP4JlTxtEb+2E2B0fs3gJSiQ9+t3bclFLjtHkMW3TDn4F8vHc2trH2ssEQ9zUz89j
         gPOzNh1L/LC73dTFxMMFt0GBN5Azggg9px67skJ8geA5CAMvzFFqs2cmF6Fnta9B6+Y8
         Z6vgPpq/FLEcfQOMJj7ftMwgNZgKjA+gRTeUJ+CKNB2cuBmJDc8BbCT/lwGO4muDSz++
         HdyJY1GMMgVpgox+yMd02s0GBVgNEN6lccwrvz+PUWrFa/7oSlWp/fE/PvWiUVTJArHa
         2MbkafSNCTsMcOfUoRxv1VB1s6xJk5u3f3WP7i/NFXQ2p3TZ2X4kp0Owc//fgBNYfiHU
         cQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768169134; x=1768773934;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuJWCMC+ki1O5dFiuI/nTsX4NmEuqAEk+ttwMbUFY+Q=;
        b=Ev3iLomn1sZDs9xessF6YGPF9JEdDGEsgRljmcQtsLReaYgQkTp18Lv0EblP2PYhwc
         NQztIHmLZzlWWJHAI/0EDnHhr0QMNL+zsBBm97dmJgY55JOjK4ugYjLx2JYSiXUOtqBA
         icjApVa1nKXDN7JGVw1DIxn+nc1taQN/JQgLSYU/LVefcF+kM3cwkL9rGzrAvJjoOCal
         LsiwJPYoEVUiUKyTAxA7ZttFN2Zf/tbB9+45Kj1/KcXPyMKqK9hlm3KkjY6Y249tm66N
         WlmvsI71u5aiH0jKpcIfwhUhdPykpl88FCoJla7DySi0SQKYBPs/fYJmFgKhGIO0AtB9
         gocg==
X-Gm-Message-State: AOJu0YyEpiCpx8g2cz4eeTGd9Y2Lv6T5cQ1mF81MIGar9hlMNErtawLw
	7vB5o/XccdcTay16RlV6T3bixWXwzFDkT9yZoS0hIY362of4xaTuJ00ljb8HDhaoBzm8dqMFtAO
	q6kIhvnS5qivxQb0DmzBhdVrR6SyBE/5/7djS
X-Gm-Gg: AY/fxX5uq1xjWJqk6gwWtLCpnnqAiyIS3CjhMd4ZMsvNDQdkaL3Kq6u410JzTIvzlMI
	bfhCmC5+EfMPXSwl+zkSsCXdRkJ8ukYL+54rCGLa+xpqBarMRYAVGOPto/iMCnGAWHRbStDlF9L
	TVpW/wmXZYLmRLcRkOrRW3tgEU10WumyevcabHVWNvs+gUiqYlTwNB3eD7sdUi6YqNOEp4Zmudw
	CSvorkmSZs//rQ5qXxGQeT2DD17SPZcxwbPdflo4cEVVlgopDPnqXo8e4Ds9k85FNKxfXQr6UbF
	SjZ6ZaQnqfxJN5rgsvRhOkUb
X-Google-Smtp-Source: AGHT+IEt40jwVJeImLdgMcNAOIZQL+vaG2C4ruxsjcFHSHvuxlsg1CUeAlZF7C2SCipodSN3OESWPfDbCO5aOt9Jkqo=
X-Received: by 2002:a05:6214:d0a:b0:890:3f6a:fab2 with SMTP id
 6a1803df08f44-890842f028dmr262835166d6.68.1768169133725; Sun, 11 Jan 2026
 14:05:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102002735.31390-1-rostiprodev@gmail.com> <20260102002735.31390-2-rostiprodev@gmail.com>
 <20260102061626.GA2581074@coredump.intra.peff.net> <CAKU3Xk5=dmdQhTgHB8WrPbbOOo3cyJtCgFgo7juW06F9YaceRQ@mail.gmail.com>
In-Reply-To: <CAKU3Xk5=dmdQhTgHB8WrPbbOOo3cyJtCgFgo7juW06F9YaceRQ@mail.gmail.com>
From: Rostislav Krasny <rostiprodev@gmail.com>
Date: Mon, 12 Jan 2026 00:05:22 +0200
X-Gm-Features: AZwV_Qjw_DJMtMUy3mWXSW8DD0m2nW6J9J-FI_grukeJ9R4zzyGTLhfxzTebcd4
Message-ID: <CAKU3Xk5kCEDU7JZBhb6a46dZ=gEkP4neCNLMHXVB4RDnYZHG0w@mail.gmail.com>
Subject: Re: [PATCH 1/1] compat: modernize and simplify byte swapping functions
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Content-Type: text/plain; charset="UTF-8"

Hello again,

Did you decide something about this pull request? Should I improve it
and send v2?
