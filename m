Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCD22318
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098136; cv=none; b=WVl1TYdEMCuNbL0/FXR8UiNsNrUsfh2zDIz/3507WMDUt2mbN7zpkXZ8NaPHK6EkLCed5tInFibQpJ283fzTBJEoHO3fCiZNKaItvZQa+S7vgpJYwYG5jfM9M+8oEOxoD/aIGVR2SbRcLPsoxekE5/cuUT6JQvW5IHnNmskvXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098136; c=relaxed/simple;
	bh=t7wf0IYSEx2bcr461+ByErI8b33KSo4hgJPb/6oby0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RE9avoj6NAIN3uLFvZd6Xkf42SE/OYzGDkGat2RbQXuOMRMfblQrVVe9l+l8ruCGbylPLm0Zw+J9SzL2GiIQ4KAHS6JEXESiL+C01Dxwzd43/cjjc2zm4GI1UdwkbYe85xm7QkLg5kq5pjfqbASFCV6EDQNO+zKbLf61SWmY2xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt1XIVus; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt1XIVus"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfbeed072dso4976287a12.3
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732098133; x=1732702933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzE0wJJKyRmOaMdaPP0eXZ4U6Yj1eam3P66NIDSULBE=;
        b=Wt1XIVusF5s3wd/TnagA+IJ7yY/XOcX2aE4ItnRK3QY1Q9gBkqX4gE1AhA201wzIMU
         Jxmxqk14zMzfCwvSMn0Vn0+jAr4jXubFlUqkdHm1PC5P3HEaKS1q6aXFcDGFY+dPkPAh
         +pC6fQSivto1+PxG7oXH9/3zXWfj9Qp0ybGvsFfA+ws2T7JCacJvyh9XS+4sosomA7YM
         nJtkZ7w2xd90m6/z/QVC/NzNkC5S2A6Q4ItV9Pg0r9biesVi14n2rUvE1hd3jZPK06Bh
         kWk+w2OqV+R+MdyMEr6Mf5YohnOmlzp1JFveoVjgBjnltOpgj6v67TxrkiD8kL2Nrmuj
         SVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732098133; x=1732702933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzE0wJJKyRmOaMdaPP0eXZ4U6Yj1eam3P66NIDSULBE=;
        b=JlfAZsenLILRIzltcOMpf49Cu9jFIGSX18Cg/TcfC23nI3owrwrJ15D5hxdezkD0y4
         G/Yugx71tcNMD4TeqeAodLa0EVLUX94+CgMYc2f6sqXfsxUr2fJKS1vnsAhafg+F1GuZ
         9YPtRechq6wm6/vvjLk4Is1L9evd9OzEx47ZY11XqmZI3QNcPc614CURyAb/MV22Jhq8
         uIkq98e7MWSpL8oPWcGZVDtqu261faIEInAVFrwWdmdO78Y5TeE+9SJ37kERT+NJKL//
         EgiOc3sfFhnZSFEXRUjDrPOj3aMj19SP4Ga5Mzf1gABf5gaUibc3JLwJxnBtdBtNpltw
         iieg==
X-Gm-Message-State: AOJu0Yy13ZJOhkhlShWfqla85znBvZkllX5kvDr4WHqXUbmSYBxjiycO
	dElLmHjWGgwj3Z9oCl7nls6z+3OXgQQvDjYqmsvXTd4qODX3r22ZNB8+4IIWWFJc3cuX55WEFp4
	DU17iiruzNvtV4+/PYlQcOLi1VQg=
X-Google-Smtp-Source: AGHT+IFO/d0hGpITEGx3gZ7hKoZwTPGjD5DdqMJXKo1ixV+dxmkyjs1DM6GEQZj4JTYPW2oHzPIo+FM+I9Nr70yR5co=
X-Received: by 2002:a17:906:fd88:b0:a9a:1b32:5aa8 with SMTP id
 a640c23a62f3a-aa4dd53da6fmr184005966b.4.1732098132792; Wed, 20 Nov 2024
 02:22:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im> <20241120-pks-refs-optimize-migrations-v2-10-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-10-a233374b7452@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 20 Nov 2024 11:22:00 +0100
Message-ID: <CAP8UFD2hjbmqkKcx+8=6uMmaXOZJbL4kJ8X9HtniuRsX=-=rtw@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] reftable/block: optimize allocations by using
 scratch buffer
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:56=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:

> diff --git a/reftable/block.h b/reftable/block.h
> index b3f837d612a8f0fbe98430b04e2dddaa975a15ab..d76f00553073c10185e716e71=
e2f415ce5dcf7e2 100644
> --- a/reftable/block.h
> +++ b/reftable/block.h
> @@ -39,6 +39,7 @@ struct block_writer {
>         uint32_t restart_cap;
>
>         struct reftable_buf last_key;
> +       struct reftable_buf buf;

Nit (similar as for patch 8/10): It would be nice to add a comment, so
that readers don't have to look at .c files, or the commit message, to
find what this field is used for.

>         int entries;
>  };
