Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23DE202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 00:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbdIWAkA (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 20:40:00 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:43142 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752004AbdIWAj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 20:39:59 -0400
Received: by mail-pg0-f45.google.com with SMTP id u18so1392094pgo.0
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a3qPAiEALn+XWqtbF4O0nBs8c/5esE7aqrhXYz1FIac=;
        b=qbSt3PBtJvE7ZC9OLAm9M1xMaF+4z86UTLzvdUPlv8Ceg9KoAVXYtq8NvQI863FJHD
         RtR5ntDYHygugt4FZcwRy/t4tB2sAQl4mKZ1Z5qs/7sGG4Kw/1TYroBDp/clFqsjVzeH
         MwrST8lRixCxWd82DLWWhV0eHfLWPuQEsoqvp/bQQ+mRZIVkJySJzHrGeHkfAPidwBGA
         PLbf0ztaBIasmmDK9qp3qfqvmOoute+M9qP7oDfSK+yoERzudWGqVT1CjBIxfgB2LrvM
         hFohx6U9DJF4fMoWfxVdUK0A+QM9cP9/LX10Mt9Rlys6X3+Pcw6XTOR2uJZ7b5ZABfMg
         57Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3qPAiEALn+XWqtbF4O0nBs8c/5esE7aqrhXYz1FIac=;
        b=SnWECI/E66W9bxsIFhZtmf8Pxf+C7SNQs4o55Cpb1UeWIDHJYLv/OmPulwSVKuC2ud
         JWAmyQmy1vah6jyaRsjD1NLkRMEj1oZicC6WFKtks71tkamIHMyXGqzcByilwBZ7kFD9
         DETiSne8aqtCAhZUVBFGnyb1eyEDAJvcgCqYZqHDww2oLC2Pw7AJlZYGEiNkvzDeg9CR
         pwXhoe69KssmMKnoeSsc5bm2+qz9AtwP0042CE5XaVs/k/YNziNXvUPILmeNnCHi5ZrZ
         0oj/ir7HzQubYfmiYNcKo0TkDlqs8YFcc9mOJ777g1tyrCwLrXKA21/f6ar9VvCmV5/5
         t1jg==
X-Gm-Message-State: AHPjjUjpp+1uhZD4sq+F8En6YgfTnqrbMZMaP4rto5xAnAzSw8Br9rb5
        FirV2ay1I2emFNcpGDtGv8fm6ktG12U=
X-Google-Smtp-Source: AOwi7QDKkxflT+fqXPPvdBJ0xqm9T7x62xUwjk8BP4+3qLsA9KnvgdLXK6R3WUB+GdULgDmBhqD2Xw==
X-Received: by 10.84.134.34 with SMTP id 31mr726897plg.124.1506127198614;
        Fri, 22 Sep 2017 17:39:58 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:840f:cadd:b54e:2e8c])
        by smtp.gmail.com with ESMTPSA id m13sm1073448pgc.58.2017.09.22.17.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2017 17:39:57 -0700 (PDT)
Date:   Fri, 22 Sep 2017 17:39:57 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jeffhost@microsoft.com
Subject: Re: [PATCH 00/13] RFC object filtering for parital clone
Message-Id: <20170922173957.f5601015cc8d6760c80293a9@google.com>
In-Reply-To: <20170922202632.53714-1-git@jeffhostetler.com>
References: <20170922202632.53714-1-git@jeffhostetler.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 22 Sep 2017 20:26:19 +0000
Jeff Hostetler <git@jeffhostetler.com> wrote:

> This draft contains filters to:
> () omit all blobs
> () omit blobs larger than some size
> () omit blobs using a sparse-checkout specification
> 
> In addition to specifying the filter criteria, the rev-list command
> was updated to include options to:
> () print a list of the omitted objects (due to the current filtering
>    criteria)
> () print a list of missing objects (probably from a prior partial
>    clone/fetch).

Thanks, this last point seems useful.

I tried applying your patches and it doesn't apply cleanly on master.
Could you try rebasing? In particular, the code references
get_sha1_with_context(), which no longer exists (it was replaced with
get_oid_with_context()).
