Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AA41F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbdBCSMS (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 13:12:18 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33531 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdBCSMR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 13:12:17 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so2036239pfg.0
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 10:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i2gbhWahm6jmWNSRUw61R5BSzeeCJ1Gach+SkB5Va1k=;
        b=ah6oDUBENbcXBHkjNcoK+D7+NqzylSxeE2rqXqN4rOX3MPdbwsBdBOSgkeLRTuU4JE
         baPjjQb1L4oL5yGyYHHGj6RPN0EQ8KkelwchByestkbekbb5K0o/xgbgDlZeQ03O5Prw
         6SEzzofS2DBI+IgY9Kzwwe+hDCXNzpcTr5W4EYxDQBJixCG77SH1STvhC8fQiLjdFyv9
         f2IRrpV+lj/iwtMQkXqS1r3nJ/w3PyEik5HwbyUxemQlfELgRHh96kIp7KWOZvL798kR
         hkDP2U9zjB0lOea1lgZ8mW3K5vSKJa2NegOqYy8Ua+I4fvtRxdDj7K3Sz6hwEWSnToIM
         BwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i2gbhWahm6jmWNSRUw61R5BSzeeCJ1Gach+SkB5Va1k=;
        b=LUnNEj1MMYJgoq31XiaMSl4zl00OVI0/6hbRkR2rP7cbHGssSExApyDJVL7rwuhB5v
         muq51qLAewekRe2OZaSnMpAZ7tJa511satwAVMcb0Y+g4ttobuqB3pNHAIQiSVBNCuNa
         90h73U98AcCe9VKY+f0g9kS0H8Sff691bTEIsZvlYhUycZWV4tnZg9DrXJWF7BUXyqxb
         5hgnBWBxReAa/djRzqcVDMq71bcKyZVP64NUM+iSVqF1Do3ULI2Z24fTddYJ9RBRnzsU
         w2OxVpC7IB0cC79Xo3K1IC3BDY7B1N9eO+yR8b6ar3HukDOPWZNDKbRXYKTwu8eSCMU8
         FMgA==
X-Gm-Message-State: AIkVDXI9SPBpDV/On0K2ginDZFkQdouylyCTPjvcGQ8+at6FS5ZkP53HcXSvcIFH4hNkKw==
X-Received: by 10.99.5.15 with SMTP id 15mr19336250pgf.109.1486145536294;
        Fri, 03 Feb 2017 10:12:16 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:dd9f:576d:b8fa:253a])
        by smtp.gmail.com with ESMTPSA id p26sm69336148pgn.39.2017.02.03.10.12.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 03 Feb 2017 10:12:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] document behavior of empty color name
References: <xmqqpoj2q25n.fsf@gitster.mtv.corp.google.com>
        <20170201002129.xb62hmxwrzwgp6vg@sigill.intra.peff.net>
        <20170202091615.GA22337@ash>
        <20170202124238.53k74cedpp2rcmzo@sigill.intra.peff.net>
        <20170203092430.GA10987@ash>
        <20170203122859.753bexioxxkibfzb@sigill.intra.peff.net>
Date:   Fri, 03 Feb 2017 10:12:13 -0800
In-Reply-To: <20170203122859.753bexioxxkibfzb@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Feb 2017 13:29:00 +0100")
Message-ID: <xmqqy3xnf8jm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Feb 03, 2017 at 04:24:30PM +0700, Duy Nguyen wrote:
>
>> > I don't think so. The default value is a git-config thing, but you would
>> > want to be able to do the same thing in a config file. For example, to
>> > disable coloring entirely for part of the diff, you could do:
>> > 
>> >   [color "diff"]
>> >   meta = ""
>> 
>> OK but it makes log.graphColors add empty colors though. In t4202.39,
>> we have " blue,invalid-color, cyan, red , ". With this patch the color
>> after red would be no color. Without it, we get a complaint and the
>> next color would be cycled back to blue. The test does not catch this
>> because the test graph does not have enough fork points to get to red
>> and back to blue.
>
> Right, I think that's the correct behavior. The empty color name is a
> real color ("none"), and you can put it in your list just like any other
> color.

Makes me wonder if we have a non-empty string that spells the same
"do nothing", because ...

> It's possible that somebody would like to use the sort of "hanging
> comma" behavior that people do with lists that might be added to later
> (e.g., for enums in C).
>
> IMHO that would be best handled by having the list-parsing code drop
> trailing empty entries.

... I agree with this position 100%, and while I have a suspicion
that real people do not necessarily want the "hanging comma"
behaviour, we would need a way to spell "I want a do-nothing color
at the end of this list, this is not a hanging comma" for
completeness, if we start supporting "hanging comma".

The above is just me "wondering"; I do not think what we have needs
further tweaks--an empty after the final comma that means "do-nothing"
is fine, I would think.

Thanks.

