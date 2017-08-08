Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA6720899
	for <e@80x24.org>; Tue,  8 Aug 2017 22:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbdHHWeh (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 18:34:37 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33110 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752414AbdHHWeg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 18:34:36 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so4350799pfl.0
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 15:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ag2EbTGUplmTkTjTVsBYA4iIm1qqBtacitJvJcV4hAc=;
        b=HdbAgJzsEV7l8CQxhhwc2VJKbZHkdQaLN6/+m+phVB54h8b2UfjOZzBk9T0FuvNRJ7
         vgNHb8Faa+j61nK4urozH1fJ6kdcTs7wKcECOglmssly7QJf+VQ1CY2+GdkDkIkTChNq
         z46Iq2OVTMLfqHNJCyAEKWfdI84FwXMkuMcGOfciBAGRLFwqKSheF2redmpSTKXJ1Tog
         LWfr1rozvvGwi+anGnZEzqQMv5ydjd7RbnCeYQg5NnULEF5gwbfzFOjbrYUqeCO0wPG/
         G4HJFGvVzz3XgGp9GSO5kZpa/GnWPEmrk4LF5IqMm41yNGePYATrlbyYqRRyXu5WVKUq
         tS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ag2EbTGUplmTkTjTVsBYA4iIm1qqBtacitJvJcV4hAc=;
        b=oEJSKjeC17ZDfL0CbtOYmHm3NDtT+6NNLW65yqT6uQJpxVbdD+PedLALOCOXjZH2XK
         mxJitEKotv8vtUdfoR3rkG3L2HqB4Fw4BqZ0mtbWaYJvbWobRdasA1hHQ/r0bW3ZwPd0
         1DOaG6EHjMb1gZr9XT7JsZ9fK2cBZ3We1ZPhMRUnzEtFzOrMZVR4EW/AxYnBIyQ0/Mag
         awEi45rkKKm9y2Q2fsjOlOibnflrLV+FPspyQNhPHB0VSeNb5557+e/ZrkWmo7EZrthB
         uVwKF6yX7rmtteYvosEpmF7ho96Iia1GIxTgvKbUUk28q9Wc28IkpfyDU6LqBiWkKsrJ
         kexQ==
X-Gm-Message-State: AHYfb5jtq7Q/A31gzmwb5phonH8pZW+1mfcbCuWRrEtE3Ya/wJUqeL7i
        73UHrkheevaiK7sCex0=
X-Received: by 10.99.175.1 with SMTP id w1mr5633538pge.390.1502231676176;
        Tue, 08 Aug 2017 15:34:36 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:d173:771d:dd07:d344])
        by smtp.gmail.com with ESMTPSA id n129sm3878796pfn.27.2017.08.08.15.34.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 15:34:35 -0700 (PDT)
Date:   Tue, 8 Aug 2017 15:34:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] builtin/add: add a missing newline to an stderr message
Message-ID: <20170808223433.GC169894@aiede.mtv.corp.google.com>
References: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for catching it.
