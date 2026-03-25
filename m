Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF07C26CE32
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458329; cv=pass; b=qafydP0DGidDLWhda7z41j2IDISJmUVL8esjlchiXiVwyU9lfG9Wiv9fPqWGQ+mqjJix+6eEmiULaZF3W/aajiPGyIpYoEjIL2T8gH50yHW9jtCl10GpagpMkXW5bxzGUHWdslT9sPaS7LEFNH2xjPBVojFZ4g8xUuzLS18Jh98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458329; c=relaxed/simple;
	bh=mZNasvR8ha61D9nfehTckxezbdmL0zgu9D8ZAVFRpG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA1sbnCEdpffQwuTIuGOa31e3OTQbma98Rofw0sa/r050N9oFHnPTVdk74qn/9kyeNdn2EZvVIIy7SI8ge+6vJaZoNFn0EAvVgKjZuonks72wFSaIYCeLf6bzlqI5WNNpbS/mT5/vfNFVyyK1Bs76MZtcPMkO/Du69lO/420Hy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIBPn4yE; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIBPn4yE"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-66aa2204e9dso1373269a12.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 10:05:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774458324; cv=none;
        d=google.com; s=arc-20240605;
        b=Ln+tXulVn/68Xt9nSrz9wC9notIDUmZFdLm7bqRCnD2MIo/8e/4dDgP+8Fh7KYSjn6
         x405f5vK5LVSz3W78f/k/O4kW9dhZ4jh+Q/8YptKgqm4Ch3mk66JRQ8rf/6jQJMoRkAL
         NfSed0zCBCeFqielr5sNWAxL8c1WX5TxubbS+n8vbfCStkmUk4///Y58l85bDmOEsq9m
         0K0tNxc5iIWVDpS4G47FxsYrgBtee9rHSvkm80VA+yJJ2UWhIVYRK3fhDNOKvOWhMX/X
         rMPOx2sdJBONlreQ1VyGJZe8WFamSkjrUN+90pO4lJc909lwhzHAaL+d5aiImsJw7CAK
         AswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mZNasvR8ha61D9nfehTckxezbdmL0zgu9D8ZAVFRpG4=;
        fh=92YHPqv+Dgz2hIQYxcqhnikPL8+pZwc7nL3MBjz5fX4=;
        b=W3Qi/FdHvc+iaWZ0rh+fTen1/KDgQPBBqIppCYEFNKN43dJQb+5MGyzraiIBjq/GI2
         x8HyrN2rY+EakVC3I8HKEQGiLDxeemsZ1nRR6NVkBXIFdZbuU/DzedttTEcgGtEkYQUQ
         jacaGgDxGC4zi7VxjKlx/2KdhmZZLi6YVrCKh7Sy9Tx/GNZBGwnNunCP3uYPWzBmAS/X
         vU1yPZwQwPGlo/9JSP3mh+8Wuo60TwZptDrxtE1MCQD3x6kZcV7w4CpKDyricPeyerao
         g3vGURjKZyNTR5/3B1gnVK5MJzbj3a7KOwX7st1+VJoN/NFmsu0unPmpTXEcb3wT6g0c
         eT5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774458324; x=1775063124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZNasvR8ha61D9nfehTckxezbdmL0zgu9D8ZAVFRpG4=;
        b=mIBPn4yE9RQeJVJLae5sRPHdlSVJNEqQsbqlP3E5604EStFg5soAm4d1qmARSfPBkF
         5kFTZeYqBcd44J5l/G8VEkCpf4SoZK4x3zHb6ulDZPlzIzK8i//LywslmA/WwwksMwwD
         +rtoGgdJQ+HMAZE3NG3lnxMUKdbLo5dPdaV46KaGkGL07TNwra/QAI0Eyf8z+3Ke06K/
         NQVq5reCHsvUh46rB7O4y4lwqkhRHTzUHQnFD1h6/sFTlUzgraTF2rGxtDARZZaGUoip
         e1RYzqIZC0rY8nqRQo1aRuFjKCp5EddD2thruRWMmbJ5lQEVmS+uz0wQFZ3i2vW+Bss/
         HQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774458324; x=1775063124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mZNasvR8ha61D9nfehTckxezbdmL0zgu9D8ZAVFRpG4=;
        b=SbKy7DJsVVrb64aYhP4LUySry1xyMVr+HoMkH+FiA03vS+RK1/V6/+YnSfZAiHPadr
         itLSnMbeeopmzCj57tFjohEck9PIVzl78ejNwQh67183qNlWlENr/dPgSFnsRdYaLS05
         WirFOIMykrbM31znD8TCYpV/w29XzeuOEA71ud5VCSA8+QutbxjY/J/m4Fobsf6Abe4U
         Y8vaWKEDIDXW5HT5w988AXtJrmbp2NQsbh5MyJyXqrpJtUfMXRwdaI1fwLfCyIKhFOqE
         F418fJiKQFUJfZrIGARNzMYKILd4SwM1K3YS3FrkYze4F6JJ01GIgfNPDK3fnbbmNYPt
         VkBQ==
X-Gm-Message-State: AOJu0Yw0MxJLMfZy3vObCwvVF14/QyDjRsoRiU5ySb5CC5PmtWZpt5Qr
	b5OjIprQba9xCEVbE1ZKtx1uBc2Wej7Rjtu6P4E3n1uXQi2dHuCcOI2ps3BJSQeK8ihxrLbq0XM
	Q9dvquSUviL3K8/bh7RLlVOpAI539QAE=
X-Gm-Gg: ATEYQzyAU0kQ+TavYYwkUDw3SehoZn8oqgNbpBTaZWdkh44yJfhUjTfRw9HaF/gOWLR
	UyKx24w2VCnkHhYR+CDJkNXRwequKRw2RCacHavdOL3XidA2rC+oAFzFh8MuWSz0F9SpEQAPCEC
	cEloEZ8I1jujqtGzYIojGsdfOtdhpU+briyMd3G+bnwbjpih2gQwzSj+u3w+34op0Hm2eZIWrri
	lxjtBCjREZcqrx3a1p6Ou1eGA2/zIosLUz79jxI8cje0a/jbBzhFvd1lbwAss3MGLjpdXAgCkFB
	hrkSRQ1aJBdjvCcJ8MiADkwtgnag++q8b2QXJwgPPjo9q+cftmlmY/HkNpbLyd7Kh8eysr96kA=
	=
X-Received: by 2002:a05:6402:5193:b0:667:90c1:844 with SMTP id
 4fb4d7f45d1cf-66a80cf991cmr2688770a12.10.1774458323878; Wed, 25 Mar 2026
 10:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325075055.354709-1-luizedc1@gmail.com> <20260325075055.354709-2-luizedc1@gmail.com>
 <CALnO6CD15Tcs+Sr7XDO0eB3KSC7RT2oawTiSpUGdrQkfbPJQtg@mail.gmail.com>
In-Reply-To: <CALnO6CD15Tcs+Sr7XDO0eB3KSC7RT2oawTiSpUGdrQkfbPJQtg@mail.gmail.com>
From: Luiz Eduardo Campos <luizedc1@gmail.com>
Date: Wed, 25 Mar 2026 14:04:03 -0300
X-Gm-Features: AQROBzCQNu_P80q__IMN8Hte1bhFIgVh3ntvu4knEA5XD6dz6vEySUqOcLbCkFU
Message-ID: <CAN+A6TuhiC9U==QvuMXtnTHtwzSMh1fSe12kxqj3iy03jF-Cxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] add -p: support discarding hunks with 'x'
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net, sagotsky@gmail.com, 
	Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Thanks for the feedback!

(Sending this message again because I had not configured my
email client to send it plain text, so I apologize if you received
duplicated content)

> One feature the Fugitive Git client for Vim supports is to discard
> hunks; when it does so, it also prints a message explaining how to
> recover the hunk if you need it.

That=E2=80=99s a great point. I hadn=E2=80=99t considered recoverability in=
 this
initial version. Storing the discarded hunk as a blob (or otherwise
making it recoverable) seems like a useful safety measure.

> If it's never been in the index, it can be impossible to recover!

Agreed =E2=80=94 this is probably something that should be addressed before
considering this feature complete.

> PS How different is this from "git restore -p" ?

My understanding is that `git restore -p` already allows discarding
changes interactively, but it requires a separate pass. The goal here
was to allow discarding during `git add -p`, so users can decide what
to do with each hunk in a single pass.

That said, I=E2=80=99m not yet sure whether integrating this into `add -p` =
is
the best approach, or if this should be handled differently.

Thanks again for the insights!

Luiz


Em qua., 25 de mar. de 2026 =C3=A0s 12:44, D. Ben Knoble
<ben.knoble@gmail.com> escreveu:
>
> On Wed, Mar 25, 2026 at 3:53=E2=80=AFAM Luiz Campos <luizedc1@gmail.com> =
wrote:
> >
> > When using `git add -p`, users can stage or skip hunks,
> > but cannot discard unwanted changes from the working tree.
> >
> > Introduce a new 'x' action to discard the current hunk by
> > reverse-applying it.
> >
> > This idea was suggested in a previous mailing list discussion:
> > https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.ne=
t/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0
> >
> > Feedback is very welcome.
> >
> > Signed-off-by: Luiz Campos <luizedc1@gmail.com>
>
> One feature the Fugitive Git client for Vim supports is to discard
> hunks; when it does so, it also prints a message explaining how to
> recover the hunk if you need it.
>
> I think it writes the file as a blob to Git's database before
> restoring from the index.
>
> I'm not suggesting Git copy this necessarily, but we might want to
> consider how to help folks when they lose a hunk they didn't mean to.
> If it's never been in the index, it can be impossible to recover!
>
> PS How different is this from "git restore -p" ?
>
>
> --
> D. Ben Knoble
