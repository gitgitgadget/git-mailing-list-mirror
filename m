Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F6C01F461
	for <e@80x24.org>; Thu, 22 Aug 2019 16:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbfHVQki (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 12:40:38 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35540 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390142AbfHVQkh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 12:40:37 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so6453937wmg.0
        for <git@vger.kernel.org>; Thu, 22 Aug 2019 09:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sxjx8NCtsNhuNqlOhAXJxoihKAIExkoGDC1DscSScaI=;
        b=lFej4K5666IhVNEc6wTV00NkTWYCc7ykVBZ6bsfFJIa6TGosUTh7r+ZyfXfcCb7+JT
         //Ch2S7Bvq0c35m/JLdv+7MHYaORUbvyGQjiQMWCGZES8+TFUQaBW6AFoDc2x3L1OIWC
         fnEY//N2q5P4t1tELP8uTy/X1TaWyVKs4oTg0uut6EE+s04Lt4btphEIXg2bCfq6iSWT
         5V8XgzsTnTQmUkrEUssKXqywdS/Uu+lglQSdk5pJNBm3M8XHg2216K6SQnCuTXElWZQN
         XTScwfNSNg15uzq/+GXJGN9+YsCKm8O1iV94AzUPCe0c+aMkw9VwZbKM6w58riSZaPAY
         AhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sxjx8NCtsNhuNqlOhAXJxoihKAIExkoGDC1DscSScaI=;
        b=rKUF1tqCBCh+CJyuK0dwwORYLiwr4WIJ99mE6LxLqzgn6+d9Ii3H4PqLAnVoRNb0Cf
         dSAhz05mA5xUGzcRViV0VGbfDTZcYb/dUdlgQ1orAdqaum4xYYtI2vc7Y2Usk0LGGC5r
         KdWwDmBqCD5rzXVNjCXC4tEksGjp9Z6tXxYn1F2nsyagEmcRcjHIb3IIagFVY5LA1yRl
         NooQsR/j2jqnbf8mU+Bt9paqOXATgf4aqqEw8YmQtFgjX9Ehet79NqmKx7IzVtxDqGm+
         LsUo+61y4YsCEzrlaIkHQbVa6jghNIvOqjoDP8UxTzQ+F3FZStDDCIgbY/pc5qE3HIFR
         dl2g==
X-Gm-Message-State: APjAAAW4PT+LrzYKjRp5rLwfGrWCL7/bt8VyIvl67RT2442Ms3+Z5Uld
        BhqO6lJlwLhiT4kZwOAcJEE=
X-Google-Smtp-Source: APXvYqxKM1XZLCSOGVdfAULvhFiAilRw6CVs0yKCWNJQdQeLviZPfINfAE7YWNaryxJtM7nqb51OTw==
X-Received: by 2002:a05:600c:24a:: with SMTP id 10mr7685079wmj.7.1566492035817;
        Thu, 22 Aug 2019 09:40:35 -0700 (PDT)
Received: from szeder.dev (x4d0c08c4.dyn.telefonica.de. [77.12.8.196])
        by smtp.gmail.com with ESMTPSA id x6sm69892wmf.6.2019.08.22.09.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:40:35 -0700 (PDT)
Date:   Thu, 22 Aug 2019 18:40:32 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Charles Diza <chdiza@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: v2.22.1 and later regression wrt display of progress indicators
Message-ID: <20190822164032.GF20404@szeder.dev>
References: <20190822141928.GA3163@323642-phi-gmno-clahs>
 <20190822160702.GD20404@szeder.dev>
 <20190822162907.GA17013@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822162907.GA17013@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 12:29:08PM -0400, Jeff King wrote:
> On Thu, Aug 22, 2019 at 06:07:02PM +0200, SZEDER Gábor wrote:
> > I noticed this today when pushing to GitHub (I suppose they have very
> > recently upgraded?) from Linux, so this is neither specific to 'git
> > pull' nor to macOS.
> > 
> > I'm sure the culprits are commits cd1096b282 (pager: add a helper
> > function to clear the last line in the terminal, 2019-06-24) and
> > 5b12e3123b (progress: use term_clear_line(), 2019-06-24) with the
> > added complication of communicating with a remote.
> 
> Yes, we moved to v2.22.1 last night. I'll revert those commits on our
> servers until we come up with a more permanent solution upstream.

I think it's sufficient to revert only 5b12e3123b (progress: use
term_clear_line(), 2019-06-24).  I only mentioned cd1096b282 here
because it better explains the reasons for having term_clear_line(),
and an other patch depends on that function as well.

Or you can simply revert the whole series, of course :)

> One interesting bit: we have traditionally used \033[K on the _client_
> side of the sideband demuxer. So I think in the "remote:" case we were
> already handling this correctly, even before your patch.

Gah, I feared that the term "sideband multiplexer" will soon come up
in this discussion...

