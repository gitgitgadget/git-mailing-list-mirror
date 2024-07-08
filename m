Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9D1E487
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720443708; cv=none; b=OL+gyi1z/EUUyWUIKed8HEMvD6b9S56ArbOjrHiGuc9BUXnJnjKmooj9IAxtquqk4Pn8f6JQ5O1VaBFXebBzZkEZ3+k0uLHUu9PvFZCmArdbziIKA2YCH6EiL7BHHAJ1b156tm0+2V+eyB0Sm1fAaf80dqbmWxs2oiZl//pFiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720443708; c=relaxed/simple;
	bh=7OLA8QoL2zHukNlXdj58vEkYtGJZXIX27BAh2hKEbIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dY9otPHFXsEBcWVT7d6VzzwGdYXcrio+xv1l4S3ouWLOK/9g1KioMtNKJoUpPMmyn9UDyus/7Ge3TQwmKN7jbQCP+a60V7xky8lWA9T74QmQzG/o5EeoOOxLRTZU4xjIgJj0IfSkdvmo4tlOGOoXPRULNokPF3PXViDv45llXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm+5yktI; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm+5yktI"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d9318a005eso357083b6e.1
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 06:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720443706; x=1721048506; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7OLA8QoL2zHukNlXdj58vEkYtGJZXIX27BAh2hKEbIY=;
        b=gm+5yktIugH+9XzzMoFC1W1P8hh0h+HiTn/dfHuX1H5/4R9rzwOWd9sjHi0f/kgRcI
         6l2ML4F9vXBkCBh888u8a/Rziqh/KoGnSZrjsGB4JsbGXsRnf1egmrmt5B4qjyBLjy9p
         5gjtMcLRAEFpxP1qqtz/dYc+HVnbxTVojGceMN+guJSqCXifwwT0Hf4zs0jRv0I08rZs
         5ZRy7qlUbfyKPmVlYgM4NzlHED48Spsdqe5MzDsvdy5PeIcN5hsl2vPo0RuZPGbO4dr+
         e7THKMi7/uESTNQnz1pwPpEjW0U+lNg/xVM/xMgHPPgXDSg6k4wY6DpzZoJvave/Hfju
         mJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720443706; x=1721048506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7OLA8QoL2zHukNlXdj58vEkYtGJZXIX27BAh2hKEbIY=;
        b=KKcZFHvyd1pZIYIg4NfJZ3T7dfzuc1VSxiaMEERp/d/vBtGtO5VahbTT5pN2MLAzOG
         jTzhF5edKgCQCU0TUMwUffXLg1QtSnWMujcRlB+5dSNnw3treOle+SERnJDmegzWF2Z7
         HL9eMoh1mMNG9PrPII+RwMrn1z+AgXiQRkqzA7BqvvMP8gTz+dTZSllrfaveiiACNGJ9
         rvu0LsYOxz1l1E7olRZyu2CyGS0ge8J05WFS164ZXSfUGrZqQ8O4DegQS8qMRasSJyJL
         bE3l8OjLN/B1u2nYjKUObVMJteNctpqJ6y2gQffnAoJbZ5j3I3HOmg8rRGTb/WZwq5XE
         hYzg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ2DmN0jQsw5+nlriOMkr36CWsURnn01f6GGzBBuTVnANbBxrRyqUszBCHEXS+O75Gimzbuai+pozzuN1y5MAGikYw
X-Gm-Message-State: AOJu0Yx6gdJHsRyg+d2mQCRE6KrVkDxk8YnglEjlySSNBy18Fusfa2RB
	abj7qd5pha6NlHyw+YVZCqFHSW/KBjG3zFN7UXsaVTPWi2XxojB+4xCnHjNZniVEDVp/EKnng5g
	ZpkKX3V3weliJoeWbUxo7i4+en1g=
X-Google-Smtp-Source: AGHT+IHrUQTJb7jpdd9N57D5IzdNpeiw8DepdYa79cIoCzGSwp6warddiwDxJAZnHjJR5l3opPhitQ7Z4+sKSfUrKr4=
X-Received: by 2002:a05:6808:3196:b0:3d9:2b54:7d44 with SMTP id
 5614622812f47-3d92b547e87mr6628800b6e.19.1720443705564; Mon, 08 Jul 2024
 06:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1757.v3.git.1720318768439.gitgitgadget@gmail.com>
 <pull.1757.v4.git.1720319311301.gitgitgadget@gmail.com> <20240708085232.GA819836@coredump.intra.peff.net>
In-Reply-To: <20240708085232.GA819836@coredump.intra.peff.net>
From: rikita ishikawa <lagrange.resolvent@gmail.com>
Date: Mon, 8 Jul 2024 22:01:33 +0900
Message-ID: <CAKPZ46d6Fv+=8f931Qrbec2-5rnGBDbZm1AhKhh78E31em71jA@mail.gmail.com>
Subject: Re: [PATCH v4] doc: fix the max number of git show-branches shown
To: Jeff King <peff@peff.net>
Cc: Rikita Ishikawa via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the feedback.
I will fix it.
