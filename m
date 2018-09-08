Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054D21F404
	for <e@80x24.org>; Sat,  8 Sep 2018 19:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIIAku (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 20:40:50 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54381 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727638AbeIIAku (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 8 Sep 2018 20:40:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 576A621B0E;
        Sat,  8 Sep 2018 15:53:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 08 Sep 2018 15:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stason.org; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=LYQkxJ/OMJNT+VJaYgI5QYfXfu2BP
        QPWorK/7zvSx9s=; b=rxMHruH31EW898O/s9h8byo90fxX50fkx9NXx1B3ckSY+
        fc1ugtABkf2xZTi0PHCRp375obxV2J4Ij+6UEaTyE3LscuXI+NV7pE11JuFJMMBw
        tCVvdfDYKB6lhrA+vUReCKL3bZqxr7HkL7r3cQWfYdeEwzi2P0qM+s5UgkLHvA7p
        1DR5jEABMe1WRvzK+trgp9ayNqK6yngAsTg02bI/l2qebQtiMMfb3QEQo2AC4maF
        PaRlECnEgf/v945vxl+P2UWytcSB0n8iWMEv2KY2x4ZmZJdMq+K/l4rzskNkqyBZ
        Ckc40Nqd6q+hzD35MXbnFJCBiwMteDMGsK8QauYuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LYQkxJ
        /OMJNT+VJaYgI5QYfXfu2BPQPWorK/7zvSx9s=; b=I2i8qm+84tqeXlCkCTmHAG
        +XP96qHKM3VahbKPR6Iyd4W3OCWimDBCAhDoBjVnAqF614kCc3ya0h7u934kU4I2
        swqpR72++44IBptVsaJ0/NXVeMeJvZerlRplyKtICCZVY9zbAvxHMa3B3hDs46+t
        RFtKoB4zDKUCG73CLYCdYE5jzkgOT8D1AjG6zGoowUZ4kp7tjbk7LLp+rFTjS8oS
        bTkbgrzM18dhDUOpN/7LuIeh8objARDxFhmYeM5z5nmdrJHE1JkC7HWzWUkmVzcr
        9iHmeu0jJ38AgnT6rI4WpiJvfNyua9eim+mhp7T7ipjj5sLs9x5sH4i1TWEBimFw
        ==
X-ME-Proxy: <xmx:1CiUW10YClE2wPgAtwUB1tQcEUd5HCS3yvMRvkHWs2lQ90WPtZm0BA>
    <xmx:1CiUW8PN8xxzwgKU6hj93kZXnOUu-qqZ8KLtYlp8fzvDT0GRk8DnYg>
    <xmx:1CiUWzssRiOhJF8KcgjyxaH_pZ0jPHM4-01rD7IRhnBSYpyngbAP6w>
    <xmx:1CiUW3EW95ScR6RICq5wUj6R5ENhKwou0Tg1887Ma44LnCDy2X3XXw>
    <xmx:1CiUW2TCo3PK9WDvI5rufjpsi5hsykD1mdvo-qIPVXoStyWWaHO_1w>
    <xmx:1SiUWzIQaguWZc91ar227LlbyjRpKb2fLGRfcW4_G8SC81lS0eKshQ>
X-ME-Sender: <xms:1CiUW92zbinun-7JdUJgZoqxUtAUG4N2wAIdUen__bT7Ha2MYQdwMA>
Received: from [192.168.0.10] (s0106f0f249e4dad3.gv.shawcable.net [96.54.245.187])
        by mail.messagingengine.com (Postfix) with ESMTPA id 12D611028D;
        Sat,  8 Sep 2018 15:53:55 -0400 (EDT)
Subject: Re: git silently ignores include directive with single quotes
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
From:   Stas Bekman <stas@stason.org>
Organization: Hope, Humanized
Message-ID: <a76c94c6-9fd7-4ed0-be2d-6fc1d021f476@stason.org>
Date:   Sat, 8 Sep 2018 12:53:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-08 12:30 PM, Martin Ågren wrote:
> Hi Stas
> 
> On Sat, 8 Sep 2018 at 21:00, Stas Bekman <stas@stason.org> wrote:
>> [include]
>>         path = '../.gitconfig'

> Actually, there is a test explicitly testing that 'missing include files
> are ignored'. I couldn't find a motivation for this in 9b25a0b52e
> (config: add include directive, 2012-02-06).

And also to stress out, that the file is not missing.  At least in the
world of unix, in particular its many shells, - command line arguments
"xyz", 'xyz', xyz are often deemed to be the same if there are no spaces
in the word. So that's why it took us a lot of trial and error to even
consider the quotes in '../.gitconfig' as a problem. While git deems it
different, to me:

        path = '../.gitconfig'
        path = "../.gitconfig"
        path = ../.gitconfig

appear to be the "same". So git needs to have a way to say otherwise.

I realize I am going back to the issue of quoting here, after suggesting
to ignore it. So to clarify I'm bringing it up only in the context of
wanting git to tell the user what it wants, and not necessarily asking
to support all the possible ways one could quote a filepath.

-- 
________________________________________________
Stas Bekman       <'))))><       <'))))><
https://stasosphere.com  https://chestofbooks.com
https://experientialsexlab.com https://stason.org
https://stasosphere.com/experience-life/my-books
