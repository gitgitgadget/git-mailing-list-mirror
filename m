Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00892904
	for <git@vger.kernel.org>; Sat, 31 May 2025 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748670693; cv=none; b=BtOjtQe25EP68XzUyZhL4Tpf5xSAjkBFX6nZ4dEQZb9lLPyiatMYzBBH6dW9BTG2YTYiqUMLiGvFOU7sjOoLt6zwuSzX2toLelTmjErL+hR272iPGk5mtGFAvxzYXvIoTMePF9mfOEqefe4aoYVyJBfCBvWzhiGUdgGqAOoFo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748670693; c=relaxed/simple;
	bh=so18c5Wksi9N3tW1XNGer3bxDmvbmUu1hLtXqYXwRo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oohXZlFEqSIU4rjB7w/67/1KXFV+ICcw38MAwmevUs5Jxi+iFghUrzv9uqPYuCvbxujoYjwE3NNkQzNdw3PmG9DyM4UJhuEY9VWQU3/vZl/2NP/IVRCe7sDkmpYSpEB/jyAchj4eT+WC4ARzKHZcNETSFA4ttNPrjkprp17+R5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bks8CNhl; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bks8CNhl"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-530807a8691so562147e0c.0
        for <git@vger.kernel.org>; Fri, 30 May 2025 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748670691; x=1749275491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=so18c5Wksi9N3tW1XNGer3bxDmvbmUu1hLtXqYXwRo4=;
        b=Bks8CNhlIZ5hYPC3FzsoF3nF7A+CFFMfeDfmt6chq4gBCfk3Ykl9yoTylLb9uXtoZY
         qjjG+KHoc6Qd1mg0+lWLWwcGudYW9VUdRrPPRWmD+jx30yEjJb2pHQ/FK8Y1lHA+83bJ
         vVYOOzRRitpLttKMIjk9oCrKeet3mFivz4GoYRpCENvPhA1rgE51uAehGJ9SZ3hDHMUe
         9yPNa8TOlwDYSMudSqPDzcL7o97ZgbeOoz8PNfIosQF/ashRkiokNvICCMkzi+kSCm5J
         lPr8xOtKF8yuKv+ZTC2BxuoP/CCHni/Ee5hnYUi2gSv/WIqVD6wbRzPaJFFt4/dFUMCA
         twQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748670691; x=1749275491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=so18c5Wksi9N3tW1XNGer3bxDmvbmUu1hLtXqYXwRo4=;
        b=Fj7vjty20Dibl7UWjuVBxff560XLuSBnGBtAaz6ynDpuRIDmm4+eB197RabFkf/nQU
         PfGNQkiHlNkhtI1/KUAi8QwXDY7tamsXLrZiQBnI00Z3tAN4Yg7cSVNAUr/A5B54tYxu
         IaNyqqyuCRwAnVIvN/Z2tTuiVc1hVZVIE4c4RaWPV3bqfsQc4U1skdLoVm3Ghm3CJnA0
         K/eGl3IpsXd6wGDWsn8iu1p+LUXu9cEAfkYsCyUi/txFWQ1APV9FXSxzCci12LRsYLdn
         qxsoHXVonv+89FyB1FUw/3oEHkoiwgNngp8yxKOqAWcfSclkFH9Kqcuhtj+GKGo5O2DF
         XPPA==
X-Gm-Message-State: AOJu0Yym3rP9jH17wyTErcQtCVTr1iIA6AvZYMeyUy9O4wKhEJWhXeU6
	606Hb1157JiNQq8diRO/xz45rH6VeFdKPv7QF3pDqslHP+t3Brn1Jlsd7JKC1FK8BXFZaZSXojJ
	HEw21LHYxfy8ExBt8OVWZ8kUm3u46H+w=
X-Gm-Gg: ASbGnctZ9X/DJKYBn8h7MeoGy7r+3+xtZa6E3RWDVRxKw/oQq8IRh3RVo2FMVUNRPyI
	qowOJ1j9iFJp8tLGceFZbcK+mNmnlGIrth/l2Rts03sGBy+QjknvjpNSaFvdAgjfjVylIlEigkV
	p0cea7TWYTK3ECEu8qbnXKIXlzf9CH6BHWTocssqtPwArb7u8PKMK8eX7M9xzaegO8tSssWuwgx
	Q==
X-Google-Smtp-Source: AGHT+IE3e2WjWLQwJFAJSV74sLc1lCoegfyPx+W1HnGlnYY9hpMHsLyaD/vReuVAqX4L63++AAH687eZd7wU+sMZUqg=
X-Received: by 2002:a05:6122:2a0a:b0:530:727f:a7b7 with SMTP id
 71dfb90a1353d-530937f61abmr490975e0c.11.1748670690737; Fri, 30 May 2025
 22:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOWMAxwQacT=PcPrWiuEJzSH24ELDBxq2XMNX1X75KSp6cS6jw@mail.gmail.com>
 <CAPx1GvdqVpmw2mjbSDyVqBii4y=_DpTpa3jXM4_1tg5h5BWF4w@mail.gmail.com>
In-Reply-To: <CAPx1GvdqVpmw2mjbSDyVqBii4y=_DpTpa3jXM4_1tg5h5BWF4w@mail.gmail.com>
From: Jarrad Whitaker <jarrad.whitaker@gmail.com>
Date: Sat, 31 May 2025 15:51:18 +1000
X-Gm-Features: AX0GCFsn1-YxLT4E0Ow1mKIrazdkH2LMwgUZP61rMu3w4GY46uQMF6XLURdn_XY
Message-ID: <CAOWMAxwqQepzcGpuocLA+d2=+AAdLYDOswsNr3w8xaO9zZFqqQ@mail.gmail.com>
Subject: Re: Feature request - optionally include merge conflicts in `git add -p`
To: Chris Torek <chris.torek@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As a thought experiment, what would happen if the first invoked stage
operation of `add -p` nuked the stage-1/2/3 versions? Would this work?
The file would be recorded as no longer conflicting, is that too
footgunny?

Apologies for the double-send and top-posting, Chris; I responded from
my phone's gmail without thinking.

Jarrad
