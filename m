Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936901FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbdEaWuK (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:50:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34814 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdEaWuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:50:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so4661403pfk.1
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2Ex298xlRDBrKVSQ+aO14cqZAH/vxXtF/sOV8pADXA8=;
        b=cXMs4Cxcr6qnd8kIfW/ed90hzxE8yAzZ+Xr1wvqztXCfK4Vf+kOfX9Uxz2YeIZL7z+
         eiS+Wl4v7uKdnPWKhE6jIIMhKp+PD/pU/sf5bkchgg03quzhUIC43fLfxeSKLxigyrYn
         AsxVzVbvgRjAYDLUXBSqowlQVOJ5hC1sjh6JAdhxwhy7cdveWPHtnxe1oE1+wthqwpNq
         y3jCFEVM4oj9+xXtKwwA4km5j283SdG+g+hblvLF1ej2KS1WMHXS2sR1JRhW4/Wv9ecF
         NZCS0hw41fN6XD8HGjrNokB1dIdc/bhlGNii0BH5T+Pt+YROP0GgUtBQmyg0mxoBBs/x
         VJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2Ex298xlRDBrKVSQ+aO14cqZAH/vxXtF/sOV8pADXA8=;
        b=mqj7uLkmg/+pmSofdMMJy5WhLoJzkzVUxCpIm97s7vTV0eZsM2HK0hHQa1ydWq82ZZ
         EqkabLc+zEEBlkDlZJ65V4M+5zu6Z85xGc84dNqRIfJolfZgqpuhilKj3irQ6mJO20T/
         VMqd6JTbLTq8hVHc7XXmxcITBgd3yCoPL1fKeFW+dzHO06VkOX1V62j6brWeY6ZPaHcX
         VBZ0msDxDZekZD4yypLvkGYcEtlvKh7Q4EpkbdhpkZDslHWLDrF7A9A2eWBNTCkKY0pO
         Nk3LDqy3FxWWHuVLQNuNBukVUWE8IeXGcosfxPDF5C9jnQf5BFpg3ry6bIN+mbj113jK
         BvSg==
X-Gm-Message-State: AODbwcCrRLIbwo677bpvuijE+2iQk05Wtvitx/DW1TyNTsUlVROQwMkP
        nwyTA2puaIM0bQ==
X-Received: by 10.84.236.77 with SMTP id h13mr92981147pln.5.1496271007785;
        Wed, 31 May 2017 15:50:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id v15sm24526643pgb.20.2017.05.31.15.50.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:50:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org, avarab@gmail.com,
        Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v2] send-email: Net::SMTP::SSL is obsolete, use only when necessary
References: <CACBZZX5j1dYk8aeRED7T7iJ=b32aFUpfUWPpMpmtofBL3QnVXQ@mail.gmail.com>
        <20170324213732.29932-1-dennis@kaarsemaker.net>
        <1493881302.20467.3.camel@kaarsemaker.net>
        <1495227246.19473.3.camel@kaarsemaker.net>
Date:   Thu, 01 Jun 2017 07:50:06 +0900
In-Reply-To: <1495227246.19473.3.camel@kaarsemaker.net> (Dennis Kaarsemaker's
        message of "Fri, 19 May 2017 22:54:06 +0200")
Message-ID: <xmqq37bkabfl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Second ping. This problem is not going away, so if this solution is not
> acceptable, I'd like to know what needs to be improved.

Perhaps you needed to actually test with older installation that
people have, it seems, between pings.  Immediately after this was
merged to 'master', we start getting bug reports X-<.

Eric Biggers' message 

    https://public-inbox.org/git/<20170531222455.GD72735@gmail.com>

seems to indicate that we should cut off at 3.01 not 1.28?

Thanks.

> On Thu, 2017-05-04 at 09:01 +0200, Dennis Kaarsemaker wrote:
>> Ping. It's a little over a month since I sent this, but I haven't seen
>> any comments. Is this commit good to go?
>> 
>> On Fri, 2017-03-24 at 22:37 +0100, Dennis Kaarsemaker wrote:
>> > Net::SMTP itself can do the necessary SSL and STARTTLS bits just fine
>> > since version 1.28, and Net::SMTP::SSL is now deprecated. Since 1.28
>> > isn't that old yet, keep the old code in place and use it when
>> > necessary.
>> > ...
>> > diff --git a/git-send-email.perl b/git-send-email.perl
>> > index eea0a517f7..0d90439d9a 100755
>> > --- a/git-send-email.perl
>> > +++ b/git-send-email.perl
>> > @@ -1353,10 +1353,12 @@ EOF
>> >  			die __("The required SMTP server is not properly defined.")
>> >  		}
>> >  
>> > +		require Net::SMTP;
>> > +		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
