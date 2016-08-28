Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39DDC1F859
	for <e@80x24.org>; Sun, 28 Aug 2016 21:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755834AbcH1VVJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 17:21:09 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37968 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbcH1VVI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 17:21:08 -0400
Received: by mail-wm0-f51.google.com with SMTP id o80so64313226wme.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2016 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=1qIO8ZzgWc8fPBeT6UjJB3JpotmeVjX4q7aM6JIjsGU=;
        b=07pKdGIGBSAJHOUwK/fgCbFREsLqbA5Bs2Vt+2g/Ibfx8xk0i+ODyaS3gpXpZClvE/
         atIDb+Jtl6t0uTQT4EybHMUBOPK86xfUjj37dmi7CwtQPr0tb7Ty2jMg2NPbJvuNrIHV
         b0Od01UmYpekW90PeJBBsPWWaqpIv3unh5zosDSZ2s76TTVvR1kEQzAOTcea9AY2FI16
         GO2ueAkIu7XcLePOMGuwiv9+lIAUSv6obhOgz7XQ0RKrKUSo84fzBetH+iZzNgrASqBg
         inEzyeBvwEfAcLIkonr2YiR3CQ6nI4v1SlXvVSl1vdaccN+0goxyfqZ1XIirr2aa/044
         o6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1qIO8ZzgWc8fPBeT6UjJB3JpotmeVjX4q7aM6JIjsGU=;
        b=AkT9sxjFZPIv65XR7t1nCFpnYj1uxR7byJr238qeydzVoYSDTWAKWuhX08wx2ep6Fh
         YJQtu7i3D+EtE5XnPD5PT7cBp8sZGu9ezNY5o6gMSha1TsM3AvvGeV+j1PrfJjD92dsf
         ROA6DmwdC5Ch1Bnrn/+bPx7uPmnvExgRtcMHegxJnIy+q+rVzR6jb+RCNexMaQRqCjzO
         +KsJwXo2n5Tch2EimuH1DO1b7lQ2Bw3MagzNnfdJTSjwKBqiv2OUwDBBeccmMWOai5l0
         0swYoIPk+UCecXjrD5MUslBS/PFqigfji4UfQ+QYvRv1DGae1qPjTHPzXaVdlt4Al1gz
         QfMQ==
X-Gm-Message-State: AE9vXwOmz6MXIpi2BcUB/PIiim5ESVkJFzPsdfRR1WAqaDjj0gqGOX11OaF4ookVJa1ewg==
X-Received: by 10.28.15.194 with SMTP id 185mr7820079wmp.58.1472419266911;
        Sun, 28 Aug 2016 14:21:06 -0700 (PDT)
Received: from [192.168.1.26] (adby156.neoplus.adsl.tpnet.pl. [79.184.24.156])
        by smtp.googlemail.com with ESMTPSA id pf5sm5214984wjb.42.2016.08.28.14.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Aug 2016 14:21:06 -0700 (PDT)
Subject: Re: Reducing CPU load on git server
To:     "W. David Jarvis" <william.d.jarvis@gmail.com>, git@vger.kernel.org
References: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <51205109-5293-3058-f029-0703c33e8cb9@gmail.com>
Date:   Sun, 28 Aug 2016 23:20:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAFMAO9y3LsrAb_jp8XVq2mexaA4bBqmWFwJu55r4S6Dxd2-zxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 28.08.2016 o 21:42, W. David Jarvis pisze:

> The ultimate goal for us is just figuring out how we can best reduce
> the CPU load on the primary instance so that we don't find ourselves
> in a situation where we're not able to run basic git operations
> anymore.

I assume that you have turned on pack bitmaps?  See for example
"Counting Objects" blog post on GitHub Engineering blog
http://githubengineering.com/counting-objects/

There are a few other articles there worth reading in your
situation.
-- 
Jakub Narębski
