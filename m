Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDDA1F428
	for <e@80x24.org>; Sat, 28 Apr 2018 16:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758043AbeD1QJu (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 12:09:50 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:43502 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeD1QJt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 12:09:49 -0400
Received: by mail-wr0-f171.google.com with SMTP id v15-v6so4378879wrm.10
        for <git@vger.kernel.org>; Sat, 28 Apr 2018 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hr9ka8aDeJa/eLCfh9FWxOlmHuRTbuxip71BryawcI4=;
        b=EGj3pXQ2DKMoq0No5yDtTHfyvtX97M4hWK/a/ONGFXCVQECVk1EVZ94Ax/HgQHPYlF
         98CVia+SRMKynPaRi3V+jK1QNGh5lLlkvdX0ODk8QJ4Cmn3QOWmgdKST+01XloVQi3sz
         bccBVUziXrZlACokUAYHzxBqVaFRdVBBA3TsgxIlzYc38Oy7NQdzQMDX4FIHElnVM27j
         dRXvjlQIyE/S29f67YIxvP4TO84woIohPcDckW22+BNc0XxotbQzCxnLaT94u3XGlpmQ
         Fe8I3AkP7SGCEnGuJSesDTRGsev5hjXvAW72f6dPTzyH+xnR1l3wEVtRhSFD4nH4b00J
         Ut0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hr9ka8aDeJa/eLCfh9FWxOlmHuRTbuxip71BryawcI4=;
        b=EW8br0bZGUnFLftaTLtM8gI/w+6iMkOQkQjjXZyE3uM6KUeCj35w7ThdMU0Y8HYaqI
         fJrTqp38V4atW5zVc7c2Q5vDOQTtmZNCXM9mg7bx8k+sfTUXExMJDDPDS02KisycBIYH
         cNN88+rjssRgAZkveRSeleuMSBj6L+xW68MbLPJSoZ1MxO4/3qNoZNC8etxg2KvPgGJa
         v2AkjS+59b0A0IHR6iQXNzLuJe/ZlB5fZmcK2Wr35Xm1i4SDB04UngvOEct088ui4IeZ
         dwb9RY7QilvBMy7RW9WjTB3m5YHpn8hn/q4ybOUB3Z/WJ01I76yRx8LkqW41vdMs8EdI
         Qosw==
X-Gm-Message-State: ALQs6tD8mAFDVAWXjsflO4IfnAWB7FFm87vsjxdjDXG4LZAJGIhm7sbR
        Lp+HfXzM9V7Oiv09FbrLbU8=
X-Google-Smtp-Source: AB8JxZpcb4KjGy7huGYGkWEeWp8PGcN+33dQ0OmUE9YVr4AMaCvEwXZf1oq6kD032AJbPrHxsaAx7g==
X-Received: by 2002:adf:aac5:: with SMTP id i5-v6mr4276880wrc.16.1524931788653;
        Sat, 28 Apr 2018 09:09:48 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id a139sm3222767wma.43.2018.04.28.09.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Apr 2018 09:09:47 -0700 (PDT)
Date:   Sat, 28 Apr 2018 17:09:50 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 0/4] worktree: teach "add" to check out existing
 branches
Message-ID: <20180428160950.GA17619@hank.intra.tgummerer.com>
References: <20180423193848.5159-1-t.gummerer@gmail.com>
 <20180424215635.9183-1-t.gummerer@gmail.com>
 <CAPig+cRor4UXXZhoAkhOQfe6W+oC84YFmA-KwpLspuEh_A4Zng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cRor4UXXZhoAkhOQfe6W+oC84YFmA-KwpLspuEh_A4Zng@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/27, Eric Sunshine wrote:
> On Tue, Apr 24, 2018 at 5:56 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Thanks Eric for the review and the suggestions on the previous round.
> >
> > Changes since the previous round:
> >
> > - UNLEAK new_branch after it was xstrndup'd
> > - update the commit message of 2/4 according to Eric's suggestions
> > - make force_new_branch a boolean flag in
> >   print_preparing_worktree_line, instead of using it as the branch
> >   name.  Instead use new_branch as the new branch name everywhere in
> >   that function.
> > - get rid of the ckeckout_existing_branch flag
> 
> Thanks. I did another full review of all the patches and played around
> with the new functionality again for good measure. Everything looked
> good, and I think the patches are now ready to graduate.

Thanks for all your review work on this series!

> For what it's worth, the entire series is:
> 
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
