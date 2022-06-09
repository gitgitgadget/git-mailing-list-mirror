Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA9CC43334
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 05:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiFIFBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 01:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFIFBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 01:01:53 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C17219117
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 22:01:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so25737906pjo.0
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 22:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q/ASo8+iH4WrexNJHVXUn2ErKhgGvOL9EcYkgFXn1+I=;
        b=gacHeWDFOarPFA8KL2XxknXw5yUXH1Ak8tiK2unOMkrAdiUcJKiYb+U3MDVYvHEKdx
         8ofymG4beju9rulQwobde82gRfFx6eJPnfZCT3cvbEOh8vJuS7ZYD4j2wUibe45dU6qn
         zbR17GuFU23ioIKxq/QZaSfhAfIBDybeFoSxcGye/YrO2AdJ9SfeU7bxZKhlw1VoXZdP
         1y4FXTMJvWR0J4EqXz9av3BbznkAyB06qec40rOpTVzilXYu8s/+1UTreuLidfgCZIcB
         Nv6VVv2SvaRZzPBHWcsIeuge/3hbmz8RPYnlDDhyWWq6Bg75NEvxEmpE+Fv8b+bQXOXU
         8tCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q/ASo8+iH4WrexNJHVXUn2ErKhgGvOL9EcYkgFXn1+I=;
        b=DH2w4fI/PyNGNC049ftrg967R8NaTN9QkMHtW63RXzop0wZiQK8WTV+L8D2LQmqnS4
         LllCUSCgn4hB40kDCTHU326TI0r8iduAWWnSf8bCdzJZReGk3yfvCYGBoN/SxS6oOLOP
         r3wjpWAaowoybR/jbNej3ONjeyijpcax0DsZFr0u45O5OTaF10gemLvq17tj3fq8Dva3
         Q4DGTzK82khSh1nUsIl4ng4e9A2qC765lQMyARYN0FU2sN324Yi2YcOnicXCsLUWenn6
         l+1bXUlzUMcN1VzQzgJvZiwwnfIPiJIbxn/5qzzJG5lTJDvjDiB2wzt/Kpw6MrJDPnu0
         b9bA==
X-Gm-Message-State: AOAM533K99jx2d5kih3gmQKgVO1oMzAPB3COZZQ+UMpKT6oLGhFUVHMR
        EvX8e9oy/EhZfqOZbPsHppYCwCfAQrqSvxpbVfw=
X-Google-Smtp-Source: ABdhPJxwCJKDNerVqf8Xb7hcwjm0mPHyM9gR7B8R21iLhU4vdTlQjJuMsVwaDoxd4MHHv8lV31PlHrmK3GZlQllfQaM=
X-Received: by 2002:a17:903:2344:b0:163:ce0a:4655 with SMTP id
 c4-20020a170903234400b00163ce0a4655mr37947755plh.122.1654750911613; Wed, 08
 Jun 2022 22:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANWRddN4R6AceeaOyZm1vs8AXBNv3J+cE5MOyrhKVhcqddjUOA@mail.gmail.com>
 <xmqq5ylapy0s.fsf@gitster.g>
In-Reply-To: <xmqq5ylapy0s.fsf@gitster.g>
From:   Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com>
Date:   Wed, 8 Jun 2022 22:01:40 -0700
Message-ID: <CANWRddPDhM1g6rtu-a2a=EogXD_hOFwSDsgMCbVvB7dibMaEqw@mail.gmail.com>
Subject: Re: Best way to update `HEAD` in mirrored repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Great, thanks for the confirmation. Appreciate it!

Rodrigo

On Wed, Jun 8, 2022 at 3:54 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Rodrigo Silva Mendoza <rodrigosilvamendoza3@gmail.com> writes:
>
> > What I've got that I think works
> > 1. Get the ref from the origin that points to `HEAD`. Extract the ref
> > from the output.
> > 2. Manually update the `HEAD` ref with the extracted output prior step
> >
> > Like so:
> > ```
> > $ git ls-remote --symref origin HEAD
> > ref: refs/heads/good_main_3     HEAD
> > 0666a519f94b8500ab6f14bdf7c9c2e5ca7d5821        HEAD
> >
> > $ git symbolic-ref HEAD refs/heads/good_main_3
> > ```
> >
> > Does this make sense?
>
> Yes.  That soudns like the right thing to do.
>
