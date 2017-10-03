Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A472036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbdJCXvB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:51:01 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:55751 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdJCXvB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:51:01 -0400
Received: by mail-pf0-f179.google.com with SMTP id h8so4820341pfa.12
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 16:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xDCSK93T06lJVv2pA2qz4tDTxWFKhUo9lzV4HljZp4c=;
        b=YBKERRA7hmuDNHb8RFImbZUpTkOoG1JGbMmHX9fwfuAHRu9zNjVk2XMoAHJPtKdvzy
         rdUS60cwhPp/eaCM5u/9+A5qYm93r5/MNIOxQlGhMxk65G727E2yrEOsz2S3d+Yj2Q5h
         Xopwz35NxmvF0x5Tl/Nc+mT9riKd7JJIEXs2ggKRs4YpjJ3PzTnCOZae8xPdhscL7B4M
         lrD/CnUtcwvJsQX9+vJ6qi/0ola9F1oL88cf0SyiR9lmTBb2zFetvg5A2R7RgkZc/2vC
         PcA/TPmP1DTjikX007ZiS0/KPIFoaiuF4SldjzFmZTPZPWknrHcHwyOSd5sZqH3HUnRh
         5P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xDCSK93T06lJVv2pA2qz4tDTxWFKhUo9lzV4HljZp4c=;
        b=HeqvngptTKGCWuwpiATKIOypWLu+2aUgHMbb6u030qY6OKyuzb9phEORaXCTIIpyVt
         socWAzk56VuZADgIVgaCnnrTdpmiuSrELYwFZWzgfmeXtyX91xY+6Ef8/idWi/14mMUs
         skxM/CBjlQFvR5+R/0N3oKsK7Q/IvuNtAcnfa3GJXmgRRIS4bDp/hLcSqAHf/zYfO32U
         ef46uhZM9AcbnaTd99zIwOaAHPQUCR7m0Zc+6O+QXm1jj2gY4tgSyth49a4lfvTIs9JL
         JXy/T8KWAvHG8jt/U3NponKs/jwfKjB+UrwN+vHHfq3MyfTa4Dvdb2DY9PJ/Ggwe9UyX
         eG1g==
X-Gm-Message-State: AMCzsaXAp2eS0lAtBXsVWhydeupWWTsrLJO+ngPsXaXRd3TpwVQ9kXQY
        QKUp8gKwr2yowFnKe9DZ2G+I2O6n
X-Google-Smtp-Source: AOwi7QC5BKSN3lPYgJ4nobSqmSeWkNKhKFH8tNIRq0e9NcIcXFWGEyGGL4sRTAUBvsmdI/NNMo4X1g==
X-Received: by 10.98.252.17 with SMTP id e17mr2840611pfh.48.1507074660420;
        Tue, 03 Oct 2017 16:51:00 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:3463:ab6b:5863:927c])
        by smtp.gmail.com with ESMTPSA id w12sm24062043pfk.83.2017.10.03.16.50.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 16:51:00 -0700 (PDT)
Date:   Tue, 3 Oct 2017 16:50:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] fixes for running the test suite with --valgrind
Message-ID: <20171003235058.GI19555@aiede.mtv.corp.google.com>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171003234153.pmslizidgbifl6en@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> I think using SANITIZE=memory would catch these, but it needs some
> suppressions tuning. The weird "zlib reads uninitialized memory" error
> is a problem (valgrind sees this, too, but we have suppressions).

What version of zlib do you use?  I've heard some good things about
v1.2.11 improving matters, though I haven't checked yet.

Thanks,
Jonathan
