Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7A0C433EF
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 02:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbiAPCPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jan 2022 21:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbiAPCPs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jan 2022 21:15:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8937C061574
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 18:15:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q25so49797334edb.2
        for <git@vger.kernel.org>; Sat, 15 Jan 2022 18:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQhSm9oiY0QWgYQy1iTvpfPE/8FxRmdpViTr/jQXOCE=;
        b=jqDQuhrsNfoKQRu7ErHJgXrH/okmHJt1WHJV3DRZkE2UODYSH7JWaX0wHfXcBGM072
         +17SZqy8gI6jgNm7mlDdXfx/rnoS9C8HJfPTSU0hAQflKrnwC9zbeiDnYuLOuUafzrTi
         gxZR6ZuWWjCkUEg4QTNZeIri+yyIqACP3afPY7ZxyepVCUwi3/g66+TeBEvyR0zGlNyk
         2fonGZYNE+b9eHcHBXrZSbm3AfJ6+FT8PlLA5XL8NEBGr3ugRLqjM/C41FgnrNU9vjGv
         +GgdXh0pEEI/FwohdQTe/frVaddh3FNRVGxoWc72kx/rISViJosSPxeY3vBYo3LCfiKQ
         4mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQhSm9oiY0QWgYQy1iTvpfPE/8FxRmdpViTr/jQXOCE=;
        b=skhcm1ajygGEQtW1aSBXJHJWAJ3B6A0fac6tdYFeTp9a92Jco4UHs1fCKuGKV/MZgN
         +tGoCeZ5lGmu41wfi26pAFNDzHNdNhi0Jk7/jYtvLBM1nu1ArXujvKEiF6HVnK3LyRLE
         zajDlnHcS0UPEtH3QD76Af6PezTP2RimlREJ8uFHXiR2wzt0gk+DWdhvZ5BtuvVDdJvq
         xFkPn8HAFdrqcxk1Nb8swemsIloBJVVsdoXMlX13WSnLZix6t9l4oZvSlxZAk8I69G8J
         tUNvMpn49yhmdSmHTwLpaweo2AzFR+MLwiPA+K7hUkWXFQFKiqLSQjaBpoGMuT/4TShI
         ohig==
X-Gm-Message-State: AOAM531wmoct67gPLqcZ22cK23r3kI9dzk5o8odtNyfeV6e3DSak+/xu
        UpMiofpmqgZlqlBMfv7TIbhzHxRce6uwso/uTyU4Bgry
X-Google-Smtp-Source: ABdhPJxLQYjU/jId1biflWNRVSiNiczdAHOP7d08cdu3PQWSmVyR5Xv3wM41XWH5PNlg8WQEfSgqI/AqQIriL8TuB9s=
X-Received: by 2002:a05:6402:16d1:: with SMTP id r17mr5369864edx.284.1642299346342;
 Sat, 15 Jan 2022 18:15:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqq35lrf8g4.fsf@gitster.g> <CAJDDKr7bYP7JNmY7XML0rkxv8uCKAbO-LdAAn0KkyTq3UX4hkg@mail.gmail.com>
 <xmqqo84c4xqh.fsf@gitster.g>
In-Reply-To: <xmqqo84c4xqh.fsf@gitster.g>
From:   David Aguilar <davvid@gmail.com>
Date:   Sat, 15 Jan 2022 18:15:10 -0800
Message-ID: <CAJDDKr61fZhSOmEYzwzMgmsR7e84SwpJJ9==NV-4aepAKp2u8w@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 15, 2022 at 11:15 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> David Aguilar <davvid@gmail.com> writes:
>
> > I ran into the c99 test balloon. I get the (expected?) c99 build
> > errors and an uncompress2 build error with RHEL7.9's stock gcc 4.8.5.
> >
> > Are we dropping support for RHEL7.9?
>
> No.  Our expectation is that those who care about various distros
> and platforms supply patches like ...
>
> > Using NO_UNCOMPRESS2=YesPlease and CFLAGS += -std=c99 in config.mak
>
> ... this, but not locallly but to config.mak.uname, to help the
> users and builders on their favorite systems.  It is better done
> sooner rather than later.
>
> > works but I'm not sure if we actually expect users to deal with those
> > details themselves.
>
> Users would not have to, as long as somebody else on the list uses
> the smea system as theirs cares enough to supply such patches to
> config.mak.uname.
>
> > Sorry for being out of the loop on the plan for older toolchains, but
> > I wasn't sure if we should be expecting a patch that configures the
> > default flags so that things build out of the box again or if this is
> > considered the new status quo and we're okay regressing?
>
> Obviously the former.  This is a team effort and everybody who finds
> new issues is very appreciated to chip in.
>


Thanks for verifying; patch sent. A simple $(uname_R) check worked for me
so hopefully that's not too much cruft to carry around for a few years.

cheers,
-- 
David
