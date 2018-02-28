Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7B961F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752957AbeB1XQo (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:16:44 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46037 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbeB1XQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:16:43 -0500
Received: by mail-pg0-f65.google.com with SMTP id i133so1542584pgc.12
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7Wqcah1JRo+hqSi1o3DrbKFBhgWC2/ZhnsmwOXzI5g=;
        b=jpbx50BXk0YphSaMTUamk0F0+GI5vr+I7N/xcCTZr2/P/1AFHn9glwL2yBXCrt7NXf
         xZLGPKS7I6KJW/woyJVW6yFF6NVCQcpJqbhuFvH2h89O37NgDJ9W5ZHQvLz4htF7F1F8
         EdrYhpHDdUeqplb1zPmQfpQADPvLn9Y2SfWiO4okg30fcV+iDsUyNeXXOLqn3vuqCxgf
         D88n3rTiYyCov3OnLVQ+rYihqor4FoZ34COvxOMnCYcwh4nJiSl+xjGAX9ujDrrMiKSl
         8kHB+3tunl8ljA6enca3o6cN9y3Y/iyArcQ2B2CRM9WCsJu0L8vANCNvLjjIGKnpr4ex
         B7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7Wqcah1JRo+hqSi1o3DrbKFBhgWC2/ZhnsmwOXzI5g=;
        b=Pk+81OxWMhDe1zlGvvWP0D9eVeuQN3svXtJE/t7m5NjtZuvbZPlDw9skenG5xeqXun
         OqOYKsa03GJ8OGjG2cqJlpfKTm+r2+L0oROKk+cvsNM/Eb0UNnYEHBroR8EUWa2Rp3ah
         J7SD+psti20UytVa+fsdyAnWjO3+WAe96iouxt8NAxP9XRIQ2QOQ0Y1swgGxZOGoiCGd
         aZtP0Iq12aWpfdHZKuynzCWeInGOWlGy379OVGYi+A28I2O4WokW0bWfS6Q5yqa1bJrA
         qCyrETD+6E/LZc5EuC3qE4xaKFHRm1g7kd+++YOuC8UFYbU/UimAE34AjynVuyMqyQMI
         7eLg==
X-Gm-Message-State: APf1xPB+Z+TSTCIxVaXiWhOhgM822w6DfwsnEa2WPd+8IR1vdlfz1bvd
        baLQwxAJcKgLQb8tAygRaRktcfew
X-Google-Smtp-Source: AG47ELs9/1SvMMgki7SQfP70/HkwAWUF6gAK/e5Gw39K4q9wGUEEztVyccdfapXczh74rgBt1igNAw==
X-Received: by 10.99.110.5 with SMTP id j5mr2268680pgc.65.1519859802263;
        Wed, 28 Feb 2018 15:16:42 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 5sm5881009pfh.133.2018.02.28.15.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 15:16:40 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:16:38 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'demerphq' <demerphq@gmail.com>, 'Jeff King' <peff@peff.net>,
        'Eric Wong' <e@80x24.org>, 'Git' <git@vger.kernel.org>,
        'Joachim Schmitz' <jojo@schmitz-digital.de>,
        =?iso-8859-1?Q?'=C6var_Arnfj=F6r=F0?= Bjarmason' 
        <avarab@gmail.com>
Subject: Re: [Problem] test_must_fail makes possibly questionable assumptions
 about exit_code.
Message-ID: <20180228231638.GG251290@aiede.svl.corp.google.com>
References: <20180228050034.GA373@sigill.intra.peff.net>
 <20180228074251.GA11673@dcvr>
 <20180228074918.GA32127@sigill.intra.peff.net>
 <CANgJU+V3fmhdsD8Q2NgV+RF3dbRdASV-Qwbp-agGjm6Y-PUCEw@mail.gmail.com>
 <003901d3b0b7$0a144280$1e3cc780$@nexbridge.com>
 <20180228174402.GC251290@aiede.svl.corp.google.com>
 <005901d3b0c0$f5acd370$e1067a50$@nexbridge.com>
 <20180228185152.GE251290@aiede.svl.corp.google.com>
 <006901d3b0cf$4a3f7d30$debe7790$@nexbridge.com>
 <007001d3b0df$e8b9c280$ba2d4780$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007001d3b0df$e8b9c280$ba2d4780$@nexbridge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Randall S. Becker wrote:

> The original thread below has details of what the original issue was and
> why. It hit three tests specifically on this platform where die was invoked
> (at least on one of them). Perl was invoked under the covers and the
> completion code of 169 propagated back through git to the test framework.
> https://public-inbox.org/git/499fb29f-ca34-8d28-256d-896107c29a3e@kdbg.org/T
> /#m0b30f0857feae2044f38e04dc6b8565b68b7d52b

That is:

	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting

Which matches the case described elsewhere in this thread.  It's
git-send-email.perl.  test_must_fail is doing its job correctly by
diagnosing a real bug in git-send-email.perl, which we're grateful for
you having discovered. :)

Thanks,
Jonathan
