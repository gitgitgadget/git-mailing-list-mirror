Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 110DB1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 10:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387958AbfHWKPN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 06:15:13 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39891 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbfHWKPM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 06:15:12 -0400
Received: by mail-wm1-f53.google.com with SMTP id i63so8547672wmg.4
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 03:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kUTgMFBruYg8tgK7hf5MR5UygQxqJ97+VyyZR6CTaz8=;
        b=fCtJDVxJEGzRGi1255lcmKE5V1gMyO5jfEDCWw7yL+TWozu7zG5XwEs1BNUYsXfPh7
         uT0xreIOveP+XHHobfAWY//QUn/CdRaKcNV8CFP6hAF7wL6GljMlCP0w3sXctGJm6B+m
         M8VRvkCzSVA9kalX+bUgpDZfoWGK5AQFKykNPBbfUU2HyT9juKdv6LuacXQS8DQnM3Gb
         pez5/Y6BC0o32RDyM3zwmUePns02PHBn9EyjOXgVhqeG8ght4bP4+FInAlnS7HrU4jkZ
         MakrRjJKcZfH6/nA06C4bHyX2674eYdaS68rlWLKs7QGAPHNS5dGMU1Yr2A3rRQPFHGv
         R0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kUTgMFBruYg8tgK7hf5MR5UygQxqJ97+VyyZR6CTaz8=;
        b=FCWsGRMgFyWlzG7VlfFZmudcuciSYF5heGKbwzsdklqndttU9tUzr1SDp2ARbfE3un
         ind/n6PfFDeXi4Mw1v82m2iq1lorgZJPO98YKSKxZGDn+SlGIcQj7o1whAmDFYJB79qR
         9g9Bu1v+6ZA2Td3LKYLps5lHPkJr1V1vwWMUwsklKCSMMgLEQ5zHE8QZEufp/fQ8OMa5
         u6AWzu+ziGiE6Lp+zrzNrAbfIdYgOgDwIbdo9gwlndi5L49XDHFM/fnm+jJoBlTysweF
         w3kRCyaZOoXav+J33Nk/Bj/DRboKfBhgk2zcfnmFVNMn7NtOrIlINK64NngWrz/F0uql
         /EQg==
X-Gm-Message-State: APjAAAVuoPhRPUBVEfCpAt6J1jULkTFQaU8nfm/B6HOBFMyopsdLnIru
        wc0lA1g10voLVCpy2Z0A0co=
X-Google-Smtp-Source: APXvYqzQQqPUNuzlwliSDd906EmkqXK0ymiQo+kNXqfjdL5weBwfYyFc5TRJcsN09k5KXOSMCzvgBw==
X-Received: by 2002:a05:600c:292:: with SMTP id 18mr4347486wmk.51.1566555311080;
        Fri, 23 Aug 2019 03:15:11 -0700 (PDT)
Received: from szeder.dev (x4db558a2.dyn.telefonica.de. [77.181.88.162])
        by smtp.gmail.com with ESMTPSA id q15sm178484wrv.1.2019.08.23.03.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 03:15:10 -0700 (PDT)
Date:   Fri, 23 Aug 2019 12:15:08 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190823101508.GJ20404@szeder.dev>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
 <CAGV3M54LVwHMkXd=wB3tQ_h4K0bJOZ43TxXZ8Fh5ZKfATBS57g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGV3M54LVwHMkXd=wB3tQ_h4K0bJOZ43TxXZ8Fh5ZKfATBS57g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 11:35:48AM +0200, Giuseppe Crinò wrote:
> On Fri, Aug 23, 2019 at 10:29 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > If we go down this route, then someone might want to write ő as o" or
> > ű as u", which still supposed to be used in pairs, but what if someone
> > wants to write ä as a:, ö as o:, ü as u:, ç as "c,", ş as "s,", etc.
> 
> I don't know any language that uses ő or ű so I can't tell but it's
> definitely possible.

The Hungarian alphabet has both, and I've seen them written like this
on old typewritten documents.  But that was decades ago, nowadays
they are either written properly as ő and ű, or without any accent at
all (banks...).

> In my country, sometimes the last name ends with
> an accented letter (mine ends with an "o grave") and people end up use
> a single quote to avoid pissing off computers. That's standard thing.
> 
> In my current team I don't know enough of the setup of my colleagues
> (they may use CP1252) and that ò may be badly decoded.
