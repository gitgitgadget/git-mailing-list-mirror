Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C2FE207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 20:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031234AbdDTUtl (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 16:49:41 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34688 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030672AbdDTUtj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 16:49:39 -0400
Received: by mail-io0-f170.google.com with SMTP id a103so87276530ioj.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 13:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YscHujWBTGSiHs/BS2gQxoQSbj6ulAmVxjeVYZo1N2E=;
        b=Afl3VUojDnvwGOBmv5hTWSxTjcWw5gg2pOS4CngT9g4+nSOjjcN9DernR7fnca2Wvd
         U2OZiLOJS0oUTlNtOkRllxnpryQVj+MO8mHYwnEiCa9QaFNoWjF8sDraolTIFaOzz75H
         ghKDqI5TCXnO74IuJ8jw6p05VuafUyr/Pk8AeEWAQDhnukE//qeooEuizv5Ps293ZF49
         T6ZPp5FpUJWiCFF4eI0DyFp08hXUWsDob3/T6biqrJcPJrYd2OCEXulKc2NT1Vk2e4Qh
         Owz2cJqP9ykJommEq6D9Yhf7FU37J1u7g1kGCxx/zf8iwqhyvZNDROuXCkKAhdhy0EN3
         Icfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YscHujWBTGSiHs/BS2gQxoQSbj6ulAmVxjeVYZo1N2E=;
        b=Eeq6x2X9u1nnnanTegZDTv90qo31eBXf9jhe1iRk1NTJHBXJ1mNLQS/s3iqfFA75jD
         pGGTjlQ2j005qlmj/7FylyxZZ1QTCfdFZDwz7jn3Z6sE106R0CnoM9yOu+sTTXg0kqTx
         d/zPa8iiJ5InL186+wB5HBlPRA/kHi7Zy2ckcRD9Li2LZ6I1zWEVC4CtDmnuEdiw9ZN+
         jpU6jmvMj4Sc3oiaZqBJ4lLkxTn0kgS+12ZEnBBcyJ/mj+QPRlI2wY90APbYeKWaNuRf
         WTCTENWjBmCpdmVkINCmiVDnf2RSKD++DnopPqPZxdxDCDs/CFBUb5N+iV1j4jjYxkz+
         qAdg==
X-Gm-Message-State: AN3rC/4715v5gkB6V/FzXNCjjg9Zg+/uWsi7dVs8s+PELrGivZANK2SN
        JhISHVkUKQNtaNVn
X-Received: by 10.107.16.100 with SMTP id y97mr11179352ioi.164.1492721377837;
        Thu, 20 Apr 2017 13:49:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id 9sm3185664iol.36.2017.04.20.13.49.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 13:49:36 -0700 (PDT)
Date:   Thu, 20 Apr 2017 13:49:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org, e@80x24.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 02/11] t0061: run_command executes scripts without a
 #! line
Message-ID: <20170420204934.GG142567@google.com>
References: <20170417220818.44917-1-bmwill@google.com>
 <20170418231805.61835-1-bmwill@google.com>
 <20170418231805.61835-3-bmwill@google.com>
 <12add885-b56d-4707-57c1-1073fbb7786c@kdbg.org>
 <9c562827-78f5-ab8f-bf04-5f403672a32d@kdbg.org>
 <20170419155659.GA132229@google.com>
 <alpine.DEB.2.20.1704201245420.3480@virtualbox>
 <20170420170223.GE142567@google.com>
 <alpine.DEB.2.20.1704202223060.3480@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1704202223060.3480@virtualbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Johannes Schindelin wrote:
> Hi Brandon,
> 
> On Thu, 20 Apr 2017, Brandon Williams wrote:
> 
> > On 04/20, Johannes Schindelin wrote:
> > > 
> > > On Wed, 19 Apr 2017, Brandon Williams wrote:
> > > 
> > > > On 04/19, Johannes Sixt wrote:
> > > > > Am 19.04.2017 um 07:43 schrieb Johannes Sixt:
> > > > > >Am 19.04.2017 um 01:17 schrieb Brandon Williams:
> > > > > >>Add a test to 't0061-run-command.sh' to ensure that run_command
> > > > > >>can continue to execute scripts which don't include a '#!' line.
> > > > > >
> > > > > >Why is this necessary? I am pretty certain that our emulation
> > > > > >layer on Windows can only run scripts with a shbang line.
> > > > 
> > > > Out of curiosity how did you have t5550 passing on windows then?
> > > 
> > > This is the reason:
> > > 
> > > 	1..0 # SKIP no web server found at '/usr/sbin/apache2'
> > 
> > Hmm, that's interesting.  So do any of the http tests get run on windows
> > then?  I wonder if that lack of coverage could be an issue at some
> > point in the future.
> 
> Possibly. I'll put it at the bottom of my TODO list ;-)
> 
> > > As predicted by Hannes, your new test fails miserably on Windows:
> > 
> > Isn't 'miserably' just a bit harsh ;P haha
> 
> Ah, I tried to be funny. So much for my future career as a comedian.

Haha yeah I figured, no worries.  I was just throwing it back at you :D

> 
> Ciao,
> Dscho

-- 
Brandon Williams
