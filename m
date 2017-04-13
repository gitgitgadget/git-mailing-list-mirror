Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB6C20960
	for <e@80x24.org>; Thu, 13 Apr 2017 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbdDMRzL (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 13:55:11 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36639 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbdDMRzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 13:55:11 -0400
Received: by mail-pg0-f41.google.com with SMTP id g2so33601349pge.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6fFWB1pdXNbr8wtErw/ZVKLBVoWnptbSYOL2QPu1ieM=;
        b=B6ybfF8TKwcBA7FDWvOwi5VkVy3OSbIQeMzociznAXUUtahrOk0Mp5Zlze62N2VvQK
         BUyVGXgym3bC1nBfvtaKBrFeookx5CYDw7ilvu/fk2D2bZYNdL+hMNE+2YvhCvHq4/AZ
         8Y1sm4sj6Pe2iS5cv0EdcVMSMcfr96xYBzNGiQN1jx8mzdDDFJ5j36fvsDZKKSta8aDu
         fc77+4MaN+l1get0g+1GhJKgel7ALpD7tdZHfdsSH6pKAqKaHjebJKmkUsZNx15QLRxI
         ej+GVTiBWo0CX1mqP+GY3ds2mdJtacVmPN9erQbqjXQ7D7g6GmsRN8MIBnimAXxUOmcq
         wdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6fFWB1pdXNbr8wtErw/ZVKLBVoWnptbSYOL2QPu1ieM=;
        b=YTLP1PAo6N9JVMi1mXV36d+17uGjfjvB5VqAUKkk3vsrh7+MHhri0btturqobx/uRp
         lWOWuVuSTFjaFhn2ncX/6JoKxuztwn77SFOwdq4cxu2ojPaEGe/+vO3YnlosSDsG1m7/
         s15W3zV/WU2eLTCGqBmUYN2m6GeX8Cauh09J+kfjHzAq7YblRyTJXkp989NkKoIY2f+Y
         uixBYG5Hv/mSwO+xmkIcHJeReF1MBcaRaDM0YiYsd7Qy9kyaEdIgJgb380IhHgzY4cF3
         z23yTneSb5wXE/NE1z6R1A2wVDa1LuvjlBFYVFp8Tgm0HGgS6ZiN2w/caE7OL1728JJa
         oJpg==
X-Gm-Message-State: AN3rC/69JvwyLTVy1XsvfMRQAgHi31jf1APb+UHh2EWOcXbH4Dlww9NQ
        aejhCNhxm286l9DXg5I++8oW4VRZ0Z7E
X-Received: by 10.98.9.29 with SMTP id e29mr4168778pfd.101.1492106109148; Thu,
 13 Apr 2017 10:55:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.163.239 with HTTP; Thu, 13 Apr 2017 10:55:08 -0700 (PDT)
In-Reply-To: <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net>
References: <20170410125911.6800-1-szeder.dev@gmail.com> <20170410135837.2ukgksfxdlcfqldy@sigill.intra.peff.net>
 <CAM0VKj=4Utapk9iFasChkPSdkWxB5WiHtpZGPUYKMC5LKrnGXw@mail.gmail.com>
 <20170410163557.gn3mlcalfhhncbtt@sigill.intra.peff.net> <CAM0VKjkdqjbkqOF6ucymtuBAAgBVJQ6SGe4Ep2gqVBtNp=s_CA@mail.gmail.com>
 <20170410170154.qwzaolflrvsduwzd@sigill.intra.peff.net> <426f08b9-79c8-0c5b-e07e-4dd6a49243e9@kdbg.org>
 <CAM0VKjmuCjLBFAErXP06wu0+-7SdWVMaVu_g25Q4V-uQz8T1uA@mail.gmail.com>
 <20170412005011.46tr4mgsxk7chgfz@sigill.intra.peff.net> <CAM0VKjkuoCotm8FB5qdTQsC0SaJiwBA9dXmdLJdSs8NwLdY8fQ@mail.gmail.com>
 <20170413163701.33zjwrgnlfxjfwjo@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 13 Apr 2017 10:55:08 -0700
Message-ID: <CAGZ79kY6TmEV38NkYJwkb5=Bu69tCjx6k+t6An5_52h8rEo5-Q@mail.gmail.com>
Subject: Re: [PATCH] t6500: don't run detached auto gc at the end of the test script
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 9:37 AM, Jeff King <peff@peff.net> wrote:
> Ah, OK, that makes more sense. I can detect it reliably by just checking
>
>   ! test -d $root/trash*
>
> in my stress-test after the test successfully completes.

Would we want to report such an error from the test suite itself?
(My line of thinking is that this is a similar issue to broken && chains,
which we do report).

Stefan
