Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6413F2095D
	for <e@80x24.org>; Wed, 22 Mar 2017 22:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdCVWCw (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:02:52 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35235 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751153AbdCVWCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:02:50 -0400
Received: by mail-pg0-f44.google.com with SMTP id t143so47520763pgb.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 15:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uvcthn18FZPWGEp2zFPOzDMXTOLFINliQtaAjOD9ghA=;
        b=qcnT31prxT89BWc/aDRul5rVJiE+l/Ij1th2+cjkYSq4d8Lwg+duWJNVF1Cvqttkk2
         +xPoJ0Q22SivhblRGHJSdnDq91IAVHi2jDu3F5DBRsq+jl6+Flw+7rc1R7CbRMDxh+5S
         kz8W5mTyB6JxSbRz7ByUiXgCmfGYXOu6Zg4J6EOgqqYGPEd2AcKYFO0giQX+WzDzJCg5
         ZtUCNKBqBDV9IjmbSFmq3bmOEtvGthiNgBRYcfXbmOp/THP+m9zOhnsNsymsFWisByVd
         9Lvh+rGKKtS91tRBRM7qc1SgAdgODU0XKGFnzmgEOl1YvkLUJpipo+mQ8YM9K3SH2gzo
         j2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uvcthn18FZPWGEp2zFPOzDMXTOLFINliQtaAjOD9ghA=;
        b=lpvQMmzUUPw9CgZpm+XTY4vA49donR5Kh0+SF8KeTk54x/aA5GMPDHk6ldPnPNP0S2
         SJGgm6Y8s5giBXWX5eQGpnXkgP0rVTRraohizjQ0XQ6bA48t9KGTW1VvfWmQGpNjcgtG
         hvT+rC/9sEtkOYPIXAeqWnL/Xq8NQ7hov/H1XNP8fLAdQrsXbdgnwzyoUZLpCydZNiCx
         R3Fwff6k59ghesXACGx6eEWGsIMa70rlrRkaG8DPh8UjAWNn5/gg046yMrq5Pxj+31zz
         H6mhi0FHyFZCj5/SonGXFyK6A9kMQ7WAn2rYjbuOU5dppLXETcEnLElXJZTDzB03bYXe
         c/9A==
X-Gm-Message-State: AFeK/H1xeUZR25LozB9dfnA2B+CKZ23m3Lv0epJ0gZfWUib2sTVkwamW9CedoCgXtRO69w==
X-Received: by 10.98.16.11 with SMTP id y11mr48147909pfi.84.1490220169506;
        Wed, 22 Mar 2017 15:02:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:55f5:992d:bc78:c749])
        by smtp.gmail.com with ESMTPSA id t6sm5825203pgt.8.2017.03.22.15.02.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 22 Mar 2017 15:02:48 -0700 (PDT)
Date:   Wed, 22 Mar 2017 15:02:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: USE_SHA1DC is broken in pu
Message-ID: <20170322220246.GD26108@aiede.mtv.corp.google.com>
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
 <2B1DE627-11C8-4FA5-A354-76B6C475666A@gmail.com>
 <FFC0EFBD-C4D9-4FB8-A45D-7B10689724A1@gmail.com>
 <alpine.DEB.2.20.1703212105030.3767@virtualbox>
 <xmqqh92mo06a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703221530040.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1703221530040.3767@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Johannes Schindelin wrote:

> As to the default of seriously slowing down all SHA-1 computations: since
> you made that the default, at compile time, with no way to turn on the
> faster computation, this will have a major, negative impact. Are you
> really, really sure you want to do that?
>
> I thought that it was obvious that we would have at least a runtime option
> to lessen the load.

It's not obvious to me.  I agree that the DC_SHA1 case can be sped up,
e.g. by turning off the collision detection for sha1 calculations that
are not part of fetching, receiving a push, or running fsck.

To be clear, are you saying that this is a bad compile-time default
because distributors are going to leave it and end-users will end up
with a bad experience?  Or are you saying distributors have no good
alternative to choose at compile time?  Or something else?

Is there some particular downstream that this breaks?

Thanks and hope that helps,
Jonathan
