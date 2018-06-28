Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90D031F516
	for <e@80x24.org>; Thu, 28 Jun 2018 17:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967523AbeF1R1g (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 13:27:36 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:41750 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967499AbeF1R1f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 13:27:35 -0400
Received: by mail-wr0-f179.google.com with SMTP id h10-v6so6293090wrq.8
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 10:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bKMu+dZpfopOw2vhhu6AHeQSy/BNwFtTBJLxa2/sbKM=;
        b=C/ByQKZWEctg7nfm7iIKQu1BHVOmT0D5ZvU1gy8uBaj4sDtnv6fntSRBXSuiWEElUR
         oUbOds51ofFMfS+xnfiMZ1u72402m0olH4dntmdn5QTKUZVYz8pIqt1LRE0yAnnUFcMn
         nRdX7EaLFLQKUhFiPtxja2aSEljh+LG3KKs39ARz3uwp9tef9HzaKuo9byHKvwvK4HMh
         ovo0XLHdBIqCf48gSBTAJQSnLk4V60ZApmhcocZ0+vRm89sA3pnDeJZJKqPagzsuLFOh
         etIOMTe3Z5Yc9QV7P9pOdTOS1bWyqLNbtvJZZtFSri8b/B1rigBTFz9wrBG7LCQV1077
         Nycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bKMu+dZpfopOw2vhhu6AHeQSy/BNwFtTBJLxa2/sbKM=;
        b=FZPHBbg3Sqd3qLW3Urdnk2R5N+ESgf00QWAVJbPN15nlErqMpGwofk5uCNF0U0ZBMw
         u1PCl2Z05RQOHdkjyuDyyguEIFbglIVjJwC7kH9m2iMxlxc9iQqA+8PBLxkf4dSkCHyP
         bLYwju8mIhjvZ5SSHvFEMd7TXvjhL1fXRPCXYkMmSRQtUcpnq54fkhBRfzSXXmGBp0om
         vn6lttbQRqNw6IonSV6jkEOGvtL3rqid5Ad9x8gVRi9TzEvNO5JiRYrQW9OzxXr2iJYL
         fcfNJab1Uz3UhW6DooNTSoUd0gEcVrvlfHtwgsY00MyL/iT2e/Vufd2DzsyIM/r2MSOh
         8mqg==
X-Gm-Message-State: APt69E03FLfL9RBv8bIbzfiZa5DH+AXrFw50CTujquh/XDg4SxrQ8mme
        OAA082VWO85I+42ZEvw93LE=
X-Google-Smtp-Source: AAOMgpdZ372X1eJ3WSzDJcjuW/3YEIoSneW/DsIkbCBwU8z/lI9Rx9T+bD8NXbhFA5dqMYFl3+cPZw==
X-Received: by 2002:adf:ae51:: with SMTP id u17-v6mr9207526wrd.201.1530206853913;
        Thu, 28 Jun 2018 10:27:33 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o13-v6sm5533935wmc.8.2018.06.28.10.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 10:27:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: fix the "built from commit" code
References: <pull.7.git.gitgitgadget@gmail.com>
        <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com>
        <20180628132314.GA14026@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet>
Date:   Thu, 28 Jun 2018 10:27:32 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 28 Jun 2018 18:23:56 +0200 (DST)")
Message-ID: <xmqqa7reyg6z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I.e.:
>> 
>>   FOO='with spaces'
>>   BAR=$FOO sh -c 'echo $BAR'
>> 
>> works just fine.
>
> 	$ x="two  spaces"
>
> 	$ echo $x
> 	two spaces
>
> Maybe we should quote a little bit more religiously.

Both of you are wrong ;-)

Of course, the lack of dq around echo's argument makes shell split
two and spaces into two args and feed them separately to echo, and
causes echo to show them with a single SP in between.  Peff's
exampel should have been

	BAR=$FOO sh -c 'echo "$BAR"'

But that does not have much to do with the primary point Peff was
talking about, which is that in this sequence:

	$ x="two  spaces"
	$ y="$x"
	$ z=$x
	$ echo "x=<$x>" "y=<$y>" "z=<$z>"

assignment to y and z behave identically, i.e. dq around "$x" when
assigning to y is not needed.
