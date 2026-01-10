Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1827FB21
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 20:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768075476; cv=none; b=uAZ+0iVi+myIbGI8L82z8+mT+XAqiX8kY5nWLYgttrSLEsED7X/MU+5FMUxx83RhGx59MfBMaFSGXfN3vQ3eKN/WS/m7ERR4jez46VUSN2+U/t48uJjS574rGPbZPFcYIiXJlleMIJ7qak8rnc/rCl7BRkdbCZL/QSDYvrloSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768075476; c=relaxed/simple;
	bh=ckmcjBSmd0ldOvjsdx1XHwbYuwi4HbTFvoYA/AxdYq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXrlHmYULwS/PjoahCSLptIzugPm8xvIGdCEgUJRnjH64nYtL+W6UBtsU6AIvf+aOsYTmY0lim+tGtCM/5IcIOBMp2BzIYRyhEH7qHCyMnqDO5jCTg+Zn/qDMmzofk9uJZg0/GjrtQUQYZrJicdNa9NpIyWnJLRcZGpb9xqIRiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noDEPDeT; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noDEPDeT"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso34846711fa.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768075473; x=1768680273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/t3/pApIU4Chm1gkOSiJwWaprjmUMeTB+68whKRVOQ=;
        b=noDEPDeTx3VR7ru0zmU86NIO/FSKpqAlvk+Ds5ocy69geHy+cy0PbAkiQofJ9JRtpE
         2xz9eu04Q3dughpP++GTWsWgChYDrPPwLrNUKcD0bfKT64wW1+7dihMtO78AUDy/SKc4
         pxD4xH2qWrxMlWOmIUU2IXMPnZXHzXTuQvG4YJNHBObQjvIlfJPDsnN12UF4XA5CF/Lr
         rOTErTwOZJySZH7TRufYrlkRxfBP+mVuF89KcoArVg1Vrr0EhbnLPgA/Ppe/MJaqIq8+
         LPjnKeM9THOoypfvvdcW4RI/EGcWH5cUSgLY/QOn5pj6xie6hrXg6uokIltoUOlFTeRU
         xCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768075473; x=1768680273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r/t3/pApIU4Chm1gkOSiJwWaprjmUMeTB+68whKRVOQ=;
        b=Y/iFq+wuDx07h4izfjZO/UJwgZkom2xo2v804C9iDaoy/9T6HC7M0WVj7HIWM2LStn
         4mUE4HwaOdn64oXTlrst6+bBgMrOUhN1+wrzFc/dw0qNFRZbsw6dG4LLrDRPWUsmGpZy
         R7QkxWgQegOqW7wv8oqIn+uuEUMCK6b0eqy6EEHzeXzFLW7MEtKqWny6rXqkAEYPqvC+
         VffEAUYX0OXujldqcrr9JFiQd24iq+EPnz9glraKKo4SfHHyRHziFjfgq81pZ4rRbe3C
         TRso+Ju1kEfFJyUGvNFb8Bscss1c6XEhbT6ThaSA7hSObxeYu+4LBWkBdsGemvuoJGgl
         YUQg==
X-Gm-Message-State: AOJu0YzsCePKoiDy6G+3MP5mCSlmfeRzZjtuGwTIprOEfuDZE4L8GtDr
	cnB+M1hrPNF40j2EPhJMhCFbHoUwbqEdvE00h9tLcPxbVaxpP7FbEPEB
X-Gm-Gg: AY/fxX6cTg7bYuGPNvYBCdX2lZt4bw/cKHJEamwVu7ALgAiDqqwgzegUYigwdBiKstC
	7+bfCmjzra9VQuLvmVviaxHbiamBXNsKhcbeR8fvpy6rzvsf1rcTH1g16I8o/tizOm6f3PQX7r3
	KQKqFOawPeULucdvNMGyRR9z39RtOrcDNA0m3Z2yKD36rStMnA4dUVH28T5zWJ6x+5TfWblVSgJ
	bbrqLExUyDIFtZNE7nL0PA41m6V3BkrZTkBaaWDqg4WKGmKjFA5qu9CBDpe6q6EsU4icfTln/A8
	sMqZ8tRg4eKohfIcMuf81jvc8oXQV1dMu0Qo7TIO2AGg7GH0/G00Hu66GmOCsjYz5l6Xlk4yp9e
	J3KWSMg6n3wtc+ovkCYuKKML1IgfSi9+UOJj2WCoV52mghbX4W0FxyG8PQri0ubXnXj4EOHKuia
	0/uJ5VQshgu85Yn9Z3yIfSmreAuPioWJfIAb910Mmqim7/ha2GFnvhr4kq/Oakam4an9DvRhn5C
	hBfa2YKtw==
X-Google-Smtp-Source: AGHT+IENU6btieniaXzWspAn3b4GqhZnX1D4KR6yJ9jPqPJXhUqi7Rjj0NO7Jw+D/3Os0sYJLtUtqw==
X-Received: by 2002:a05:651c:1506:b0:383:1704:2211 with SMTP id 38308e7fff4ca-38317042ad4mr23805031fa.19.1768075472888;
        Sat, 10 Jan 2026 12:04:32 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382f8bb1981sm24760141fa.12.2026.01.10.12.04.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Jan 2026 12:04:32 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Re: [PATCH v17 1/2] refactor format_branch_comparison in preparation
Date: Sat, 10 Jan 2026 21:04:31 +0100
Message-Id: <20260110200431.53479-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqfr8ds7br.fsf@gitster.g>
References: <xmqqfr8ds7br.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Not at all.  Unless the contrast were "something_fetch" vs
> "something_push", that is.  And that something being cryptic "sti"
> (recall my comment on it, being the name of the function that
> returns the value, which is less understandable than using words
> that signals what the variable _means_), would not make much sense
> for the "push" direction, as "sti" is not even an abbreviation for
> the function that gives the value.  "cmp" (or "compare" for that
> matter) still has the ambiguity "compare with what and what for?",
> but at least it would be better than "sti".

Maybe simplest would be 'upstream_diff' and 'push_diff'? But this begs the
question of why not all the old 'ours', 'theirs', etc variables are missing
an 'upstream_' prefix.

I feel like this can turn into endless refactoring, latest version now has
'cmp_fetch' and 'push_cmp_fetch'.

I have on my TODO list to fix the pluralization of the "diverged" text
after this patch series has been merged. I'm also working on refactoring
this by introducing a struct to pass data to 'format_branch_comparison'.
This has the very nice benefit on natural namespacing of variables when
they become fields in struct variables like 'upstream_branch' and
'push_branch'.

In the meantime I think I will leave this patch series for now 🤗


Harald
