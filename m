Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A91EDC
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459649; cv=none; b=qKbzVCt5yYw7GRFLBniSopAot6czj5JI2PKuTwsItdyP1RDSI9JbQuumC6BZX3Czn7Xdg2IAHxd58i6rDkOy7f+XsNw/gHCDik0jvtF5PTtMP/HCUUu7U4XYea41Rl+Mt5O2sUhUSklMbweuSmK2aZAsEgdJ18y+GbpJc3jtkGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459649; c=relaxed/simple;
	bh=aYVQXCWw8cG2ZVsddd4QiC+KH1TINJNVPmiBemuMrHs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=P+Pqg4Jmjmbbb3kzXHlxRnOaNynkyBZ3ky+q5kxfcvZlFOnAARCOZNDSvDI16icC5wJVShfsHpwMYNcB9yz0YSYB8T/t8WQt8+DshYKjfr0SR33A6p6ES95epS4fmm66wySAwtiMdO3ZxASzaSk94N7H6gmSHlJU0Bkwf21oTGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqqANn9L; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqqANn9L"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d220e39907so51373641fa.1
        for <git@vger.kernel.org>; Sun, 03 Mar 2024 01:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709459645; x=1710064445; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYVQXCWw8cG2ZVsddd4QiC+KH1TINJNVPmiBemuMrHs=;
        b=CqqANn9LVkzvIEOaO7KotM8qmM5ioWDRCPU/xef3eZdZxxRQa9xPH1vRKjR4eCQOp3
         NERaYuzfaYmXbMZs7Fram9wtRNTW3D8xPIthz3DXK8c1PVV44cA4HXv9UwnonSbt6TDN
         LfmrTMSVAxMzKK8cHEAiiSxszl3QTWORSea2dPj8q2IpliF11LDR1rFY01fM1QOc3m1B
         UaY4Vye7pxBH7uTUmJFsPH4m++Unz8AgXLBbkiprZuiI8eloXGWHvYBvbTfKUzc7LoLe
         UqOvVYWcXlaHlFSUxtzniBdJQKhzQJ+x57xVM9i6C/2Qbz0wmeF+E3VFqUO71cXuX7VO
         NDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709459645; x=1710064445;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYVQXCWw8cG2ZVsddd4QiC+KH1TINJNVPmiBemuMrHs=;
        b=UHZZ63HQ+YOjTzX99M9Gt9K7QxeEOqVNy+ieebHMO7TRSDJmjIyYjfToJDwZ0e7On9
         SaWZUqXmUYT7KSwKCsgzHkyUZ/z3fHBJFit7q/Vydr4AQbb1mxa/4Z+X0ZFFeIXxR3vG
         RXao3gjxrSkkKfr+vGlt32wYhioavV5H0VdDRry+iUkw02kvmrJef2KEQ8XwYGVesfEH
         BEEtdcdG6zVXU28NyimLw6MveDpKsA1QzAbfV9nUyuiwhreF/g/QTCnL+7uI56AeTFw4
         2XkQFKCYefnrwYYSdE9wqFcRQmkweXH/C1IgsQig/iIpcuwd7OfbQFkcQUye0peGJ+Pg
         f6yA==
X-Forwarded-Encrypted: i=1; AJvYcCV2zbXWxwTqcH8apEEv27tWcoCil32CNB1oDxRXsj3v3v7QRZzaUzApOEeVgoeu/jwGmgz+vTqZaxC3EcwuHqZAsOIH
X-Gm-Message-State: AOJu0Yxr3NRuhJjLuy10BUi/nDax3DE2RtyMp8y8tjOkd9ZU0RHeXF+W
	QOEyAJrWwn2k20YK0IhRDOZ5L6sCzWmjU0aYy/zRSZW6g+Cv3fe6R7aRHzjaWBA=
X-Google-Smtp-Source: AGHT+IHaf7KdsAyM74tKsahGGfdtk+HEGGsBJQVzvskLtHPMbpDaZfV6n4q3diMvtSNmpZqyiCNj+A==
X-Received: by 2002:a05:651c:2128:b0:2d3:acd0:bb0e with SMTP id a40-20020a05651c212800b002d3acd0bb0emr570798ljq.43.1709459645242;
        Sun, 03 Mar 2024 01:54:05 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id d6-20020a2e8906000000b002d250e323edsm1282825lji.89.2024.03.03.01.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 01:54:04 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<87frxam35f.fsf@osv.gnss.ru> <6033073.lOV4Wx5bFT@cayenne>
	<87r0gs8kgw.fsf@osv.gnss.ru> <xmqqwmqkwdef.fsf@gitster.g>
	<87bk7w8aae.fsf@osv.gnss.ru>
Date: Sun, 03 Mar 2024 12:54:04 +0300
In-Reply-To: <87bk7w8aae.fsf@osv.gnss.ru> (Sergey Organov's message of "Sun,
	03 Mar 2024 02:48:57 +0300")
Message-ID: <87h6hniqtf.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>>> Oh, sorry, I misinterpreted the patch. But yet, I'm not sure that
>>>> specifying that this is the default or not is really useful. If the
>>>> configuration was set to true, it is was a no-op. If set to false, no
>>>> message will appear.
>>>
>>> I'm not sure either, and as it's not the topic of this particular patch,
>>> I'd like to delegate the decision on the issue.
>>
>> It is very much spot on the topic of simplifying and clarifying the
>> code to unify these remaining two messages into a single one.
>
> I'm inclined to be more against merging than for it, as for me it'd be
> confusing to be told that a configuration variable is set to true when I
> didn't set it, nor there is any way to figure where it is set, because
> in fact it isn't, and it's rather the default that is in use.
>
> Overall, to me the messages are fine as they are (except -n that doesn't
> belong there), I don't see compelling reason to hide information from
> the user, and thus I won't propose patch that gets rid of one of them.

Nevertheless, as others are in favor of unification, I've merged these
two messages in the v2 version of the patch, which see.

Thanks,
-- Sergey Organov
