Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA9A207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 22:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S978719AbdDXWPC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 18:15:02 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33608 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978713AbdDXWPA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 18:15:00 -0400
Received: by mail-wr0-f180.google.com with SMTP id w50so75884686wrc.0
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 15:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3MsGLWE7h2HO9wXBvl0p+pJH8jTCcX7e0g6fAosd5HM=;
        b=IfsxGag7AsEpl+WEzSU3eOG+HucQKD9fh1HxI22tHBHHiM1gyCpcTZ5QMN9MnOF7AB
         Lfw9PoQu2XuuzN4N4PAdO0Nvjn49fvRbNK7aBazrHiv0HdCpPgvbj3nPpjhtrnDB7LkU
         wLB1wsMGcQdndcSnGKs6A1ML570XSMQAaCvYZlUVIQmtTPkJF7A52H57ej4xA5V3IUpi
         VpmYVENdzeyEsKFut27qF8BsVsOgFm66k0SzYhDTP9yG2OPAc9EQN33UujWtFoWdCg0S
         JAhKtH7C9e+5zPsneYLH5XXfBnr9gbRDfyQ6frtAhSMFqtQh2U4RzUA8Sz/pqEDlWVML
         p6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3MsGLWE7h2HO9wXBvl0p+pJH8jTCcX7e0g6fAosd5HM=;
        b=GySSz65r2KyfHMRKTJ09wv6xadSCwpaMegHC/IxCipCyRuDl+onvOF6mOFIjK5m7xm
         nYkKWRIi+WAfOHm1r55DpCNBPhzgnFuVI0MqXoiSy15O416dILaGnyXHzd9RXQY+tPn4
         F4lzjaycNoXhl4ymN3NT9/MPtqQXzL9eZarG4i2SBvIgfntwcavWXGduQ3XsYRHhcQRe
         8vkpYmnYkOQ10gsXFSiwyZwz/DIR5lVs+tN/Psn3egFo6vx/slhZpBFK5ZMeBYFbAImc
         zBv2GNDKrqbcpk8+u6VI5Q2OXK3dsRUKar2H7xvO8ZOYNVKqwKatpQKlxeJv17vmx42F
         Ezkg==
X-Gm-Message-State: AN3rC/59+Px5P8xfNtorBAlV3xoTeCQi3gjRdu4X3HWrBQ7+qdd6ZbO4
        tEG4Os9AoC/HxQ==
X-Received: by 10.223.166.129 with SMTP id t1mr327032wrc.116.1493072099266;
        Mon, 24 Apr 2017 15:14:59 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id m5sm23878819wrb.61.2017.04.24.15.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Apr 2017 15:14:58 -0700 (PDT)
Date:   Mon, 24 Apr 2017 23:15:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [BUG] test suite broken with GIT_TEST_SPLIT_INDEX
Message-ID: <20170424221516.GD4989@hank>
References: <20170420205214.GB4989@hank>
 <CAP8UFD1LAU8hg4ioes=y4o_Phgd1zBhUJOmkqTPo++4SprWWpw@mail.gmail.com>
 <20170420212436.GC4989@hank>
 <CAP8UFD2f9g__ykCjReSoaAUvFTPmgRDbsWFQMRrFoFw8haV0uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD2f9g__ykCjReSoaAUvFTPmgRDbsWFQMRrFoFw8haV0uA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/21, Christian Couder wrote:
> On Thu, Apr 20, 2017 at 11:24 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 04/20, Christian Couder wrote:
> >>
> >> Could you try with the following patch:
> >>
> >> http://public-inbox.org/git/20170330210354.20018-1-chriscool@tuxfamily.org/
> >
> > Yeah, I tried with and without that patch with the same result.
> > Unless I'm screwing something up when testing I don't think this fixes
> > the issue unfortunately.
> 
> I just tried on "pu" and only the first test
> (t7009-filter-branch-null-sha1.sh) fails there.

I can't seem to reproduce this now either with the latest pu or next.
I must have messed something up while testing.

Sorry for the noise.
