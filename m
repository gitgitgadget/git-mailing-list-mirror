Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF801853
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753534847; cv=none; b=iAX3JSVMSG4Ixx1KiAaE3SxnlMFYDKdH/4v8FcBlk+lPLzii4j6R9vXbOG8TaLoMOwPXQs6FUBL9IaNi7v5IS/VENiB9w3X/4m8fQ0GszACGIpokMN0nuUrbb28kVJz2AR6EQQKrgBb18iISogyWHY9S+9KuIgO0FWRAfwHi4I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753534847; c=relaxed/simple;
	bh=H4xWCz6LXXzNOMVaibkQ3+IK0bl36+6U+y1oUkOMw7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcHLOBb8BTIlNlXdSLl3L/bNg1EIA/bGF04OvABUoJ0Ky9ybtDka7yv1M8FFoW6Q/GGK7DXlIefEhclOAavkDdcPYCMzPlqAS0S71hMDcBLyTTA+uu34WL7vxVQrVVsIMz9kJkCiiUHpHcWM2BmqyxnRNtcTJc/hIBBGrtEGeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RtfM5tob; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtfM5tob"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so636220366b.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753534844; x=1754139644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4P+Mcy78FHf/NQFbeYG8w6A9VW+hqY7siUDIWr/rzY=;
        b=RtfM5tobRk7dnYmStcCMGpR7bY8lC1QV3IMKURfKGU7ge6lKkV72C3W2vSEFJxPZOI
         FTNwOnYfzfF9rYTTBWl5WUdqRXGQBa/X84N7DWAQAzvB6g/qQW90gzlrf30UqAOyDc1G
         L1aRP1MbwDeOvDeuhDZxY5/Eo5uVr7SPxzgKe5350ZlBKb4fwg+4BjlX1AJPHUdcSQ5w
         NS14Seilu+faDB/2F7IlztFt9NTjbZl5ZnJ11E41gGUAaWXZxHSNYOhS//EovPpRDAbk
         y3BwATYEzdzfVUBkMM+Crue8324xIIVMxnl/SbSjkY0IkJzmpvlRs/YuHsfFVlnw3UuV
         R6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753534844; x=1754139644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4P+Mcy78FHf/NQFbeYG8w6A9VW+hqY7siUDIWr/rzY=;
        b=Nix1iV8iyrhpF905JeQN6Mo/YNiKPs2n36C3gW0z7/Y+99uo2KQGmNaKVtfw18P4Tu
         Aiq+vIZfJKs9hjQ3jLrTJUT0IrMRidWoieUEPU9TdwCXV3PONoOWBGxZ9QNx69qiJnzj
         oC8kSkAn1VLZSV39BMA3JstUlSPrjvDd069jt4sWHxHeUet59sjGIxmwe6iWcJlgf7KW
         htKnWfkJzllmXI2EZH6nbYK/3X9mrFwet8eMA0DXh5KUITd3aaE+1dxeHC14gtUfxyB0
         gFv+pf0+BP0yyH8czCkvnqDH7IoGPpxOixQ25Xj73RvcFaiW50gjWB3KhpGXj3rqD/W2
         sRbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU+QbcgodNCX+8dK9YI3iPPDhfapD/t+Ue/8btaarQzJDRvKBcZOtVqG3l/ony22bxZmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVeUJRlNsbi9Khl5QCMxlw9+C9WO3OXL5CtfuSzc+/sQTr20q
	iGkad9hMOU4Ha5ZctCWcfAp/dwawuBhx4tV2pSmgtWXmR419aleU5+4HI9nwIdIkaLcNHpSlaAR
	vF6YOzPUrH8oym7dTPmrN3XzTM8+UEts=
X-Gm-Gg: ASbGnctqNpmVSwkMQoCcHFJcX150PSWtAKp/U0qkR8PIcsecb28rMzFqQgou6A0VbOQ
	hj9W9vDzbbYn6ePyWnzkgFr9gYCZNjLyEPGSWnpxvYtnVQPGMDbHqa800BdCOzHskviZB+y4N31
	jQaVSiCpPMmxCwwU52wbZoCUO5ckAthJcOCWlbrQvS01rwpuvJQapujoDic1ZYd3/JWPukWxlMe
	wus4Mpy13Lk22eAnJVSfsc8ATB61JXbYYf8HB8o7A==
X-Google-Smtp-Source: AGHT+IETVXDYNojFbBHbTpCL3vChUTd6GFVMW0z721YNvB3A05IB0Jk1EUUm2IW4pLRuZ9VX0Fl9AbIb0bft4r6wvqw=
X-Received: by 2002:a17:906:c147:b0:ae3:ee3a:56ee with SMTP id
 a640c23a62f3a-af61c2b41acmr680289266b.3.1753534837966; Sat, 26 Jul 2025
 06:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq34alik2g.fsf@gitster.g> <CAPSxiM9Udi2PxpT7f8DdLn1ihny2gW_H=ieLjV25sEFYSdAjMQ@mail.gmail.com>
In-Reply-To: <CAPSxiM9Udi2PxpT7f8DdLn1ihny2gW_H=ieLjV25sEFYSdAjMQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 09:00:26 -0400
X-Gm-Features: Ac12FXxeHQfWCR58brQOQJrd1RSJUE4AF-B4kY12jvFqgJJL40Qd_n2Q3mBKX3A
Message-ID: <CALnO6CD58LMgGgxGF1DRheeFe-E9zRwAKG=-qsUO=kDB-gTdeg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2025, #07; Thu, 24)
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 10:03=E2=80=AFPM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> On Thu, Jul 24, 2025 at 10:48=E2=80=AFPM Junio C Hamano <gitster@pobox.co=
m> wrote:
> >
[snip]
> > * ua/t1517-short-help-tests (2025-07-21) 2 commits
> >  . t5200: move `update-server-info -h` test from t1517
> >  . t/t1517: automate `git subcmd -h` tests outside a repository
> >
> >  Test shuffling.
> >
> >  Seems to introduce a few "todo passed" when merged to 'seen'.
> Hi Junio,
>
> Is there something that needs to be done here ?

I would interpret "introduce a few 'todo passed' when merged to
'seen'" to mean that a few test_expect_failure's are now passing and
need updating.

>
> Also, some tests still have both the `git subcmd -h` test outside and
> inside together
> and the first patch of this series already tests for all the outside repo=
.
>
> Should I send them as an update version with this patch or wait till
> this gets integrated ?
>
> Thank you
