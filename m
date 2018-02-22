Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1552A1F404
	for <e@80x24.org>; Thu, 22 Feb 2018 21:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBVVc4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 16:32:56 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37109 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBVVcz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 16:32:55 -0500
Received: by mail-pg0-f67.google.com with SMTP id y26so2518259pgv.4
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gvIeSA4WGhD3RL/BN4gnBQ0DYDuVXfVAljwTCkR90Nk=;
        b=kjZ+0sXtnXQsHrGB+tNr3QONbh+Y7eMOajLH+ghMUUGlHwtYwB9ZJMu1jR+yzr1EUy
         QBkyijBx3+2qL4HJjCmFZS2a3YOKv26OWxklKKSkrVfc1Cg9I4jLYXM5ZMxc7xLYKU+c
         mSf6dG2xhWUnVMZ6KTI8KXNDCnYa6vcFPss8xeth2z5ZlbEUCkhZTHLhyRr8T+Ew4ZkA
         zXNUCK6nK2jt3qCwsrkuDOXfSHX9jn6GySyZT2I9+Zjzeg8knJwmP23Smq+RO8eL2Jjj
         odKv7bgJzGVPhBayyWWcpScN3cgyWpWWhCS8lCDrL5lEPDx+QeWcGZzg3tmfkXI+HgbQ
         fIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvIeSA4WGhD3RL/BN4gnBQ0DYDuVXfVAljwTCkR90Nk=;
        b=K5JiX25wWxZgNJpBHWsfWNcqv7WPjgNom3MrOcn73ch7Sb+9j9g0bWHEoP2BCmzvC3
         JLRWvJbtu+FFpYkHghP4WkqkhfYzEQRK/uXxLpRZHJ1rP4XPdyLLRKLpMFABvpEYEtQj
         vOy+xxcdVtgzhfVBq4QEQL1b2ZMRCkQPwUX9L7Ff7/JKD0CkdwbhIBEyLgpmIBEl1Vn3
         aWSDDnDz3Iy1wvTBsArkZP5b+LOd3AP6UCPJTUVSfHZ4KTb+3FLGh2acVswILl6h6EpM
         CcYKDAbsTSDBVazhKVVn3Q/pBsgM3hw+fJUU+MojhbVBo5Zi/SMwJyy4wBojYcxAJjwi
         iZhw==
X-Gm-Message-State: APf1xPDfYouREE4SQ5G8FFgKb16bt/7bgeWJyM2PRUE75pXyz/Nh6bHG
        027ukAtYhstRbX33ebF/MqU=
X-Google-Smtp-Source: AH8x226fhjUsXk6b5BKj3Km8esN8BbhfgWV1GM2PuYJmTnRQ3ZGJ8JBqlfDAtYRjbtvVfi5D4Ioyvw==
X-Received: by 10.99.96.146 with SMTP id u140mr6772159pgb.211.1519334797116;
        Thu, 22 Feb 2018 13:26:37 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v8sm1851351pfa.32.2018.02.22.13.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 13:26:36 -0800 (PST)
Date:   Thu, 22 Feb 2018 13:26:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        sbeller@google.com, gitster@pobox.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 04/35] upload-pack: convert to a builtin
Message-ID: <20180222212634.GC256918@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-5-bmwill@google.com>
 <20180221134422.2386e1aca39fe673235590e7@google.com>
 <20180222095833.GC12442@sigill.intra.peff.net>
 <20180222180715.GB185096@google.com>
 <20180222181400.GA19035@sigill.intra.peff.net>
 <20180222193814.GA256918@aiede.svl.corp.google.com>
 <20180222201940.GB23561@sigill.intra.peff.net>
 <20180222202150.GA23985@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222202150.GA23985@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

>                 The current property is that it's safe to fetch from an
> untrusted repository, even over ssh. If we're keeping that for protocol
> v1, we'd want it to apply to protocol v2, as well.

Ah, this is what I had been missing (the non-ssh case).

I see your point.  I think we need to fix the pager config issue and add
some clarifying documentation to git.c so that people know what to look
out for.

Keep in mind that git upload-archive (a read-only command, just like
git upload-pack) also already has the same issues.

Thanks,
Jonathan
