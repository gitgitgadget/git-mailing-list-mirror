Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD183CC1
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780637; cv=none; b=BdJcwGlT3156SOMuf2LQtt5uDPq7tC9QtsqUgjuMUck93/HSrK7iNSqXe8A7Rtjn4lTCdlGLW2x6MujlUha84ZIGY6qXzW01CcZ4IjE1NMasrZGMq9DrfJ7uiHA6Td0CK5PRSBA0bkOwDpDRIl7LpQTuTb3uyX19ZFAs8ONYYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780637; c=relaxed/simple;
	bh=8g8iw42HHkq7OOwUvpUYpznPtxeI2v+32TtTI2/aQ5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/d5+APO+BwO64UkIEQbVdH42+6f6F43Q9XevHyKRJzU239DXcMl2WHo1YOaVy6BFEDgicEs8c8h9FA+FC8LLng3VAseafA3vJv3rdUHAaJPrUwx+BfxKPfrQH/EMMyicduFmxE0ZwtgZ2o/Bp6Sr6qZQssZ7IcQ8okHI82fXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b66b64a2ffso718285a.2
        for <git@vger.kernel.org>; Wed, 27 Nov 2024 23:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732780634; x=1733385434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+0FO70kmKKh3omsc154m9zsrM7YGdLvTn4bxBVwluw=;
        b=RCruJarTnF58vT55lM/vvgCfH+BHcgTt01GMhW6rywrfUSUlVau70DF7H7ev9+4+EA
         1WQBCtLhomT5+n4By1GGeTtNOFxOh2N2BiRok+tusPloK//n5czc2Bv+7ZHcM/nZyFo3
         JETlJMnYgwjJPTXWAMnQptzrSvTFQrrF1npujND8V2HGDICTecgzp9vUz0n359KMf2PB
         fR249dWc9mw/lb2X67DisOMvp2vZvoZmE1QQZlEHZyeBo4TCymcGx+KarkLDNtQFaE28
         CWKqYI69xG1PEDOVXA55cg/HbSw2sPOO6suSuqq+vFbb7Yul//2WID1fCPMLEvaNyYhq
         BA/g==
X-Gm-Message-State: AOJu0YwUVu2V2mpYM2pODkVLa6uQ9Xmnilm7W494u6gkgir1KWnlWJd1
	XclaJ8vFQtFyyyfMs/3cDz5LgYhRZpXFFsrnvwniYuwFJierX+9a6okGcuXn0S12rDJi+pLiol3
	+IFYmupZCFY+tWnGV7nqYAOJ5dG0=
X-Gm-Gg: ASbGncsT+lf8spFzl+Qs6UEbiaM07W7L7140JwXGy7Y1qo1nl6NZBX87R4/G12iONxA
	KvjV3xI7expYVsH82FbycstzEADEa6Q==
X-Google-Smtp-Source: AGHT+IEuGIF2Ohbs6gX90mfB2TkWfxjEnWES/wQK7EGgRZf21bE/CoTF1ic7mncHYrk7vs7R905iho6XVMXppQya5X0=
X-Received: by 2002:a05:620a:408b:b0:7a9:a632:3fde with SMTP id
 af79cd13be357-7b67c448f26mr336223485a.12.1732780634573; Wed, 27 Nov 2024
 23:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1831.git.1732557520428.gitgitgadget@gmail.com>
 <pull.1831.v2.git.1732561248717.gitgitgadget@gmail.com> <79f6027b-123c-40a6-975b-1c6053b9391c@app.fastmail.com>
 <xmqq1pywvmhq.fsf_-_@gitster.g> <xmqqa5dkqjmr.fsf_-_@gitster.g>
In-Reply-To: <xmqqa5dkqjmr.fsf_-_@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Nov 2024 02:57:03 -0500
Message-ID: <CAPig+cSXGreymhni_J8TZ56rp+VZB_Z7ekaRtwFdxE3a2QWS5w@mail.gmail.com>
Subject: Re: [PATCH v2] CodingGuidelines: a handful of error message guidelines
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 7:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> It is more efficient to have something in the coding guidelines
> document to point at, when we want to review and comment on a new
> message in the codebase to make sure it "fits" in the set of
> existing messages.
>
> Let's write down established best practice we are aware of.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuideli=
nes
> @@ -689,16 +689,29 @@ Program Output
>  Error Messages
>
> - - Say what the error is first ("cannot open %s", not "%s: cannot open")
> + - Say what the error is first ("cannot open '%s'", not "%s: cannot open=
").
> +
> + - Enclose the subject of an error inside a pair of single quotes,
> +   e.g. `die(_("unable to open '%s'"), path)`.
> +
> + - Unless there is a compelling reason not to, error messages from the
> +   Porcelain command should be marked for `_("translation")`.

Here you capitalize "Porcelain" but below, "plumbing" is all lowercase.

> + - Error messages from the plumbing commands are sometimes meant for
> +   machine consumption and should not be marked for `_("translation")`
> +   to keep them 'grep'-able.

Using the same example, `_("translation")`, for both the "should be"
and "should not be" cases may very well confuse readers. (It certainly
confused me.) Perhaps mirroring the example of an item earlier in the
list would be clearer:

    - Unless there is a compelling reason not to, error messages from
      porcelain commands should be marked for translation, e.g.
      `die(_("bad revision"))`

    - Error messages from plumbing commands are sometimes meant for
      machine consumption, thus should not be marked for translation,
      e.g. `die("bad revision")`

> + - BUG("message") are for communicating the specific error to
> +   developers, and not to be translated.

Okay, although could be slightly more explicit:

    - BUG("message") is for communicating a specific failure to
      developers, not end-users, thus should not be translated.
