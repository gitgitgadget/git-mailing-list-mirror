Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411301F424
	for <e@80x24.org>; Wed,  9 May 2018 14:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935190AbeEIOwh (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:52:37 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:45781 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934517AbeEIOwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:52:36 -0400
Received: by mail-qt0-f173.google.com with SMTP id j42-v6so45949726qtj.12
        for <git@vger.kernel.org>; Wed, 09 May 2018 07:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=n3/zV87yPyUxdIX5DF+epgjXFtDnZp2/cl9Z9VoUD/Y=;
        b=cSwQENyvCu4AEQNsQldNBAT0lTwo8Ev2FwcBdw6M2pP2WHOJyCA97BgRxdh0VFiMLl
         fDXwCSC59UJ189fcskcpcZKdpBx2FKHny+K1CmiM7GbqJ1Zok93pRk8naiDR/OwzlKlZ
         735xWTuC+3Dq0il22A48ZZJ/Jypw3An4PBz1sTi3F2U+ztkJbJklk+i2wl3LKnWwYoDM
         /XeknJQY9AkNBrRiMwnoeN2FDyPh7v4Ofxq2EXXtfdr0tQSPqE6+SDrZ6rr0wZuLHbS4
         BuXKy9l2qTusWdROlgM5RxPNfZ5L0zJuraWWz/o/m2EIyYYlw87eVI6dFb8zcIlG2lHC
         SUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=n3/zV87yPyUxdIX5DF+epgjXFtDnZp2/cl9Z9VoUD/Y=;
        b=AUhHnY2sRzWN8Uyqxo/vZPTctgKIfntquz8JetbbkXjBAMXvD+FdxRmDIHU1wuI0iV
         erhlJHr+P2dEZpaQOKAOKHkqcy0TuPpgBt27j47gTt6mEYAUJN4lZcQXtWMVD+BR2DLB
         w7QnwmNzyfw1eR49J8bv0uC+K6kh/1NfMEtWluKywAgCESbUwiWvwM9/b+8p5YIYeA/g
         zDGq+WHQ6MnXuC61RJr2lXgusCzA8tSdyq/PJd58L8gxLx4B7F8OUjz6P4nr/MODhMcX
         TlEFRREdV+KqnKV5O9mvOv6UP+hQ6he0zkDTPHW6i/I5kFzXsaKnJJXwjU2xdx1iVGUM
         3V/Q==
X-Gm-Message-State: ALQs6tDvSZcGRaUtQ3IeosFmT7mSR1tHs+Thf0+qeQNmjLmn9SiTqdVZ
        1S3Y/ZXsKUuH0gQV2dD5m3U=
X-Google-Smtp-Source: AB8JxZqk6t1nNJJyvk3IidQE/2PrIRgXYTGzBy33pw1GU70bVm5Xna3rc33+S2vis9WRM/x/2wK9jg==
X-Received: by 2002:a0c:e44f:: with SMTP id d15-v6mr30789969qvm.143.1525877555169;
        Wed, 09 May 2018 07:52:35 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id h3sm12610241qkf.86.2018.05.09.07.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 07:52:34 -0700 (PDT)
Subject: Re: Implementing reftable in Git
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <059b8daf-c990-aad5-90a4-5ec38c42b7b3@gmail.com>
Date:   Wed, 9 May 2018 10:52:33 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2018 10:33 AM, Christian Couder wrote:
> Hi,
>
> I might start working on implementing reftable in Git soon.
>
> During the last Git Merge conference last March Stefan talked about
> reftable. In Alex Vandiver's notes [1] it is asked that people
> announce it on the list when they start working on it, and it appears
> that there is a reference implementation in JGit.

Thanks for starting on this! In addition to the performance gains, this 
will help a lot of users with case-insensitive file systems from getting 
case-errors on refnames.

> Looking it up, there is indeed some documentation [2], code [3], tests
> [4] and other related stuff [5] in the JGit repo. It looks like the
> JGit repo and the reftable code there are licensed under the Eclipse
> Distribution License - v 1.0 [7] which is very similar to the 3-Clause
> BSD License also called Modified BSD License which is GPL compatible
> according to gnu.org [9]. So from a quick look it appears that I
> should be able to port the JGit to Git if I just keep the copyright
> and license header comments in all the related files.
>
> So I think the most straightforward and compatible way to do it would
> be to port the JGit implementation.
>
> Thanks in advance for any suggestion or comment about this.
>
> Reftable was first described by Shawn and then discussed last July on
> the list [6].

The hope is that such a direct port should be possible, but someone else 
should comment on the porting process.

This is also something that could be created independently based on the 
documentation you mention. I was planning to attempt that during a 
hackathon in July, but I'm happy you are able to start earlier (and that 
you are announcing your intentions). I would be happy to review your 
patch series, so please keep me posted.

Thanks,
-Stolee
