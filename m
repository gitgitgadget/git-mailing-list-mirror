Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CBA41F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 17:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933355AbcI1RYV (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 13:24:21 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34932 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932977AbcI1RYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 13:24:20 -0400
Received: by mail-pf0-f178.google.com with SMTP id s13so19477116pfd.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2016 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlCpyAo7yWh0by9Koyfj16JbHlTu8aWPvhU9sFW22go=;
        b=V0DLs3DLEyVrMQVnmZFqofOWIrnYliNFGJo9GkbTEqhvFpYUmqCB4dDnREvi7j88wb
         FBMaRqn/h+v56JRAWji1vGWw7hknJe6Twpk2IC/eWzt44FZrDtn4b3og+UKojlv7lCrt
         KSMpmcI7sGdFV7/Ta02HSbWmoTcVyGXqC67Undwga6atXM3toWT87LGo2O473C79LRj/
         2IRPprf68gIRjbO6YcxT3HerKVl36e+FkSeu15i4jR32DGQ5L23kIbDyHsnTai9uH1CO
         Weklv5sk2JE7zkhjSnSIYkB/DA7GxDC+F7TjydHHmpSlfGM/PTnQNx688xeyGiMYMtIq
         vdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlCpyAo7yWh0by9Koyfj16JbHlTu8aWPvhU9sFW22go=;
        b=f/QnpGtgOqACmC0l4j+1fxETJFIR2FhZMxLE6NT/ckmmVPB0Hmezbgx0Cuh758YS0M
         XbRkOKHrjOTVbA6cHWo5hDkh8X6ndYbPaiBk0pee8SEtY4C/Jqq8q3jQPOy+1cUfJyal
         is87MucA44YijwHoRagTWvRR9IGhtzJ7RPaX9hOUK58+EtcsFCAoLjoA9ZL4k2lIQ4Gi
         lP/4qlYzMb4BJ8qMI//I9/tfNxN45vbq8BLby9hfNr8D47kNpG9frwejFxWSCiuPKHTI
         N3825z0l6yzFlRywJR2UqvgCXosi9hLlhRWFCVLuL7XdZBd3nM/HPMYxtAZbsIymgkbz
         f4PA==
X-Gm-Message-State: AE9vXwPxAenAhMCPHy4cnDIMkwKHXfE7QdGpLW1jYNTKJiDie3FUwfQoM5DSPuAqseGEF2mt
X-Received: by 10.98.73.202 with SMTP id r71mr58804270pfi.36.1475083459303;
        Wed, 28 Sep 2016 10:24:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b482:c60d:2980:8ef5])
        by smtp.gmail.com with ESMTPSA id tn5sm14077646pac.6.2016.09.28.10.24.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 28 Sep 2016 10:24:18 -0700 (PDT)
Date:   Wed, 28 Sep 2016 10:24:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for
 --recurse-submodules
Message-ID: <20160928172417.GA61176@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
 <1474930003-83750-4-git-send-email-bmwill@google.com>
 <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
 <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > In nul_to_q and q_to_nul implementations (t/test-lib-functions.sh)
> > we seem to avoid using "tr", even though q_to_cr and others do use
> > it.  I wonder if we had some portability issues with passing NUL
> > through tr or something?
> >
> >     ... digs and finds e85fe4d8 ("more tr portability test script
> >     fixes", 2008-03-12)
> >
> > So use something like
> >
> > 	perl -pe 'y/\012/\000/' <<\-EOF
> >         ...
> >         EOF
> >
> > instead, perhaps?
> 
> I actually think it would make more sense to add
> 
>     lf_to_nul () {
>             perl -pe 'y/\012/\000/'
>     }
> 
> to t/test-lib-functions.sh somewhere near q_to_nul if we were to go
> this route.

Turns out this function already exists in test-lib-functions.sh

-- 
Brandon Williams
