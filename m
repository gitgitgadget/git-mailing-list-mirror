Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEF2C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 18:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353520AbiBCSdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 13:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiBCSdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 13:33:15 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F06C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 10:33:14 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id w21so6770119uan.7
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4vF2Sl2r9JXy+SGWlgTi5M781OCbeD2o3XztMZi7/ys=;
        b=FOYlxNgKEGy85qI0t8kxftPlTVn8B5WvNK9QRJOXUQ/5O6fu0O+XUdxCBb62uCjDKc
         gUEu2+u2AU30f44t+dPzM7zAxnHUPL5a9eKYgopAcaFw9bzebGB9qFxYdBQbG9AsgsgA
         2RNua6iPZ1f7LxYOpT04lZr4fmpVsOShkQhB0RJcOBHTz5cT9RZ/UnzlWUJEKkGereHX
         W3dxAg8c8s9zZdHpJwHAKvOr4vy/jygiNEUoGOQZkn+e3OUGzQb6GzY9+Inc9YK797Ar
         WhZEW9K5LIygw3lAmXGfoSDj4HCgeNHgb/pKkFnxkYV/ijn7wIOTqfnR8qBq2ofRUSWb
         mgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4vF2Sl2r9JXy+SGWlgTi5M781OCbeD2o3XztMZi7/ys=;
        b=n0A4eovI9pNuYam7Aym2QLFkfDyISGvrX8rCNToTD0V86Eeyb/FGQJlUtE2D9e1Uxo
         daKC7u4AmWQKGHQScao8d0xnivIZClMOqzq8p+iNG8o4TFpolvsVIIPoHHbgE8Sfrnyh
         o3iD5MAaGy59yMTHRACHiGdUVYhFjT7rNP7Z7s7lRyXpS5WLh4+VjtpF6zysqNEkSpKd
         inylPjSeUAv3icWn2iOvlU8FPkT44hv/Dqch7FjPXicQ8Ueqb7yIOu75GyK0GXMBm+cg
         wFwqHt//s9CYTPUiamCymcJzBhtpICi8ML28RZg7+SrzaAmLmU1+CdW3CColhVJ7G6Zf
         QXkw==
X-Gm-Message-State: AOAM533BgxirfNYg08rZOPT+kBnDdyZm501TnFS6bRAMEKWr2TOPKV+e
        TehqoGfUA1u6ahesdKLkrmMIgxJZTeFPa6CVX5VNRTp7uHk=
X-Google-Smtp-Source: ABdhPJy5eti27D5REkBtbNiDm+byQYzuLS561xZzyk1Rg9kZvqUhW25S4+O8/ODsmYTkB+0cb3rm4/RQuuqT0aqZ7dk=
X-Received: by 2002:ab0:2a07:: with SMTP id o7mr14944826uar.39.1643913193964;
 Thu, 03 Feb 2022 10:33:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1210.git.git.1643660136530.gitgitgadget@gmail.com>
 <pull.1210.v2.git.git.1643719616840.gitgitgadget@gmail.com>
 <220201.86ilty9vq2.gmgdl@evledraar.gmail.com> <xmqq8ruub35i.fsf@gitster.g>
 <CAFQ2z_Oxq67XO20oG7Tokk48wm5ZzHRR3GDi4PG5wg7FMJ89aA@mail.gmail.com>
 <220203.8635kz6d2o.gmgdl@evledraar.gmail.com> <xmqqo83nvm8w.fsf@gitster.g>
In-Reply-To: <xmqqo83nvm8w.fsf@gitster.g>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Feb 2022 19:33:02 +0100
Message-ID: <CAFQ2z_Mmfp4wrHNo92ke7i7UF2bDL9v4oddRC4UKN0R9h2C-6Q@mail.gmail.com>
Subject: Re: [PATCH v2] refs.h: make all flags arguments unsigned
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 3, 2022 at 7:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Yes, enums or not, what I was also pointing out in
> > https://lore.kernel.org/git/220201.86ilty9vq2.gmgdl@evledraar.gmail.com=
/
> > is that changing just one logical set of flags at a time would make thi=
s
> > much easier to review.
>
> Another thing to consider is how to make this play better with other
> topics in flight.  Basing a huge single patch on top of 'seen' is a
> way to ensure that the patch will never be useful.  There won't be a
> good time when such a topic can graduate.  The topic will also have
> a hard time keeping up with what new topics add while waiting for
> what happen to be in 'seen' today (some of which may even go away
> without graduating) all graduate.
>
> Limiting the scope to small and more stable subset of flags that are
> in 'master' and does not conflict (e.g. no new bit defined to the
> set of flags, no existing bit gets removed, no new callers that use
> the bitset introduced) with other topics would incrementally improve
> the code base, and makes progress in the sense that it reduces the
> remaining work.

OK. But do we agree we want to use enums? Me and AEvar are in favor,
anyone against?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
