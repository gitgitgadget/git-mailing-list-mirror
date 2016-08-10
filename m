Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE501FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935415AbcHJTwJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:52:09 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35811 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935768AbcHJShB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:37:01 -0400
Received: by mail-wm0-f44.google.com with SMTP id f65so106441769wmi.0
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 11:37:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X1nXcY/1Ibmfqu6oowDV6PaC+sZXrl4A3jg+tMNtAGY=;
        b=RTkQ3P4uvqO1Am3HmZ85tLchPJAj/wUs5mQP7Z/szf4v+eo/yiKfgR0yrN7kjyqnAh
         KWKaMMWaRDWngDOYHXWVanwQB0zMfJ7NIdHV0s2CCaAK+fubdLmIHDC08t6+AasUNH3S
         ihSiLd8e5vbGtzpgLI9uaPoTeMY6FkXNjYoImvt1ix8O8PzMy7jeZkYAe+SZENVgo1Lk
         mqpeT+TfQml/7sYs7yZVAEIUlp/Fstnx/T9VeLAiSsr/h0JZPIqgEsEmGQC0ss4DPvDP
         mtOOZbw+dKwM/ZIxOgVzXJzx7Ka1Dv74azhsQA2/Uz92W8SOdjJr0EeNl7HqAec52IWn
         12kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X1nXcY/1Ibmfqu6oowDV6PaC+sZXrl4A3jg+tMNtAGY=;
        b=fvrTIejvAWBV7qTcnO9UJ9DUx0cMHKhchBesHiogqbuOyBjHMqCOMO/qO38o/Yvz/G
         5vW8hhKaB7wA2rqXqMCt8NvU+Wi8AEA3s4CMuJzU2PigqSN4kuOlbQKMF6ATXmstB0dh
         rpMx2rhiM2IapRyqe3utWkze99xplFBnKWKtjk/E9p/Dca+iYOM3bkq8deH9TbPRqyj9
         GflBX51+6I/wTBYt/blfC/R1vpJ/a23fbQDK1mkAPuhMg2rtKse9Vhetvv1hk7YVULqF
         9G0cAy16Ur1eWOdAV5ujDqYAlhrIy1NPgEFdjahqoMbYv/YVStY0z81Dkru3+ErnzR5a
         9fJw==
X-Gm-Message-State: AEkoouvETqsDtf+P+4D4I3BlNC8h4YbxrS/Dw4IlDG4+nFklak4fbUhAwx0RP7kBw/2y7cGys8S6JwEPE2gvxA==
X-Received: by 10.28.203.136 with SMTP id b130mr1544707wmg.13.1470814242283;
 Wed, 10 Aug 2016 00:30:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.102.70 with HTTP; Wed, 10 Aug 2016 00:30:01 -0700 (PDT)
In-Reply-To: <20160810005548.gee6ontd33ck5vej@x>
References: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <20160809182800.GA19044@dcvr> <20160810005548.gee6ontd33ck5vej@x>
From:	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:	Wed, 10 Aug 2016 09:30:01 +0200
Message-ID: <CANQwDwcL0etdZiiroAStwtpYurYEhJ7vcM52BUGUXh_ey+P9Kw@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Eric Wong <e@80x24.org>, Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 10 August 2016 at 02:55, Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Aug 09, 2016 at 06:28:00PM +0000, Eric Wong wrote:
>> Some of these problems I hope public-inbox (or something like
>> it) can fix and turn the tide towards email, again.
>
> This really seems like the dichotomy that drives people towards central
> services like GitHub or GitLab.  We need an alternative that doesn't
> involve email, or at the very least, doesn't require people to use email
> directly.  Half of the pain in the process comes from coaxing email
> clients that don't treat mail text as sacrosanct to leave it alone and
> not mangle it.  (Some of that would go away if we accepted attachments
> with inline disposition, but not all of it.  All of it would go away if
> the submission process just involved "git push" to an appropriate
> location.)

But submission is less important than review. And for review it is
usually better (except gigantic series) to have patch text for review
with the review. And threading. And (meta)-versioning of series.
And place for proof-of-concept / weather-balon patches...

-- 
Jakub Narebski
