Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C29D2FDC4F
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 18:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023419; cv=none; b=RwRHfC1Ngv+Tjn8v1OtpfFZgsm/5rWq1mbvfA3nQyLuzBVTDXLsb1BcqNSoVenbl1sX1y828u2e3IAX6dCaA01Ppbfi6onRxUxzsJQ0tSUVgerIIN8w646BGlzZqJ2LzjcuX0ZVGRzR4ahhsBPjaclXBe0AcUDZgk+RZWRoNJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023419; c=relaxed/simple;
	bh=v7UD5UDzy8R4Cppw66qiEhHdOfNN53eVpIOFYe1xolc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E447so0ADeVwxY7g+BpSNU2BfPWiPzWScgMYZh8XRxHqq58d5OZrQigc07gRXeh6HUjlz3B/l2WFyh+pOmkRUMFE+ufh1nozrIN+fQSDZVfiM2wROUH5Amk4rT2QiYljbFdmtXtKv7TxEB3O80CKYW/ugv26cPtyM7n6rxYQkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7e6984d694cso129982985a.1
        for <git@vger.kernel.org>; Tue, 12 Aug 2025 11:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755023416; x=1755628216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R224MtS05hxTHme5rUYixF13dukS0IDfmbXjVDWb6RE=;
        b=BTLp5JlQ992vx1hUufOukDztNVTjmDKiQbzq2284jap7xerGJNw/whlJWmleMj0c+L
         MWfS4e1gMRTUw4h4f9SeHnMZ/nQdbdgJ712x3j6IYDDozp9i7PVc6EoAhLdBcIxqu52H
         rrIXP1Jlrra5wN9P2xvRtTtQrzBwSG1zkCMx4MO/vnrxrkgrmQaDL9aRPxWISiLa5Mgj
         Voy34SQ9RximadwcelZ0cIEFKUUcv+FUUmlsWpd/0KDf0GAiM9HXkfwrsgrHwSWgUE+X
         NYNwqaE8lKm3FY8P42IqBB3r5woecoYgR6w8IBHgfMon9sqqUsNiH/5x5wC8guEQ49Cj
         zxng==
X-Forwarded-Encrypted: i=1; AJvYcCXPUodTZhOxq/TcSdCIgTmN+BDzrwbRlkYS92Z1GBJLRCy5g4vvvt2TOutKC2FwErRZrIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ8RbGVUTxAVMPKqBdKrj2XwHCWOA6ebZD3kyY5tyO2sq+KfmY
	yAA8ZyIC/y120nf53eBVozSEv+PL5v8cLN4ykrp6DX/DDNdi3h767/SjN0J+Py7qfEW/+fx+AlS
	k6A/aexJwUKsPI5RKXmn5mIbEMDH1tTw=
X-Gm-Gg: ASbGnctRl0VrO3H2FhO6uWJgc9Y0CK3wan0w/PYsaD7LSp/M4W0D3LURT2zgPpPcV8m
	B6J6JOH/vvf+0VWt8UD/R+7IsJ24NroP6HdvhUncwHxz9zLR6Mj2fMdeKaSTSbMHB2wijP1DDMy
	3OMJOZBv7j3FgK2B84p+BcmFHBVRl4tNDbY1IbtEIUChIvawB1eSVbANSp1PC4AI6BOARSi2y/m
	1dJ6gysbte8cJ0upZ/J/yzkziwMdmenSe1ME8M=
X-Google-Smtp-Source: AGHT+IEkPi55MkCL2IFq8a9WopKZ5/hhLaGJ9cISznWkCcVzlslyinUk/nia8z18o7dp62hA5SfZQK49CDvh4inO/EQ=
X-Received: by 2002:ad4:5fc7:0:b0:707:4aa0:2f3 with SMTP id
 6a1803df08f44-709e8854841mr800426d6.2.1755023415834; Tue, 12 Aug 2025
 11:30:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221706.67168-1-ben.knoble+github@gmail.com>
 <6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com> <CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
 <xmqq1ppgv3wg.fsf@gitster.g> <CAPig+cQMa32G0pqi1UU6hqRAB5709Zcif0pd5uWifqB8d9o6rg@mail.gmail.com>
 <xmqq8qjotn5s.fsf@gitster.g>
In-Reply-To: <xmqq8qjotn5s.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 12 Aug 2025 14:30:02 -0400
X-Gm-Features: Ac12FXwbfcYRVqDF02K_Zejymzqqx3xlg7ACjesedPRIOaBFhPudTCJAZRUHUAA
Message-ID: <CAPig+cSuHoUesmnPkQ-VBXsZFtG_jmXV_DHB_jFHd=nT_D43ng@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clean up some code around editors
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, "D. Ben Knoble" <ben.knoble+github@gmail.com>, 
	git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 2:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >>  ifdef DEVELOPER
> >>  include config.mak.dev
> >> +all:: check-developer
> >>  endif
> >> ...
> > Not a bad idea, though I don't think we need to hide the target behind
> > DEVELOPER.
>
> This target is designed to be a collection of light-weight tests for
> your uncooked code, so running it when somebody makes a production
> build should *not* be too costly, but at the same time, it is more
> or less pointless---if it catches somethig for a build engineer, it
> is way too late.

Ugh, I missed the bit where you had wired it into the "all" target; I
misread it as defining the "check-developer" target only if DEVELOPER
was set, so my response was bogus. Sorry for the noise.

> On the other hand, if you have only started to add a new command and
> trying to see if your skeletal implementation even compiles, it may
> be annoying to be told that you still have to write documentation.
> You may already know you need to, but you are not ready to do so
> yet.  Even though I on purpose made the checks run as part of "all"
> to give the target more exposure, I am not sure if limiting to
> developer is still too aggressive.

Indeed, wiring it into "all" may be too aggressive. Because I missed
that bit, I had thought that you just meant for developers to run
"make check-developer" manually. Documenting it in SubmittingPatches
may be the lesser evil.
