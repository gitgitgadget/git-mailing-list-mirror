Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933C61F463
	for <e@80x24.org>; Fri, 20 Sep 2019 21:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfITV4m (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 17:56:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37881 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390897AbfITV4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 17:56:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id f16so3572826wmb.2
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2q978FlOvAb+PH6Rh1crIsIuTFVul3AMa0MA/92BSRk=;
        b=u6YPjUolTZiGEFshcd5ly0v5UYVJ5HoZXPAzw5cmEkZmhB/+xizBV/K0Lj7yXGxUfc
         CKpZLjxlEGz6olzD9OAeWKaG1MGNXG1vALXCmSgI0mvu1gpxP0m5R+Ix/LhGrTYBjOPF
         HFvzQUsPV5DKrdGl6g3rHPCT3qM5rdEEDQ9VN/NIadUJqzYg1vFLfnwVDBbhkFvNAL8h
         61YBNc78oO+bKk/bZw6mkgikFm8rs+rOhMwGW83TA3RkqHxlsoCyb/bXWe2JWlb9I0Jp
         HyY2afDctfdPaYvJYzxWKFxmjD3y9OuG9K/bB/V4q41CyAHS1NoGYg5fQm4WF/Iu2BJp
         7pHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2q978FlOvAb+PH6Rh1crIsIuTFVul3AMa0MA/92BSRk=;
        b=LPZ0Gt1Iugot2puSlov/eHNLVMoKdQPDaF5hZtK6BrTnw2vW1U4pMEOIWKmIHuDYkb
         un76N9HX2MF33u376RXO0cWQqv8BWViPTTxIaFloW1z0myOUXjrroavdIwm0E7ZxnSJ8
         ZUztyJYcCQubbAgY4RlrogaISutn8E5vWjyjzlbz2kQ2ZtNnMOIIgvEahVD5dzDU+Pxf
         2CdYaZyIcfteoIypymgTqeK+uukXDk3HAPR7XJIe+0cPmdE9BqFZW4HSCPgwIZo4KPPg
         vAkOZbMwLVYC59mJnYwNj/JH0IF/wyGBS8Fzs0l997VEmGrQuHzZNY8ShOlg52LX3qz4
         Yb1A==
X-Gm-Message-State: APjAAAVI7E/3p6JJHJBiaTpSilXrRPvdrDXDDPXdx0Xsxyh2+oaWpxQ2
        KOzEJchiTtA4zNC3rN1Se1w=
X-Google-Smtp-Source: APXvYqxOW7HWyXZD77UzSCOUGPWgkxSN2VGakjjUc63W7MxeMC/xQpeUjmb//6dkTRAV47Ecew1Uzg==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr5176262wmo.114.1569016599731;
        Fri, 20 Sep 2019 14:56:39 -0700 (PDT)
Received: from szeder.dev (x4db40123.dyn.telefonica.de. [77.180.1.35])
        by smtp.gmail.com with ESMTPSA id h9sm3482265wrv.30.2019.09.20.14.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 14:56:38 -0700 (PDT)
Date:   Fri, 20 Sep 2019 23:56:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] travis-ci: ignore already tested trees in debug mode
Message-ID: <20190920215637.GD26402@szeder.dev>
References: <20190919173514.24074-1-szeder.dev@gmail.com>
 <xmqqftkqvo8r.fsf@gitster-ct.c.googlers.com>
 <20190920181732.GC26402@szeder.dev>
 <xmqqblvevn44.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqblvevn44.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 20, 2019 at 11:28:11AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> >> But in the larger picture, I would expect that readers would more
> >> immediately grasp what it is about if it were titled "do not skip
> >> versions that have already tested good in debug mode"
> >
> > Will try to come up with a better subject line, but I don't have any
> > usable ideas at the moment.
> 
> Subject: [PATCH] travis-ci: do not skip already tested trees in debug mode

Wow, that's so obvious it's embarrassing.

