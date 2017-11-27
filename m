Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DDF20A40
	for <e@80x24.org>; Mon, 27 Nov 2017 05:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbdK0FXB (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 00:23:01 -0500
Received: from mail-qt0-f178.google.com ([209.85.216.178]:42051 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdK0FXA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 00:23:00 -0500
Received: by mail-qt0-f178.google.com with SMTP id j12so15932575qtc.9
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NLyhtdWlVXVlS11zocupUpSImqswQHPJiC8DWMWEPAQ=;
        b=ByaHZi3eIlXAtWpRsoRCa0ti3CKv/Fdr0lQ/fYicrkeA7KD6Y/ucZ5iTWxt62gxnWb
         r5ip0drH7yDJMUNvhr1lKqp77UbaGLBukiaRPLaVM/kRG5ZkpQIpWg0hjrS3uQQI48Sr
         iyUeqyFmWZKHltgEMjvL1ob5Cyx/fF41TuCNfcRh4P3uDejH6rhzr7vMCH4Um/x4Spef
         FOKLCXSKgQnyEpTTVwCzAZdTujO7aTcOXo+gE9mvsWij4bUiUI2B/tpgTJTq+h/SU00D
         DvyHD5AF2ZjFC0Tw2J8Ib+m/60DzZw1mxxbJNPN0C5zfdm+kXl1dtTsYNYZrH6D5+c+H
         l5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NLyhtdWlVXVlS11zocupUpSImqswQHPJiC8DWMWEPAQ=;
        b=ljJro8ygPFSbz5Do+ueqQxtIXB7O0V1sSh9ME1c9/3erSf/ELNzfirJ83oI+arWGbZ
         dWQQxWmJ5osPyE7+QkpHSyKQ/BM6n+HKNgFWalMYvdeJJWe0sg9kcZM8E0+M2dR7QFpS
         WRSyhMC+itSUcUWIzegPH1JB5HxRRFEENQV6CAcyQOSYuHfA2zBsJPQ7nUG9PYGXAulR
         CL/L6VBrlKyNubi0SPY1s2E+/9NvUUgcBuMkI+klZ6vxMjABjSWKOhlw/jpDxRrYwbhY
         aRdcY9FwNjqBIAw76QaprcJ0JOFPYYa5p0Iv/d4SuExHdrnE1gfxzah0mmO4krUyosJH
         Ku7A==
X-Gm-Message-State: AJaThX4hbbqUS7iMOSj3Va/IBKetR06618SsTwl1TeDeHp8wUG1Xs0p2
        wH1HwFIyDY8v1Av67V5pcKo=
X-Google-Smtp-Source: AGs4zMb7W/bIzsltUmCcH+xSuYXPZEdR7ArvZ8TISiDCkoBZkSy5QUT4DcrH0w0uC6pt3qNvu6cYJA==
X-Received: by 10.200.57.80 with SMTP id t16mr56068357qtb.98.1511760179072;
        Sun, 26 Nov 2017 21:22:59 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id 26sm19580850qtm.3.2017.11.26.21.22.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Nov 2017 21:22:57 -0800 (PST)
Date:   Mon, 27 Nov 2017 00:22:54 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
Message-ID: <20171127052254.GA3693@zaya.teonanacatl.net>
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
 <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
 <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
 <20171126191510.GA1501@sigill>
 <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
 <xmqqshd0e41a.fsf@gitster.mtv.corp.google.com>
 <20171127043502.GA5946@sigill>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171127043502.GA5946@sigill>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> Yeah, this side-steps the "other half" of the issue that Christian's 
> patch addresses, which seems like the more controversial part (I don't 
> have a strong opinion myself, though).

I don't either.  The general motivation there, as far as I understand, 
is that it's undesirable to have 'make install' install tools that 
cannot run.

Perhaps it's worth noting that there are other commands installed by 
default which won't work out of the box.  For example, 'git svn'
requires subversion at run time but not at build time.

If there aren't many such commands, then maybe checking for them in 
the Makefile is reasonable to make installing git from source easier 
for new users.  Without looking closely, I can't do more than take a 
wild guess.

As a package maintainer and an aging sysadmin, I'd bet that there are 
more dependencies than one might initially guess.  I also tend to 
think that by the time most users want something newer than their OS 
provides that they're a bit more able to deal with these sort of 
issues.  But I could easily be wrong on all counts.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Going to trial with a lawyer who considers your whole life-style a
Crime in Progress is not a happy prospect.
    -- Hunter S. Thompson

