Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80C851F404
	for <e@80x24.org>; Tue,  6 Mar 2018 21:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753994AbeCFVdM (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 16:33:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55464 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbeCFVdL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 16:33:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id q83so934439wme.5
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 13:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+0lNX4AdF5xVWqhR88+5oWiKkuLJg8AgctV5MmXHNPo=;
        b=QIu1+TLTlG8EBxM/mTC685AYPBaSl0Jt88KBkvIh/7ChZcmEZTPU0WdA15uzvYsC/J
         wj/DhNN2goKiCanJGJyGEcR5yy5ggCtJTOVkAfEuo6JHkdv1RAdF1mUTCqfFjt2T7e85
         fajwRhV0CQtjw4kliz1qIbA9eDtyacpgeTj81TgA4+2PNLsT5tlPLN2rQD7XSZ72xmUd
         oTJ+FZ6R1gwhIi1pCrYwbQ8cK85Q7b03TFUB3shanMJhsBMHfMYpx6Gpzii/UM+PDuUY
         5KWlMGvE0UKtE+Gu/T8pX3fYeDUpNpAgsh7Y91irRvOEWBpkFdz1jOhtXTKtNFGohXmi
         RwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+0lNX4AdF5xVWqhR88+5oWiKkuLJg8AgctV5MmXHNPo=;
        b=IrDzUxl/VgeKqyFBvNrpfsAbVj5iPqDYO1WEfHp1zqGGIkU3eW3HLelN8VjiNtXR4a
         C3s2l2ebv3lIa9YZ5/Yws15c25Etw09+JCDO6CMsom7cUybteBcnKmbyhb0FTByRulYR
         5xpgS32jHBuLhK/IpMytrGSa0fNhLbF9MJdoc5OsYI4Vlv60p7w62kRuz8+Ucg4k1/lS
         qL0uz4T5L+RkGorMm7wF+bo12UhYL4L+wFSLxB8cXxj4MQWPRbRZyhOa/H2y4e+qMCyu
         fSXdYNC+VUEC6V3eIJ+fqE0/rgJTPj3piv0wL1OXaCc0FjUXrNcQWnlFQOQtVW15XmcT
         bwvA==
X-Gm-Message-State: AElRT7G5Mt5QP2GgrpPDT/ONJhjRA6wodL0Rqq1qsqVG8GJ0Onfw8Ink
        MkdoXBEAux6Du0E70AcDttE=
X-Google-Smtp-Source: AG47ELselrBKH1ve9mj6KzkbrXWT5dcORqWgZU1kpCGGw4NR3oDzEJdlN1JKmYad30glFg/oxQo84Q==
X-Received: by 10.28.74.130 with SMTP id n2mr9392135wmi.22.1520371990435;
        Tue, 06 Mar 2018 13:33:10 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 7sm36371508wry.18.2018.03.06.13.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Mar 2018 13:33:09 -0800 (PST)
Subject: Re: [PATCH v2 1/3] add -p: select individual hunk lines
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gustavo Leite <gustavoleite.ti@gmail.com>
References: <20180219113619.26566-1-phillip.wood@talktalk.net>
 <20180306101750.18794-1-phillip.wood@talktalk.net>
 <20180306101750.18794-2-phillip.wood@talktalk.net>
 <a6f70938-0834-8109-6b94-d93639bb6d0c@gmail.com>
Message-ID: <4328de01-f3e7-7cc4-5ed2-8b90da2fa94e@gmail.com>
Date:   Tue, 6 Mar 2018 22:33:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a6f70938-0834-8109-6b94-d93639bb6d0c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/03/2018 21:29, Igor Djordjevic wrote:
> 
> > diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> > index f83e7450ad..a273b41e95 100755
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > 
> > [...]
> > 
> > @@ -1255,6 +1382,7 @@ j - leave this hunk undecided, see next undecided hunk
> >  J - leave this hunk undecided, see next hunk
> >  k - leave this hunk undecided, see previous undecided hunk
> >  K - leave this hunk undecided, see previous hunk
> > +l - select hunk lines to use
> 
> s/select hunk lines to use/stage hunk lines/

I was wrong here - in the context of Junio`s remark, I now think this 
might even belong to context-aware "help_patch_modes" instead, 
phrased accordingly in there (stage/stash/unstage... etc.).
