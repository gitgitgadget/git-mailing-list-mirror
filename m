Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7AFE20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 22:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbdAWWGS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 17:06:18 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35231 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdAWWGR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 17:06:17 -0500
Received: by mail-pg0-f41.google.com with SMTP id 194so48252389pgd.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q9S4TD00JlE1WvRRAeze0sryucstvKDax8ndJKCtTkE=;
        b=JgyjdhMYvdlR90UIRBP7dBEwKl058sULLp4rbAqmd3cUQ3GZAlYrYYOyQDtEFd4I4o
         5l2RDbQPXP2v4WYFJBz5MpPKacOxDl0ChM1cRWQX7Vxt3tUf0uQtyqC+4mzdedBOloiV
         2n1aQ+87dJdPCOiut+JGhkw6OryCOKUHhO2rYxXkEfM/HL6nJhh7McSD2bam5CvF6KPh
         Z0CYy2TSuXBGSBmy3v0mW1SQXH+z6fdZfqOJk+92mOJuh7oKob7VXMJbbpcGnepLBeY2
         2nwl+i4PKxDPsdfarESCvtvLJ5oGR6741ABcYKwe8lxokYhX9LPiUPnm82nrKaDRJJ27
         FmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q9S4TD00JlE1WvRRAeze0sryucstvKDax8ndJKCtTkE=;
        b=CCKIPKfRFnEL6W86AmqKG8buyJehr1fPGrT5YiTorgbUlHtAV5yfubevfokS4Wa5hq
         GQDFE08zPGxdn/l6X/cHB6fevRw3PNaEV25N414qhOAa65mW0sNgZ0+NrqpoCONXQKiS
         b3HqbbKltUGMAGPDpPVOPrSurYfYqiojN8qAS/fPoLNErlggxR8cPQ+12Je1C7tpsRKv
         330phY9yQKll7Qx+sPfpzY8p+JiPdWlPZkBpoKAvMkyKTRxo9V9Qi9mWdAMucDpYbMxZ
         cy3MQNROGlecU0jTLw51RGD9V1WMqgov0GxkJS5c7/EeoD+lTIjVtESiU5chkKpsQtbk
         +YOA==
X-Gm-Message-State: AIkVDXIe37SGkkCIJVJmGktkvRXGA/WR9zz1KdIl/KuFWYTHB1BZCtNf+bdhgYdIXKev8wgQ
X-Received: by 10.84.225.150 with SMTP id u22mr46862210plj.157.1485209176999;
        Mon, 23 Jan 2017 14:06:16 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:19da:d768:d0e6:f301])
        by smtp.gmail.com with ESMTPSA id a25sm95528pgd.26.2017.01.23.14.06.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 14:06:15 -0800 (PST)
Date:   Mon, 23 Jan 2017 14:06:14 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check
 structure
Message-ID: <20170123220614.GA187696@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
 <20170123203525.185058-26-bmwill@google.com>
 <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > The last big hurdle towards a thread-safe API for the attribute system
> > is the reliance on a global attribute stack that is modified during each
> > call into the attribute system.
> 
> The same comment as 22/27 applies here.  
> 
> It is not an immediate problem we need to solve in the scope of this
> series, in the sense that a Big Subsystem Lock for the attribute
> subsystem around git_check_attr() function can make it thread-safe.
> 
> But if we want to make it truly threadable without a Big Subsystem
> Lock, this and the other one would need to become per-thread at
> least.  I think the check_all_attrs scoreboard, which is the topic
> of 22/27, should become per git_check_attr() invocation (immediately
> before making a call to collect_some_attrs(), prepare an array with
> map.size elements and use that as a scoreboard, for example).  I do
> not think we can be sure that the "slimmed down attr stack" 15/27
> envisions would help performance without benchmarking, but if it
> does, then the "attr stack that holds entries that are relevant to
> the current query" would have to become per <thread, check> pair, as
> two threads may be executing the same codepath looking for the same
> set of attributes (i.e. sharing a single attr_check instance), but
> working on two different parts of a tree structure.
> 
> > This patch removes this global stack and instead a stack is stored
> > locally in each attr_check instance.  This opens up the opportunity for
> > future optimizations to customize the attribute stack for the attributes
> > that a particular attr_check struct is interested in.
> 
> This is still true.  But two threads hitting the same attr_check
> would make the stack thrash between the paths they are working on to
> hurt performance once we go multi-threaded.
> 
> Perhaps, provided if the "slimmed down attr stack" is indeed a good
> idea, we should keep the global hashmap that holds everything we
> read from .gitattributes tree-wide (i.e. as in your v1), _and_
> introduce a mechanism to keep the slimmed down version that is
> relevant to check[] for each thread somehow.

Sounds good,  I'll reintroduce the hashmap of stacks that I had in v1
and instead make the all_attrs array that is used the in collection
process allocated at invocation time.  That will cause a bit of
allocation churn but in reality shouldn't make that much of an impact.

As we discussed off-line I'll also do the rework to break up the
question and result.  That way two threads can be executing using the
same attr_check structure.

-- 
Brandon Williams
