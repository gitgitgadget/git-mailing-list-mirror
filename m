Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACB71F453
	for <e@80x24.org>; Tue, 16 Oct 2018 21:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeJQFrX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 01:47:23 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:39092 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbeJQFrX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 01:47:23 -0400
Received: by mail-pg1-f177.google.com with SMTP id r9-v6so11483488pgv.6
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kgmIjRq3R4PZnV6awj8o4idMTZFbyfOwg+I8jEL1htU=;
        b=dHNLP6apOQ3JI3bVv5angVzOF9GsVs+mSRlO+m27fnNFTjXrTJO6w4gCXsHXE7od9l
         VFHRncW2k61VL5QsBz65KqI3qEuZQDNsIp2PdjOOsKQvaoIZfrHzuE+5WIfyxv4gIpJO
         YkseopO8N05lZify9tnkmYmbUZElVKapOt2f7aeZL7GEiz++O7miWBNn9xAJoam2WuMa
         7tIOJmXfhEO51XwT7xVz30ImETj6VM2ihCPyVOTIxGilRYhzwIh7vZHWYEqfClZ05lhN
         4kAWvx4IeRFsKN45wq8qqD1KmOgg1gxLIxTluqM2eKzy1qXnrnpJ9CLUswPoclcMosby
         S8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kgmIjRq3R4PZnV6awj8o4idMTZFbyfOwg+I8jEL1htU=;
        b=jUiDQi9+A6qEnoIKmCB7czXQODy0cnpf8/iVeP/zO/SlQ23j4a8nqj0RNm+1dvTlwq
         qM3Rv3fmSP+tFLxSaUQ9NN+CQJOBc+tKe4bPKX3Zt0YStrsxdPBsNGDzMUW/8u71ZPpy
         JacV1hoAv0uDPWmFxODzdfLzH/8P3+N43prqxJdQ8yZL1LacsI4Wxfd212nNSEqPdFgJ
         XFGYmiixxFCwTuLFhQEPYr7ohb4GIk9UXtCHZgZxtNxs9x5dCVkYtqAdg+9tRMWyxPiB
         Ub7HWN3RFvpBoDY84lb1M4YhhfIN3Mgl7MltnWkMEH2EM7L2JVrkRqnYbqNGcqxBNo73
         t6Bg==
X-Gm-Message-State: ABuFfohAf3Ffv9/TUW14qlzWY5CyGmHQxxOGWO/FnwimH6Opb51GJ9lI
        PsmSnv/yUetZVPkYihEklVI=
X-Google-Smtp-Source: ACcGV62E9WuBzxhcGceWfLdPGOf51rjdZkh2XZFY9inUvM29sQhDWcUw2wECiwqn0qHjeK6AX7N7rQ==
X-Received: by 2002:a63:fd58:: with SMTP id m24-v6mr22289919pgj.132.1539726899313;
        Tue, 16 Oct 2018 14:54:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id v26-v6sm13209591pfg.43.2018.10.16.14.54.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 14:54:58 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:54:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: On overriding make variables from the environment...
Message-ID: <20181016215456.GB96853@aiede.svl.corp.google.com>
References: <20181016184537.GN19800@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181016184537.GN19800@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

SZEDER Gábor wrote:

> Our Makefile has lines like these:
>
>   CFLAGS = -g -O2 -Wall
>   CC = cc
>   AR = ar
>   SPATCH = spatch
>
> Note the use of '=', not '?='.
[...]
> I'm not sure what to do.  I'm fine with updating our 'ci/' scripts to
> explicitly respect CC in the environment (either by running 'make
> CC=$CC' or by writing $CC into 'config.mak').  Or I could update our
> Makefile to use '?=' for specific variables, but:

That's a good question.  I don't have a strong opinion myself, so I
tend to trust larger projects like Linux to have thought this through
more, and they use 'CC = cc' as well.  So I'd lean toward the updating
'ci/' scripts approach, to do something like

	make ${CC:+"CC=$CC"} ...

(or the equivalent multi-line construction).

That also has the bonus of being explicit.

Just my two cents,
Jonathan
