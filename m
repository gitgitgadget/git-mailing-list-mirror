Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 523EA202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 16:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932525AbdGKQFt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 12:05:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36197 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932498AbdGKQFs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 12:05:48 -0400
Received: by mail-pf0-f194.google.com with SMTP id z6so447977pfk.3
        for <git@vger.kernel.org>; Tue, 11 Jul 2017 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6lBPP2bl+kpRo+KdEc2eTx23S4yIG9xwJFWWQdJYbRI=;
        b=CqW0Cf6WE7N3XgzCXEHP+2dKeL3iOF+1twC62mIwNXIC7lmEonqPparDRB8cRuPyT1
         ICnjCAZbZvS0oQKfyG22/1Lp2bM8Rpi3axXgKySxJhn4DrYdXKlpwxLWMHgwv90DlEu4
         V9AKgRm/3j3TDwQeIbTbqWRqMzIScHkcMMRBhOUqYUQO0/J/WEpPCMtzFRTX6x2TrLIH
         8yKTiTEKjjZYqifEzezkiXNzVJmf7L8Gpoq8Fm26l45pokhumPeVEOgw3BRzmwEkj60W
         go/DIRhTdV01tuGwoeou/Wq1kbWJcwaGjfrSqbxgDSuieBB8i5zxex5A0haDkswzqZlx
         JHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6lBPP2bl+kpRo+KdEc2eTx23S4yIG9xwJFWWQdJYbRI=;
        b=tH5eqM3OIjeR2lwFQOw28eY2zRhxCRcH/AZsSYQ8pm5r84eX7xptQkpiNTl/XJBbHQ
         cyJ861XKuion6cSXKlBsN2EXzH9/Zp5J8Swkze/HLqhLUfTiF3FdX5dywQKyPiFyUj20
         gnSeOSAo/L07hVGIaNquqlY4IPUw7rSzFWaP9Kzjg5B5qA/W3ViXJQMj1CaJMbH5RQqD
         qXbVppiQkChzLxUSrcWpr6RykC5jAgIphwXa/YycTZzmCJHrU3EqmbhzRAJuxEu6K1pQ
         5uYjn5CNCTRUXiDgc35Rl1ZASM3+69wPI96tpjCl7U1T4O1LmeZR7TsN/d1zniHkQT7a
         CQxA==
X-Gm-Message-State: AIVw1127tmsU7xCayn5ZT/6Khxcy2sqhXOzrvJPNHKn2J2T8GsvDPJnz
        uuCkUFPVA2OS7A==
X-Received: by 10.84.198.67 with SMTP id o61mr683719pld.98.1499789147867;
        Tue, 11 Jul 2017 09:05:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fdda:b931:7ea7:8e3c])
        by smtp.gmail.com with ESMTPSA id s206sm588942pfs.55.2017.07.11.09.05.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Jul 2017 09:05:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
References: <cover.1499723297.git.martin.agren@gmail.com>
        <xmqqpod752yh.fsf@gitster.mtv.corp.google.com>
        <20170711104755.4z5exp43lvwbb5hq@sigill.intra.peff.net>
Date:   Tue, 11 Jul 2017 09:05:46 -0700
In-Reply-To: <20170711104755.4z5exp43lvwbb5hq@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Jul 2017 06:47:56 -0400")
Message-ID: <xmqqlgnv2c2t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I see you CC'ed Peff who's passionate in this area, so these patches
>> are in good hands already ;-) I briefly skimmed your patches myself,
>> and did not spot anything glaringly wrong.
>
> Heh, I don't think of "paging tag output" as one of my passions, but you
> may be right. :)

Perhaps not "tag output", but the paging is the area you are the
person who spent most time on.

> I left a few comments on the code and direction, but I agree that
> overall it looks pretty good. And I'm very impressed with the attention
> to detail for a first-time contributor.

Yes.
