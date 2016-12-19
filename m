Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 338571FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 21:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbcLSV1w (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 16:27:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:58184 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754082AbcLSV1v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 16:27:51 -0500
Received: from [192.168.178.43] ([88.71.251.25]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MS0c2-1c8c8Z2arK-00TGeH; Mon, 19
 Dec 2016 22:27:29 +0100
Subject: Re: [PATCH v2 01/34] sequencer: support a new action: 'interactive
 rebase'
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
 <cover.1481642927.git.johannes.schindelin@gmx.de>
 <297140020a7312af03136848dcdd0353ee3abdfe.1481642927.git.johannes.schindelin@gmx.de>
 <xmqqy3ziwbpk.fsf@gitster.mtv.corp.google.com>
 <f0762491-63ca-0814-0005-b2cbdd4dc505@gmx.net>
 <alpine.DEB.2.20.1612191515000.54750@virtualbox>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <940cbdcc-e289-6be2-29fd-97c5e2549642@gmx.net>
Date:   Mon, 19 Dec 2016 22:27:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1612191515000.54750@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:9VJrxOJ7xGHnoo2fFAL+C8zpxMYaJIGPL4/ToNSqDPEpUBaBqKD
 mBV5Zh+BHwX26xTLD2Z0Uedu6Ggsq7D1/EyKUurXJThfHPYq43/+BcqFRLu0zF8RpZ79eWV
 SAmy1G0ykELw/FSGbPR2FOog4zD9HEdTXqdAKNAX2TAD6VUQUseqbLb4EGesGLsk6nGMeFG
 d+go1+s0QVHDSfWTZ+ogQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/bkHVA/LQ8A=:JIgBFPFsjQ7dQ7mpHgB5F/
 wSr3CkoBPb2IoDxf0VkEcAd12SpdlsmVDGUvT22ukbJFul3rNGgfStzIdFtj+dvp3oqe3XcEW
 aqqpKs8K/rev5xmjhnbaCrOLHIAgRA+sfgo8s3PZ2ph55+/08GcH2PGFKK2KocEE4xYl/XlhH
 lhyIJwn+ol9u44z4QDMA/kHw+hklMfABYi//GqpcajB7J1amtVzD7Ea1REi8lK9AkXmbxeuq6
 CpN8Ki4K3mEKIDQwsLtORCBtBOVLNzFg3GvRD7nFfMNaNk+3gF9xTBhUapup42b4owSYwUpmt
 qM6CTwv9QFZw3ySdpRr4yt84UDlrl2I7Xi7el4+RmRbJLuUKLfFLMyhcmjc3gY0KXfxRVDrT9
 DYaQys47QlBmOOBfh7D6RYo2ufo7Sbb5OkokJ86QL3yqBgbJlNIu0C+LrLZloM1vx3ezLbexj
 G1dVz/7Zc77/z9LMoqbdpTMcotNUhxKHMx6ibDigqEOKbDNzD1m36xS5TkvsF3B+PB2+y7Ang
 wHww5bysSNgS3SfHznAJQFKkYdv536JcHch6a/cVPSqp7yuGzlUWmqJanfZT8s2FODJ/J1qem
 C+fcgmcpgsTZxGj3ltvv0cPZkB87+RTN+mB0WQmeGNucPGxkjXqTd9Ik6I3MaWuBSIEyJtaN9
 0YCLBuGtlQxV6SjqTpIeRpvDnUXabfjiUahnoyVZ55uWN5GGMZyElnOe5mH3JerHruzwwtHBD
 grVBnX+XDnSbZQIgcZsWCQnbGRaExeMffyT7tBZP5V6zIn+ZVb6BpDLdiARd66yzJI6JeM3FQ
 2A2/tUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

>> However, maintaining more than one directory (like "sequencer" for
>> sequencer state and "rebase-merge" for rebase todo and log) can cause
>> the necessity to be even more careful when hacking on sequencer... For
>> example, the cleanup code must delete both of them, not only one of them.
> 
> That is incorrect. It depends on the options which directory is used. And
> it is that directory (and not both) that should be cleaned up in the end.
> 
> Otherwise you run into a ton of pain e.g. when running a rebase -i with an
> `exec git cherry-pick ...` line: all of a sudden, that little innocuous
> line would simply destroy the state directory of the current rebase -i.
> 
> That's a rather big no-no.

Ahh, I see, there seems to be a misunderstanding on my side about how
you did it (I did not look into the other patches (obviously)).

Thanks for clarifying!

Best
  Stephan
