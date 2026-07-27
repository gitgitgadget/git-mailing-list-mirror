Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9263B9
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 05:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128648; cv=pass; b=Vf9FXe5UN/jI8hb0vJMByWLIfuUgN3pPuAt+xN8qQjClMm8eyN68nPEQ63YayIqpRAEOac1MHwIwWs0AD/X+38/QOdZaGCmAS801aiCVU2teC+qWn+OCPrnzfUYMpNv/526Hts/07KcMHwHheqUAO8ByGK7lHA2tVERVa+QpC8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128648; c=relaxed/simple;
	bh=N5rLXWrkt8rMixy7usRXhAg/zRlRR4eMjZiT9tnG1as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hud/9NXgulkMiUT7Yff1JHQx/vaiyy9LogexqYDdki9uy85rV8eHMUtRuTXeBwHpx8xEn0kJz5fKLkDv7rzDjgsQmk3weG4Zsh9tpTr5Tvb0rNvHNwUpYgpGQiFHZRY4Al1ESnpdjggtFKuRXNTCOeEvrNN3/vMgQV+8EOY2mJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGi0wMOF; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGi0wMOF"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a4c6081f9fso392925b6e.3
        for <git@vger.kernel.org>; Sun, 26 Jul 2026 22:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785128646; cv=none;
        d=google.com; s=arc-20260327;
        b=aVAg6kd6IImpCGQNYK9KjHQ3vZcpggLPqk5NjFCA+TAUW+88WyDSlRJKdJqsEmUdSu
         wyhb7sfdu7JvpXmKZhSGujfejN+pEQdpgEhSyh71MQSsLnUpJgg6kjRcISq79WkOH07U
         9+49FVbNi2N5GJFTRvVqBcBno5ZVkvcm/wCy4xgU+psdbYwlFuKwv2FtK2q5y0k7PYGa
         qq6gsLHpBCNbVTd4xAFpCzMNGdK/7gCZwVsqpomDQC0CBHf6O2oaIDbNEstD4Ee1LOmH
         Lnd0K++IhVp4TY65GE7Rs4TRZrgB6j5iz+1HCET4WpbdQedKSmJFlbA8YaU8YZgXj1dh
         BoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N5rLXWrkt8rMixy7usRXhAg/zRlRR4eMjZiT9tnG1as=;
        fh=14WwI+1R8fC5Gl/uZJcJLXlQcxWqfccFpWyCmnzn9HY=;
        b=hO24mBT8az+kP87s9RPLxDIVLlVN53hnRDdUfxtm9NoYGhCrRjTpc3a7Xr705Cwoz3
         DXEHPZch+LuPKCP6LcCK7/rXURik7y+QBY/aHIjflx1nXKtkb5+dU5XCSTuz3X5Wltdf
         SwASCYTJMeMQ2XpFn2CnqBiFxHxAY284pTVD9/6rLGoezmwKsfsHKrLdTVktX2V17LVP
         G+9DCtxDVPIh0WtbtieHmMq6Lg2b+Xw2HctGL5QYBwjaeO8/uXDqW8drkAEpLEBPPwL6
         r0xAcSJbmnrzi6rPMd/M4WBVwKgtG0XrZlCc6KT2rzL8bo6B1Cd3XE/VmyhWm0ZHacIc
         FDLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785128646; x=1785733446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N5rLXWrkt8rMixy7usRXhAg/zRlRR4eMjZiT9tnG1as=;
        b=AGi0wMOFUdkaMd5OL+ujWQCvSFwxg0u5mF/tMFq3HxM1qULn6SMA7gBNpoI5wQM7bf
         hETLBQDwi9g+S2QwDq5KgRSpO+LnNaJmTRD14SF0g8DN57ZaWFWA7eXfeSvanyTefuxe
         tdCKC8oixrvvrhVV5uem+tK8vqLmUJem9yvDs4Q0CXkg+3qgqVRugIDWlwChmtb3Gq+d
         wdQh28XaYPEIgnGIQ4I6ul31Se4Ea6MVM9kAvR+mZ0Ma+32894eGHay5jf0DUWHgKUOJ
         WqPsSCLobRY0VgdtYsBfDnqeXxya45gNLrZog5fcOk97bCPD0l1qSZZcUG122sK2onq1
         tWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785128646; x=1785733446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N5rLXWrkt8rMixy7usRXhAg/zRlRR4eMjZiT9tnG1as=;
        b=A30+9B2EPVLUkdBKSN7uLf8+ShA2FWre8ZaiWi81mjjFl8QHZC+kKiY51ZrA6BTGCe
         AkP/mmKmLrt30kQZ5hSv1y1/whs/nM+5lcUzw79YdccKAd6ihNFYSc/b0+CHc5huo2X3
         XPusgEPRBMnhy9EOPC1W0g2q7yRzbJKRulexex8MnRIvTvdrsYhtbXct3oKUGkwMsE5U
         AbrIci6BKUw3mfKAVsmQMYooLL4j2xZVYWXan7JNBzoG6qBlLj002H6jPp2depx0Kps7
         Sme5Mb+E1/g8WMyjruVzTMWmCIHVZ6JkaxJ6TCjXrtnKnCk/Gbb7tvAslJjuIobrJrnN
         vK2w==
X-Gm-Message-State: AOJu0YzuJFAbJZO4l2j/ePjjPJOUGUh33csc9vzyhGLWw28FgNOBuMU6
	swqsEuK5OWp8n20n2xD5X7OBdTTXaoxBZV+AeQq7OJoBfYJe2ywhEO/CyJvraBGJuBOgIY7zcoA
	zbOkDbMUSlabvqOvecvrvEAK12xuXlbs=
X-Gm-Gg: AR+sD10YoC5+ZeeUb45TKMCVylJ/00VJmnQ4yU4K55WfPRDEp2OJFODrG0G7tbwYIEY
	ZC3ZbE8b2lwjUR9D+UNiCQnjrHc9irG4DB2FogUtj3H9zo0qgu3v1j2pq+m18RK05ugBUGkrJ/M
	dH1VUJTcL5R2kWu8K9btz67x1l0QypjpKjzbIaV6zSUVpeGmSidaJSYvJlt20z0bdxER76RFNrT
	hOaHtTsJdzoc45RrBYuJONEjwD8uVl+Q/kB9gF5vIy8x+vtv/Bshne4LoEzG2h9TQh51U0lrDDZ
	WrXKz+wxfZA7iIpsBIQx+KOlUrx6gr3E14qpb4H0M4/yUDG+BVZMfTuCde7F7HgIm1hY63XwTdC
	WPs/k6q4GLPVlNQ==
X-Received: by 2002:a05:6808:23c3:b0:49a:1ada:53da with SMTP id
 5614622812f47-4ab6a34c23bmr7371366b6e.34.1785128646284; Sun, 26 Jul 2026
 22:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717140232.6722-1-diy2903@gmail.com> <20260721065736.8747-1-diy2903@gmail.com>
In-Reply-To: <20260721065736.8747-1-diy2903@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 26 Jul 2026 22:03:54 -0700
X-Gm-Features: AUfX_mzNsUR-iRWDeeL86YwurKFe1t14SZ7h0EB1jZVjonpfkbxL7IgIBtQKtRw
Message-ID: <CAC2QwmK7HVma7HMxmXvC7qa4XQVomteC0x7PpX61MjpDLbvDzA@mail.gmail.com>
Subject: Re: [PATCH v2] userdiff: add support for Swift
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, 
	"D . Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Eric Sunshine <sunshine@sunshineco.com>, "Scott L . Burson" <Scott@sympoiesis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 12:06=E2=80=AFAM Shlok Kulshreshtha <diy2903@gmail.=
com> wrote:
>
> Add a built-in userdiff driver for the Swift programming language so that
> diff hunk headers and word diffs work out of the box for ".swift" files.
>

I noticed other languages add a test_language_driver entry to
t/t4034-diff-words.sh with corresponding pre/post/expect
fixtures. Should we add something similar for Swift?
