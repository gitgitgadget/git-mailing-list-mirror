Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C3F11F516
	for <e@80x24.org>; Fri, 29 Jun 2018 14:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934699AbeF2Oqw (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 10:46:52 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43539 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932254AbeF2Oqv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 10:46:51 -0400
Received: by mail-qk0-f196.google.com with SMTP id z74-v6so5031991qkb.10
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 07:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=jLogF2y2+/4RJAhstkAHIy96pHHBvas2gdbdG5u8g0E=;
        b=ZCrilMld5gtJtqvk3/NdpStOgol9dyCnl8wms9ushhgQWwinRssnPn2AcMHzoJ7qSi
         0S7ILGsz1fWZSWzOAnUdkxtA0RhWRR4x9PqcU6Ff9C7j/z4F/sZF6dxyIXYnRMImfBe7
         0lg9teYMdBTc188CrTjEFJq6BgwoWDnZKgWVITojkzsv3tehP7S8/+HAIJ8mMzxRa5E1
         cw9ROcxohmmJUJaoB/TBPK5L/hEfqbdvXFkhIv9Nx1iyQLLpfZw+EpqlLA/QWzbx8/0O
         r5YT25yaP9udwDG//dDsMLpCIDAaVafvHuyP5Ct4qewepGyTYC4IiSvf562bqEkpcxeD
         Qd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jLogF2y2+/4RJAhstkAHIy96pHHBvas2gdbdG5u8g0E=;
        b=NVVHy/wGYrvQ8dPcO6fv4TKfcxSmL724bCc/+unIK3ouz/gUir02+Wu30EskrF5pDf
         0vrBqB6ydl00cktqqEhgUSvugKWIy8Ptk5rWV7eXmyZ4pJvzJpNuMsmx7mVIjWd8KVz8
         Brheaj7k7r0kmFyToqwICX+Gg9RuIFQgByZGyC+aMkhkomli3LXjFhZoAEKiWHLIMd64
         2gOPZZt+sQVWV0F33nBt53MGYVQQrfk9yhtYg57afQlcjTmudm0IIKQVrcUG8PlM5eHc
         /2ezIEonK0AqOlavFfVE4Mp5ZeU897qC0kpwJKSr4MFAQBTLL/tPcAAoXU2EkRasLub0
         YjnA==
X-Gm-Message-State: APt69E2gwBssUlTZBfuaHlOTfXcZKv4vETu1X1ar1TaLu73lbiu0kQxO
        VXr43DLm/x9hSCMmdSzKa9ysnVGs
X-Google-Smtp-Source: AAOMgpcshr/gQUhCXFiJh1cNjvddG7cuY7COgt+aYg7EPEV/LhPnQJv4TQWEQ/sZgMl4In+JoxWdUA==
X-Received: by 2002:a37:9d54:: with SMTP id g81-v6mr12732446qke.186.1530283610445;
        Fri, 29 Jun 2018 07:46:50 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id x8-v6sm3607406qth.73.2018.06.29.07.46.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 07:46:49 -0700 (PDT)
Subject: Re: [PATCH v3 09/32] commit: add repository argument to lookup_commit
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180629012222.167426-1-sbeller@google.com>
 <20180629012222.167426-10-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <729d08f0-87ac-0a94-97bc-e340d75ae836@gmail.com>
Date:   Fri, 29 Jun 2018 10:46:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180629012222.167426-10-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2018 9:21 PM, Stefan Beller wrote:
> Add a repository argument to allow callers of lookup_commit to be more
> specific about which repository to handle. This is a small mechanical
> change; it doesn't change the implementation to handle repositories
> other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.

In ds/commit-graph-fsck I add a few new callers to lookup_commit(), 
which will affect this patch on a reroll.

Thanks,

-Stolee

