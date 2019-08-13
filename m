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
	by dcvr.yhbt.net (Postfix) with ESMTP id D37CD1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 12:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfHMMdN (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 08:33:13 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:41435 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbfHMMdN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Aug 2019 08:33:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 440773B5;
        Tue, 13 Aug 2019 08:33:12 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Tue, 13 Aug 2019 08:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=zt3zS/AOAgS6KeB0Z5bCjPRI9HrwnLd
        1psa598YvDIg=; b=iSmHu5EvSiIZkM+iD8/3c7NYT/OtbiJdgFgyqU9RWHjIDB5
        VMraNUYBPRYrLOTlvbr9DDyqSP0KaaN+jriR+733FnsbeJrregbsqijHWf/lYJtj
        OVDiMJxK8A+vZxFR9m9XK9EOUKXLEP4tJnAKQgeqTLnXCkbHfPgGAlBQNLCldnsr
        WvL/n0Oo7UyDQ7Jj+Qvflk1PINDfrb0O2p2Tzxnvw0f4F2d+XKSNJZF4XB0KeOdR
        wGdbqYXWJtTO4TnOTN50mHoigvkgaiOjEu++xMX8Gd2o2dvDDTqy4jYcmFaqnTfi
        evitLTQfHOuyuEgqvCewNywRS4y9DN/2eWHULBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zt3zS/
        AOAgS6KeB0Z5bCjPRI9HrwnLd1psa598YvDIg=; b=pRhe2ewAL/2hw9JOXe/P44
        wRd+P0NlQxWvGzX27kL4VZVasGcxgqn5hifOyF1LAFr+napgIgXXheYzD23LaoVi
        GWRgHKh205EwqORJYkeF07tBXFHmTAJPSSjqP65rQpfW4Qqcds/7anwEhpXkYkVn
        lxIn6mfiZQjNcSxsV8DtugoOHxPj7s0M0jkA/4hs4zys51RNCiBjpms0jOL2hunG
        nqL+6Rov2yWJKC44LuQ1yZb9to+RpgaypCHlFD6hcMWfjbUQnIs+OhC9wDtIFjir
        0bQdn8BnCPaL0kuF4Ps5GJgmsKnjyM8AmSLTICIP/dPBWmbsDhQMkeYAL/ne03ZA
        ==
X-ME-Sender: <xms:B65SXR-10lKeW3MB--aM9HXk993mF2Ha_4NGTXXezxT2rccYBOJlvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddruddviedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpehnrghnrgihrgcuoegvughhohesfhgrshhtmhgrihhlrdgt
    ohhmqeenucfrrghrrghmpehmrghilhhfrhhomhepvgguhhhosehfrghsthhmrghilhdrtg
    homhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:B65SXRYLn1eUo9wyLgFk-jPI7UFI9HgoOuykMykQvul-yORccez8xw>
    <xmx:B65SXaphYYNEcy0Exqk8ETmTDHFrzwY5CHFWv0Be0KO_qyJw2C--Yg>
    <xmx:B65SXRmwUdKkSj6CcxunpqmP52gVfMeapNNU5bsg6JiVt9mxkq9RuA>
    <xmx:B65SXYA1mHDahVp8PIL30wQwk4U_glGujnx2DGTs4kWo1evvFMmJiA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7000EE00A2; Tue, 13 Aug 2019 08:33:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-868-g07f9431-fmstable-20190813v2
Mime-Version: 1.0
Message-Id: <11796f65-42ec-4a0b-b1b1-a693f8eb3cf9@www.fastmail.com>
In-Reply-To: <20190813121733.GA10787@sigill.intra.peff.net>
References: <35477812-7889-4f32-85ac-d3da4e7ff902@www.fastmail.com>
 <20190813121733.GA10787@sigill.intra.peff.net>
Date:   Tue, 13 Aug 2019 21:33:08 +0900
From:   nanaya <edho@fastmail.com>
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: git grep -F (fixed string) requires matching parenthesis?
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Tue, Aug 13, 2019, at 21:17, Jeff King wrote:
> But I think it's actually happening at a level above that. git-grep
> supports multiple patterns, which can be joined with --and, --or, --not,
> etc. And they can be grouped with parentheses.
> 
> What you're seeing is the argument parser thinking your '(' is part of
> the construction of a boolean match formula, and complaining about the
> lack of closing ')'. You can use "-e" to make it clear that it's a
> pattern (just as you'd need to for a pattern that starts with "-"):
> 
>   git grep -F -e '('
> 
> So I think everything is working as designed, though I admit the
> implication was slightly surprising to me (and note that it only happens
> with that _specific_ pattern; something like "(foo" would not be matched
> by the option parser).
> 

Thanks. That was confusing (and the error message didn't help). I've always assumed the grep is similar to posix grep so it was weird the same syntax work for fgrep but not git-grep -F.
