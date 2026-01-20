Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3177366DD6
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917880; cv=pass; b=t6kNE/Pm0c/xsbA/YTR3eZ+KE2nZ58Qxo9w3uiowA3YgpP37xMtUko+1nDF2dnEBEXJVIruJj3rr/7EuWfIx8WA1sPC9jMTeU0czb5K83lF76ouQKUu4eJwU/cm/+EkP7zAK23V0UbhUvIcn/11pC0em+pPUSeOOpJ3mRmJ9peo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917880; c=relaxed/simple;
	bh=6k2K25NpWgNuPCa6/vVC/Cdwn0OnTVVtzPLTR3Lg2Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxnSJ+xJrMM4PokVLRLJHzhAleWHA6cPa9ZHh2CrWsV5BQL6qfO+9D4ZPnsm+pPdn62TVNSx5ZkE22OI66wl/FDMrwA6e9io49h8whQxkmUzjdQdNwZAQBIODoGUIUYqugRLG0Hb7bjYUGtL/RnhAz3RHQ0gw+eXlrKMfR0MS4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYaGzMgd; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYaGzMgd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-352f00d0e83so23822a91.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:04:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768917878; cv=none;
        d=google.com; s=arc-20240605;
        b=DKCGR2dOUQVuQmBum91jgA7edjVB7w1MuY1/DeRdR4xkBmoNok4yFNAB+m8C0pm+jH
         HicuwGydRyEDRICbUJ2dqtmrGJg00yUxDaozNyMgx4oJnV93+h+M/A5Dj+YWClEDadMb
         7bi278ee8qxVRwaSL6w67v4ok7HOx9Rm+sagdnt8T9j904Wl7ptmR5Y+uMuA9RJ+vzxx
         0bnagx1xXhI4BlEUUN2WvVtfNwDhBJw7SgSIhPRG4EBpfBPSsPIfJ5BjSu0No3J1pZjp
         0yKWn0ueC/Txuift9GwTHdTYCYxBz5djzOFjTJ6L/Jt7N7i0oVJeqUWCCHp6fcgs8cUq
         IquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Y3Zlef6i2P3NWjWcANV8mREbDBPGTMxdr4VthrDsdE=;
        fh=Nfq7QF1MjbZ3oXbuX9/v3Ag7ViofVylou5nKaNghBVs=;
        b=LrcBuixuxUsWGvLpq/VPZJeqzFGv6BAvUF1OSAtB+hpFFNIubq1WrChaCCu7apEQWQ
         0LhGBmlRk58GkzLoujdJTUIzYBwzXpM0vZ2hz5exjQplv3JTOF5AMOoe7DAYuBBNhsYF
         kugI08Fo63lNCi40oP3Ux22ViAekeLiZRTvlKdFbMM4WOqxPiSMv/kMfk4HBuRkaONOR
         YPTRThFZm+3QRi5wqacISTGzDJ72BRharyb6QNeISHX760tUROm8TnMfSNEyM/fNGvXv
         Lvezj69XkTgcfOMXXNKJM7ksxxz2CsipNdMsA+1dyo32GbzI0ajETnO3LVqqGbHxDrnN
         b7UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917878; x=1769522678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Y3Zlef6i2P3NWjWcANV8mREbDBPGTMxdr4VthrDsdE=;
        b=VYaGzMgdqoqWwSZg4AaFIlYEJauknYW9/8FlAEaSLZOcd7Xcw2yonbed4JkXHl2cCQ
         Z6NedW433nEq4DJfcQVVs3TRg9RHz8GCWk0CTZNeMGTR5RnxD38HIjsFqPU4nrS92elP
         mfhP9gu03zFlr8YdIgKNgisANhI1z08PdPW7dbqe/6yGR31fYlCIwHSo7FuYk6DhzM0B
         GM9sLCaRnewzRftEGfcCEiStsGXLGQWjfok155y2S8kEZzZ6JC3JsePmrfSc18bRxGGL
         1lJBRKrOd1YpdPYVORdtza334U6wEVUDvc0/FFBkEjfrNkWsZItLoO2ps9HNyNsRVhar
         N9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917878; x=1769522678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Y3Zlef6i2P3NWjWcANV8mREbDBPGTMxdr4VthrDsdE=;
        b=bfiDuTxIl1THXp+IyHF+u+UUdcBsBR5/OVAGeNidW1DqfWoH71miqKYL1jCggcBQOO
         zKrhlWGydZDRtygdkfz234vAWanauzrzCRp0VLBbiAvW6uCQjh+u4i7WMzMVnqULbMIc
         FOGDAJMG852k6z1oiSDzxD1y8fzidFo7Ky3XallLT4HQJxHmWM4v+oTZd2uMFeTA0Asd
         PBWcRHM6Y4I57YlD5V9+gWY44mHnYKlk3pU218ck2j6U5k3Ju6CRQd1CLVeU6kTbexMJ
         A0wYYinMTw0Ragt/xeNar7xCHMqOdRfukCAAjyalttlT8WicR9iQ1mJoAouJNTQ06iTw
         5vLg==
X-Gm-Message-State: AOJu0Yx7U2BfD0ahi4j9WXxKOx8pgkxWaJ9UHVeySkgurEibS/dYSDf2
	XVUgFxJzgwwRouWGuPPQN8o2L3hWLp8/s3osQSm1UptA9QwgCAst9Tn8GtDaGBDtp4oe9B1WwAV
	rnlqNEZqErh7c4RSKNoBp7fjjNegsYoc=
X-Gm-Gg: AZuq6aJbMg0idvtA2/AVVbYyODaPkGlqA/sRMyzqsgsTXUwINlutz3XuSZBGNKWNGZm
	ExteD+yiKHhDbXt2dmu3EaxenUL3GPD4UnoHOzipI1r8FXOnjyTh68EdADLNU93X8aR8vAPLC81
	g8vN++uVitskQZ78hXZ05V1DopZRGCJxbfSC5uEWETaaWK+GOkKMlmUo7DwOpJ06Xmn6YKNW+eT
	qJWhz3qVJukufRoVOny+cN+Rq/q+CQTsD1v5vusn22ii8OB1oOdFAQhWfxGnQiwKF07REvR3M10
	3NpdlHiRuCRGfkXX5q0JmLgcNHpQ5ORiBhsBK2R1mrTtL1UPdNNGoWzl90//wsT8BVkS
X-Received: by 2002:a17:90b:2749:b0:343:684c:f8ad with SMTP id
 98e67ed59e1d1-352c3e568a4mr1497765a91.4.1768917878102; Tue, 20 Jan 2026
 06:04:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
 <xmqqldht2fgd.fsf@gitster.g>
In-Reply-To: <xmqqldht2fgd.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Tue, 20 Jan 2026 09:04:25 -0500
X-Gm-Features: AZwV_Qis1YteynhOPlilsl-nMJocwrSuG6cQITow6D5D-pJILie0bVYGIi7iD-k
Message-ID: <CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Elijah Newren <newren@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 9:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "D. Ben Knoble" <ben.knoble+github@gmail.com> writes:
>
> > The rev-list options in our manuals are quite long; git-replay's manual
> > is no exception. Since replay doesn't use the formatting options at all
> > (it has its own output format), drop them.
> >
> > Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> > ---
> >
> > Notes (benknoble/commits):
> >     I noticed this while reading. It took me a minute to find the
> >     Asciidoc reference on multiple attributes [1] since it's not used
> >     elsewhere in the rev-list include :) I'm not sure it needs to be
> >     included in the commit message, though normally I would, personally=
.
> >
> >     [1]: https://docs.asciidoctor.org/asciidoc/latest/directives/ifdef-=
ifndef/
>
>
> Indeed.  Not just rev-list, but ifdef:: or ifndef:: anywhere do not
> check multiple attributes in existing docs.
>
> "ifndef::git-shortlog,git-replay[]" is rather hard to follow, as it
> is unclear if they are ANDed or ORed, and it does not help to have
> it with negation X-<.  I guess there always is the first instance,
> and we need to get used to it ;-)
>
> As long as the construct is understood correctly with AsciiDoc and
> Asciidoctor (two renderers we depend on), it is OK, but I do agree
> with you it deserves to be said in the log message that you noticed
> this is the first time we use the syntax.
>
> Thanks.

Extra sentences coming in v2 then ;)

RE: AsciiDoc vs. Asciidoctor, it was a bit difficult for me to
untangle https://docs.asciidoctor.org/ and https://asciidoc.org/
(which points quite a bit at the former for specs/docs). It seems that
by AsciiDoc you refer to the legacy Python processor
(https://github.com/asciidoc-py/asciidoc-py/), and then Asciidoctor is
presumably the Ruby processor
(https://github.com/asciidoctor/asciidoctor)?

If I've understood all that correctly, then I have the Python version
installed for building Git and it understood the syntax. Given that
the Ruby version is newer, I think it should also work against the
spec.
