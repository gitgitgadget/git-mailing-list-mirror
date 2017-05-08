Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605701FDEA
	for <e@80x24.org>; Mon,  8 May 2017 07:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbdEHHD6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 03:03:58 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33563 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbdEHHD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 03:03:57 -0400
Received: by mail-pg0-f42.google.com with SMTP id u187so22129907pgb.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zewWSdliRhMS3acgWRtGdSJje5JFnH7xLv8zx34IFXo=;
        b=kknD3ZzuETaqRK5c2gFE95CPJC2iOjEycCOiRdxNDrGhytB9RlOvqc3BJk5rv+O4KC
         vMaNVBm2REOihS7efLHAEEJxdy+G0sK/vPHDYvkrLSlwVMFMR5isuOpfaviF7XxGvdpI
         cQ1kVLzg+HIRMPp/K9OOslt7tgpemSBfzHw5GxBFv9Nht61ISeg5+5X3L9yuuSw8U/ec
         QoL8DrJY6kN2FK86jH8B213Hj8sTzmqaWTJnrKVyqoKMCQs8iRdgRjJSdnAKQY4fPIFG
         cTOdXBwXd/IbaqLUW55/GA9pfdKhQTm20xZkr9hvxDemiTKZLCuSeie95Wybx0iFvUAx
         cNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zewWSdliRhMS3acgWRtGdSJje5JFnH7xLv8zx34IFXo=;
        b=NTgAp/2ZIqW69xWggFA7+GUteuhde9kJ2WihFwvx7baiQOqgXCBS88+WY7jQ2r06UL
         w8i/yWwq/i/RE97PoNQ3MfLuqZfYqPZ0I++BpmkAUSPMxZ4KK9Md5RRk5iX/9oHK185L
         tz0IUrXDSeFZFYrvXwY3YJ/9UyJaZD6ioTxNQFdWjc86+n+oMOnQyOI2OGdgpY5pqu6i
         WvYiE/5AZQZIUDx2D8D2nxbNmXu8pgteltv6HJ5LcKZmLus9xiUW4s7H+StdSI/EdWWT
         g2LfK44Loz8lfkfiLZSJI5qm32usmx2LYaYCacKljT1qYfiwbkHU5AXc6O0WNXXBcJ6o
         /LcA==
X-Gm-Message-State: AN3rC/6SBwM0MEr7yqTjkts6923FOwspzraDKFjU9ywrhNd3h+aqo789
        0DWOoPOBbJzd5ROIE8d3jQ==
X-Received: by 10.99.114.6 with SMTP id n6mr17094715pgc.175.1494227036790;
        Mon, 08 May 2017 00:03:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id e5sm21630277pga.13.2017.05.08.00.03.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 00:03:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
        Stefano Lattarini <stefano.lattarini@gmail.com>,
        =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>,
        "Arnold D . Robbins" <arnold@skeeve.com>
Subject: Re: [PATCH 0/7] Update the compat/regex engine from upstream
References: <20170504220043.25702-1-avarab@gmail.com>
        <xmqq8tm8cglo.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4UzmFxDUwTA8JBX-UHDm4+c90qX7VmKqfDi+=783LmdQ@mail.gmail.com>
Date:   Mon, 08 May 2017 16:03:53 +0900
In-Reply-To: <CACBZZX4UzmFxDUwTA8JBX-UHDm4+c90qX7VmKqfDi+=783LmdQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 8 May
 2017 08:38:54
        +0200")
Message-ID: <xmqqtw4v7rty.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> It's just to bring us in line with upstream which as noted in that
> commit has fixed the issues we locally patched (and more), and for us
> to stop maintaining a fork of an old version of part of Gawk.
>
> There's no known issue with the existing engine that I'm aware of
> which impacts git, but given ~7 years of bugfixes & improvements
> there's surely something.
>
>> Having these "fixup!" as separate patches on the list makes them
>> smaller and easier to understand.  What do we want to do with them
>> once they are applied?  Squash them all up, because these do not
>> have their own explanations in their log message and it is not worth
>> keeping them separate?
>
> Please squash them all up into this commit ("compat/regex: update the
> gawk regex engine from upstream"), as noted having them as separate
> patches was a hack to get around mailing list limits.
>
> Also, un-squashed they'd break the NO_REGEX=Y build for a few commits,
> which would be a pain during bisecting.

OK.  Thanks for clarification.
