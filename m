Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F0E21F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeBWVKG (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:10:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34049 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbeBWVKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:10:04 -0500
Received: by mail-wr0-f196.google.com with SMTP id m5so15422733wrg.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EQuFcXquJqfHo5DEsy1fJQkhKVMvhuDIaRS9pNAVtFM=;
        b=Xph8g6mv6RNvgChCDBlzaJqqO9LzxTnEe6hwLDpObEn5NNvNhcaYUlPGRXCKTcu7DZ
         kqXeevYhN/VW1cZI8EWSMNb3XzJHHIX8r8CDLoxhJVsfyUWdZlwtUF7Zi9/4ZJvW/y7D
         qQ1LRvnh5zpW5TbkPNlwv9Ok6kyxMWdUfqAbzet7BMZS9K4raGyFw4LPgO4AtPtQ3+y4
         h6gspIt2x4Wfvry7X8Vf/hdP6yklctsLa/6TFXV07kp/RM4r1kIO/ydkOm9+UjwYovZQ
         oS3l1mIKJ1IvdiQUxS0ZskmR9wUePBC4B27No1uN9O+eduWdmymcN1el51Ou3winoE5C
         4Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EQuFcXquJqfHo5DEsy1fJQkhKVMvhuDIaRS9pNAVtFM=;
        b=PxDi7xQl7nJtepLG2CzsLYxuaiSYmTtAH91/CUWvIMliNNIg60s+ZD0w6zOLGpVimI
         RxyyxVMIUviHKhxb4Eso07JPhnmEzrZgJjE5VnLtlI3QtKihkiUOrW/0e7yvjeNUnFQY
         XUB5cC5CxN3QymU727aRttIiaSIQ8mjw7mkjHaE6H6hpvwOObbwRDP/OIlq+0rF2p4+4
         uAdP5ciF6j9OMMmivhiwSvf0jN6mq8jx/SfIE8cEVJJBnmYpg+GqWA8Grdv7+4B56G3i
         p8gnGjcBRmQwF5LouKZGADA0vyUq68/DOqeK8/eVItmVZh/4NjvVIdzQrnilyIK6Z4D+
         tpuw==
X-Gm-Message-State: APf1xPCEqf6L+8HHfpnxnRjbZcZpxq4uF4wHJYQgsfixDyifRs/tCXtF
        +s4lBaZ+wvWM0EaR8LAg+OV1JZL9
X-Google-Smtp-Source: AH8x224ToBDFqDN/1GtIWzkjTQPL2QGE3J+u1DcWK/LEOsB42HMLsmkcH1IdkVEE4gzs1abvg4NvwQ==
X-Received: by 10.223.157.22 with SMTP id k22mr2654115wre.208.1519420202856;
        Fri, 23 Feb 2018 13:10:02 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k2sm2478695wmf.10.2018.02.23.13.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:10:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v5 00/17] document & test fetch pruning & add fetch.pruneTags
References: <20180121000304.32323-1-avarab@gmail.com>
        <20180209203216.11560-1-avarab@gmail.com>
        <xmqq606pyiqo.fsf@gitster-ct.c.googlers.com>
        <874lm9f6pe.fsf@evledraar.gmail.com>
        <xmqq7er4wzub.fsf@gitster-ct.c.googlers.com>
        <87zi40dqm1.fsf@evledraar.gmail.com>
Date:   Fri, 23 Feb 2018 13:10:01 -0800
In-Reply-To: <87zi40dqm1.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 23 Feb 2018 10:04:06 +0100")
Message-ID: <xmqqsh9rs992.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Let's see how others find it useful and/or if the changed code gets
>> in the way of others (I am not absolutely sure if the changes are
>> free of regression to existing users who do not use the new
>> feature).
>
> I think if you're on the fence about merging it down (and others don't
> chime in saying the want it / like it) it makes sense to merge down
> 1-14/17 and we could discard 15-17/17 for now for a later re-submission
> and discussion once the earlier part of the series lands in master.

Or we merge everything and let people discover glitches and
complain.  Reverting the last pieces can wait until then ;-).


