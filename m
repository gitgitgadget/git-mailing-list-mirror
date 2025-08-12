Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D92D46B3
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022396; cv=none; b=dy4Qy709yZ62u+LKjvdmhY6AN4HnF5rLTG+BrpC5JGaM1ADEX3FK0H1ePN/pmfQsGBAxS5Zjo7IR97LtoPX9CKdzaRhLsT6n0z5mqshqLZ7M7gcZMmIMKEQPlhsggHWveC8uRzFPqBC0JDh9w1W/Dspi7AXKq5S9WugOstfIA8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022396; c=relaxed/simple;
	bh=QXh4tKmzPbOPWMbmwAiNaiXlSLtCWNKsHjwFLT7hxtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzMtINmWsJWvctkkz50j78tQW/YvxzJ+EmS/H7iuvGoCihjXdJoUPrvq717TTX554jSgPTnqbYeonCbeP71bXTOmaT9cOMtwnBnVVPCX0e7GJ7jpN9Gy0J0209uJd1zbDlxxuOf9JlfFCXQa88dpB+sSvYhBU1mB3SPqNh2OMew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e826840e1eso44206085a.3
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 11:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755022393; x=1755627193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lTzluLPsMX7Lu8ehkRPmQSS3GGA4JYOsQJ0HrfK9TJ4=;
        b=Rbuz9TuSt/f97mt3xDd1iPfNPIoBrjy9mh0fFy5msdgy0kM11IhmZ6Lt6rQx0y4Say
         L6ESit0MNTehgpMEhbjIZzTacUUdNt8nX4SCOszC8VTW5JAbmLuK14C/n2K+Heuz/nWl
         Cjcjreh9NA0YwNE+Xyg0i1Dingz2+57OJNRN3ntOid8zedm0ghZcVKN1SkHiJPfcudMe
         eAt8+oSHPBVjmqwVjdOqK0PkU9dV+PQCtwRgaZ84QKAqLNam9RP0WgighuyusuxMUgE7
         KqoD4z7LVCTJBmgfUgRXIibw5IbHERebRCxaev19pzK1npiDYL0UQ5PdYGFmSDX5MqHk
         jocQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2FfJFlbiHWAH3v1etvZ5ClvNj0Ts3rnwW2ux/fFZ+GKQ6cQgu/BMpzBOQAorUL7fI38U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn6meHp5urOomsCOwJ0115PhzNv/uicGzUqpws7B9Lk0C6qx9H
	XjYWelx5nouILk1oWDsq/P96Eqj1LhHPYgBGvO4X9WIjvPXgDHw438eRAHDuz2xdbJ7fj/Tt1om
	IpHMYaFPtb5I/taGmAK4Zw5N0hrgITLIkDg==
X-Gm-Gg: ASbGncvrXe/Q7bnA3bpC1cx2xPFK1rO7Sj9HLQHfdUIPpUdcvQTCSmVUd+YQWg+5wq2
	enSoypJNBt5x1bOMrEqofVsdr3HaIbi3JF57fo4r+B3/Z4oNsmhV+43eNDYheBvUJlMzvh7k40S
	GhPVszaHlfM9JUZqps1w3Y2NKcvwhq0wQKCsp3rxseEY3QsXwiie5ttuqo8EABjSNGkFc6Yo4Dh
	MQd0zqV2ZN49USiPGsGxnS15gmH1Quf4PMFIsY=
X-Google-Smtp-Source: AGHT+IFWvPTgOwjP/VYb/b9kuLoC8fTVEIrdtWeEFQodtgie9jnkBDg64sodtp7k2H+F6GF4/ZGYQhrHZ0XVKv/2Pgk=
X-Received: by 2002:a05:6214:763:b0:707:48a3:f833 with SMTP id
 6a1803df08f44-709e87c94a4mr558056d6.1.1755022393174; Tue, 12 Aug 2025
 11:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
 <6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com> <CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
 <xmqq1ppgv3wg.fsf@gitster.g>
In-Reply-To: <xmqq1ppgv3wg.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 12 Aug 2025 14:13:01 -0400
X-Gm-Features: Ac12FXySJD1hojiix31BXVaL7U6Pf_OjMxz9JIyxZKg59tfupfdWQ8O7FNheF44
Message-ID: <CAPig+cQMa32G0pqi1UU6hqRAB5709Zcif0pd5uWifqB8d9o6rg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clean up some code around editors
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, "D. Ben Knoble" <ben.knoble+github@gmail.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 1:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > To catch it locally, you can run:
> >     make test-lint-shell-syntax
> > in the "t" directory. Alternatively, `make test-lint`, `make test` or
> > `make prove` would also have caught the problem.
>
> "make test" is a bit too heavy-weight to use as an initial sanity
> check for tests that are being newly developed, and I am wondering
> if something like this can be added as a first-line sanity checking
> tool.  The idea is a simple "make" to build, while DEVELOPER=3DYes is
> set, would trigger the common linting any developer who is working
> on new things needs to pay attention to.
>
>  ifdef DEVELOPER
>  include config.mak.dev
> +all:: check-developer
>  endif
>
> +check-developer: check-docs check-tests check-builtins check-headers
>
> +.PHONY: check-tests
> +check-tests:
> +       $(MAKE) -C t/ test-lint

Not a bad idea, though I don't think we need to hide the target behind
DEVELOPER.

The "first-line sanity checking" phrasing you used above suggested the
name "make check-sanity" to me as being more meaningful and obvious
than "make check-developer". However, upon reflection, "sanity" is
perhaps too generic, thus might not convey that these checks are for
code newly-developed (or changed) by developers, so perhaps "make
check-developer" is indeed the better name choice.
