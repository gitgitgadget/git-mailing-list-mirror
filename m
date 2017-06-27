Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C503207D2
	for <e@80x24.org>; Tue, 27 Jun 2017 03:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbdF0DPm (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 23:15:42 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33210 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdF0DPk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 23:15:40 -0400
Received: by mail-pf0-f176.google.com with SMTP id e7so9496565pfk.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 20:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tPYZy0MssuatzOVeznb8bV6JMmqDbYqaz09yvdBDf6Y=;
        b=B/rnXnv+kdlB7uS35DnLtm+nM9WdLY8m0IQhqp50HwPt68ij6ZAMGHlSHf3Wvje5JS
         FsJMpz2BL405nR1cA+WQd/b/0ZfjBS4rDF1NJgy0QNueK+FThLZEFDeHhHZio3LcF43Q
         6elU27+KM2Nkts8whP70mxvoDJ1HFglkjNd2m3cSpeQAn/2M4nH8rLtWjTZN/TgrLr5p
         S6X0iZfIcIttg1BZYpuIcMxZjfZq1h6pntkt5ji+U8hmQsAVZ4y4PMo7Req+Yu9kElwR
         /x/dyZ9urO35vBBbeCybNQb9nhaIqTC4czjXtWr0VgkuPGfgDnr/E0sl9/C0pud3KHaL
         0nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tPYZy0MssuatzOVeznb8bV6JMmqDbYqaz09yvdBDf6Y=;
        b=sanmHjqakCme8F8gIVcFbvkfV7Rk62QfCxq7hnCDM34YtGfR9J4EyPS9Lz6e0n5eb4
         JyY2u5yjjXjkZ2okvzTrdVVBs/NXc1brryZ2vSA9krcVhLWPeqwTRUMjYaPkzfhyBKLk
         qa7prTPxfNhB9Qo6/WHaYdb+mjpSuIpvguiVDPieamAGXjE5zXDHN3jGIcbqxju7JRlo
         3h/OwKur1D/6zqc8L0j4ccqB21TVxa29s0AoVT279TfjguUyfOy0eL0rPJDUw1CQ1fmh
         IznVjKgzspifP4/kCUD7YaT1L5vHvEtOgOP9ubJdqKBSr0aNQzBjr1yWELxyl4bRtZE3
         TtFg==
X-Gm-Message-State: AKS2vOx72sk/4IfPGu7wF1wVFXijABcNeg5AQDgu9KvQ9E1j/KJ18OlE
        gAnVLLlbJzIjZa2icw3nj92J+puQHZgB
X-Received: by 10.84.217.138 with SMTP id p10mr3437402pli.66.1498533340108;
 Mon, 26 Jun 2017 20:15:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Mon, 26 Jun 2017 20:15:39 -0700 (PDT)
In-Reply-To: <CAHaNChdhg-nHv34-jgumeKw8iJXaXwfY2DAe797nRXPU1VzT3Q@mail.gmail.com>
References: <CAHaNChewK_4a7sPgZqWTNSmchiSbKOJUrpCrGLmcnR+cw6J5qw@mail.gmail.com>
 <CAHaNChecHzZqzafe4P85Kz4BtJuisO+krCvm=yPW9wGMXWJK_A@mail.gmail.com>
 <CAGZ79kYR_Vw454RBw7A7ygJdiOauzepVZXBb_CvsCoN9AGE-sA@mail.gmail.com> <CAHaNChdhg-nHv34-jgumeKw8iJXaXwfY2DAe797nRXPU1VzT3Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Jun 2017 20:15:39 -0700
Message-ID: <CAGZ79kZ94Qh4CzCUWNYQQU5EB+Oky13gcp09tBKSYoCaFvqOuA@mail.gmail.com>
Subject: Re: Bug: Cannot kill Nodejs process using ctrl + c
To:     Gyandeep Singh <gyandeeps@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I miss-read your email.

So you are not running Git, but only talk about the (Git-)bash that is
conveniently bundled with Git for Windows?
For that I recommend https://github.com/git-for-windows/git/issues/new

Johannes Schindelin the GfW maintainer is cc'd here as well, but
AFAICT he prefers Github issues.

On Mon, Jun 26, 2017 at 8:08 PM, Gyandeep Singh <gyandeeps@gmail.com> wrote=
:
> Not sure what you mean by output. But its just goes back to normal like  =
this
>
> Gyandeep@Gyandeep MINGW64 ~
>
> $
>
>
>
> It was working fine on first release of git 2.13. It broken with
> releases after that.
>
> Will try with =E2=80=93no-pager flag and let you tomorrow.
>
>
>
> Thanks
>
> Gyandeep
> Regards,
>
> Gyandeep Singh
> Website: http://gyandeeps.com
>
>
> On Mon, Jun 26, 2017 at 9:55 PM, Stefan Beller <sbeller@google.com> wrote=
:
>> Which exact outputs of Git are invoked?
>>
>> Does it change when giving slightly different options e.g. --no-pager?
