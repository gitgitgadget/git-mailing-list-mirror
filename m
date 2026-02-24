Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CCE263F34
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971748; cv=none; b=iBKITtr3poeiS4Z95bJEOXE33rDUzUnvULfYv/9zCon9iIbR0M57aHhkaPOxiS2jHjA1hvmrdxniuMBfJ+h6F+bIG1rAGn/oYQF7FhMjeywoXaz+RUCUk67eYmv3i7N2IWUHEUMc2/9INEF9M8TVf9PCKHRKlNdAPr0Fah5r6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971748; c=relaxed/simple;
	bh=vGLH+Vw0yueNvrIUiFsL7Z7AS8O7U/SN2wMnXdKbA24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWJmg9OTc8oO0X6lqetfNJLCTXcpKLzf9bUd9C6XVfPCpKLuVCRDtSSm9BRWY+814af3FuTlykd9i+tuBtaPCIecC4mkkv7qBQUHKO31NjV5n0B/DTgdG4xEtqeB8DRU0RYhDXE14bxJrjftOQ5STA6KY5M7zTRsWVwwITRiChY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jygAoOB8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jygAoOB8"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c70378ddaafso3486305a12.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 14:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771971747; x=1772576547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMeOFY/6Cb1F9WWBKqBCG0rxndGas9IfEmfe1aU2kBw=;
        b=jygAoOB8n0nWPWaLiz5gBDPWIiVtwZRK7rqjGJWiENRdz7Q/8BQJHobZV8On0TDz//
         aBl7jBcp4xrYgVFZLkdUiHAgI2YEthhJnAS4dHIGLo5oL/KZ3KDv4FPDRVheMpC9JZIk
         Y+0osdzVDxGlVt++pJ5xYddGXkRWQsOyuwYtYOAASM7NTrvnr1mOYoX6OHrxo87l8qbA
         elqqsWSarCEv+U+vlr+SpLd3uwBieeVVACP8nLGJroyiGAQn34GXuUz+00FrS1SLHOZ3
         B4BQ39RLdYubNIx7fninCjJOX5KDEzTgGOJDudw32s0rg9An7Sqy6iqY/D69R+gQIyLz
         I4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771971747; x=1772576547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BMeOFY/6Cb1F9WWBKqBCG0rxndGas9IfEmfe1aU2kBw=;
        b=KBViooi388SO1TdE79JD53Gp10l0T1rjwJbxcuQ8hQDx/LPOEj72HbiEU+hm+sTfRF
         //bxzXN/wmSWvV7hf2rla5tCozCeZFWhgYi5Zw9lAHKcDz8NNUe+7ob+Df/JQfpHRrGV
         oUWwouNG6NOfBU5hGP1fgUteCwTFira2fFgMQtaheEk6/mNQDD4N7ejft42UYs9UVE9U
         eSQHmTmGCsT7005nsabq5uVJ+9vifkpWGhbqHbDkdA1Z0Yw7UNmzZX4HhX+1A5A/NO0t
         nVoXlrfrkVSNtBIqoC4WWORKTYSdc8MhQHpbJLhAilx4fY0KK7oGbErKLmcPcJREZb0E
         2XhA==
X-Gm-Message-State: AOJu0YwFyzzpdwk1w70rUV6o5itFb6St4UX4n7PTXIwdwFeTEBGsIjWn
	lpCSOPJ3Z7hu0d9u2l2ogar9dNkhQaRsW6Q2sMiU2ecsW/GGymdllM7UFl99Iw==
X-Gm-Gg: ATEYQzyU/DlD3CHVxWWvdWRCIM1XSH0AT+giomp0Bu10XdkOJztUf/B+f3x6Xl9T1bK
	Dk46qUjkBJM7xjRoxFnBB/NFqp0X+r8MriB/u4ZGnHOclbfebMXTu7/D2Rj3KayF8evA12f3cla
	L3ye3twzXsF2qPUrvpOkU1/Pu7iR6dWygtL84yt33xU1xZXRLuLmsta6cQ3qtoj4hF4zYj3HQg3
	33i0Kec1t8UBQYruBp/PwFRVXOemcx+2XnRrRybJUhITTNTNhRFQk1udcGBHG93cvHhPfT7HcnQ
	Q5irj2EAr4yS4vxnydTrNNP5/j1v/S6RkFVWUXF/kSBebFGsCq4WLO0rIckzc5Y31chMDkI4laQ
	nWpk73jQi3CqD3IT81cnq562p4MHnEfbEKxPA0LjAMlwM0KMzO8emiJ9tgmPZ+Q/vPuU2QcU51W
	IiTUHaKGQ4VrJBq4EI7bQ7jafeUiderulVybFm36aqT8gWT9/zSupLZ8wB
X-Received: by 2002:a17:90b:4c4c:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-3590f135a7cmr213736a91.18.1771971746680;
        Tue, 24 Feb 2026 14:22:26 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:642:5855:f5f:3f00])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359034bb172sm739930a91.11.2026.02.24.14.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:22:26 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	gitster@pobox.com,
	philipoakley@iee.email
Subject: Re: [PATCH v2] send-email: validate charset name in 8bit encoding prompt
Date: Wed, 25 Feb 2026 03:50:36 +0530
Message-ID: <20260224222156.13712-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqqzq9er01.fsf@gitster.g>
References: <xmqqqzq9er01.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
>
> > When a non-ASCII character is detected in the body or subject of the email
> > the user is prompted with,
> >
> >   Which 8bit encoding should I declare [UTF-8]? foo
> >
> > After this the input string is validated by the regex, based on the fact
> > that the charset string will be minimum 4 characters [1]. If the string is
> > more than 4 letters the email is sent, if not then a second prompt to
> > confirm is asked to the user,
> >
> >   Are you sure you want to use <foo> [y/N]? y
> >
> > This relies on a length based regex heuristic check to validate the user
> > input, and can allow clearly invalid charset names to pass if the input is
> > greater than 4 characters.
> >
> > Add a semantic validation of the charset name using the
> > Encode::find_encoding() module of perl. If the encoding is not recognized,
> > warn the user and ask for confirmation before proceeding. After this
> > validation the lenght based validation becomes redundant and also breaks
> > flow, so change the regex of valid input to any non blank string.
> >
> > Additionally, the wording of the first prompt can confuse the user if not
> > read properly or under any default assumptions for a yes/no prompt. Change
> > the wording to make it explicitly clear to the user that the prompt needs a
> > string input, UTF-8 being the default.
> >
> > The intended flow is,
> >
> >   Declare which 8bit encoding to use [default: UTF-8]? foobar
> >   warning: 'foobar' does not appear to be a valid charset name.
> >   Are you sure you want to use <foobar> [y/N]?
> >
> > [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b
> >
> > Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> > ---
> > Changes in v2:
> >  - Added braces in if-else block.
> >
> >  git-send-email.perl   | 17 ++++++++++++++---
> >  t/t9001-send-email.sh |  2 +-
> >  2 files changed, 15 insertions(+), 4 deletions(-)
>
> Curious.  This change to t9001 was there even in the previous
> iteration that did not even work.  How did you test it?

Initially I had the braces in place, when I made the wording change to the failing
test, so all the tests passed. But just before sending the patch, I saw that the
indentation looked a bit off in the annotated git send-email, so I fixed that and
also removed what I thought were unnecessary braces, but I neglected to rerun the
tests after that. My bad.
