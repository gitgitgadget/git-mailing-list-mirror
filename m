Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 580FE20248
	for <e@80x24.org>; Mon,  1 Apr 2019 16:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfDAQme (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:42:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43078 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbfDAQme (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:42:34 -0400
Received: by mail-ed1-f67.google.com with SMTP id d26so8832824ede.10
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P61U9eGT2VOnWJ/rudKsZhPEgTeqwDukbZxTjd/55rk=;
        b=iJeggJWNmp0qJ1VflQsw/rrLRuE17pHwabbMZyEtwMhzrLk5CHaQJrXV5UYnY/UJD+
         oLZMmkHdCaOLy34xjRL1c/1li4g3RxHBvZ9fQ60m1XQF0O+47oUnFNnLhdpb1f1CL5fM
         qbOcdH7IxTYE6o4/YVGMmtZcz1gxCqk4uxB8wTIsI1CLCxlAkO/zYUARHMgvQSrcN4HF
         FS49vzJNnp4+mpfXFTFtoG1mpYzJE3jwt0zzZp7wLR6kNMp+LKKWNKjWNyw7zvNxEMGG
         GfeM2MvdlmDep9klO0mS3Ks30spEdbwpUKXAM3AgmLzW8VIQ3tk1VC1B0h8iVM76yz85
         +E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P61U9eGT2VOnWJ/rudKsZhPEgTeqwDukbZxTjd/55rk=;
        b=dElvJIDK+Loa4E2TIFMnXiV8wBQzFelx/qtRIdg+hvFguLHojdjqDAxfXmtK0BGUAL
         wrCzgPb1MDnF8TC68VUjxbJDZ9hpyJZ6M2MndAZtZIWYdAlr+gcbL00m0QhPrFoBlyV1
         Dpwaw7z8cfIyV4bBzvx3nKhkgMcu6Gt1kvkjKwXH2NlN41wFkq9v9x7bdI5vYzAlcFar
         DThXdyCtnfSapWFXy3+dqFZ17GUBEKGXJWEZf9C8VrJhNADvken9ezKyogl3DbV/P3Kc
         iI7C3Tt19DBe3g9gH0LtioXg2fORJ/njCtpXkm69O7lgdfqfesJAq6kIMG6J7l/++qOb
         O1pg==
X-Gm-Message-State: APjAAAWKOFUKdfKcfeJb6VEJFIPfobMgkxzrFBm6VOcUy3Lh/fThzrt3
        7GRsxc8W9KxNju59U3xnb4hiPfMPJ0h17k723gY=
X-Google-Smtp-Source: APXvYqwRFYQqsqfPrWOpW0+MHqpviXOlbhZuomXI4Xp7EptUeCDR+NJY0S13DhmjxOn6/eX6Kx77hjtRdH75Yain89Q=
X-Received: by 2002:a50:9b50:: with SMTP id a16mr8840847edj.160.1554136952231;
 Mon, 01 Apr 2019 09:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
 <20190312132959.11764-6-chriscool@tuxfamily.org> <xmqqftrre6p1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftrre6p1.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 1 Apr 2019 18:42:19 +0200
Message-ID: <CAP8UFD1K=n1CriNSY75MyBG7ZDYUQRq3LcEMrxTJVcyhQgyJrg@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] promisor-remote: use repository_format_partial_clone
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 5:31 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > A remote specified using the extensions.partialClone config
> > option should be considered a promisor remote too.
> >
> > This remote should be at the end of the promisor remote list,
> > so that it is used only if objects have not been found in other
> > remotes.
>
> That's a declaration, not a rationale, and does not answer "Why
> should the origin be only used as the last resort?".

I have added the following explanation:

    If we are using promisor remotes other than the origin, it is
    because these other promisor remotes are likely to be better
    for some reason (maybe they are closer or faster for some kind
    of objects) than the origin, so it's logical that we try to use
    them first.
