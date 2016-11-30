Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD1371FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754905AbcK3X57 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:57:59 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35252 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754515AbcK3X56 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:57:58 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so41693914pfk.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2WPXAiwsxkNFd1Cz/n3qUzSSjPuEIQI3RGTF7DW+M9s=;
        b=PY5umc8UIxiQLx0yRiqOJ1C+SAiRRyiI4TGuQJ4SjymFgOac/EoBYm53CFbT1m0YZT
         YCKTzOk+s/iEQN0Dpqj/tn4mWPjy+9LY/2+m/OKmW7nycJLCB4HBv0pyS7uflg4UVzLx
         ukQck31TPGZhFQ3snUBwqVUN9OhUhnrMPeIxRCIKAD2x1vqIG137GMVHEr2c3gHcD+y7
         JsfqC6RMPcGViJg2XSJGo9IFTqS5hkA7euiiM48FJWvy13ViQpCb6zaOJ/3LzRnFlWB4
         iDBzsCMlTJzS6K93K18Yhi73HeTX+HP+ZBB1wzTFFOXZbsX03tZnS8lbRwbJzfJJC0mQ
         5/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2WPXAiwsxkNFd1Cz/n3qUzSSjPuEIQI3RGTF7DW+M9s=;
        b=dKAvXytCdRrL6m5GB9iWIZGSoe7odHROrWZ8NdhCMBLwI0EWiDCd1LtCnv7k/lG6QD
         r1MKk6GOFiecjz97/6jwM7obzB1te8dSpiats27WO+zdPOztRur+btDp0nZkbWWm2qMg
         ESLt1OaE69+92zYfc+MDCzo8Hd64lG9TaMKxBPlnrmtrNw8NlhzQWKTF87hklzvauBH+
         257dUlipAyz/FvlmQwlhWfC51gy6L/HCF+rSU7VyqlkFuU5Aybjq8up97r1k24dt9xOG
         sbMb4q0+shSm6h7OVMPsXbaWZ1+9CJzDAm3C03XvpKn+TzB/LCkNcuSN6eVpWoPnUzD3
         5LEA==
X-Gm-Message-State: AKaTC03Q4S4rD7WOiIGX0xo8/dwDdTzi4k/ONn8HK/b2B2Z7caUM4DBS38R2i4mDKoMcJj0M
X-Received: by 10.84.217.202 with SMTP id d10mr77487729plj.85.1480550277987;
        Wed, 30 Nov 2016 15:57:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id t193sm87632194pgb.4.2016.11.30.15.57.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 15:57:57 -0800 (PST)
Date:   Wed, 30 Nov 2016 15:57:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130235756.GC192901@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Jeff King wrote:
> On Wed, Nov 30, 2016 at 03:42:48PM -0800, Brandon Williams wrote:
> 
> > > where 20813 and 20867 are two threads of the main process. One is doing
> > > the lstat and the other calls chdir at the same moment.
> >
> > Yeah so it looks like the start_command function calls chdir.  Which
> > means any uses of the run-command interface are not thread safe....
> 
> That seems crazy. The chdir should be happening on the child side of the
> fork (and looking at the code, it seems to be the case). And on the
> Windows side, without fork, it's an option to the spawn call, which
> makes sense.
> 
> > For now the work around could be to just pass "-C <dir>" to the child
> > process instead of relying on run-command to chdir.
> 
> Yeah, that would push it after the exec. I just don't understand why
> that would be necessary.
> 
> -Peff

You're right, I jumped the gun.  That doesn't seem to fix the problem
(as I'm still seeing the same failure).


-- 
Brandon Williams
