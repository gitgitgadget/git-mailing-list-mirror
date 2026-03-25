Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433F03A2570
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441734; cv=pass; b=ZEC8P2/irZ3lGQlyO1dR8FY7W+fQvG5mciZ2kv6AG+PR/JAGj39cFbdgk7DBgwUxZ5Gibhec3pYH8nJrFKF0Xl/gGGGBxA2I7TPmcoMdKLqv0lsMHWSt83/13IUhzUTkr0mrfm1TUYPKXPbkqYEX9fXNmW54YeaLidyogTUnpDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441734; c=relaxed/simple;
	bh=fuAsw3GV8lYFXg3FF+AuIZ9XOCXQEiyFFkr4OE256IQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjkOHGtnFwgJ1dhCnBVs+k5m8AlNWpQICBkBfutRApPWWcxMijskl85e+xX4mWZf1qI4OcwJdJupCsK8PGEnYOuAWkhwudJFExlWQK5dafIryvLxmgsJ3pDiJprBCaLyDCCUIKr725aoleZwR9y9ibl2d95YRaIQiOKQ8JpQ0jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGTEGDaK; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGTEGDaK"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79a535e7c00so35820887b3.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 05:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774441732; cv=none;
        d=google.com; s=arc-20240605;
        b=lHYyB71lKNRcGVmyJyaXkSLylcUfIjkWVVVBJSbhdQNPIK3SG2TxQg3+q+XyTlDCuu
         Iv8ACF24cSVzmZ4hlUu93zczZ97TgVnRSIJoSau7NH4mD/shXOz4d8rFd7z86j7C/DjK
         KtfoG2+3mnAizf2HsV5oJjknmCWrfGAm4UEgbASS3QAScmH8fsjmNHVIj7wd6srby4uE
         DgJxZAaqtuuYndru1y4EyMf9TXxFRxUAbuTkdo8mfvWyKHHAbfZMNuCflcb2XPlPren8
         au2n03YlMA7w8xmvjgqNhTk16gP9co9+u8hMApo0rHAfJTV6tq5C7HqgMyImp6Szxhl8
         Jixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fuAsw3GV8lYFXg3FF+AuIZ9XOCXQEiyFFkr4OE256IQ=;
        fh=tcHSeyFWSwrY6TQp/SiVMx2my4MAqsWo6eLCYHcaoH4=;
        b=W3lxW02mPJ5lSnKAnMxKfEJ6Ao/gYDwiXEdAHs5uJD7unYId3Mbp2KWv1v2AuciYah
         VYFJYjmcJ6x9OMHDUKpGI5NwhpATgl6x3rtXAGEmsbqqb3wFJsCMQV03RYBhdvruURJb
         +gcBbjJwbbxEB8Pw2vCcDfaX6UGH8Y5LTbRpVrKuSAnRjJ1j/I0QnyN35Ej3rpMA0UaY
         IKrK3gemnHEvEFHeKterAEUDmYktCaLWFKZttMipG1mFy6lC4vgjXXu0CdougLMSvcym
         SQdKJchHh2m+sUmzbuBInusxa7uxgJ4YimMRTpOqkfYu8DN5YEqT3hb/WBmBJim66SvR
         LoKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774441732; x=1775046532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuAsw3GV8lYFXg3FF+AuIZ9XOCXQEiyFFkr4OE256IQ=;
        b=IGTEGDaKTcF4ZpNszs0+yhqltGei9KLBp/4szc+tQJeW97ZUz4lXTPS2wrwnnUmcdT
         TWdyCvESaqVbdGVsfA0ME1N/566GWV9gIkRCWHTb5uiMzFHMn3DV94S+tfjtfYoKgt0R
         OAx5NJuFDsf0cEocBtw7pOjnPIhv0hDzF7LvrbzYukUFXiEW8pVz6Ii4QR04hW0+Zyz3
         sH6NVn7aHk1DHHoVCLzzsBiD2CnCCXGqDW68WNbliep0TmztGg9jHlogNrbMyN0eWbEX
         /QB/+alGfIwtPVyMwcVUnvl3zkPbTvTFUDpB+CJ/PdGFz7Mo1BldwFgDyBDBJ7xduONu
         MQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774441732; x=1775046532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuAsw3GV8lYFXg3FF+AuIZ9XOCXQEiyFFkr4OE256IQ=;
        b=YK1l4ttFp3gGCRtlMQGH6bW7lFqGjxLtH/A7CMIzPe6e/ecDLvHVJcdhJaIgymUe0y
         2TBBE1E1GERAGhnE0RsHNerGs4xMfFrggBEJtvlW7cwuSDEAdZ0ZxZu4XbVtAjlyimS8
         JGybrBi86anxpyuhzcyNdzwQ22Lj9PgOo3CRRWpIszlUyZvZU36Sfcj4z/EKVtA2YD6A
         Qrv2ZgZDx048prmNmQTzpRPG5k/W3RVBdEWQzvxUjTh/DcnhSLjBmJAMjF/9yuyr39H5
         JJGOyKVnI6PbEAaPhi1/K4quI3ATQvbKkqBiQI5WmCKziWI9OpCPk9j2dR7SLP7pFaMH
         AJlg==
X-Forwarded-Encrypted: i=1; AJvYcCUKHcw5RXUcajyE2GiIST+wHCU+zzic5e8jizhvW+IrdVlJqxb5YOeAHbrfh3/UoZ7LA3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZeBlq2Y6Fbv1NuzjtRDcoHUJjtNHneSILkGkk6xQuwHz3QcO
	vhLuPMM5tZkYshrid1kzKB/LFKn7346HSE294JDTq0g/DoS5UGKm891xOoW4kGmBnVdky01PJ6Q
	ZtTIDdJicYiK6LnrO+ElT9vouT2+RckE=
X-Gm-Gg: ATEYQzwxU9AHdHC07d18s3/vCj0wSk7Q1SrnaZS9IxdGOqgcw3goBnYT6SEmXO5zLCN
	unAsDOhIZYwGCb74rf23Ago1A3J3T9TemhBf8txgmIZII+SsImA8t0ZhnGqdHfeXybT17slBcPr
	cnunx/lqoHTxx6jFamrYAuMlSLpcrhugmL5KTcsxd2YvQWAVYC7QooLziirjWNhDalsMHpCgIeL
	uGkuUSHflzyQUmmGF09kxwvBxGbnyOpyMDBh0IfpI+WyNSLkKxLCj33/X5aLBqjSzkqXRob4dsc
	n6cXAJ/IBPyUy6oto9n1r2fwq9Gf+8UwuJxBIe6kPxqp5jWVm2Y5JChUzLOQn+Q3dm+sg9LXMEK
	j/Zon7OmnO/T3SobrQrS8x0s=
X-Received: by 2002:a05:690c:102:b0:796:6df5:485a with SMTP id
 00721157ae682-79acf67f441mr32975007b3.39.1774441732170; Wed, 25 Mar 2026
 05:28:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322195406.108280-1-pabloosabaterr@gmail.com>
 <20260323215935.74486-1-pabloosabaterr@gmail.com> <fae2f8e3-029a-43c7-aa6e-45a452026853@kdbg.org>
In-Reply-To: <fae2f8e3-029a-43c7-aa6e-45a452026853@kdbg.org>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 25 Mar 2026 13:28:36 +0100
X-Gm-Features: AQROBzB24IMC68QRR-ldl-hz-fZ8kapUizoHXEQsBSlWxATCQvRntfaur9ivYJE
Message-ID: <CAN5EUNTXy+cFyHApdrhGKUqrvBGO0bb9X-=MaAWgp4DWOAkA-A@mail.gmail.com>
Subject: Re: [GSoC PATCH v4 0/3] graph: add --graph-lane-limit option
To: Johannes Sixt <j6t@kdbg.org>
Cc: christian.couder@gmail.com, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com, 
	chandrapratap3519@gmail.com, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Johannes Sixt (<j6t@kdbg.org>) writes:

> Generally, I like the goal of this patch series. However, the way in
> which it is presented and justified can be improved substantially, IMO.
>
> It begins with the statement of what this patch series wants to achieve.
> It is "limit the width of the graph", isn't it? It is not "add
> --graph-lane-limit"; that is just a tool to achieve the goal.
>
> To help reviewers, you should present an example chart in the cover
> letter that shows the before- and after-state (with and without the user
> of the new option).

True, I'll do that. Because it seems on your last review that I didn't explain
myself correctly, the idea was to:

Without --graph-lane-limit:

| | | | | | | * commit message
| | | | | |/

With --graph-lane-limit=3:

| | | . commit message
| | | .

It truncates the lanes horizontally at the lane limit, the "." replaces
everything over the limit (n+1).

> As far as the separation into patches is concerned, I see a few
> problems. With the current separation is difficult to justify the
> patches. For example, the first patch adds prerequisites for a later
> patch, but it is unclear how these are used. The answer to the question
> "Why do we need this?" is simply "because the next patch uses them", but
> this is a very weak justification, because the next questions are "how
> are they used and why didn't you squash this into the next patch?"
>
> Let me suggest a different separation.

I'll merge 1st and 2nd patch together into a single one, adding the option
together with the actual logic that does it. This fixes what SZEDER said about
the first patch alone breaking the build.

And the documentation + tests on a separate commit.

> 1. The first patch limits the graph width with a hard-coded limit, say
> 15 lanes. It limits the graph *always*. Choose a limit that is large
> enough to pass all tests.
>
> 2. The next patch adds --graph-lane-limit and its documentation. Let it
> do its thing. Revert to the default limit value 0, i.e., unlimited.
>
> 3. Next, add additional eye-candy. I am alluding to the line that marks
> where a graph lane was truncated.
>
> (4. If more detailed document is warranted, e.g., an example chart, do
> this as a separate patch that can now show all bells and whistles that
> the earlier commits have implemented. Whether this makes sense as a
> separate step, or whether documentation grows with the earlier patches,
> is a judgement call.)
>
> As far as commit messages are concerned, always, always provide an
> answer to "Why?" for every detail.
>
> - Why do we want to limit the graph width?
> - Why is the hard-coded limit 15? (because it lets tests pass and is
> still a useful limit; we'll make it dynamic later.)
> - Why do we always limit the graph width? (Because it makes this patch
> simpler; we'll fix this later.)
> - Why does 0 mean unlimited? (Consistency with --max-parents.)
> - Why is the truncation marked with a fullstop "."? (...)

Ok, I'll make sure to answer clearly all the WHY's on the commits.


> I'll also look over the patches, but I don't do C code, so I can provide
> only superficial comments, if any.
>
> -- Hannes
>
