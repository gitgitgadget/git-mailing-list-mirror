Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3895B1F405
	for <e@80x24.org>; Wed, 19 Dec 2018 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeLSSjb (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 13:39:31 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:35132 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbeLSSja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 13:39:30 -0500
Received: by mail-pg1-f182.google.com with SMTP id s198so9822465pgs.2
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 10:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8MQoI2dsv7Qe+IMjYv5p1U7fIvafbv9mQ5TioJkaSqY=;
        b=jx3QuP6qA12HofEp5aDcSHhT1plmUVOKHNajc/p1ssv4On6+DsF0eqq/tguzplGJ7b
         MQKri2csH+4tAsa2theYXX7vRO5+OF//HKtaD9mL4HWCvS1kkuj4WyrJDn60nOGgjfYa
         kD91RAV+oNMPfoHoqTzkptfzhC85EmmlQ/whdgXPHKQ/F1Umym8GFdZc/iFWmwjhsJGw
         erXebZ1vgNIuYgTGELwOVrmomW1+9UbGQOJwbScxPgKbNJH/jHoT95SfYUVxRJPz4Za+
         97LMi99ARYavzznhYndcl++bnGRqeeqv7WvEqDtx2qcMx6GCPA4wgwk2xMhTviOF9XDz
         89Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8MQoI2dsv7Qe+IMjYv5p1U7fIvafbv9mQ5TioJkaSqY=;
        b=amh0/qfKZHE/IMxryblp3M+we23TBlBBwo6ZejT0RTC/JpPkSsJ/8LGzIcq7N4aOG7
         HFoY1yezTPQGzfur+2wKV6Z+z4lPYMI7NzH0ooOEm48PpZ4KDrYDzM5be7KDV2CXVnbx
         qyneZMDnj3vnaolRUdtWidnqj1YDei8dGIMnHW8LnGdLHvCXIP/BwNvxu5Wh32AK2Hgi
         SmSdXqeD7q84iv59jhmGYwtk1g1U8oPIWMlD2DXJyPvH16jzfLASffH+Lb/XnUSrH8cV
         IPmKxOw2XDR3xu7em5fuSRzPVNr7g3+nM/nEey6KFBXvx3MJP5U1ZWWekdCs9yS0yJt8
         Rcyg==
X-Gm-Message-State: AA+aEWb/Kad71gXqA0xa1LR8Zu5hSMmcY2t+tJmTlR2PetO01erY9Aiv
        LO8ba8cdAOIRcRaaoGcqUK4=
X-Google-Smtp-Source: AFSGD/Xw1ootmvH+z/4TwVm+XRjQ9CHjhBaGyTeK+JBUm38KpTFAhZc9WnwIBbJBZnxnEFTqp35JCQ==
X-Received: by 2002:a62:c613:: with SMTP id m19mr21752691pfg.207.1545244769554;
        Wed, 19 Dec 2018 10:39:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id t87sm62432864pfk.122.2018.12.19.10.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 10:39:28 -0800 (PST)
Date:   Wed, 19 Dec 2018 10:39:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Referring to commits in commit messages
Message-ID: <20181219183927.GA228469@google.com>
References: <20181217165957.GA60293@google.com>
 <877eg5fwd5.fsf@evledraar.gmail.com>
 <20181219182216.GA17309@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219182216.GA17309@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:

>   - web interfaces like GitHub won't linkify this type of reference
>     (whereas they will for something that looks like a hex object id)
>
>   - my terminal makes it easy to select hex strings, but doesn't
>     understand this git-describe output :)
>
> These tools _could_ be taught a regex like /v(\d+.)(-rc\d+)?([~^]+d)*/.
> But matching hex strings is a lot simpler, and works across many
> projects.

Is there some rule about how long the hex string has to be for this to
work?

[...]
>   In commit 1234abcd (the subject line, 2016-01-01, v2.11.0), we did
>   blah blah blah

The issue with this is that it is ambiguous about what the tag name is
referring to: does that mean that "git describe" and "git version"
tell me that v2.11.0 is the nearest *previous* release to that commit
or that "git name-rev" tells me that v2.11.0 is a nearby *subsequent*
release that contains it?

Of course the latter is the only answer that's useful, but in practice
the former is what people tend to do when they are trying to follow a
convention like this.  So we'd need some automatic linting to make it
useful.

I think a more promising approach is the Fixes trailer Duy mentioned,
which has been working well for the Linux kernel project.  I'll follow
up in a reply to his message.

Thanks,
Jonathan
