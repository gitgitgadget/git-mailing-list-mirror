Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89CEA1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfEPBqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfEPAvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:51:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id v80so869048pfa.3
        for <git@vger.kernel.org>; Wed, 15 May 2019 17:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kM7NLn8NSQselnYESt8sB3Bt9bCZDC+BaisgknaURNU=;
        b=Hv+6PzyWpAubFjhkoqPt5y/ha/eOjPLym8Q7m1BAjenSxbyuWue9auQhphBonYU5Eo
         4LAdjAcBjwGLLGIxBumD+4I8qKB/T+G74RUj/YIa1peigPJzrjOE5snnwerKY+J/2GJN
         u0aPbQ91S2aceSl/yVcOmqQWiUBQxRXDNVpuQ26sGIRUxCOXhHmHlIl0NAUbobM8rUro
         4Up2vczDKc5o+8PTBHPpsa5X8nVaWl7judnA6yPUPCeZkwcQxa2ca8n0Q2dIAnmCQbZg
         VWhnLdTn6oGK9t03omGF4SDs7/SqsWqjINrZNsHGqoCaI54/+/IIk68YwQ2ajYsm6cz+
         GztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kM7NLn8NSQselnYESt8sB3Bt9bCZDC+BaisgknaURNU=;
        b=MbQf3Ona3GWWYVSkMzVIEjKLQquFDfvw3dtI5Dq9Ph0OqjNsllyteopNQnM+sQ7G7V
         e8nQ8XDw8DXcwg1G1vm10Lboxcp6CQkaoWPD3E9tvR8z69cRQlwMtO70NOupGKuhJj5P
         ccd1FhpdsR8A6J/qZZ9bFwQy/2Q3fVcZU50EuRzBabjCCD314sFvNTRFiS8XlzekpzGm
         PYgu/h2KPjWL0T9wvL1oWGHnGSGD/7L5tJY1ndrLgOTKk/+1jjj56tOWv9KL2PmwYTcj
         TLT/4z+CbuE78CN+IiTFuL2Lh9aqOQezCmQj/TIKcT9Gzy5CE5N+t6xpP0tQukaTvKoT
         nTmw==
X-Gm-Message-State: APjAAAXXcNYzxj9LVFPDD8eqQDou6PJTOkqWB1ToxQzfcOB1lmSfY6Ot
        0Id34ZkBNEWOv3IIaVphc0Q=
X-Google-Smtp-Source: APXvYqyE4Qjr8wk/oU4Bv9KZfbr+o+WwbQnOc3WLFajC123zeA5G07wQwLB8X5PaAJzrhM8XKjM87g==
X-Received: by 2002:a63:6c83:: with SMTP id h125mr2726222pgc.86.1557967906628;
        Wed, 15 May 2019 17:51:46 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id u11sm4015341pfh.130.2019.05.15.17.51.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 15 May 2019 17:51:45 -0700 (PDT)
Date:   Wed, 15 May 2019 17:51:44 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 0/7] Multiple hook support
Message-ID: <20190516005144.GC34155@google.com>
References: <20190514002332.121089-1-sandals@crustytoothpaste.net>
 <20190514004920.GB136746@google.com>
 <20190514015928.GG7458@genre.crustytoothpaste.net>
 <20190514022653.GA34155@google.com>
 <20190516004233.GO7458@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516004233.GO7458@genre.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:

> Also, this is the way that most other programs on Unix do this behavior,
> and I think that is a compelling argument for this design in and of
> itself. I think Unix has generally made the best decisions in operating
> system design, and I aim to emulate it as much as possible.

Do a lot of other programs run commands from a specially named
subdirectory of the current directory?

If you were talking about a hooks dir in /etc, I would completely
agree.  But we are talking about .git/hooks/, which has been a
constant source of real compromises.

Anyway, I think we've gone back and forth enough times to discover
we're not going to agree on this.

[...]
>> This hasn't been a problem for remote helpers, merge drivers, etc in
>> the past.  Why are hooks different?
[...]
> Git LFS, for example, installs hooks that warn the user if the command
> isn't installed, since it's a common misconfiguration and not pushing
> the LFS objects (via the pre-push hook) along with the Git objects is a
> common source of data loss. Uninstalling the tool (or not installing it
> if it's a shared repository) doesn't mean the hook still shouldn't be
> run.

I don't understand this example.  If the repository is configured to
use the Git LFS hooks, why wouldn't it print a friendly message?

[...]
> I'm not opposed to extending the config system to implement multiple
> hooks directories or add support for inheriting hooks, because that's a
> common thing that people want. I just don't think our config system is
> the right tool for specifying what commands to run, for the reasons I've
> specified.
>
> I can't prevent you from writing a series that implements a config-based
> option, and if it's the solution the list wants, I'll go along with it,
> but it's not the solution I want to see personally or as a tooling
> implementer.

I think you're answering a different question than I asked.

One thing I've been talking about is having a path to eventually
getting rid of support for .git/hooks/, on a user controlled timeline,
with a smooth migration.  I proposed one possible way to do that, and
I was asking whether it would work okay for your use case, or whether
there are problems with it (which would give me something to work with
on iterating toward something that would work for you).

Your answer is "I can't prevent you", which means you don't like the
proposal, but doesn't tell me what about it would not work.

Thanks,
Jonathan
