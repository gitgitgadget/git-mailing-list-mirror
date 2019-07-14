Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3931F461
	for <e@80x24.org>; Sun, 14 Jul 2019 16:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfGNQio (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 12:38:44 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:46344 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbfGNQio (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 12:38:44 -0400
Received: by mail-io1-f50.google.com with SMTP id i10so30374878iol.13
        for <git@vger.kernel.org>; Sun, 14 Jul 2019 09:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTilezLw0tlvSuypNI+4fz3eggqVuTMAIUN5H9x74HM=;
        b=Bco6qXZU67Oo0B8aZp7wKei7WbstSL8uh03dJ9SonZXZPXLRBGZIM53fRdanAbfSUr
         U7mjfVwysp3TUJQwNXFXBgQF0qAzIIEC9ueWcllEIPJKdH4CL1paKK3bvzRrBN/WcokG
         rFnwRlQn6YAp/7mav4mx+HEOwUBR43VWvyCsRETZ8Ld1xKBXUJQ8Eojeee7qvjkVI8UX
         MQnz11w731YvYDPcOscXM72NQSu/40Bsn3fL9EXia3vEyHRfzt5DJLBvTgB5ZeD0H/KX
         JcrZbskW6AuZS8C1Ji1Gt0TzwscjzytwhL1ovYaD9MECxSusgVvobC439SbenXxVa/DP
         nLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTilezLw0tlvSuypNI+4fz3eggqVuTMAIUN5H9x74HM=;
        b=FNwvkhwgbdUTkKjGTiW6mGI02rNSSKtSlIjZDF//DTzapop1z/Yup2eOvvSwqFf6UZ
         oswHIDO4Mfe9yJ3tBnnN1DTV6pAbs7IlA00Kl00ZYeGQZFdBpTnLBeZDc7vffET7LlzS
         n96zk4ITV4ObGJLimRTT9r4mOJAIf4h1O+eT6k0o48FRKdVKRoI9Vx2uQNoOE5Hdh1MN
         I3MTSSryW43dkfxIgx5rtoNtyMREIV8JgIG78KyMz1pPXq2GYEFk3xbO2KwxZ6oaVmjy
         bRIwVm1DChtrGR+SeUZcYHCDbPIT4ApYgr2uRWkgX1n1BYkbEMzJdhfIZdwHlga3zvBj
         PsqQ==
X-Gm-Message-State: APjAAAWdL0Q1spxDcqJyToADB02yz8ssl7AQW8EdcfYonYMER85vtMc8
        XDZDoS4VJuruCJ9hB28z7o0NeP1gUZxZAX23Nq2n8w==
X-Google-Smtp-Source: APXvYqxDO5Pe0CbbonQ1F41tTpPMOQIMLNXs5K66wh10rsksZHzuqTzyZ7N5zxgNjkubNsJbv3DM1nTB24H8ffcVEjw=
X-Received: by 2002:a5d:9711:: with SMTP id h17mr20514127iol.280.1563122323313;
 Sun, 14 Jul 2019 09:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd-oW5MZNQ=AWwL+4wh6wERYJTMVv_1DKCBk4OK9Asui_bQBA@mail.gmail.com>
 <CAHd-oW7V_oK5Tqg-fF3G-7r+k7eX8czyaT77yBPoEDoXVthj8g@mail.gmail.com> <CAP8UFD2eHq+BynC9LHNvPB6Sk=1zTvM-r2VRD8sdxhCe+uNrVQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2eHq+BynC9LHNvPB6Sk=1zTvM-r2VRD8sdxhCe+uNrVQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sun, 14 Jul 2019 13:38:32 -0300
Message-ID: <CAHd-oW6MkZ+R1YZo9GNyJgJ=mwVdEwutiY1JhizibiVN-AvjPg@mail.gmail.com>
Subject: Re: [GSoC] My project blog
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 14, 2019 at 8:00 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi Matheus,
>
> On Sun, Jul 14, 2019 at 9:38 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > I just posted a new update about my GSoC project here:
> > https://matheustavares.gitlab.io/posts/week-8-a-working-parallel-inflation
> > Please, feel free to leave any comments. I've finally solved the race
> > condition problem and now we have a working parallel inflation :) But
> > there's still some tasks to be done on it before I have a proper
> > patchset.
>
> Great that you solved the race condition!
>
> I agree with the tasks you list in the next steps. I would even
> suggest that, right after splitting the changes into logical patches,
> you ask your mentors (Olga and me) to review it, and then send it as
> an RFC patch series to the mailing list. When you do that though,
> please list the other tasks and limitations of your patch series in
> the cover letter.

OK, I will do that.

Thanks,
Matheus

> Thanks,
> Christian.
