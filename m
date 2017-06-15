Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB1C20401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbdFOTNT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:13:19 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36361 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdFOTNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:13:16 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so2599460pgb.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fW8JTGyiJU3jdMHsTGk5nQqKA+7dJ9Ct6sjkGPO1m3Y=;
        b=hCo53HwYQin9BAOdzfkKD1/ZeDD5OtAyDTcejuRJ/2UizrEYGM45oHA1eWDXqhTumC
         43C9g8o35ciHFeFDsFhquLdj+f6IsfpsRo7D/+3QDaIslYizHNUiVE53Tf4jxiIJTZ0q
         WETIkPpbrJKbkd9faLP97YevQ1T+EWZ8EZddEmZoVe+T2q4ZXuEBMVFRtfoj2c1Q+u72
         +k6s6G5RPv4zyx/TW/Ybtv8zfVpzOquSSGmxPmKKjHAl2vKCjUF4YIgbjEY3f+5DGspJ
         9PpGqxA2ZkBVP/dYLVARu9lnf2S/S65zsrPdWlRKNKJ3TCzwMSJbIk+HoSwuN1vlLqIx
         3qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fW8JTGyiJU3jdMHsTGk5nQqKA+7dJ9Ct6sjkGPO1m3Y=;
        b=IarbBbM9DZGdEznqfC8548Rz9rPWlcL0e7fkSd09NktOSY8ZxQDNiw4bgpHpfWXQ65
         j4k9OI8kLJzK1KRlcQcp6NpUThVmy/fEKXGZtuIkn8XtMy5FNJ+S1V4BGcU5FR/kbVDm
         D6V9ENJKhGo1I/Hq/8vDTSeJn+yLbOrC1lCsB9uShP2MgXKEkeqTjQayckgeHWc8Y6Y5
         Ov+lkviT5I413kWkvoIbGqtbwDGbqVha+DXaTm9IrI/2zxsvPoYYYjYb0Zmeve7TRDbo
         ovscz95kewP6nI01A09xX0fvQXFeU4ezd+78AHJ15XwQIgy4saftezXH6rFlR3H3GcM6
         HL5g==
X-Gm-Message-State: AKS2vOy+KbDXTyGFcRUNXc+FieKu3gK89SWH8hibXIt5raBoiOl+wUyR
        xwwzkwbz00RsxQ==
X-Received: by 10.84.195.131 with SMTP id j3mr7999195pld.97.1497553990941;
        Thu, 15 Jun 2017 12:13:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:658a:74a7:91cb:4852])
        by smtp.gmail.com with ESMTPSA id n71sm92732pfg.46.2017.06.15.12.13.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 12:13:09 -0700 (PDT)
Date:   Thu, 15 Jun 2017 12:13:05 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Brandon Williams <bmwill@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170615191151.GA45444@aiede.mtv.corp.google.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

Johannes Schindelin wrote:

> From what I read, pretty much everybody who participated in the discussion
> was aware that the essential question is: performance vs security.

I don't completely agree with this framing.  The essential question is:
how to get the right security properties without abysmal performance.

> It turns out that we can have essentially both.
>
> SHA-256 is most likely the best-studied hash function we currently know
[... etc ...]

Thanks for a thoughtful restart to the discussion.  This is much more
concrete than your previous objections about process, and that is very
helpful.

In the interest of transparency: here are my current questions for
cryptographers to whom I have forwarded this thread.  Several of these
questions involve predictions or opinions, so in my ideal world we'd
want multiple, well reasoned answers to them.  Please feel free to
forward them to appropriate people or add more.

 1. Now it sounds like SHA-512/256 is the safest choice (see also Mike
    Hommey's response to Dscho's message).  Please poke holes in my
    understanding.

 2. Would you be willing to weigh in publicly on the mailing list? I
    think that would be the most straightforward way to move this
    forward (and it would give you a chance to ask relevant questions,
    etc).  Feel free to contact me privately if you have any questions
    about how this particular mailing list works.

 3. On the speed side, Dscho states "SHA-256 will be faster than BLAKE
    (and even than BLAKE2) once the Intel and AMD CPUs with hardware
    support for SHA-256 become common."  Do you agree?

 4. On the security side, Dscho states "to compete in the SHA-3
    contest, BLAKE added complexity so that it would be roughly on par
    with its competitors.  To allow for faster execution in software,
    this complexity was *removed* from BLAKE to create BLAKE2, making
    it weaker than SHA-256."  Putting aside the historical questions,
    do you agree with this "weaker than" claim?

 5. On the security side, Dscho states, "The type of attacks Git has to
    worry about is very different from the length extension attacks,
    and it is highly unlikely that that weakness of SHA-256 leads to,
    say, a collision attack", and Jeff King states, "Git does not use
    the hash as a MAC, so length extension attacks aren't a thing (and
    even if we later wanted to use the same algorithm as a MAC, the
    HMAC construction is a well-studied technique for dealing with
    it)."  Is this correct in spirit?  Is SHA-256 equally strong to
    SHA-512/256 for Git's purposes, or are the increased bits of
    internal state (or other differences) relevant?  How would you
    compare the two functions' properties?

 6. On the speed side, Jeff King states "That said, SHA-512 is
    typically a little faster than SHA-256 on 64-bit platforms. I
    don't know if that will change with the advent of hardware
    instructions oriented towards SHA-256."  Thoughts?

 7. If the answer to (2) is "no", do I have permission to quote or
    paraphrase your replies that were given here?

Thanks, sincerely,
Jonathan
