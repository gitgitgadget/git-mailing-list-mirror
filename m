Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11451F461
	for <e@80x24.org>; Fri, 28 Jun 2019 12:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfF1MYD (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 08:24:03 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:34474 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfF1MXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 08:23:54 -0400
Received: by mail-qk1-f178.google.com with SMTP id t8so4594182qkt.1
        for <git@vger.kernel.org>; Fri, 28 Jun 2019 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aTEiYUlHTTg2UirE1BR2ZxlTnL4JoJz4KSddpZnqB3w=;
        b=hXg9CCfia6uizUz0SpPhDWglWefnS8H1I0VeBDCxWYNd+ApTRsdQ8g+0fGHU3X/DSe
         7A7CLAasHfb0E/O2zlArQtpqb6/RvA7eGNNDYAhNp6ncynKbmPfvfr59lAEJ6enEHtBl
         uAUcAWpFM3avgMZjcM2hM4KtDSf7WAe3Qr0ol1/VEi4jZ7SpdS0p/QI6q4yH659dTE+D
         oiOcag+e1tC5Ms7zAORR8YTXIjFMfWzapf+b+E8h23mETiNAJZcRqg/UJrkjx6vzAChx
         JybvkJnpMpKmIR8dWz321ce8dH/zFfDqNFekA0aI+GM/nTKMuVQH6u5TvEl6RYve+jUk
         Ti8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aTEiYUlHTTg2UirE1BR2ZxlTnL4JoJz4KSddpZnqB3w=;
        b=RCAExvHaO0BAh9yOcxgseL0yH17U+1GYy1lSqULs1BR+uesv73qO1C1Fax+91R7i+M
         Pz8+zAuDicxu6Lm1lzqpaoTtgsI0XFh7K/e1xz/NQd9gXCAwvpoc58FqWlX5mMqZtb+d
         /Na9YsI7gizDhIjwhFSI8mOdn3K0c7q0QNP88dxj8VYVw+yk4idiZ3yAFi/hJ/+vAWvc
         hdscDV1+FSCf/nnlm0ITVXt5wMc+YimOonzh+YAnlca3PUzc0W5JysXcQ6vcJxQ/UR/Q
         WX1CJ1xgOaSpFkwyZwNOVee8Bk4GpFdcQt+ONKxZrvrS7ynPW4JES6xsPMrJDkwGbChB
         xpog==
X-Gm-Message-State: APjAAAUhJ0WNvsnzFQbQrL8oImVMGvskQ/jI3lp7hWaU3WsHnH/b5AdM
        qWkV35F1qGkbjWR1AB5nL8LrRcVw
X-Google-Smtp-Source: APXvYqxYNn4VvBT9BBVhuu7tfLMOkrg6Y36pTO6ZMxUQ0PbCAZMvyI7Ndrt46+5PtOnuquZjRRAcFw==
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr8272135qkc.491.1561724633667;
        Fri, 28 Jun 2019 05:23:53 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:54b1:2872:57:b107? ([2001:4898:a800:1010:5e7:2872:57:b107])
        by smtp.gmail.com with ESMTPSA id d31sm976530qta.39.2019.06.28.05.23.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 05:23:53 -0700 (PDT)
Subject: Re: Git Test Coverage Report (Thurs. June 27)
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
 <20190628064520.GB19777@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ddf13a6b-42f4-57ae-49f1-8cc758b1dc4b@gmail.com>
Date:   Fri, 28 Jun 2019 08:23:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190628064520.GB19777@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2019 2:45 AM, Jeff King wrote:
> On Thu, Jun 27, 2019 at 01:35:17PM -0400, Derrick Stolee wrote:
> 
>>> t/helper/test-example-decorate.c
>>> 0ebbcf70 29) one = lookup_unknown_object(&one_oid);
>>> 0ebbcf70 30) two = lookup_unknown_object(&two_oid);
>>> 0ebbcf70 59) three = lookup_unknown_object(&three_oid);
>>
>> Peff: again interesting that these lines you refactored were not covered, especially
>> because they are part of a test helper. Perhaps the tests they were intended for are
>> now defunct?
> 
> They should be run by t9004 (and if I replace them with a `die`, they
> clearly are). Are you sure your coverage script is not mistaken?

It looks like I'm missing the 9000+ tests. The following line was in the script
I adapted from another CI job:

	rm -f t/t9*.sh

This was probably because the job I adapted from needed to run quickly, but for
this coverage report we should do the hard work of running whatever t9*.sh tests
we can.

Sorry for the noise here, and thanks for checking!

-Stolee
