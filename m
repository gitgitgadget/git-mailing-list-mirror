Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD7372B2A
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 03:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976371; cv=pass; b=tkHGc9ghV2oaRZ92N2S3JBbIcRuB0e0ChZcRfQVFFckoay0xvEwP3y4ib5ZCfFb3E3gNWIxSkqzPZv6aI0APAHrFBnLUAnrl4FKA/u+4ykxunhesy1RJxSuPXQATia7rDZtZW0/VBIikPUS7FuymjHICk7iATX4ZUh1fxVqYSzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976371; c=relaxed/simple;
	bh=kBI9VhY9HquFtCtXaPOE7Ym20u8ZpKo3nOoZj6pKW3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gENMfQah3QqUL6l6DGtniGfEB4jW1DQvhYq9hiww6ng6c7e6GwnhiVO1g6ao4ZzDDx2u/XWys0ALpet3QtFyRcIWw9+VCnWKOX4IBHmtTlUJ2V+CnubmSBcfpl5bkHWftWYYsnLEi5241BaxIRX7xnQQX4AOmSi4NX4PveB/hmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQyEq+KD; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQyEq+KD"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa5ce4904eso5242952e87.3
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 20:39:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780976364; cv=none;
        d=google.com; s=arc-20240605;
        b=RuSxtlJUD2spWCXsimYEqK6lkgYKEnu+6EcBxXwy2KQVXjrH2SF2BW+1NEVZ+NS+im
         Usf/OsEOxnec+VZErHpaCsFZdmPiGY3O6ptusJqJhQj9WdhSZQ3rpvKVbTNLb5xr60yw
         xTUuhhmA5hFc2mDyF8AbYa7YVA97EIfmSfqSzkmRxWaXJZjj5Z2hVSybkY7hQB75skpw
         HCtLQcqqF7BawwkXBFQbwxBZC8xWIbZ8vaM3Tysvj8he4S8y24gMEaHc8G8S0pQBxETx
         fou4MgcnC0jzIL9aUIo2VXl/sqJpkcrt5b5BZ4c9IzfFACKCwgL+33jFcNyItSYZfzMJ
         CkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/1KnQ1jOBPvVzr4w7HALBZwb5zZj/KoEewn+h/Qyg2U=;
        fh=N/Hn4Wb1qGNgntkEgdKemjVdh0BBMPDjsCOEmemegKI=;
        b=OXbYn1H2H8QlByHQg/bX3PadWMfOisc6lKsy1gz6RdaNenasN23UJkqSE5mlA6HSyX
         8TIfCmImMbqyTWCF/XoXKO6303YfWUo6W3Fp7N6PkXXaKzGcuEl9S/iW4MiA7HCgVEKZ
         jNme6oQ1R98yrKITNI4oyix4HstdHBBb/IdaoOiOfZWMH8YeA2JvgioJUfocaqNkgpKd
         ffxPctSAQdSyPvY2yD7FG0MqHzQceeOLBlFpfTx/JNnBazh2FMn9TTwGhRezqrPyg8hx
         9T909Y9WgM38IoDVghY8nea/dD/IMcPMKFFz3n2oNv0/ga6lfCv1QfayL8EuYRcMxy+z
         lImQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780976364; x=1781581164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/1KnQ1jOBPvVzr4w7HALBZwb5zZj/KoEewn+h/Qyg2U=;
        b=WQyEq+KD4WAMIRZScvjfFD8Xq9GnTdm0/b66ZoXntDyeHvdr3tWNE38fZxL/qZqn3p
         MnjxtG2ZWK7mYXWCGT1mDW7Qxw1kcT4FrBir+zN7xpD4NVHSdrx+EzdG3lg0zggFpxnH
         EQ0rO+sF7NWtF99Q2OiOE9YKsl+7p2CYdDFCVVUAEguGsKYfOsVvsdXQP0/ol39nAfLN
         bEJdkNDW49B9dUewanV+EpEFzWZW2Q2qV2mnQOTI8kSpjJs8haWkEH1AEV9TCPz83oid
         0o5ro2bNIVKIUtu7Ot9IKmQpiQ8ttoOLHLXnXXFYlvhapz8/qoZMYdK1JUjlK73JCcMa
         plIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780976364; x=1781581164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1KnQ1jOBPvVzr4w7HALBZwb5zZj/KoEewn+h/Qyg2U=;
        b=oP0qEANUBhmavb5cXNrrEOI59nlUsYdiD/oVLqrSlDe4tAZagGNsyRecLfQP0rftVb
         12qGJB/+3J+EZVc7/gbRAqxo3lQqbxLaBmOmDRsWvS92AbURHOuAfVrbc1g2GsCW5tBS
         jlklkB10UMRNPbFBsmFSHA3jBSC1b7oe/omHjOfwdMttXYR5dWF6Hqq1kX022MWLXnc0
         UXN7cUi1Xkxf0VXYHm3MOmYdM+W6PYtkbXRcyW75HE1mwZWXpB7YqGedkdOno8I2m/Tc
         chCb39OKWCiyClgRD1hRbmvXVmdSx1ThHdIu1sIwAKz37A/UhyCUcmSHALEi5qPEfzPb
         EBRA==
X-Gm-Message-State: AOJu0YxYfzeVMW2kJM5+ReuGFSlAekCHEHFOQWPjI7TkdEhmFzDO4vY6
	UIS/9nEyBH8uNXgkxTP1JR/k/JxvW2EMfTUNuDpqwMBQODO0pZ18OUyjO3MPu85eiKAUcTdA5MJ
	VJUcYvRihJQTHW2K4NRAOY/OwnvKW3cc=
X-Gm-Gg: Acq92OHMQTO29n4RkRU4lTDo1N6IRkrjXHr/n25rqvX9YI1FMAzki86RS9f64MIjHvi
	3V26Chq0Ze3NpVf7GVAp+Ttdtl/n7V7jTVqXi5IhN79OghxkTAO10FklgdoU+LlIZo7YiKtNYsB
	TQUwCKV93fi10bODRlDtqnGHw0BuVUwjkIvWHe+bVKUGj7NpSJ3NfouezMSV9uNpB360x2+J0PS
	2QoTauJ8noqzyFmcwpNy2uxeTF03VrC5TdDo2nJ4g7nrElRqOJ6GFynFcUW9QPeWiALCXpghzn0
	s1amK6JXuQI2Z4iLAMBZlkhkGyfxiLCHGTlQO+tAM2zC3kO4VE36CENOtUnAERX4rn2NUQWJ2pg
	QeBysOnvBqHwFEyl6D+u+IclnqgkuvE1WRZAUdQ2fng==
X-Received: by 2002:a05:6512:138a:b0:5aa:638c:f2fb with SMTP id
 2adb3069b0e04-5aa87b509c3mr4551473e87.12.1780976364100; Mon, 08 Jun 2026
 20:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-ls-files-pathspec-lstat-v2-1-fb734b28422e@gmail.com> <xmqqv7bstmw8.fsf@gitster.g>
In-Reply-To: <xmqqv7bstmw8.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 23:38:47 -0400
X-Gm-Features: AVVi8Cc8S5hjam8IXSiqUQZmk04p063mkylJtLSzRFDGo9ZESaXEZvHGGDqQce4
Message-ID: <CAJ-ks9ku-uYeZ+3BhLAzrNdnOc7qnhudxQgy6PwU93jmr7ka+w@mail.gmail.com>
Subject: Re: [PATCH v2] ls-files: filter pathspec before lstat
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 8:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > show_files() checks whether each index entry is deleted or modified
> > before show_ce() applies the pathspec. prune_index() avoids most of thi=
s
> > work for pathspecs with a common directory prefix, but a top-level name
> > or leading wildcard leaves every entry to be checked.
> > ...
>
> Please make sure that your v2 is a response to v1; otherwise loses
> sight of the previous iteration.
>
> > Changes in v2:
> > - Restrict early matching to one pathspec, avoiding the regression Jeff
> >   demonstrated with many pathspecs.
> > - Add all-matching and many-pathspec performance results.
> > - Drop the Assisted-by trailer.
> > - Link to v1: https://patch.msgid.link/20260607-ls-files-pathspec-lstat=
-v1-1-8cf40b730146@gmail.com
>
> And it is *not* a replacement to force human to follow such a link.
>
> Instead, please make sure each piece of your e-mail identifies where
> it fits in the discussion thread by pointing the message of the
> previous round with its In-Reply-To: header.
>
> Thanks.

Apologies, I used b4 which follows kernel rules. I'll follow this
guidance in the future.
