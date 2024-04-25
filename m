Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6C12C7F7
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078841; cv=none; b=QKYJGsufopo6ESUymXOitnzTi+AcFCdJVYg6XTsCNKo+LZMtM8EQImFDf1f49RB8njlnU8Oi1TVnSAYsgWTz7rdgNAHqHJwyNHg7lIfmaRPtzD+3vGdshpPO2VuHu3ybPUYZFYMQnYsQWkqhiov9a0/Qk4qxG/zJ2jBWG23mjl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078841; c=relaxed/simple;
	bh=ORqoSPNrxQGl93BTOmckebdx3zkPeB1jCFwdAzFp+kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMIRcnhahuz1mOozPmQXpwnoeu/NAm6bQ4gC0t2c6dyLxYz8VEGDVgNfE1rCA/Kz6zSoBKUhPyjnfGa49p9pk+FTqp5CsKzs5wqrdNbobge4C9l6uXurlL5yJnbPanutO+1nHtekYE0AWZGpIBTk+de442dyNFsktUG177dJw5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c749aa444fso901047b6e.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2024 14:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714078838; x=1714683638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ORqoSPNrxQGl93BTOmckebdx3zkPeB1jCFwdAzFp+kw=;
        b=aV52Bajl+IpxL5Y52aPH3okBt/D16OMji/ZLhPCB7HVPysAKlfl+z58lKiP1b9V9pb
         CcrEalhDSaXZcgq3f45CJfmQ46B1MLnin06RZy5tnVrak4mhbyM736mO5fdo7qLsLb2K
         s0mZ1ouai2sASGvF/KFkaY34NE31p+mc+djG+ct951JGGiKhdpnZnySkkQ61sJfUqbEN
         /yLUOVEjyF72azaznV4B98AvKyE1lTtPwqTFPMuwitoMQrfvXN0wuyODeNRYzmlE2e7m
         GQrC/AKcwKPb6mxLLMZXQ6nl8skKOZhA/dUPvF8ElUErvNF0Oy+rvBO7ELp5ip0Thi01
         xHlw==
X-Forwarded-Encrypted: i=1; AJvYcCUoT69pl3hFTsQm0FCtN+tzXAUTQrm4/z9K0eaYKWZI5bMgLxuRdcw/m3AsNjh6kl6AAEddL4eJAVr0jghWO6t0nYzu
X-Gm-Message-State: AOJu0YyZECsj3pOUXTJzZtNxENUjCbN9KEUf0x8i6iFZi1OwIVIL9mtx
	kElPanUPYLXhUtmME+81G6NMy6MDPNzrMQosvWLNQuAw06bDlh3tNgN2rdDuKhqLUl063VT/Msw
	7k55cJ1K37EuekV4UZi5xuwP58II=
X-Google-Smtp-Source: AGHT+IFLLI8XmUM47Kfj/Y32aaZxYJH1x1DB3Ct0XcbEW1tYifzXF2HXMiG/qggntDe36KWby3E5CWbw0GaM/xzLI5c=
X-Received: by 2002:a05:6808:2026:b0:3c7:48a3:b28 with SMTP id
 q38-20020a056808202600b003c748a30b28mr1181045oiw.0.1714078838701; Thu, 25 Apr
 2024 14:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com> <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com> <20240425014432.GA1768914@coredump.intra.peff.net>
 <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com> <xmqqedatfay3.fsf@gitster.g>
In-Reply-To: <xmqqedatfay3.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 25 Apr 2024 17:00:27 -0400
Message-ID: <CAPig+cRerw2SnkEK4-_wiPopGii+Eq92UiBmqib_oBgArty-Gg@mail.gmail.com>
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 4:23=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > That's very reminiscent of [1]. Although, unlike [1], the output
> > presented to the user in this case is (I suppose) less likely to be
> > messed up; only the combined captured output is probably affected. So,
> > capturing stdout and stderr separately would indeed be a good idea.
>
> Between adding fflush() before err() writes, and updating err() to
> write to the standard output stream, I am in favor of the latter for
> its simplicity (of the mental model of the resulting code, not of
> the patch that is required to do so).

Writing to a common stream (stdout, in this case) for this sort of
interactive session is indeed probably the way to go, as Phillip
suggested.

That was also the adopted solution to the cited similar example[1];
git-worktree was changed to send all its chatty output to stderr[2],
which was appropriate for that (non-interactive) case.

[1]: https://lore.kernel.org/git/CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZH=
SiLX-brOQ@mail.gmail.com/
[2]: https://lore.kernel.org/git/20211203034420.47447-2-sunshine@sunshineco=
.com/
