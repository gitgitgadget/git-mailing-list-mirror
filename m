Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D046E201A7
	for <e@80x24.org>; Fri, 12 May 2017 23:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752976AbdELXsS (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 19:48:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35883 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751505AbdELXsR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 19:48:17 -0400
Received: by mail-pg0-f66.google.com with SMTP id h64so4510125pge.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kR3/xcxc+2vkQMKBsyTJVnNSRud9CZuU1XYrYLWwEb0=;
        b=RJGib9X6o4SQFe3n/8lwWn8DqZtfN6RhHvnmjmD6pbECEN9/d61UmJgfik83urzu5Z
         kI65LiXkUoDzG80fEPQG3nLTzKwipPioXyiCmYFnSzkgOU59Dg1AQbpUbhwKmE+3s+BL
         MsSxUWZkVI05BbA2Dr/+zPyT8o8dEK0+FSdJehrF9nS2viMwglhHsdm1MCoTsNiIxe/I
         0/fYgCxD0vCLl/3MzgCIhgRC+wK/oSuzip4AGFL2jUpzdgztAHDKqudEImZ2K2j+8orR
         Cdav6AIDsb8+ek0a0xF57dk4fwgIfVOhT344Jg8OJCcl81By+gGH9XsgNokDAntZAt+p
         UIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kR3/xcxc+2vkQMKBsyTJVnNSRud9CZuU1XYrYLWwEb0=;
        b=a+0TcHEsOowchM9ILuZ+/gJmQpLQQ/r+Pn8J+eyUUtw3KB7SHtvV1pDRv9PDBA/HUR
         8QbcE8PXiFDnIk8tbvVg2HSbybFKQ2/go/2Z8ufPez+asNlmWAQsGlbSLFkTr9Cq55Po
         4hyv9ordSoCHn5TmX2Bfrc2xbBSc6a0SKuQrP6+DBh+VXAZjLXZt5JY+uzTzNfIvdReP
         fidx4lpI7+RPQKKiCEHSBVzj0P/FGMLvclZBShFlrtg0bkWB7lYvYfVJyB7mTt0O8Xtk
         JXvQL+n1NSvWkT7wdRZx4O/3bjaukccv2w7ngFdUzbgF0yipKiBFQrQMh2BuCrWnL1vb
         qMIQ==
X-Gm-Message-State: AODbwcDpXx69UJuoxbbQs0MXSxXv5k1K6NY9/s7R20d0yROmj564hbQ1
        lltclK4MlTYZCA==
X-Received: by 10.98.8.142 with SMTP id 14mr7242781pfi.35.1494632896875;
        Fri, 12 May 2017 16:48:16 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:fcb1:2bc1:55ad:11f1])
        by smtp.gmail.com with ESMTPSA id m18sm8947566pfj.108.2017.05.12.16.48.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 16:48:16 -0700 (PDT)
Date:   Fri, 12 May 2017 16:48:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] builtin/log: honor log.decorate
Message-ID: <20170512234814.GG27400@aiede.svl.corp.google.com>
References: <20170512220704.txmdk45s66aqhexi@genre.crustytoothpaste.net>
 <20170512221221.406645-1-sandals@crustytoothpaste.net>
 <20170512233214.GE27400@aiede.svl.corp.google.com>
 <20170512233753.rz2g7quews4ny5iq@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170512233753.rz2g7quews4ny5iq@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:

> Does anyone else have views on whether this is good thing to test for?

I know you don't mean to be rude, but this comes across as a bit of
a dismissive question.

> On Fri, May 12, 2017 at 04:32:14PM -0700, Jonathan Nieder wrote:
>> brian m. carlson wrote:

>>> The recent change that introduced autodecorating of refs accidentally
>>> broke the ability of users to set log.decorate = false to override it.
>>
>> Yikes.  It sounds to me like we need a test to ensure we don't regress
>> it again later.
>
> I can add one, but it's going to be a bit odd.  The issue is that as far
> as I can tell, the option is honored only if it's the last one read, so
> it necessarily has to be in the per-repository configuration.
>
> I'm not sure it makes that much sense to add a test for this case.  Do
> we generally want to write such tests for all config options?  I don't
> suppose it's that common a mistake to make.

In my humble opinion, the bug being subtle makes it especially useful
to have a test that describes that bug.  That way, if someone is
refactoring this code later then they know what to watch out for not
reintroducing.

I'm happy to hear other opinions, especially if they come with data or
a principle attached that I can use when writing future patches of my
own.

Thanks,
Jonathan
