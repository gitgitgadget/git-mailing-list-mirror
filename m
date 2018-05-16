Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273F01F406
	for <e@80x24.org>; Wed, 16 May 2018 18:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750953AbeEPSXG (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 14:23:06 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:37107 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPSXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 14:23:05 -0400
Received: by mail-qt0-f175.google.com with SMTP id q13-v6so2349912qtp.4
        for <git@vger.kernel.org>; Wed, 16 May 2018 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=4ezuXAXryaxYdiWg17HuvGMhCLpQcdkbEQ95gWdMfZg=;
        b=CrPSlvy2STNpj3Krsv81CJJ+vc4BJgwFneBpQcxS2ZA3TL06rdJupBi1a5EhAmW5Qf
         Fg2dF+dbABo6c0ht2hNx4PwG/fYVoFev68FvvrNp/IIAzAuZ01B0Yh3jc7X51EuvvCwC
         wdY58IxxzkgEjWvGjXBNYtH3V3y9skVMjClxOXS+3EYMaZPDGUutqWeliJtEB8mihOy4
         kthIVxpV/TNE83xRKd7MUX5Fiy3IeAmQlFCkuHXMHtwi8zySn63ItgkH2KAX21AkdqKi
         d+OgEtpUtRewK7xWy72t729AZDy89pBkIKPBblqm12BnrPiRyqI4ruQ8GUEj9LbFfPLW
         ur8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=4ezuXAXryaxYdiWg17HuvGMhCLpQcdkbEQ95gWdMfZg=;
        b=c5RYbKy7wGA+t7wcO6uzMm3MAnQFPVC8rJ0j2TiOFSzV3Sug6B6ARqAUUtXiLZ6NJF
         ljp4nMeGYLJpExAnydK39K5xI6bEZibadiDrAyD00t09ZS6epKQwlTZXkUKJvlx5pNJg
         jJghkL80TzUoFt+kOClSnjQImAtmiEznFs+cjAQoPS32Isw2KN2Yx0XDShunfY5xx8+v
         3Q62cY+nzg3TNRXeed1hUwO5XM8OiNaKZxbpweAlhS2TPnDVGooFVOtuT4ZoLyxdg65h
         j1ruBg1s/8S5Et90NcCnmLEhJWzXxN1WV00ztk23f6UGrOnOyHLnatKhtfvBfUPDA4NO
         YDpw==
X-Gm-Message-State: ALKqPweQlE+nycTIVlreE06DB4M28EJWQWLAEmdU8ZdVm/EeUcCs2OPt
        NbKMDV3Yrwv9jicl3NcUZ9PcvPU+
X-Google-Smtp-Source: AB8JxZoeClnk8qomvIZh/K7csWmOQyTLMPddvItdz6s0d3gG+pFmf47Q265TJMmIJNzCVBbOqstgYw==
X-Received: by 2002:ac8:22d4:: with SMTP id g20-v6mr2098994qta.159.1526494984297;
        Wed, 16 May 2018 11:23:04 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id k46-v6sm2455340qta.65.2018.05.16.11.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 May 2018 11:23:03 -0700 (PDT)
Subject: Re: Git log range reverse bug
To:     Mehdi Zeinali <zeinali8@gmail.com>, git@vger.kernel.org
References: <CAJeoX+5ZGFS0yhXwaESzx4kTHn9AOLVF5d2MBU-Sr8JeQRBSxA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d95c41a0-853a-e66e-da00-065f3ccf3c47@gmail.com>
Date:   Wed, 16 May 2018 14:23:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJeoX+5ZGFS0yhXwaESzx4kTHn9AOLVF5d2MBU-Sr8JeQRBSxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mendi,

On 5/16/2018 2:19 PM, Mehdi Zeinali wrote:
> Git Version: Version: 2.14.2
>
> When reversing a range in git log, it does not start from the expected commit:
>
> $ git show 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b
> commit 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b
> Author: Some Name <SomeName@SomeAddress.com>
> Date:   Mon Nov 3 19:01:53 2014 +0000
> .
> .
> .
>
> $ git show
> Author: Some Other Name <SomeOtherName@SomeAddress.com>
> Date:   Wed May 16 16:49:10 2018 +0000
> .
> .
> .
>
> $ git log --reverse 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b..HEAD

This command is asking for the commits reachable from HEAD but NOT 
reachable from 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b. To see 
8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b in the results, you would need 
to add "--boundary" to the command. That may still not show 
8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b as the first commit, as there 
may be multiple, earlier boundary commits.

Thanks,
-Stolee
