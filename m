Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE31220357
	for <e@80x24.org>; Sat, 15 Jul 2017 00:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751193AbdGOABk (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 20:01:40 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:32860 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdGOABj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 20:01:39 -0400
Received: by mail-pg0-f67.google.com with SMTP id 123so419774pgd.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=07WBlvFlNjqDHIo+PnuYH+EkYswuZ3x6n3GnUgd5Yj4=;
        b=H0SZsoCn/eS1EL0i6lksowdeaHl8cSOZXCrOGWOXftjCP1YQannWJyNJX1zeLBEjNd
         q+3KYjVAAwA7JSTZE6f22/vmHsxWpa9XJTPPufHAb0eSMVc58BTjxHDDbrUvYTgTstRZ
         wslxr/Wf4ncAqXGX9MXLtvnuJwNH4sVJjURz37LWzDcn2tBhx3rWs4vlswjkyuKYBo1I
         eWCgKalnpQ9VMe9Tx5WuWKAteEt/Kl6aNYXeJ5vLFwaUrnEn39plFUo4CcBB/Mt6opvZ
         8h4qwskAFthPrF24+VK6hsS+JLev7K20x8qtFFFWkMp1O4xiNFcXgefdMbii1cyWdT43
         5T4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=07WBlvFlNjqDHIo+PnuYH+EkYswuZ3x6n3GnUgd5Yj4=;
        b=F0kMzHh5c+P6gomW4Zj1FxgD0J+1nxxxyYedY0/uSweQhPztgxRLf4nrCvGFrH8lUA
         sbG7Y//zx4vsPTdw6OMNHO9s7cZWHbzi4KFjjOJwNb1NdFvVXi7Y4wLjzxm/8Sj7CMC9
         Mrk1anTz34TUwcVKoogaYKoU5tO/QhOthld2hItoaxivdzrCMRtS4PUoRPCWCJSGzqMZ
         MmoAQ7V6HSyRcmDltbJv7h17hL2nKCHWbKKivsCsUov++KEhY+NOUZrjwEram8CV6moO
         ZXKqFSRQsU2lgMK/9hhdIfNVe1/DZWBWkpbVV4GraSinwmCNY48XARfch2Kxah7/ziN4
         KN9w==
X-Gm-Message-State: AIVw1128ZtQNbqsW8j2UgK2tyNLufNLR0VFcs3VDsrLwJgU2xEQyGn8S
        BMrp0clD5bP4HTtVx6M=
X-Received: by 10.84.172.131 with SMTP id n3mr18343639plb.14.1500076899181;
        Fri, 14 Jul 2017 17:01:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d522:5f:8052:2b20])
        by smtp.gmail.com with ESMTPSA id b28sm23189211pfm.9.2017.07.14.17.01.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 17:01:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     astian <astian@eclipso.at>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
        <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
        <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
        <20170714153015.crklfqaa2qc573zo@sigill.intra.peff.net>
        <xmqqh8yfq8pr.fsf@gitster.mtv.corp.google.com>
        <1d79b017-38b3-e1cb-a4bf-1153dc4fdbca@eclipso.at>
        <20170714174002.xjizkofjxlirgnaj@sigill.intra.peff.net>
Date:   Fri, 14 Jul 2017 17:01:35 -0700
In-Reply-To: <20170714174002.xjizkofjxlirgnaj@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 14 Jul 2017 13:40:02 -0400")
Message-ID: <xmqqzic6pnz4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> There is also this:
>> 
>>   $ git branch
>>   * master
>>   $ git BRANCH
>>   git: 'BRANCH' is not a git command. See 'git --help'.
>>   $ git config alias.branch 'branch -v'
>>   $ git branch
>>   * master
>>   $ git BRANCH
>>   * master 51c785c initial
>
> That is an interesting side effect, especially the latter BRANCH/branch
> one. We usually do not allow overrides of actual git commands, but this
> "fools" that check.

This one is tricky.  An obvious fix would be, because users expect
that their aliases are case insensitive, the rule that forbids and
ignores an alias that masks a real git subcommand should also apply
case insensitively.  But that opens another can of worms.  If "git
Branch" is forbidden to be an alias, it should not just fail but
invoke "git branch", which would mean that Git subcommands should
also be looked up case insensitively!  I am not sure if we want to
go there.

> I agree it's an unexpected fallout. On the other hand, unless you are
> _trying_ to do something funny, I don't think you'd ever hit on this
> behavior. And if you are trying to do something funny, I think this
> behaves in a reasonable and predictable manner.

OK.
