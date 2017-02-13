Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85851FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 19:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbdBMTVt (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 14:21:49 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35660 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbdBMTVs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 14:21:48 -0500
Received: by mail-ot0-f195.google.com with SMTP id 65so13110345otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 11:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZjhjFe98PQCO+d2vSuIpJmps2J8/cyOURRR1k3SCSSg=;
        b=vcIfpbhxcDQ6RZWlfyHiH8BVGmSrcEzgnEP8YGcpDyW7G83B4tH5IF0nAjWmAak+UQ
         C5ckLVaNRz6E2BI4rJRS88/x3BQdin0athmv1OTV1NPluIo7wTcYx1rWtmdk4egXkMY7
         aIOFdKBOz2yluFNOU/fzxn7JrNDTYXvFVWxHLFipN0JIgDV0DpNvGdzJtMszMIwetBfA
         xOxoVgCplX1GPrNK81r06F2zn6pKmNUvbDSzS2MrMVyxhwnSGzmlCZ5FaP0kJhLmy8OX
         88y3PJkQNxNbln9KoDVHG/+1S0CRBIyRBvHhrQmzFGNGAM89jQwzyM4dh7/FTKKjLeBO
         upjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZjhjFe98PQCO+d2vSuIpJmps2J8/cyOURRR1k3SCSSg=;
        b=Ab0wZoNIHqSYM6oKs+nFRqkAIL2aJgJ2BwCER+UJLg3DyESB+xNJZkZxXiwfNIRoPm
         bmj+IGMMmC/otYpW+qKBkyxcON7Tsq0W1pCwZuQmWpDdzPex/Q5lywFWBuQJOd7Orjha
         IhsR3PPVQG/eoDOER75xABzjyc8hH6JC3ee3XyA6RTdlgiBhKnJCFthMjvc/YtYWyFFg
         AFBixOP8mDtkV7+epLnlHU9N4UR0DrYygjuyl3/WftUVPfijlwe4u6nJdRpQ2xYQ5Z+T
         ZUgP8T22a7AsxOxCiclMY6hordTuJyASPfPksjW5KkGvr+LRjpN3ps7nNAzagQaN3jk2
         u/aQ==
X-Gm-Message-State: AMke39nESY/t4++fZQi59E2I8zTeYXH6Yd785Xfn4d7mcYpu1y1DJIZMQlnY1zhrljg9tw==
X-Received: by 10.99.65.67 with SMTP id o64mr28349763pga.119.1487013708077;
        Mon, 13 Feb 2017 11:21:48 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id u28sm22559673pgo.20.2017.02.13.11.21.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 11:21:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Arif Khokar <arif.i.khokar@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "meta\@public-inbox.org" <meta@public-inbox.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect core.hooksPath in --git-path]
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com>
        <alpine.DEB.2.20.1608181430280.4924@virtualbox>
        <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
        <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
        <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
        <alpine.DEB.2.20.1608241509200.4924@virtualbox>
        <alpine.DEB.2.20.1702101707060.3496@virtualbox>
        <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
Date:   Mon, 13 Feb 2017 11:21:46 -0800
In-Reply-To: <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com> (Arif Khokar's
        message of "Mon, 13 Feb 2017 00:52:32 -0500")
Message-ID: <xmqqefz1ew1h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Arif Khokar <arif.i.khokar@gmail.com> writes:

> ... I
> still think it would be better to be able to list the message-id
> values in the header or body of the cover letter message of a patch
> series (preferably the former) in order to facilitate downloading the
> patches via NNTP from gmane or public-inbox.org.

You are looking at builtin/log.c::make_cover_letter()?  Patches
welcome, but I think you'd need a bit of preparatory refactoring
to allow gen_message_id() be called for all messages _before_ this
function is called, as currently we generate them as we emit each
patch.

> Alternatively, or perhaps in addition to the list of message-ids, a
> list of URLs to public-inbox.org or gmane messages could also be
> provided for those who prefer to download patches via HTTP.

Many people around here do not want to repeat the mistake of relying
too much on one provider.  Listing Message-IDs may be a good idea,
listing URLs that are tied to one provider is less so.

