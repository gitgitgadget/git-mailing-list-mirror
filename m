Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3874B20954
	for <e@80x24.org>; Fri,  8 Dec 2017 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbdLHAPd (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 19:15:33 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33227 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdLHAPc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 19:15:32 -0500
Received: by mail-wm0-f49.google.com with SMTP id g130so2635902wme.0
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 16:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pB+CJsVarpign80hhBTG31/Esuu1Ah/5+HpyYvAeqA4=;
        b=rhwCw2elwBnPvb5T2pPEEtDvfVBDgG7GqK4gDKCzvhRFUGpXV89BxYT6+GLV/o78F2
         FNjbE9U8+zesbABex8FknVStGBAZ4IC0AZ01CBylus9K9L8Av4tcKHkE10CpIIsdMKJY
         5AwvoEA35R1FXaNUesmW1RNGhtb+NhmUdXHkFQHfQll/KScnvVWOFGUOy+OEjl8DGXiI
         IoC6Q2gqANNg1+tOsMBunqYSDY44rkBKoe9W6pES6P7PJhRVB6ovqH8dsSXH44RUbHvc
         bc53TWucb8gj4cHLjd4AOykpPsH85ns0ylOKVWhMrfv5mw5ym416l+38bdE3NhYqpKuB
         gl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pB+CJsVarpign80hhBTG31/Esuu1Ah/5+HpyYvAeqA4=;
        b=jeil58u+vI6i5YbKM1OEQ7gdD65j3PWhC/F7nge2e3hB21gJXQXlsyDDmwFG7OPFA3
         t3iUFSt1+tpNLcTfBRlw5DI/CDIB7zM2UbxqpYaEp9Obia22stulcpLEk4cbhFg1Htuh
         37XC4kEqI1PD8+uqEiY1Z9EqqNdcN7y4EIjmt/enRwvTK3T0SYvkOse43z0wARu1G86x
         Om1Ecnsw1gHhFWhGZMquTqHdYnn8wNRA40XR16i5Q0SjBY7AfIdNnMXkNamSaee2xOb4
         1WB2LG/QOHkWpXpO+AS6pkZFJEw3B5X8yqjrlhgnVzplY2DtkwH5JU0FpZh3jChfESaS
         SLzw==
X-Gm-Message-State: AKGB3mLveMtjRzHsW/P+KyWoto3ki8oN+af/5PNVeygieBePVKc6pYCH
        eAcG+F79J340U+xAJWeQoSQwz1pm2b0=
X-Google-Smtp-Source: AGs4zMZ1cmE/86nWGoC+49SfNjHLHQfbmLj/PJY2m/Q3rOhmQLNzpQDAsfpouPDDnDUGphMI+qnX/A==
X-Received: by 10.28.137.5 with SMTP id l5mr2712979wmd.123.1512692130782;
        Thu, 07 Dec 2017 16:15:30 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 4sm6384593wrh.70.2017.12.07.16.15.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2017 16:15:29 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
 <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
 <33e97533-716b-e1cc-6aa0-bf8941225319@kdbg.org>
 <7ae3ffd5-147d-55d2-9630-da12c429d631@gmail.com>
 <39323748-282c-5881-2bfa-de622bb8b765@kdbg.org>
 <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <f9a94a62-9541-e019-8ab3-9fc9cfe2c43f@gmail.com>
Date:   Fri, 8 Dec 2017 01:15:25 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12/2017 19:34, Johannes Sixt wrote:
> 
> I am sorry for not responding in detail. I think we've reached a 
> mutual understanding of our workflows.

No problem, thanks for your time so far.

There might be one more thing I should address, possibly left unclear 
from my previous message, but I`ll leave that for a follow-up e-mail, 
not being that important at the moment for the topic itself.

On 06/12/2017 19:40, Junio C Hamano wrote:
> 
> > Though, from the ideas you tossed around most recently, you seem to
> > want to make git-commit into a kitchen-sink for everything. I have
> > my doubts that this will be a welcome change. Just because new
> > commits are created does not mean that the feature must live in
> > git-commit.
> 
> Nicely put.

Yeah, I understand that might have felt cluttering, besides also 
being out of scope of the original topic idea. Thanks for the reality 
check (to both).

To get back on track, and regarding what`s already been said, would 
having something like this(1) feel useful?

(1) git commit --onto <commit>

So in previously mentioned situation:

(2) ...A    ...C            <- topics A, C
        \       \
      ---o---o---o---o I    <- integration <- HEAD
            /       /
        ...B    ...D        <- topics B, D

... it would allow committing changes F inside HEAD on top of B 
directly, no checkout / branch switching needed, getting to:

(3) ...A    ...C            <- topics A, C
        \       \
      ---o---o---o---o I    <- integration <- HEAD
            /       /
        ...B    ...D        <- topic D
            \
             F              <- topic B

So the most conservative approach, where changes F are removed from 
HEAD index and working tree, leaving it up to the user to decide if 
he will then merge them back in (or do something else).

I stress the major selling point here still being avoiding branch 
switching back and forth in order to commit a fixup on a different 
branch, which could otherwise trigger needless rebuilds, being 
significant in large projects.

And thanks to that `git-merge-one-file--cached`[1] script, we are 
also able to resolve some more of trivial conflicts when applying F 
onto B, using three-way file merge when needed, but still not 
touching working tree (contrary to original `git-merge-one-file`).

Regards, Buga

[1] https://public-inbox.org/git/CAPc5daWupO6DMOMFGn=XjUCG-JMYc4eyo8+TmAsdWcAOHXzwWg@mail.gmail.com/T/#mcb3953542dc265516e3ab1bff006ff1b5b85126a
