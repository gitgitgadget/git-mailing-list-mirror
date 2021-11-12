Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C291C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2322A60EB9
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 07:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhKLHCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 02:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhKLHCv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 02:02:51 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196CC061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 23:00:01 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id be32so16253899oib.11
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 23:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIfIQeGSxt7dfGHDEsgivGbmWOHoYwTazT/EdkcZ7Qw=;
        b=e5pb7TRvfqyt6L3ZmMsXXAAN0z6qWDzzBnLuDAW/ySe3gzLkH8Z3qOgGHfx/PWO0hu
         TV55PTWn7hjczfampAbOkrBo9gBuTQXcljthqxZxQAaIExAUFltYhQzbtXH0dn/vRMFR
         5uP5w/GOuOcRnyr7KNthmJwZ5T9a8mDEoSO9iCRKhQPSGT2+rREAutcsL0I4sQUQ1nTy
         5MLsTzDdNv0ba87MsAKA9NQ54S45Zkkna+EYksWkDzLTGRcAbZvHIHkHZHYsgqTflGIG
         VOOV3Wz+Ji4fyKTiYIXuLihJvEy+q0sO5dgTLqj9uLB49EIpYOKIwnySATJbTaxllLLf
         EBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIfIQeGSxt7dfGHDEsgivGbmWOHoYwTazT/EdkcZ7Qw=;
        b=58BupRwQXTkhGUaaLOjHNIgTTVzbPFKubtMrTE1iKXuWA0vygMoS/O260HjmfuYrms
         iUK6uMI1lzSb/WfKra0EgQhh2Fxoj0H/JVgwP5z+VnIe8OyJ/hePY6/0EcmA+HiMIWh6
         EIF5EuR9xZlxUtH/3FHEJNnw1ALmqDVhPwchWgXit5UNOrtkqWXYZZwFOO7Y+EA2CCBc
         3QUBRN224ltyPAyrK+5XW9USUUCNs1SOLVfrcgt381FM2N3BhGZdAeHiz9dSCR3Q870J
         0BmLP9sOj2iMLoBIokw8Uoo6WUOJkmq9NoWyvuY5mHOlIQ1vDR26HiwmW+Bt3J8OrHqX
         x33g==
X-Gm-Message-State: AOAM533k6YcJahbcGSZo3QG5SM/vBRhHlE87ahRbov6XfPPfrJSIjbI0
        ybDW3mcmAKoB4JVEelvYbmAOCMrUsRIrK6qG4cNH+3cJDEA=
X-Google-Smtp-Source: ABdhPJy0/vUa0rq4AeKjWManL4OJjoynxzY54vVMJf5RhqQFbzeWCNuRAdT4suHSggoSlWB4YOG9rr3miAaj22fIbJQ=
X-Received: by 2002:a05:6808:2cc:: with SMTP id a12mr11391565oid.126.1636700400383;
 Thu, 11 Nov 2021 23:00:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHPjYFyzPpUmfoCbvaVg25ZbhkHU8QtxHBmAh2gdT++Xr38HcQ@mail.gmail.com>
 <xmqq8rxuj8s8.fsf@gitster.g>
In-Reply-To: <xmqq8rxuj8s8.fsf@gitster.g>
From:   Theodore Li <teddy.litheodore@gmail.com>
Date:   Fri, 12 Nov 2021 01:59:49 -0500
Message-ID: <CAHPjYFyH+GuBG8QNzD36JhoJWyNnEXfqpn4PUJV0ANF2ertYZg@mail.gmail.com>
Subject: Re: bug report
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, though other patterns like !/*/ don't need the quotes. I thought
it worked the same way without the quotes in earlier versions, but
after testing with version 2.32.0, it seems like the behavior is the
same. Guess I remembered wrong.

On Thu, Nov 11, 2021 at 11:30 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Theodore Li <teddy.litheodore@gmail.com> writes:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > After cloning a remote repository with the --no-checkout option and
> > executing git sparse-checkout init, the bug occurs with any
> > sparse-checkout command with the /* pattern (i.e. git sparse-checkout
> > set /*).
> >
> > What did you expect to happen? (Expected behavior)
> > The contents of .git/info/sparse-checkout and the output of git
> > sparse-checkout list should be '/*'
> >
> > What happened instead? (Actual behavior)
> > Instead, the output is the contents of the user's local root directory
> > (i.e. /bin, /boot, /cdrom, etc.).
>
> A blind guess, as I do not use sparse patterns, but perhaps you did
> not quote the "/*' pattern, i.e. you typed
>
>     $ git sparse-checkout set /*
>
> where you would have got a better behaviour if you typed
>
>     $ git sparse-checkout set "/*"
>
> ?
