Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87315135A69
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337456; cv=none; b=rIhbHL/oBzmEwsatiHuCYK1DOFrNVQLQ2BaXU7nzr3kADOPTRozMFeQNRMfJCWaBWXWq7uVxA0sfUX7uSc7CQBtsmuX1fQRQBn0sGnWT2y+TokwiRuO7geKfLJPNa46aQrIG++evWRpEGBo5Qc55IA88nzzfqdLRHwO+XiDCKx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337456; c=relaxed/simple;
	bh=QqOQN796Ob8k9Jm28rh8xkQZWR1woCoWJ/pVJZayKeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2WGd4ai0C7hSZAeC4OfaL9V7eSI1gUESlvXwkslYELgUnx6CPtSumrQQVhkWqHWLv1N2p5xoaB47mYUYjk3YLos+wIOT2Hj5GQ5uCxiW/rTFlPyhXzKNC3twCmwDnzfMErFy4Rkvg0ytkIvMxzBC4nyl9Pu7/JF6R/Xcv8NPCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y94BDqQn; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y94BDqQn"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-36da84df7adso16192075ab.1
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719337455; x=1719942255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uF6h61T415IVoMcTnhJQcRrKXO1TYD2+OA4xRmWrm6k=;
        b=Y94BDqQnB5rqjcsRq7bf0qhhTKpUtREIxRMSiNDNdpSnFKqxaUser09KGxXa0beehP
         2EkroqRe8MQVU8kOKxItDSsri0plEolA+i/BmT1BhVGS9q7MOxNCbaa0qqwXAo3SdBsZ
         uc7cP2QsdPKbKYJV+aGDgo1FDTmw3P8AtUHq8MlXNwcWUWGRBE4yEqRZCLmx9D7S9vlU
         oCjRuH4hGW866U2E7bxM0deDsHQWRECuKvW4qHohdANdCpaRyCS1atNq8F51X96o+d9D
         1goPTNeLfc6Ah4f1io2UKghMzTO/LVoKhOb5t4QUolnAdqcOteDM+9GVMmgCRFv7Yt+A
         yuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719337455; x=1719942255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uF6h61T415IVoMcTnhJQcRrKXO1TYD2+OA4xRmWrm6k=;
        b=XOap3UvK5yPtSUgsrCV3amzds7Ku3iEk4vMSO5PWJ5vI1OBxphvXs0yU98YJENPtvM
         fyExWSaZAbS63vu5bu67I+ckrI+63KRPX3yYDpcmnVlv6MPdhlnLGNDNJISXynMO+xiU
         9f/pxvFBuPAGhX5tDNagBXxkanBMaBYYE3LracA3POhLM1iMBehQSF5m2KMTluwTb/7i
         IOTuTwUID465SAPJzVL46I5T/VGOuetkh9iPcjKlsySOkpx5oYzrwfriJaj6gd8yCMjS
         utkDEYwe2Gs5raAv2YES2Sv9bRKHxTQg9SxgxtToorykABgaw0+BIBEEfb7EK+fak54E
         6qGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtDgKCschXxUuurkkNaUcI9vxuEikGtxro2zDCMn5uMfn/asjaFRhaF/rLRNunpisIh2It8iPOD9wDwYMFOhsI01h7
X-Gm-Message-State: AOJu0Yx3ED5Lzo8jEkfRoju8QvkyS7Tnig41bvKTumn6ns2WNfMsVEEj
	K/yFxW8Ut+SnKpdekUTXIvgsvt+yopqEz6EYYReRQAC4JCseZw5U/GKhOxFL4wkFMp7uInOMrSl
	jetgnUphvWMgSQesur1NiPcAmHjaasA==
X-Google-Smtp-Source: AGHT+IGxUGddwYacKaAQ9XP7lQa5OpwwZ5SeKi988z645+XcPOSP76bU9ItIBlK0MUoVpS/ONuARKtwNehXKRo/TjGg=
X-Received: by 2002:a92:dccb:0:b0:375:e378:1014 with SMTP id
 e9e14a558f8ab-37639ed83a1mr41540775ab.7.1719337454719; Tue, 25 Jun 2024
 10:44:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
 <20240611075137.GF3248245@coredump.intra.peff.net> <xmqq34pjxzva.fsf@gitster.g>
 <20240613102409.GE817573@coredump.intra.peff.net> <20240614102439.GA222287@coredump.intra.peff.net>
In-Reply-To: <20240614102439.GA222287@coredump.intra.peff.net>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 25 Jun 2024 10:44:03 -0700
Message-ID: <CABPp-BEaFUH2QaAW+9B904cCN_h8oyxTaSDMkK=v_yZua=A1kA@mail.gmail.com>
Subject: Re: [PATCH 0/11] allow overriding remote.*.url
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 3:25=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jun 13, 2024 at 06:24:09AM -0400, Jeff King wrote:
>
> > > I was expecting (with excitement) a mess, but the above is as clean
> > > as we can make the idea, I would say.  Lack of documentation and
> > > tests do count as incompleteness though of course.
> >
> > Yeah, and we should probably do the same for pushurl. And I think there
> > could be some cleanup of the memory ownership handling of add_url().
>
> So as always with this crufty 2009-era code, there turned out to be some
> subtleties. ;)
>
> The good news is that I think dealing with them left the code in a
> better place. It's easier to reason about, and a few possible leaks have
> been plugged (I don't know if they were triggered in the test suite or
> not; if so they weren't enough to tip any scripts over to being
> leak-free).

I agree with this good news after reviewing the series.

> We can split the series into segments:
>
>   [01/11]: archive: fix check for missing url
>
>     A nearby trivial bugfix.
>
>   [02/11]: remote: refactor alias_url() memory ownership
>   [03/11]: remote: transfer ownership of memory in add_url(), etc
>   [04/11]: remote: use strvecs to store remote url/pushurl
>   [05/11]: remote: simplify url/pushurl selection
>
>     Fixing memory handling weirdness, which is a necessary prereq for
>     the "reset" operation to avoid leaking. The switch to using a strvec
>     isn't strictly necessary, but it does make the code (including the
>     later patch 7) simpler.
>
>   [06/11]: config: document remote.*.url/pushurl interaction
>   [07/11]: remote: allow resetting url list
>
>     The actual change is in patch 7 here, but it was hard to add new
>     docs to the rather anemic existing ones. Hence patch 6.
>
>   [08/11]: t5801: make remote-testgit GIT_DIR setup more robust
>   [09/11]: t5801: test remote.*.vcs config
>   [10/11]: remote: always require at least one url in a remote
>   [11/11]: remote: drop checks for zero-url case
>
>     This is a related cleanup I found while working in the area.
>     Arguably it could be a separate topic, though it does depend
>     textually on what came before.

I only managed to find a few typos in commit messages, but I looked
through patches 1-8 pretty closely.  I only skimmed 9 & 10 -- I don't
really have an opinion on the remote helpers.  I agree that the issue
you bring up in the patches makes sense to discuss, and the route you
picked looks reasonable to me, but I don't feel motivated to try to
use or understand the remote helpers enough to form an opinion.
However, I'm a fan of the cleanup in patch 11 that your changes in 9 &
10 enabled, so if everyone's as ambivalent as me (and 15 years of
things being broken suggests everyone is likely to be as ambivalent as
me) then I'd say just go with your changes in 9 & 10 and call it a
day.
