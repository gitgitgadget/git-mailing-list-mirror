Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEA762036B
	for <e@80x24.org>; Tue,  3 Oct 2017 21:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbdJCVrv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 17:47:51 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:56070 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdJCVru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 17:47:50 -0400
Received: by mail-pg0-f50.google.com with SMTP id b11so5429133pgn.12
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WJ1szwqkmGJaCjkrh2yFtd37jmnVR9oE6BqUPPdnr88=;
        b=iQJRiWKcKNQHzSyXf5eHeQA9kWQT/mxHEBFMNVnIcGjL47OrvzghU1shY412omfS8s
         7VCX5kH6zQz2K+J77AvUFTArToLFgj5puQiAbCRvWbi035qQULcs6G/Pg8MEXkoicdRg
         KQGIlZEaMEuKuEUJC8y/rbAAiIWP1WHEZaQciYSb/0TOinmbWxuNdcSG2GIV3vnbloxJ
         x4Q4J86p0vlmTRPrjOwHvRwWtBPud0EQUJbOu0T0+s4/wdTeaa2w9WRRm75Q75+nIrF+
         C3lYc95EvaKycO+EZEX7FTf4PDnBU8MqG2OGN4RJJjgoEV9FZ+9B3wH3QC7eckAdJKgl
         5k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WJ1szwqkmGJaCjkrh2yFtd37jmnVR9oE6BqUPPdnr88=;
        b=K6relOh/QmQtsvEuOoVydMJS1hgj1q64qJ0gCq4Edbwm7FM3+VUo52dt47RDxc5I2N
         3leLi9WoM5e5auWTEhxIPhq5gl/iUIppHJ5XdYHfppmfdK1OR830EOnOmm1KGrp4yWHp
         /ZCq3opVqtxqgvc78kKDywq2/fLoUu6xRwP5Pf34qFZZbe8OR77B+wIRsWIv9TlHvONc
         iybtYb3rCfn/5+d8lGCY+inq8BTSyE+5i017pAZnDbJelH01RNCefM1LiLYbJQQESe6D
         9RrEZaVlyBpnMK8TtPYUeR5ujcM7WA96y4muEAwcspIGo4wVw/NtwJ8VPjx8YkglNEwg
         j0tQ==
X-Gm-Message-State: AHPjjUigneGkLwzuWdhfgQVj+F9GGqTylU3ueHDWA1SOpVsmiZOfOKGc
        auYV7CYvfkwdefI7NnDvzTM=
X-Google-Smtp-Source: AOwi7QAuWjtiMV1lihtn15H0bfYicbfcaUESCLqhbWPrBJ6CsB7MuyCIkqU3u+ntLUKG1dbFM26ItQ==
X-Received: by 10.84.132.78 with SMTP id 72mr18079578ple.185.1507067270365;
        Tue, 03 Oct 2017 14:47:50 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id a78sm23793106pfl.39.2017.10.03.14.47.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 14:47:49 -0700 (PDT)
Date:   Tue, 3 Oct 2017 14:47:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Rebischke <Chris.Rebischke@archlinux.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [bug] git version 2.4.12 color.ui = always breaks git add -p
Message-ID: <20171003214748.GA19555@aiede.mtv.corp.google.com>
References: <20171003213353.GA9195@motoko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003213353.GA9195@motoko>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Christian Rebischke wrote:

> I played around with my gitconfig and I think I found a bug while doing
> so. I set the following lines in my gitconfig:
>
> [color]
>     ui = always
>
> When I try to use `git add -p <filename>` I don't see the 'Stage
> this hunk'-dialog anymore. First I thought it's some other configuration
> but now I can definitly say that this configuration breaks `git add -p`
> interactive mode.

Do the patches at
https://public-inbox.org/git/20171003133713.ccxv6clrmuuhhc3u@sigill.intra.peff.net/
help?

Thanks and hope that helps,
Jonathan
