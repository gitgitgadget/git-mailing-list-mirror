Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F9D7B3C9
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583557; cv=none; b=At2GkZ8rIeC2UPZ8/qV4RqJkbnndH8+ZBg6FfG0NT3Bm+O0wiRa2TKif6Hkvoam4hVKSI3QpofiIEoVV1syEvxEEGzV1VLrV8f8qk23AJihl/bapQXfUV3cuI44nreqE7LnmyEUKUDEJ8882TXz1Qu87chNlYVk8y7MEGRI2BAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583557; c=relaxed/simple;
	bh=cuau7twB5f5twI1urSHdw/V0MCfzlaJ1mrBL4MwxjA8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DtkM85Uj6k+xSCed5Q/oCX1vgythhsM78SxG6ouqPEJTSAZPqnUladtDOGtICl82yEn+/5In+QwUywVPZDrI00rgLEDakXa5wIcdi7VkGxw0sIYCOBX2DKAqsJXjivCZ5yD8kg/WAZiibCkoPYqr03cPRPDCXL6IJrDM1SB454s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE29jBmI; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE29jBmI"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513173e8191so6011940e87.1
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 12:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709583554; x=1710188354; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BkQ16cQjfpVB1gtoLO/w0QHbHt5a76x18zxF3FMJXlQ=;
        b=SE29jBmIUCW9uJPy3qShvp7JkXJgKMrp4L4OkU9CQrrFhy62abgSM6/JvwkX11dM23
         ojUg5kbvrCDuNR7pBy8j0rzaHOf9I8fIuEfQ0H9XUqZ+Wlymr7kQmdpOKJHYdRCRgcRB
         uOPCZAoCcrdzKj7IRkeo22qCz2wu7S4MB69D6aZZdeFNxMtUDrx38MFGrAtn/xUILMuh
         oFUkC70Gn1aMXsmeZI1zcjPU98HAGiA0YXjoVhLJZ+XmwR7spWmm/e8Lmk9zouchFQU0
         DYkJF/wEKuSo5OfYag/F8pLtrkIzxrE+g9Prwj71loacTwcAXGX/jlEGbWQki4UHH+JL
         3RCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709583554; x=1710188354;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkQ16cQjfpVB1gtoLO/w0QHbHt5a76x18zxF3FMJXlQ=;
        b=enXCsjIR9+J/QPu+f3TRbmRZeEOG/YGGhgTe7hC3aABfp/1MbsSX5G507Q583QdfME
         mL83rXj2EWh5Oaj5yKvuhcij5UeT+KInqsUeyzicIpu/IAcyzFp7dsKcsxwLqPkBYJfS
         2CpQBVVmxgXzwvbVSZFyjIAb57O1X26/VU+j5mebXdwivRzoQi07vuQk/uhdwEb0Ugeg
         p1LFQ99sKHSb+vnnVQtL1GwOIHAmPTo3FXwNnv45+ulVFGFccdXe74wSgxos1hr8spFX
         W5XI1NYc++wR5v+6XBl+I4TY08Lt9wz0dmljUvR/0YNvJMFYIVlP4Fjg3rtQ06YdgrVl
         Ke9Q==
X-Gm-Message-State: AOJu0Yx590B+N2xkvXHWgOrsfDR5jE73I/Fb4ieZHtbnEHNzK/RnHiZy
	hjqK81ZJaQzrEjHWo23awok1i8clhQQt/e0nt+VLgDlrxHXWoXfQ
X-Google-Smtp-Source: AGHT+IHpJsi0eYbrhdjH62H2Z/qPYctNuklddHdMBcdSq6uBl25oBzPi9Z9L8OhPK+7/a9D5bdHkwA==
X-Received: by 2002:a05:6512:3b8a:b0:512:b915:606a with SMTP id g10-20020a0565123b8a00b00512b915606amr9694012lfv.12.1709583553755;
        Mon, 04 Mar 2024 12:19:13 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 12-20020ac2482c000000b0051323dc3554sm1832088lft.234.2024.03.04.12.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 12:19:13 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <avila.jn@gmail.com>,  "Kristoffer
 Haugsbakk" <code@khaugsbakk.name>
Subject: Re: [PATCH v2] clean: improve -n and -f implementation and
 documentation
References: <7le6ziqzb.fsf_-_@osv.gnss.ru>
	<20240303220600.2491792-1-gitster@pobox.com>
	<87h6hl96z7.fsf@osv.gnss.ru> <xmqqo7btom4u.fsf@gitster.g>
Date: Mon, 04 Mar 2024 23:19:12 +0300
In-Reply-To: <xmqqo7btom4u.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	04 Mar 2024 11:03:13 -0800")
Message-ID: <87sf157nsv.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> The reason for the behaviour can be explained this way:
>>>
>>>  * "git clean" (with neither -i nor -n.  The user wants the default
>>>    mode that has no built-in protection will be stopped without -f.
>>>
>>>  * "git clean -n".  The user wants the dry-run mode that has its own
>>>    protection, i.e. being always no-op to the files, so there is no
>>>    need to fail here for the lack of "-f".
>>>
>>>  * "git clean --interactive".  The user wants the interactive mode
>>>    that has its own protection, i.e. giving the end-user a chance to
>>>    say "oh, I didn't mean to remove these files, 'q'uit from this
>>>    mistake", so there is no need to fail here for the lack of "-f".
>>
>> Well, if we remove -i from error message as well, then yes, this makes
>> sense.
>> ...
>> I then suggest to consider to remove mention of -i from
>> clean.requireForce description as well.
>
> The follow-up patch you just reviewed in the other thread does
> exactly that.

Yeah, the follow-up patch somehow didn't thread correctly with original
discussion, so I've noticed it only after I wrote the above, and the
patch is fine indeed.

>
> This is a tangent, but before finalizing the version that complains
> "clean.requireForce is in effect and you did not give me -f" without
> mentioning "-i" or "-n", I asked gemini.google.com to proofread the
> patch and and one of its suggestion was to use this:
>
>     "clean.requireForce is true.  Use -f to override, or consider
>     using -n (dry-run) or -i (interactive) for a safer workflow."
>
> as a possibly cleaner message.  It is the opposite of what both of
> us concluded to be good in this exchange, but in some sense, it does
> sound more helpful to end users, which I somehow found amusing.

The added advice looks fine to me, as it explicitly separates -f from
the other ways of using "git clean". However, starting phrase with
"clean.requireForce is true" sounds strange. I'd rather say:

   "Refusing to remove files: use -f to force removal. Alternatively,
   consider using -n (dry-run) or -i (interactive) for a safer workflow.
   Set clean.requireForce to false to get rid of this message"

Here we first state what has happened, and then mention solutions in
most-probable-first order.

However, if I were gemini, I'd probably start from noticing that no
error message is required at all unless there is something to delete in
the first place. I.e., the error should probably occur not here, but
rather at every attempt to delete, and then explanation should be given
later, e.g.:

  Refusing to remove FILE1
  Refusing to remove FILE2

  No files were removed: use -f to force removal. Alternatively,
  consider using -n (dry-run) or -i (interactive) for a safer workflow.

  Set clean.requireForce to false to disable this protection.

With this, user effectively gets functionality similar to "git clean -n"
by default.

Just saying.

Thanks,
-- Sergey Organov
