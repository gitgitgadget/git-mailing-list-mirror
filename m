Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793124231;
	b=Hcntiwps4UGC2RqsefVwUU755Kp+2nngSweCpRwzri/F5/ymyYlRD0zPYfUoiRY7ZwMt
	 TugTcvpAumEiC0HyTRhkH7ew3vkpLRInWmbu7mI69WRq+QCsZBaFMuqyoNhCJmGJmSZ7q
	 9gAxrljypaa//oSDFowZ/XZbt7LFmJChD80FvWHIjLZzeqpxehNme53RtqhcJElMGQ3jo
	 sSIFSOmxtqjLz4jeMcoX4Pqy5QNwkw0TvXX59brKlGWTM0ASXWz3IBwpvU+5my+U3/D9l
	 U5mgs4OYD4/r5KD5GS8tojT68n0p+n3jnz1iJjxQt9v0oGtBXW1c7zAJueSW2F+YMDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=c3YBAt8ytba6tpH5T9YxFuV6wypKWX4Ump2vcGirm44=;
	b=SYqR9zdSp20Zfik5JXQ/VWt9o3NneuX97gK1POaiNbLfy55M07OeFTQyL3wrCFxczWy/
	 TY06hjXU707kDT3XGH7BGfzC/AB2wg+Vnuia2Chw7ZQ8D4vPuReKxuvxBEMTnJd1PpeFd
	 nlDEQtZx7pTqB24U3V7sSyug43/Ib2IAPHfifmaEiXugLBzYjsUxGnsXD2QcI+y3Q9ReB
	 pTpCKjNIGtyCarAwYbm1PHwkT0BKoRsdADbSuqIhUYVx/guJsNJgJ+DJb/3YgdsWK0vc+
	 aTfcmiMqdGKQpr2Y/IYfYrhlfYv9hXrZfB3EqV2fAcVKicwx5KctfRfVERc1NDH0FZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fNCKYZXT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91F606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E91F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fNCKYZXT
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b12b1ee403so561357b3.2
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 11:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793124230; cv=none;
        d=google.com; s=arc-20260327;
        b=M5anBtkAU/AhhSOco6DLb2ZB79Wf5v5tY51G5y6RTRlZWWsBuQ9zYWG74X06B9NPHS
         LCJR2yBKgLvmDPqcrexogoowoPY3pjDXX2N0dwOUhXT1JCSQ/SLSmg5oQXdKQiWKlxMP
         hJRvqVqeRV6RN5Vo91H2GwkKKxA8xxnCxmV1/eAw7UbBbC5LVPpVot7Z9MdHLjwElPfZ
         GDZc2Ysq8DhbTLFU/jdXjDf4EMKOtVN/I4YdKxWtUzHyOymKZEM8n18z1S8sOKc1MR3j
         PyOHmq6hp6vja5bhpVGypyZbhHjf8adAwSVOjHSAWD94P2FXiItVSKzUNcyCsq0hJ5A9
         o47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c3YBAt8ytba6tpH5T9YxFuV6wypKWX4Ump2vcGirm44=;
        fh=BXqqyNtQOUsQ62vRtIQVqtJX/2KSlct6lek/PqLlCqA=;
        b=G64DvD6Yd57sWEvzxekKYKX5heBT2Bqf/UnDRfJLjJdRaXyBBeBph4f4LSqGWFTyeO
         DBzBMbMQG+2EyXIAt68TI3Mf1r+WjAoSZhFOv9o1yWSunTNZzKL0BbGd9rzfmzwW9vgd
         NEexELolKlEgSt5xER6aQ5p3O1t9Pp0xrYGXUI/HBKINVl95grvZKRWTZ6ywl7beQncD
         KzwsEDblD8x2ntIopMepbd3J8OCoGyjS8ZTp0CP0414xOuRvFB2f8S2qvhmMzBSYhnX6
         RfwCMQxH32gSzMQPbkRkFRqSqDFn7n0CoXBt0/qtxjrPkJrUerQ0MSwJNyUGgGRSIvFK
         M6aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793124230; x=1793729030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c3YBAt8ytba6tpH5T9YxFuV6wypKWX4Ump2vcGirm44=;
        b=fNCKYZXTznqv6cOd8rHneCoCswQK7aix00bimWVzjD0zeJmKIA6p2pCEy9HoTj/PvZ
         +hx1k2AlsACu7mSIX1pSv/5mTnpeLJ7Hb/GoEeMlIbOlgquOLQBAzWj+QGFL7cN2p12W
         bG4G4nDTT8fUGsEQkLI93gKMwjmJIr1FN9r+6wpHSOO+wqjLQlSRi5VFDfatBgaWwS9L
         V6RhB0h8Y+rzMtz7RFVVoG5Jnjboc720ofbYe9k/4PxMt9F+TLRZu8LQpxWq1dTJBa3y
         TU//xENIbPUMnOeeC88SdOfpshsbJi+qAMEQWZYSgHZyE4SRpdNuSmF2SPxL663F3fqT
         6tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124230; x=1793729030;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c3YBAt8ytba6tpH5T9YxFuV6wypKWX4Ump2vcGirm44=;
        b=FD5NlYKnOtmoMcO+LiI1rZpragrAHWGHrc0N4YQpFYq+EL9dpc2Zzzg+000hDJcG+E
         nR4tQ5IbU9WHuUKOgYoS0KZ/us51WN5VH96wi1BOVcJss5swB24fBRsOhxgRjku+28vC
         ie3Lx7d+KaHPTwWN30yRO84cq46evBGr1lULyaP0vXXiyZQHxQ9UB2xJwsorL2shQDzF
         iCzlrpoleATLrPXCgYU21Q84J6/dxGO7tgIalCKcjRkZexzpozhixxMcjJvJImFSUs3/
         DCk95jMmdP6tRZoUwo7SfHQVeRTRt55k+tUaVYdOrrtgWn8iigZ27uGZgCYB5VdEU04O
         J4Ig==
X-Forwarded-Encrypted: i=1; AKwUvBzUnAl0Dm/7ttDUW9fcnDyZuXZ93dXtpiDlFfZk7YQRPlXKrEet3z42hG3k7jM8ST5h39w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdUZWB8po89u7k2kpWSUaA2BkyP2qmP7Plw3WJFM32X7CLtcY0
	ABajY1r+lLtu2tdXqTTPdk4HOLHE1g+4CDCNa5Zfr2J1Ir2gwIyOlIJAvT79mWLalkZ2lcP0x/k
	Zmvlu42XBGGXoEenW9Klj8iDo/thOobg=
X-Gm-Gg: AYBFou3UnSYYOuk2/mLhnTV+cqawcR6R+lpMR6rC9ZzABBvhaDv93qok6mJlU1sSMDd
	V8FNqx5iCWFx51EpJRguZEtx/vFMehy/Kr9CUZx/rZs5fw6Ny+8PaEfuqyhHcUNpWiKsIar3swB
	fD1drXdtoyFpCJGgZAPWdEl+RUzehnT7SkF/bzuUUPc+/Lnnk7dIw7dgsXYxPWDU/WgRW5KqUCO
	It5cGOTZT5lws62DB51g8hoPp9Jn52j53rqRNYiFrm25HFxlBYWCPlKTPQqWzt6NCOphOICboqd
	Lmw8mqQT4v5OqmoRBinDDzexZyRFEBXUQaJYTLcXNb3MM8aYY7IrgAQ5lA7Ib41CmIeWRFgDzW3
	DGRyXdQk9rWOO5OSDAJgpcPw7SkV3dYgHqM/POYpQ994osDGUDQdFj81aOuK9Ri/yFDan62xlfJ
	6qfsyav82SD/gp28eac5cLwc2gM+NGx/kJhjw8W2E0tlRnBsr8TAcusoNRE2qcnYGVgdOl1UXuq
	1t/F9Nlvu8Sh22K
X-Received: by 2002:a05:690e:454d:10b0:671:506a:9fb5 with SMTP id
 956f58d0204a3-67a7bc5311bmr206161d50.35.1793124230302; Tue, 27 Oct 2026
 11:03:50 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
 <E45A3779-A25F-43BC-B490-1FB836EAEF39@gmail.com> <xmqqh5i7kpc0.fsf@gitster.g> <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
In-Reply-To: <CALnO6CCGLFwFH73of8QHnsvFjHZ8d86CRhQgV88z=WeKun6abg@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 27 Oct 2026 14:03:34 -0400
X-Gm-Features: AclHuK901r9sdga3oJgzXR7Ydm-2sHX4jTuv3nFOvc8Rub6jXzbIdpICnAe5syE
Message-ID: <CALnO6CBweMkXMZZnhOC7CERwVYfnWFKr+KHd0UiYzriiD4vdDw@mail.gmail.com>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 2:00=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> I can't speak for Julia, but I read her attempt here to clarify things
> in line with the ways folks usually use "ID" vs. "name." Of course we
> don't always want to let what other people say dictate our
> terminology, but in cases where we can make things easier for folks to
> understand by using vocabulary in line with their expectations rather
> than subverting it, I think that's a worthy goal.

Rephrasing this: I'm not sure I think it's a good idea to expect
everyone (esp. newcomers) to use what I view as idiosyncratic
definitions of "ID", "name", etc. Yes, we've had them for a long time,
and people mostly get by=E2=80=A6 but it can be confusing.

We have enough jargon, surely :)

--=20
D. Ben Knoble
