Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68C301F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 05:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfJPFC5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 01:02:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33798 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfJPFC5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 01:02:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id j8so8560175eds.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWjUlED1169FGphJKDGV/k6040WdNU6m+4JkebWBSO4=;
        b=TspUbRR1vutLnIs5Gwa4wO/c1QaTinSRcUK/UMH375Wod2t4ppelb9VGmNr8WZAUAy
         +3W73uPSK1/covdyZSjWJ9o30RmGSfUjQpmn32VWO7UgU856SSOdsOXj2K/oEvDYX5HK
         E5xnNuYLZJvBFGZGmwW4zaCGSBnQtIv0aY5hEZmDXfJ1sgkgHxHeuyBOi9N7QLxbVpOG
         EKeaEwKJHvwWT0FJHVWNeKCl2RV+ZVuzg/3vWIMhwkKAcVEk/hzqy0o6ZQDVEIwyxmHu
         GbrSDBRbWxku6RG1tBkhr0+aY058K8poN4j6jnPyGEJB3PaU51qmWgvVl3I8HB+gD8N3
         GadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWjUlED1169FGphJKDGV/k6040WdNU6m+4JkebWBSO4=;
        b=j07FO4rTemDIP9HGVVjTGZxKX/JjfgN9qTD+C9hEMw4fbmRVBllZ4rZjSrkB0RDBLV
         ZIv5f3qa9k1eUhOHa5PHUeS1sZwYDrx/Fhr8oOP8+aTeq7yqddEMBZaYV9CH9SvIJVBX
         NhBQGkOWqsteneN+r61GWPaKTmNHCDu+eSlBc5fzWCw15YcoBY39eJ2neOsGmD3pHOAE
         pEerWY5gBguOUNv/N0Sqe4ZH+vslNmLPoJCRSeGREK754NbOaywMVEoHP1NPmPRElu7I
         J9gCKw0dJ1xlcV08zgrjePJfzjPfaWDqQwKqTNRoNkUxIuIhbMqbGoRAFcwY2uA9y4uk
         b7PA==
X-Gm-Message-State: APjAAAWM7ZLUm5MFk7DBWm5IcnNDFwqts49mhR/VcYbEnBvfCt2gnhKt
        yVgX4EEjiaRLbDMFBLRqyWflXJ+2Ap6NB82k7zQ=
X-Google-Smtp-Source: APXvYqx+lWDGvzI3XxPJJNzo++x3WHnntUW8JRst4Ni9AehztB1LBbgHBsr57GR5FotvzcoAp9bQKHcOKVY2pQpmZgg=
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr38855062ejb.194.1571202175547;
 Tue, 15 Oct 2019 22:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571089481.git.wink@saville.com> <d47c5de5fc812b1fbd04bb259a522e453d4b21e2.1571089481.git.wink@saville.com>
 <xmqq4l0ad7vn.fsf@gitster-ct.c.googlers.com> <CA+P7+xr-4WXuDFL-D8pmoxFvLB0Rkm4zsGO9=aOy5-3o=m=5Tg@mail.gmail.com>
 <CAKk8isrcR2TgiQ9B8nYgfKKLoLSs9moLrqQ007+NA5VzOG3Evg@mail.gmail.com>
In-Reply-To: <CAKk8isrcR2TgiQ9B8nYgfKKLoLSs9moLrqQ007+NA5VzOG3Evg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 15 Oct 2019 22:02:45 -0700
Message-ID: <CA+P7+xpdYMA8L-_Y+W5q7_zbj9RNcH1erY=dVbDG-EDOiHhTwA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Teach remote add the --prefix-tags option
To:     Wink Saville <wink@saville.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 2:13 PM Wink Saville <wink@saville.com> wrote:
>>
>> Something like this makes sense and I've thought about the problem for
>> a long time. Unfortunately it's quite a bit trickier to do this.
>>
>> It would solve the problem more generally though, and definitely seems
>> like the right approach.. but at least for me, every time I looked at
>> trying this I got lost. I haven't had time to investigate it recently
>> :(
>>
>> Thanks,
>> Jake
>
>
> Give it a go, you'll learn something at a minimum :)

I've started a couple of times, but mostly it's lack of time to
invest, since $DAYJOB hasn't given me cycles to try at the moment.

Thanks,
Jake
