Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079E65821C
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsRkP60n"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f9fac086bso37251286d6.3
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 12:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705004434; x=1705609234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb5xAC8IrWexB4tus3qpB6nx2gD/+StFTi8DL5OGe4I=;
        b=TsRkP60naSM974W6NNdP0OSnibx0Lr+Wuvm+ySKqCzelyKSEZ8m3EzfWYF7iOd3H40
         s/1vITEBbJANTNf2jrOBBAhbLU1AYNoEOpAXxfWvIjsr1caBf/j0B0413yFJvJqncHvx
         FsJHXtSrxuqSqubM1m6m6/XvNkzRRK8szjMvdGLBzIlh8WWVIg+NcQUYk0OsGjN5q04e
         aaU3dyS+m2jKWp9YW+PJlUelexzp8cEvQK5ydJ1HPJjHLKaQao4ROqelZORSGZiQP/J7
         lp1f6zscigRij3Wo99cs7Jpvbkkn/sA7ol65zUgdR3sZQQ5ithO0koczpfvqJLQIyIHv
         agTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705004434; x=1705609234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb5xAC8IrWexB4tus3qpB6nx2gD/+StFTi8DL5OGe4I=;
        b=KCaQYmziHQHeq8ne3qDarz589s60x1kHRO/XfMD7G41vJW3+CtlSgs49xx4P4wrklO
         1OkNQ6jj6opfTds0/+uaPJSEPH0y710l+S389MWm+RgSZnrQixiQTdEQGEb4ANPorL67
         CNGqq3mqcFjq7yK8s8NlJpcNfmkDDvz7YbFiIJCHh9aRWCGisdYUT5XvHUEp7YcZUs2G
         4ADenZaE5Y5VuRD7KkF+SqSG8gVIVrlMCA5C8t2maDMUA5vbImVDh0C391ltSOSx+BLK
         gZqL7k/mS0B+qBlBCNup8wyK+aRPvxdmuxFRduERQdH1kZCXtLn10LoPqkWX2vkgVmMd
         +cxQ==
X-Gm-Message-State: AOJu0YyRdCDBPdT00VJsDRwZr4L2j1ozuQdBAsvSKunmQr59Ig4AAXwm
	Cf12KUBforgDhgKP+itE/MkGwy4IJPnte4aO2Q0=
X-Google-Smtp-Source: AGHT+IFzGS8EowvNaNqUR7Zp0+p7EIxQ7A4QWwkYTZNMLPaiHvirfzNRlImEc1BjuMJuwnCjXDRuErTEShYfuOZU/kY=
X-Received: by 2002:ad4:5ca9:0:b0:67f:d69e:9c45 with SMTP id
 q9-20020ad45ca9000000b0067fd69e9c45mr267429qvh.11.1705004433823; Thu, 11 Jan
 2024 12:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
 <11fd5091d61b54d8862ab2e316bbd25fff63ce0f.1704912750.git.gitgitgadget@gmail.com>
 <20240111072828.GD48154@coredump.intra.peff.net> <xmqqa5pbhfkw.fsf@gitster.g>
In-Reply-To: <xmqqa5pbhfkw.fsf@gitster.g>
From: Justin Tobler <jltobler@gmail.com>
Date: Thu, 11 Jan 2024 14:20:01 -0600
Message-ID: <CAGAWz+4s0YFMfMpAr-6ugoKgFKt7mjVELpMcCEOU+0nO=DOaww@mail.gmail.com>
Subject: Re: [PATCH 2/2] t5541: generalize reference locking
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Wed, Jan 10, 2024 at 06:52:30PM +0000, Justin Tobler via GitGitGadget=
 wrote:
>>
>>> From: Justin Tobler <jltobler@gmail.com>
>>>
>>> Some tests set up reference locks by directly creating the lockfile.
>>> While this works for the files reference backend, reftable reference
>>> locks operate differently and are incompatible with this approach.
>>> Generalize reference locking by preparing a reference transaction.
>>
>> As with the first patch, I think we could use d/f conflicts to get the
>> same effect. Perhaps something like this:
>
> Thanks for a great alternative.  I agree that avoiding fifo indeed
> is a better way to go.

For this patch, in the next version, I have also followed Peff's
suggestion to create d/f conflicts to trigger an error condition instead
of using fifos.

Thanks to everyone for the feedback!
Justin


On Thu, Jan 11, 2024 at 12:48=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jeff King <peff@peff.net> writes:
>
> > On Wed, Jan 10, 2024 at 06:52:30PM +0000, Justin Tobler via GitGitGadge=
t wrote:
> >
> >> From: Justin Tobler <jltobler@gmail.com>
> >>
> >> Some tests set up reference locks by directly creating the lockfile.
> >> While this works for the files reference backend, reftable reference
> >> locks operate differently and are incompatible with this approach.
> >> Generalize reference locking by preparing a reference transaction.
> >
> > As with the first patch, I think we could use d/f conflicts to get the
> > same effect. Perhaps something like this:
>
> Thanks for a great alternative.  I agree that avoiding fifo indeed
> is a better way to go.
