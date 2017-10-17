Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7857F202A3
	for <e@80x24.org>; Tue, 17 Oct 2017 06:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756976AbdJQGvG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 02:51:06 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:55037 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756379AbdJQGvF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 02:51:05 -0400
Received: by mail-io0-f195.google.com with SMTP id e89so1084139ioi.11
        for <git@vger.kernel.org>; Mon, 16 Oct 2017 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hubEios7sK4zFJUIyQbgBSnU64k3mOO2EWv4LnmZAdw=;
        b=ige/b2g866g7wcBwMmaKKqYcY5yXvw99EV8sUu+cTFKEJly8+uV80YZ+V1SACFvo9H
         wE+4XkOcCKQSE3FHUsonVnqCmV4YFHC2A33bxom5O3PSyu4BlXZJjFD3g4jS/f5jyCcI
         lr6QT8KY9cD69xwiosbnYbku+0xAiABwZEAkF9naSojFTibQgcL6u5YQxxEe0DrC3FVA
         Xxg2dvKcvfp9+HNZifKFJNCckUv21PyxbFpaRim+39M8ldeMHG/yY5jeDgNCMvQF/ekk
         WeC2XjuuXij44u3WkedifyabKolJlJUjGkF6GGjAV3BTAtgGNSq9F7DEHsBkVbSj4qVt
         FhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hubEios7sK4zFJUIyQbgBSnU64k3mOO2EWv4LnmZAdw=;
        b=Mdg1S7t125kG+Fr5Dk7zAbm8ukPtVli+bqm3e+hUKbtTRdZWXxvnYbLSUrFCs2KHVa
         sEFbV5Br/1XTr4ovcJsLBvs5Wb1sD1rsb00HNrMmsAsqxecGjCklTFTaRXuURxpDBupQ
         8moD8diDm58yZtp69npeymf+HWuQtvsCjPR2vGZ22jwT4PoOZCB8X5VKxuqJ46vvlYa4
         0fFt75G913Wo1vkMbSaPGzG0OgPgokb4F64mi/iocsR1HEQB5CoD8IhcGh5bviwxfq5E
         IeTrddIr5S0QMn51b/lY9AHoBzKN7QJhJB3kaQCK/LoD+8pBgimkcXSfjhSefzfTpZie
         xuJw==
X-Gm-Message-State: AMCzsaUM+EmUrrqOP3SjgIo16GkNHWOlPI7MtjkCWGXdr3DJjpdBWbrD
        4BW5POiGhapNcCY0bgUhHtM=
X-Google-Smtp-Source: AOwi7QBnqgF/E/Lmkrv/GlELmOKdvhc/rehkADrZSsB81QL3vR1Iv9kGgtWqu0aWIsZNeWjrbhTuig==
X-Received: by 10.107.170.29 with SMTP id t29mr16242073ioe.73.1508223064486;
        Mon, 16 Oct 2017 23:51:04 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 16sm1329228itw.38.2017.10.16.23.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Oct 2017 23:51:03 -0700 (PDT)
Date:   Mon, 16 Oct 2017 23:51:01 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk
 configuration
Message-ID: <20171017065101.ismnplaynumt5bdh@aiede.mtv.corp.google.com>
References: <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
 <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
 <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
 <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
 <xmqqshemtoth.fsf@gitster.mtv.corp.google.com>
 <20171016215311.m72jarmqhjagy6o6@sigill.intra.peff.net>
 <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9p6r3ai.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>> On Sat, Oct 14, 2017 at 12:01:46PM +0900, Junio C Hamano wrote:

>>> True.  Let's see what others think.  I know Jonathan is running
>>> the fork at $work with "downgrade always to auto" patches, and while
>>> I think both approaches would probably work well in practice, I have
>>> preference for this "harder but right" approach, so I'd want to see
>>> different views discussed on the list before we decide.
>>
>> After pondering over it, I have a slight preference for that, too. But
>> I'm also happy to hear more input.
>
> OK, so it seems we both have slight preference for the "peel back"
> approach.  Adding Jonathan to Cc:

Which approach is "harder but right" / "peel back"?

I agree with the goal of making color.ui=always a synonym for auto in
file-based config.  Peff found some problems with the warning patch
(scripted commands produce too many warnings), which are not an issue
for $dayjob but may be for upstream, so I see the value of holding off
on the warning for now.

I'm also fine with "revert the proximate cause of the latest
complaints" as a stepping stone toward making color.ui=always a
synonym for auto in file-based config in a later release.

Another issue is diff-files paying attention to this configuration.
If I'm reading Documentation/config.txt correctly, that was simply a
bug.  diff-files and diff-index are never supposed to use color,
regardless of configuration.

I'm fine with "revert the proximate cause of the latest complaints" as
a stepping stone toward fixing that, too. :)

Sorry I don't have more detailed advice.  I was planning to look more
closely at how these features evolved over time and haven't had enough
time for it yet.

Jonathan
