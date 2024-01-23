Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B45FB8C
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022661; cv=none; b=fbSFys6P99WtiBg7EZUYwJ7mH9Mom4HtAOkxP7O7EoUNYS7i3aMu+xE0nyzJ9wJM5vPWqCGGXMon0rddWLFhPOrpJ7NYMcj2K4PXgGxNwTSauCDY61j/pp0xWd6dddS7UxkT0q8uAlb7QFPNgR2UK0UAbTbTmoHwXTXRR4Q+fk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022661; c=relaxed/simple;
	bh=7KzfCnNemCRE+NE/uGFYwnjPuIYDDkxJ+57xDoEWpgs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UlmdkGRvo5SxQaz/ueFMG1bDi0LF3v8k6fCId5WANHm5K7PGJGfEgBGODQy1cEi6gYIwuX9fCclXGG4eUb4adapkQKH1WeLpYR2b/vYrmUS641/eCabT5SDGvqwHQLGNnlsFWsv0uN/P8ntfm44WE2Li0JQg6F7CPJqbUa5PXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fexIHTW/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fexIHTW/"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cc9fa5e8e1so47508621fa.3
        for <git@vger.kernel.org>; Tue, 23 Jan 2024 07:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706022657; x=1706627457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+ep7nxGK05LjJUtr24YmOpO3zsVpi5/peYoRULSu2A=;
        b=fexIHTW/FCesgzbyCGGbiNgpigMvneDWZOcvDDKgYBAq9P8ZPll+tSj80N9dfSIzMt
         YwZ6FQ4RTvM1/MfRUUjpzeew7ErP1zq1eB1uvP5eIpOmWdYSnj09b0E0DVA/XYLM8wyf
         /PBAcyLldqFLGhj7tpPNZmpWqE5yM3B5omWHH+jZlPcGKv6Tr8jwspiJiJYS3I6Ow2if
         DFNiXClGVNf96tIghfOpFhXRChokkcTxWOUy51J8yo1JRdgnBEcpd6QVLzsKU4tfzhWZ
         arbdCo0ZLPCpQLLBZAfs9KL8nR3fjXYeSRY30FPwS1YpBebHN5ubJ5B1P9IqJyaOtrYc
         kI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022657; x=1706627457;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+ep7nxGK05LjJUtr24YmOpO3zsVpi5/peYoRULSu2A=;
        b=D6/slkOSNJUVaBXVG/8bpnZ2JTgvN9sABXvgCw/hGdJbEmuEYbxXZb9Z7GMJ6LVX0W
         MgQkeIyWgZRYEH1ishYL6VxIZGplJyfRnAyhWwAsmFvtEs16v0/LZzN/CKftp6RHxbVU
         AizkfuX8UNqSCjCiF/9/CF9+aLA6SuLSKBdjQu4D2IVjZcfH0q17/YOm279tlgj9gc3A
         0GxJZlkLisT9N1VMRSdzdrQEB8WMNJnj55FgWGXP1ceTp3IN8G3TfCjXNHE7GGD8Q9lP
         z7ajSuEFUSibHH8Iho/vwfR2W7T5lTQ0QmP5KXX9Fkb/11wfYmB9lQBQbqjgT/qV4ICy
         5qwg==
X-Gm-Message-State: AOJu0YzQ3Pk90+CdbKptgXXCuXprxkDL2sy3vUOKCvCCZR/qx60qnx8h
	NGH2AeG5wdpmKIy2dFhU3tsc442R/Ug9E+rZm8lSDYEH7mqR0qhwlV2y73Y6
X-Google-Smtp-Source: AGHT+IGvWeW+aUHs2J5KZXhI6IcJfVevVj8fswg7Z4nlQRtRvTx2xhzPaOZpBIaFTZaOkzZytzj9Ug==
X-Received: by 2002:a05:651c:10af:b0:2cc:e976:5915 with SMTP id k15-20020a05651c10af00b002cce9765915mr2445949ljn.49.1706022657145;
        Tue, 23 Jan 2024 07:10:57 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y19-20020a2e9d53000000b002cd054fbb34sm3713159ljj.9.2024.01.23.07.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:10:56 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Elijah Newren <newren@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org
Subject: Re: what should "git clean -n -f [-d] [-x] <pattern>" do?
References: <xmqq34v6gswv.fsf@gitster.g>
	<CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
Date: Tue, 23 Jan 2024 18:10:55 +0300
In-Reply-To: <CABPp-BHUVLS4vB5maZzU5gS33ve6LkKgij+rc1bBZges6Xej-g@mail.gmail.com>
	(Elijah Newren's message of "Thu, 18 Jan 2024 18:07:17 -0800")
Message-ID: <87a5ow9jb4.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> On Tue, Jan 9, 2024 at 12:21 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I think the current code makes "-n" take precedence, and ignores
>> "-f".
>
> :-(
>
>>  Shouldn't it either
>>
>>  (1) error out with "-n and -f cannot be used together", or
>>  (2) let "-n" and "-f" follow the usual "last one wins" rule?
>
> I believe so.

Then how does one figure what "git clean -f -f" will do without actually
doing it?

Please notice that -f -f is special according to the manual:

  "Git will refuse to modify untracked nested git repositories
   (directories with a .git subdirectory) unless a second -f is given."

I looks like neither (0), nor (1) nor (2) gives us any useful behavior
in this case.

I figure the best solution is to rather make -n orthogonal to -f, that
will solve the puzzle, and that is what actually expected from a "dry
run" option: don't change any behavior, except print actions instead of
performing them.

-- Sergey Organov
