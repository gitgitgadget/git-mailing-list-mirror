Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC441F404
	for <e@80x24.org>; Thu, 19 Apr 2018 18:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753057AbeDSSmA (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 14:42:00 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46181 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752908AbeDSSl7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 14:41:59 -0400
Received: by mail-yw0-f193.google.com with SMTP id i17-v6so1979148ywg.13
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 11:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8creohGcEb5yNowhnLsFVG4s3vMatIPpVUfoh5oersc=;
        b=Xq+uZmkw1wZO33tKlu/9BO9NS67PLN25rVBGs0voOIbYl3v8eGq/+zSW5l9SRPuLh2
         w5Mk88O0GpaamWp3Xw2t5BKQnTCBMLxZ1RKDJuKl0F3IyZ/xuv2jSzNa9XHZ5+P21dGC
         pTnEr26nTz9iTipEG4OlT6OrIjR8khxXQlBrJPHXzcdviiFQWxTnfeV0+3X/gwrtEQ+m
         YFQADnecTgJHwf4uGo7GOLRjYbNvd8hi+NJM4ufsRju9aBdPMeM/TGpZ1g4OjE81s0ye
         K+uYilmq1YrRGAVfk/HJDud+jqAckFjM81/s7aAzBt95fsm+Q3o/8fnXv7+2Bs8cJorL
         fVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8creohGcEb5yNowhnLsFVG4s3vMatIPpVUfoh5oersc=;
        b=SIAz89On97HjFTdmzL6sO/6Mq4m6VuwDCW5ViwhbyXEILOVlsE76Y0bU9yh7quX78K
         OJov3tlo20nzNkQSIQwSQvyknFCRq5rsRD8qY2qMXnJmODDF6GY3M1VW48MsRipYG5L3
         VPlM3YmL+6aP5HKI+aClTqzRpznqXJEmlwKs/2MtzlYED9FcXDvzTKvC8EmBgg278UVj
         719nja7vIJ+Eofk0uOPCZfMFeU+v1TBx6DxQsetotYR/gLVrKtQigIStSMK3U311akZj
         qFg45VxOwRbjtZeDzLKhLq9cvha/4dtaafTNaUmjp71Fm3hkaMHNoBc7EOxele0QypYy
         CLLA==
X-Gm-Message-State: ALQs6tBItOEC6cmxXJAclqW3sO7/Emh42kayDTBRcnxG34khpQlzXkDy
        Q3R9oVeUvIZJWFgaKbLefphoAXQcGYYNS69oMKRdARYm3Kc=
X-Google-Smtp-Source: AIpwx49QIv65YEJqwr7pbAamNKcE9dD1qFRzRdANYKK/5RTtZblEk8WDkEB/x3GYtpKUR6z+d++55ZgIpoPN83dXR7o=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr4233856ywf.238.1524163319002;
 Thu, 19 Apr 2018 11:41:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 19 Apr 2018 11:41:58
 -0700 (PDT)
In-Reply-To: <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Apr 2018 11:41:58 -0700
Message-ID: <CAGZ79kat76NhYW1wbV+4=CaYdZ6ESMtBeUJuyi6yvRF2vJjFRQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 11:35 AM, Elijah Newren <newren@gmail.com> wrote:
> On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
>> This series is a reboot of the directory rename detection series that was
>> merged to master and then reverted due to the final patch having a buggy
>> can-skip-update check, as noted at
>>   https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
>> This series based on top of master.
>
> ...and merges cleanly to next but apparently has some minor conflicts
> with both ds/lazy-load-trees and ps/test-chmtime-get from pu.
>
> What's the preferred way to resolve this?  Rebase and resubmit my
> series on pu, or something else?

If you were to base it off of pu, this series would depend on all other
series that pu contains. This is bad for the progress of this series.
(If it were to be merged to next, all other series would automatically
merge to next as well)

If the conflicts are minor, then Junio resolves them; if you want to be
nice, pick your merge point as

    git checkout origin/master
    git merge ds/lazy-load-trees
    git merge ps/test-chmtime-get
    git tag my-anchor

and put the series on top of that anchor.

If you do this, you'd want to be reasonably sure that
those two series are not in too much flux.

Thanks,
Stefan
