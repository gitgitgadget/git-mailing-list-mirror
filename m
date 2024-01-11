Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8E3B198
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Gx/DppoY"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5edfcba97e3so62652407b3.2
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1705009324; x=1705614124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r25Xi4jzPqV2S685OJZJrKBi1H5dxPZ5oQtUpglXM78=;
        b=Gx/DppoYQDpqY/fvrxMjbcs5DS02hdpjqZICNREgaJuKyNDoAg93/WsC6joWcAyskN
         9B0xHlLkzno9S1OS+FuyOIrLcYpLNwaPxm6H1ZT+lUN5EP2e49HEtkTPWcPOpCCPikLG
         6S1oKFVJDtC/9IKXWlqxR9v9/ZRldO4pdVggwYLKEYmyI87k0BCpZ8u8LQlKLik18Djp
         ktPxfJbAiKJOk1TYuQxRreg9N5lyBwvZ20skNzYZdDodXaqbipTz9f+UEZPM8df7QdlP
         1CXokROjwKLaa7FhgEL54iMfwj5QXuxflTQxbKjELfM8vzC9QiBwwoaxuC/XYcE9AXh8
         eKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705009324; x=1705614124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r25Xi4jzPqV2S685OJZJrKBi1H5dxPZ5oQtUpglXM78=;
        b=bJwlPcK5m0QOOV3spBRtj7e44xLzbexebjPWBwInBCq2hF51xeP0oEn8Z3QrkxNZNH
         oM6xLder9o6SEfLeHCg9ittF7Ou5VxrfqFcMIzWVZmizVhZ6zpp5exHCYUIJ+WcP69TR
         0uouDmbG4zvQ3Fr6T35mWOIUYZpTizZx2F1FozmqqS/9WpCnf4qkW6uuRq/Tm7ZtYX9z
         /Qp87iMLukXGTxAejwzVtII5qIO7nM9zpw5TMQ5YdtUrDdIxxh5SXMB17eNgF9yJKuDD
         rwx2wc9+r9iYh9WEXqnvETSbpLxZKYqcnTqLWSeo4Dx8WiIelLT16v2ZlL0YwFiIbQCN
         7r2A==
X-Gm-Message-State: AOJu0YwyS6NPXz75rGW9jqb9QvetKf10259RWGEIJd4ZpWt34R5tm0eE
	XJEaEqV+b5QLhDaIRNe16QBlOPzVR+KMIg==
X-Google-Smtp-Source: AGHT+IHUhT+e0aKwq+d1CDK4u0IW3yknJrdZqWwebgZJJazdl08J9nh1SVsraWZ5X+oAZlWZGF34Eg==
X-Received: by 2002:a81:9854:0:b0:5f3:ebb9:ec59 with SMTP id p81-20020a819854000000b005f3ebb9ec59mr481222ywg.5.1705009324346;
        Thu, 11 Jan 2024 13:42:04 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bz8-20020ad44c08000000b00680c7c14d4bsm582087qvb.129.2024.01.11.13.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 13:42:03 -0800 (PST)
Date: Thu, 11 Jan 2024 16:42:02 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Chaitanya Tata <chaitanya.tk17@gmail.com>, git@vger.kernel.org
Subject: Re: Add support for `git rebase -no-edit`
Message-ID: <ZaBgqlR5F1dv9ttg@nand.local>
References: <CADA7-FOE_81ze8hdaRGLPbipihnvFcEYfp9uwnPxPVxDepG4nA@mail.gmail.com>
 <xmqq4jfjftgw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jfjftgw.fsf@gitster.g>

On Thu, Jan 11, 2024 at 01:30:55PM -0800, Junio C Hamano wrote:
> Chaitanya Tata <chaitanya.tk17@gmail.com> writes:
>
> > Hi,
> >
> > I have a feature request to add `--no-edit` option to `git rebase`
> > like we do for `git commit`.
> > The workflow I typically follow is:
> >
> > * `git commit -a --fixup=XXX`
> > * `git rebase  -i HEAD~15 --autosquash`
> >
> > But it requires closing the editor without any changes. I can
> > workaround this using the `GIT_EDITOR` option, see [1]. But it would
> > be good to have this built-in.
> >
> > Thoughts?
>
> With what is in the 'master' branch, you do not have to say
> interactive when you do not want to go interactive.  I.e.
>
>     $ git rebase --autosquash HEAD~15
>
> should work fine.  Building Git from the source should not be too
> hard.

Oh, duh. Indeed, 297be59456 (rebase: support --autosquash without -i,
2023-11-14) will do what Chaitanya is looking for. I'll give myself pass
on remembering that patch since it is from last year ;-).

Thanks,
Taylor
