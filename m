Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC412F38B
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723850558; cv=none; b=CtuOKWbmQVYgCTokuIP4PUqc5yOOEwfZzSOmed+pEgrX3IiwOWOouteFUP9gPVlybjzo7B6vPWZaq6jGYWRGXEhm1hj0Ndob97ZlVjEzxzFWMEeuOyJ7JSixEAuqBBd/cNtfOSze5wMqWGlK067F3U9uwEQ6yfMNp2fegSgdlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723850558; c=relaxed/simple;
	bh=F5dlgyaWeqnpBtyxISVJRlWlZt8+487rNhATlMZ+97g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ4owawkDS3eT3cjCGAZc9DrtWAE2J3BX+NeflCwMitriIXfgIsIsOE0/iY4vNTESu51+uLniqT/YSL0Nqam+SNQMM+7g91mRr1DgguMt7HECPPpqoQO7te0Qafcrh44joEmcKRFaStBjf8yL+rQ3Su+FQ/xYe/lgn+BFKbC8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6bf7b48d2feso9007136d6.0
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 16:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723850555; x=1724455355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buhxi2L41pCcJvaAEMN6tub5wTPFKrHx1ABFyANrDL0=;
        b=fKc9dxR4YgXDm0KcUEv+vTm+oTJtIDQxbhmSyU3HivBiN+kdrTkJz7TLlCc6/hZc00
         fRbcnnxKcW282vXbhIAlufwLJAdS6NRsBT5jYl3nMGiUvMMX5nN9j+tC6jmpPADvTLT3
         iyJet7nJvjouvddJEmj395bUFtQW/8CLaOcnhEK2ddnWS3Kto7O0aRUcdy3uClE05LDU
         sO6nKKExeDX5ecdNN+tkzZZHc3kARXtnzLl495YpHae1tzs/qdsyzUaTEogunbmaE7/M
         xsuhYj+j76bOsinkdzwfBVfGtahlSAZKUvt6gfArGeBJHahcgzcoGb13fp29n+IWjVNs
         QEaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpw+/mOD5Ey9X513ayp+aDP309yqvTJxHdJTkK5OmXAVZMZKF/wYnd+YhvseeHy3cNf9V98zAfI/oPxhFAFpWCKGD5
X-Gm-Message-State: AOJu0YwgrRubEfcujQNtGKXfBsw2dlAVLmsyqmjHbGW1Jfyi2Y1YiNuD
	1Qaj85DPSh8Tq8w/r+4NqUCqVaet9os1023V8tfQinI0d2T6y21ly2M4xPglxyCXvZkojA/Nf0A
	cuhz4UcsTCubAlMD/XaQw3YmBwiw=
X-Google-Smtp-Source: AGHT+IHkwNuhu2yYfaiDPGJKRyAPiR0PmA/hR1HtJU16gx+LV+t/FPtCEIAC6f0phJ03ctUxybeD60uUVDfK23YV4kE=
X-Received: by 2002:a05:6214:5542:b0:6bf:7474:348f with SMTP id
 6a1803df08f44-6bf7cdc524amr61457616d6.21.1723850554697; Fri, 16 Aug 2024
 16:22:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-jk-send-email-mailmap-support-v1-0-68ca5b4a6078@gmail.com>
 <20240816-jk-send-email-mailmap-support-v1-1-68ca5b4a6078@gmail.com>
In-Reply-To: <20240816-jk-send-email-mailmap-support-v1-1-68ca5b4a6078@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 16 Aug 2024 19:22:24 -0400
Message-ID: <CAPig+cSN-KU-TQ5UBR9KfxjmQ4zzjL-Y-anxDe9FaeqsV=1Xww@mail.gmail.com>
Subject: Re: [PATCH 1/2] check-mailmap: add --no-brackets mode
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:06=E2=80=AFPM Jacob Keller <jacob.e.keller@intel.=
com> wrote:
> The git check-mailmap command can be used to convert identities to their
> canonical real name and email address. Currently, if a simple email
> address is provided without surrounding angle brackets, git
> check-mailmap will fail:
>
>   $ git check-mailmap test@example.com
>   fatal: unable to parse contact: test@example.com
>
> This is generally fine since identifies are expected to be of the form

s/identifies/identities/

> "name <email@domain>". However, requiring brackets around simple email
> addresses can make it difficult to support mailmap operation in other
> environments where angle brackets may be missing.
>
> Specifically, attempting to support the mailmap within git send-email is
> tricky, since angle brackets are not always provided for addresses.
>
> Teach check-mailmap a new '--no-brackets' mode. In this mode, any
> contact line which cannot be interpreted by split_ident_line is treated
> as a simple address without a name. In addition, when any contact does
> not have a name, output the mail address without the angle brackets.
> Note that angle brackets are accepted if they are present, however the
> output will strip them.

What is not explained by the commit message is why we need this new
option as opposed to merely making git-check-mailmap accept such
addresses by default. Are there difficulties or downsides to making
this the default behavior? Do other things break if this new behavior
becomes the default as opposed to being an explicit opt-in?

> This mode will be useful for git send-email in a following feature
> implementation to enable mapping any email addresses to their canonical
> value.

I'm a bit skeptical about how this new flag also changes the output
format to suppress the angle brackets. It seems like that's something
the caller could do easily enough if desired. For instance:

    $addr =3D~ s/^<(.*)>$/\1/;

Or, is there some deeper reason for doing this?

> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
