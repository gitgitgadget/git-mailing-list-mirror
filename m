Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D8566A
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657669; cv=none; b=QIYeIfMrzoUxKsZGIIRpg+/iVN2kJwK7QqyrSWb/0Q89Rrv3sZyDxuUVpEnJk6AKL+OoQvhmyVBElRmWuRKQTEj/C2Gxn2p/48HoW+WEJaluv46OIN8g2iP8uAsHN/l/zR3i6PsKn/enddfZbGS7XTUWyMqYzAq4Xgvsw0O18GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657669; c=relaxed/simple;
	bh=6UTPiQJw1y9b+KUIDtOxcjYp0AGMT/I/ogqOmcI1tbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6HSU6rH36Xpw+a3uDQq1O8M+utzgTe+RplJ6OopB8bi81taBYdfFBUNSd+55ysaswEYf5hN62oYZau3vPXw5H2isDp8Q6AHAbKIQ3K70WIYDLNHuXiY26ax+8eja67YX9atseJ4YQdBAH+n8HYUUCaXewTUDBz/2S9pxcuWMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6mdflez; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6mdflez"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5bb2ac2ddso60755eaf.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657667; x=1724262467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOB/kJL5eT4RvXxp2VngwAEoANTx99XtcblUGrYObGg=;
        b=a6mdflezRhDN1u1K/zGkDGc2r1CXJHEEew0Irnnr9PX4pMHVX/oAKApzS6qCgYyil3
         klRVeqUMx1xwool23BOmCBzMopObtWZMMs+WZKPyS3Di9liHyzNFOPnyYFs8L/K0gOtC
         n+XeBWGHLVtCoJuswh8GV72uQmej5vAieowMl8ikn9dBF6D8yTbYG4EloPe/GAmeulxt
         5emNzMYIuZfk1UjPucGFbeHbgGgHvYZnrxXs4l4tjYPCHt00x/C8Tu9T5pEr9oMTOCQS
         8xLtq/ErHKglGSsAZFbBD4nS6RDRCfQRLkl9rTf5FDqA3yRbHG3pX4pVJwpCYG6iljnV
         PU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657667; x=1724262467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOB/kJL5eT4RvXxp2VngwAEoANTx99XtcblUGrYObGg=;
        b=fpCKE4WXQ/dHetwd/uzdeVVzdWq0un3ki+wqwDjO6qDXcq3yW38T7FD249m5AlhgbY
         uuVD+o5CUHDm6xeaHASpBHC0ywliUB/PIatB8nfnP8XT5bP5EzlHXxd3n97UIphEkbSo
         vNBOKhy5saBL1l6D+7HBfM50faC+Otoe5TNTfHK8UnwvY665KB0eggw/UPFbX7ECcIYY
         O4LhTQkEEHoEuNNsPZoihTEanzLRy97bq4FORP3DfJegp5BGlO1weRacVWVs51u62W1z
         RqF7D8ppLWOC5L6y1TH/kXu5/JopxqJYh4bVSZ8Nw8FqF51wJC/lbKMfkwlkEkd4XSDe
         QZ5A==
X-Forwarded-Encrypted: i=1; AJvYcCXnKSPD3XG1kW2ebTWQsWQdSNg2wyyINMU7rfGfdIaf0ecInzkdzG89bgkNGAN/v782svb/6t9Q0ICv6+f75SqLhvlY
X-Gm-Message-State: AOJu0YyalrlEcd3dAeVJpK6eIG8FO/Pl2u0pPA5nQuQXHAyvpQcEdFrZ
	QltAIriSZ03wjn2NN+QcW86AfJOnDk+839N5LKHDGOi9qYBwG3A6uSxVAYfh4KWWpGzuacmu7sG
	n89hj0gErO4zjlom8DYe1WthbtuQ6qA==
X-Google-Smtp-Source: AGHT+IEToKACSaGarntQsrexVZG9elwsadSuDyGK27rpJb5PEfBlOR3Ypa7UvFg7lNSa7w6+i8frHm0qF3nd+FMRqxA=
X-Received: by 2002:a05:6871:5cd:b0:261:a04:2aad with SMTP id
 586e51a60fabf-26fff4273a5mr176872fac.6.1723657667102; Wed, 14 Aug 2024
 10:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-jk-translate-alias-send-email-v2-0-912db4eb6846@gmail.com>
 <20240813-jk-translate-alias-send-email-v2-2-912db4eb6846@gmail.com> <xmqqo75vyr4b.fsf@gitster.g>
In-Reply-To: <xmqqo75vyr4b.fsf@gitster.g>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 14 Aug 2024 10:47:36 -0700
Message-ID: <CA+P7+xooHK-t0gEZyDeKAYYBvVJXdWyRHEOC4zok-C8+vLxqvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] t9001-send-email.sh: update alias list used for
 pine test
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:02=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > The set of aliases used for the pine --dump-aliases test do not
> > perfectly mesh with the way the pine address book is defined. While
> > technically all valid, there are some oddities including bob's name
> > being partially split so that the actual address is returned as
> > "Bobbyton <bob@example.com".
>
> With "partially split" bob's name, do you mean the HT between Robert
> and Bobbyton in the original?
>
> I am asking to see if the closing angle-bracket ">" after the
> address is deliberately omitted to illustrate a breakage coming from
> a malformed entry in the original address book, or it is missing
> merely by mistake.
>

It is missing as a mistake, I think. The main change here is the HT
between Robert and Bobbyton in the original was causing the fields to
be separated.in what seemed like an unintentional way to me. The
missing > was I think due to a copy-paste error where i failed to
select the final > when copying to paste into the commit log.

> > -     bob     Robert  Bobbyton <bob@example.com>
> > +     bob     Robert Bobbyton bob@example.com
>
> Thanks.
