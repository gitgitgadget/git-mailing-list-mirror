Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA63520D12
	for <e@80x24.org>; Fri,  2 Jun 2017 07:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbdFBHTX (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 03:19:23 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:38418 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdFBHTW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 03:19:22 -0400
Received: by mail-it0-f54.google.com with SMTP id r63so8118493itc.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m3d1XJIzk+UAwdrAcQ+3Pb+4g9ppxWNRq9Jvx5rTvAo=;
        b=LusUE2s2ze3nDKRxhNY7BQmzMz00L9E8jL7eftwlyz58ZYTDONenZytMDFs6h1B3pV
         OazdvrgEdQQ/yXqOvbhPW3U4TBPHF+V12UIC/c3KFFHe9Sg2RMZxIkzcPhefMdeVN6qM
         ccgDEY4iZgxSUTdeEYhpRQBZR185V3uIfYwBxdytlIYzhZJBbqZWFIIDRvGQWm/TMXCN
         /8iGed2sAObtz435MUo5HkAxeeSEqn7M/iIYAUDxISiU9qK2Rwet+XxdxkU+DBHrfOrG
         QtBg+nP9K/E2QuOFk09ZpIoVo3qUQV0KCXN1P+6MlepR3L8Ke/YM/9hNQZaI1FngzL1G
         FG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m3d1XJIzk+UAwdrAcQ+3Pb+4g9ppxWNRq9Jvx5rTvAo=;
        b=YEgACMAIkbWbOQpLszIT6OnLJrAFZyc4xcDNa7Ff0Wa8w6Q0lBV2s7ys+f0zUSB1bw
         42BWZE2QSwobu+tOi/7cZWlIGafV/k8EGRweHgTl2fbDBCqKMMo45sr+l3Q26SSa6qag
         8isipYFMmnSEjQ5l/oC9Pv7SWHE6M6lJdLWTpNOENBN1irN4d7to4Ngp/n2kW77zJDQK
         e8bPuTN9EACDrPeJn4oLYA2YjlwXbLImREzVTYZq/E1X3wsQkbJojkHW71L3P46NPf7B
         6J60E35yqhW3MFwaALhId//dEkY/DGUxkYsut3cpxQ4cogw22Kg7BYrevIF1EJvBO9x7
         0dcA==
X-Gm-Message-State: AODbwcAtnnTbK56NouRGrmHIPYjh059+Bag39l1Zw/2b5wu0Z+qDnn9r
        cEpOEzy2JGZ+BA==
X-Received: by 10.84.132.2 with SMTP id 2mr102217458ple.46.1496387961219;
        Fri, 02 Jun 2017 00:19:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id i5sm35750698pfj.41.2017.06.02.00.19.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 00:19:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 00/33] object id conversion (grep and diff)
References: <20170530173109.54904-1-bmwill@google.com>
        <xmqqzidr18an.fsf@gitster.mtv.corp.google.com>
        <xmqqefv3yo23.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 02 Jun 2017 16:19:19 +0900
In-Reply-To: <xmqqefv3yo23.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 02 Jun 2017 14:08:04 +0900")
Message-ID: <xmqqtw3yyhzc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Brandon Williams <bmwill@google.com> writes:
>>
>>> A month or so ago I thought I would lend a hand to Brian and do a round of
>>> conversions from sha1 -> struct object_id.  Now that Brian's latest series has
>>> hit master I can finally send these patches out.
>>>
>>> The first couple patches are from Brian which convert some of the notes logic
>>> to using 'struct object_id'.  The remaining patches are to convert the grep and
>>> diff machinery to using 'struct object_id'.
>>
>> Nicely done for all of them.  Thanks.  Will queue (with tweaks
>> mentioned in the comments).
>
> Oops.  I won't be able to queue this for now as it heavily conflicts
> with blame-lib topic.  The resolution should be trivial, mechanical
> and boring, but takes time that I do not have today.

I lied.  This also conflicts somewhat with Peff's diff-blob topic.
I think I resolved them correctly (there needs evil merges applied
to two files when merging this topic), and hopefully can push out
the result by the end of the day.

Thanks.
