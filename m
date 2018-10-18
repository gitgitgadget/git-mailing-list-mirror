Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05B6B1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 22:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbeJSGE4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 02:04:56 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38903 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSGE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 02:04:56 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so2300259ita.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 15:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:message-id:subject:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/4v2MpEVFk6CZT0mrlm2ezohki6KlAjLZUpxm9Z+yI=;
        b=YUm9AsU8I9N0TdecFlr71jpsCsluo08M3yRSS2dyKte52lFg1X4rSRiVzMuCCBr6Pq
         id62r485N1fYaiCdCCiPOyt2g/38reXz4wcN/i1jhCS+e6E2x3b3ByjuLH/aEfncEVcp
         CD2nH8Xx45N4ioslXG2YsiADNAQw1s/5EpxHPxSTajpvfGWmR+6ylNNJk28iGgQqqCVa
         /rhZavdRwYJGq17ENJOsXxAU4FXMfc/Ip3dcHjnR6bdYCIJjYzdfprNMz7zL4b4azhIa
         9CnnyNG+VuPa2tN5r7MIbn9Q7pr7BvyAXpB30wxUfm5hgkbsB289GyDW3EslYTreCs6P
         946Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:subject:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/4v2MpEVFk6CZT0mrlm2ezohki6KlAjLZUpxm9Z+yI=;
        b=jU5prWRfc1qQef76mTM0YBwD+Eu6F6CPWeqTgdIufqP3R+ZSxIwCP7PUaYnxfBemjh
         zYmVp3ZPW21EGmOK9sD2m5xw0bx/c8099kEXBC/rCV1YROg/NDsF6U4Ew9c07Q9AXzmH
         FLNtzVWhrPjE5+ANY9576OdFLTVi7YJOshyXXtrEuuvhPN2YmQ27VJkw12OakWdkNnXg
         cAK1yN52jZpwHhkVlFcfNMi1mcoRaLV1wO9xfxFJYM05pUkfQoP2L0Sy+5jdh63E10Fq
         Uerhjrw7Akc278VT64IJnW+Jq8+xbmNztjfwTtgdqtnddgYZMZgLbgt8JtFiS3GL2cMP
         X8IQ==
X-Gm-Message-State: ABuFfogvLA7nZHGLbdT+cMa2Gxou3MvNa5Q/PDZKjrbM8QU53vV5Cwy7
        TAAipKciygdtP7gC6NqOBo5KNIvx
X-Google-Smtp-Source: ACcGV62Ogp82UiPwevYoQDuBIdh5vWBjoqNUJwXsRMqUYTGHSsgjFy732jW/GwaBXYBFc2QQ4oZYKQ==
X-Received: by 2002:a24:b341:: with SMTP id z1-v6mr1673221iti.62.1539900114355;
        Thu, 18 Oct 2018 15:01:54 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
        by smtp.googlemail.com with ESMTPSA id v15sm514010itk.12.2018.10.18.15.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 15:01:53 -0700 (PDT)
From:   Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
Message-ID: <9dc2995ff84158450255478c7411339a81f63aba.camel@gmail.com>
Subject: Re: [PATCH] send-email: explicitly disable authentication
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Date:   Thu, 18 Oct 2018 17:01:53 -0500
In-Reply-To: <CAPig+cR27mPmH+0oeT+2T878K-cBNqBnxPUumETnVK1cvz2qnA@mail.gmail.com>
References: <20181018211527.25597-1-JPEWhacker@gmail.com>
         <CAPig+cR27mPmH+0oeT+2T878K-cBNqBnxPUumETnVK1cvz2qnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2018-10-18 at 17:53 -0400, Eric Sunshine wrote:
> On Thu, Oct 18, 2018 at 5:16 PM Joshua Watt <jpewhacker@gmail.com>
> wrote:
> > It can be necessary to disable SMTP authentication by a mechanism
> > other
> > than sendemail.smtpuser being undefined. For example, if the user
> > has
> > sendemail.smtpuser set globally but wants to disable authentication
> > locally in one repository.
> > 
> > --smtp-auth and sendemail.smtpauth now understand the value 'none'
> > which
> > means to disable authentication completely, even if an
> > authentication
> > user is specified.
> 
> Implementation complexity aside, spelling the option --no-smtp-auth
> might be more intuitive and consistent than --smtp-auth=none.

One advantage of --smtp-auth=none is that it can also be done with a
config variable sendemail.smtpauth="none". Would be also add a config
variable like sendemail.nosmtpauth (the negative seems strange to me)? 

Or maybe --no-smtp-auth is just a shorthand alias for --smtp-auth=none?

> 
> > The value 'none' is lower case to avoid conflicts with any RFC 4422
> > authentication mechanisms.
> > 
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
-- 
Joshua Watt <JPEWhacker@gmail.com>
