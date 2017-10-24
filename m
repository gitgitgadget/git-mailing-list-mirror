Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44D7820437
	for <e@80x24.org>; Tue, 24 Oct 2017 13:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbdJXNjb (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 09:39:31 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50856 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdJXNj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 09:39:27 -0400
Received: by mail-wm0-f45.google.com with SMTP id u138so15790945wmu.5
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IDu8/dGR7doTzwLkCUX6+mDppAvpEF+pxu1kprwz6es=;
        b=vhKl1DrpYWmg5G9fOxvakoVHpIW+i28dwlOQnSRFLhtl+fAz7G0B5gfirB/Hkm2nvl
         T5T1GjfVfBb7LikbZd+AL6D7yfgJfFEH7KP1WB7IuwSo4OyOpPBh7QbDeXYafUTmRrRo
         6m7Jvi6D9ly0tK87aCYXFKBiCZ0ZG7PImyrcXzXhmGUGnDm6THo6PnFWKqFmlY/skYKa
         UG8kdg+RHOuE/PqqyJV+1Vo87gxYgE55yRScfxcgDIaVbuAT+o2l7ghpvfFwDXdz6rDf
         TJYlIYBEDGC+BfT6MvRuNXhRt2Vklk8WzgQHMk/GQG8J72RCAx6T6/VgDd4n/V/9VELa
         s0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDu8/dGR7doTzwLkCUX6+mDppAvpEF+pxu1kprwz6es=;
        b=tD0SPY69fCnel23AGJ5aWCk4FdnViT1fQ1yBZhDih6hmFGVL8PvtQ4z4EAvVprZJ99
         TiOInHUmDRE+K5xDbJ2fWhrQiu9BPiOzmVPSXHTX9ZsDmll5T/KCBOvprq3n1kmc7mPe
         v32KryKfzO4fYU5E7/x5McNULGHAqi65khyRUhzveT9LKgRGdVaLZ4oiTvj6trJ49mhN
         u+LsZo2F18fvtPE666qvgOyWjh6upEXNuByC0TmSDwwwrMiQOeuMIgr1r8cxp0BLVC+I
         430Fa1QQGBD6/Bg7K3OO0krKsDs2xDFntmXDdYMZptMXG4IRe9bzZ0egiENFp88pck/8
         i7kQ==
X-Gm-Message-State: AMCzsaV4opxyOF1X6d5FR1QzllTHfZOG2VANIQR4A5del55atO8Lh+TM
        prXhIKOtNowNIjBBnFja8xF1
X-Google-Smtp-Source: ABhQp+TNOF7X++hzTXVnTZqAEzqG+6XhYm0EePNEdTVJc6EvUvLR5cFKSEafZcmW1GcG1t5mTLUH6Q==
X-Received: by 10.80.151.186 with SMTP id e55mr20408396edb.91.1508852365928;
        Tue, 24 Oct 2017 06:39:25 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id q12sm232536edj.29.2017.10.24.06.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Oct 2017 06:39:25 -0700 (PDT)
Message-ID: <1508852364.2750.31.camel@kaarsemaker.net>
Subject: Re: Git diff --no-index and file descriptor inputs
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Date:   Tue, 24 Oct 2017 15:39:24 +0200
In-Reply-To: <F65D91595838434A963FC2EE26D62CB8@blackfat>
References: <DF5E912A0E6343DF8C3E984A165490EF@blackfat>
         <CAN0heSpT=W=5LiQL0SPOffkUO94uTGB-Aatn1fUc07aGqLG16A@mail.gmail.com>
         <F65D91595838434A963FC2EE26D62CB8@blackfat>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-09-07 at 15:55 -0400, Jason Pyeron wrote:
> > -----Original Message-----
> > From: Martin Ågren
> > Sent: Thursday, September 7, 2017 1:48 PM
> > 
> > On 7 September 2017 at 18:00, Jason Pyeron <jpyeron@pdinc.us> wrote:
> > > 
> > > I was hoping to leverage --word-diff-regex, but the 
> > 
> > --no-index option 
> > > does not seem to work with <(...) notation.
> > > 
> > > I am I doing something wrong or is this a bug?
> > 
> > There were some patches floating around half a year ago, I 
> > don't know what happened to them.
> > 
> > From: Dennis Kaarsemaker
> > Sent: Friday, January 13, 2017 5:20 AM
> > Subject: [PATCH v2 0/2] diff --no-index: support symlinks and pipes
> > https://public-inbox.org/git/20170324213110.4331-1-dennis@kaarsemaker.net/
> 
> I see, it goes back to 2016...
> 
> > From: Dennis Kaarsemaker
> > Subject: [RFC/PATCH 0/2] git diff <(command1) <(command2)
> > Date: Fri, 11 Nov 2016 21:19:56 +0100
> 
> https://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/
> 
> I will read up on those threads weekend, then try to apply the patches and
> see what happens.
> 
> Thanks for the google fu help.

I hope to send a new version of this soon. I had almost no time to do
anything git related in the last year, trying to catch up with mailing
list traffic now.

D.
