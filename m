Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B6A20248
	for <e@80x24.org>; Mon, 25 Mar 2019 00:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfCYAEb (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 20:04:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33503 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbfCYAEb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 20:04:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id b12so5181594pgk.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 17:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUd76CSrnsNB0Ogb1rwRjeQojfJVh2SkVpFe3JsH+7s=;
        b=dEciIBudUqJo+vaafV5kI2zKOQoyUEfaiV9joZIC9IafjOPEzAvtCi67wwg1jvRuoM
         j0UNjEoiTZT0uLC8bsC3eiBACas2MIb/jQL6jKzulpuF6IuNWmf/FQ0ftKMAzTkeZAUw
         3Z2DLNUocwDOvwW+aQBn+iJLFLQD6IZumEBO+FaLD+H/OQuRA4ybE7VKJCZwtlo4MkI3
         MEBfACpdGbLTn73IWM5ULutij383ULYJYjmXhU6nhHmtQzDyt8VKzdfP4ckyjWNZcfJe
         8JFcR6vBtrdb1V4H/kz0JnWuffDt2WRqrmyulWS3Gq9he5J8ffw1X4AmYSrjAo/pExlN
         E/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUd76CSrnsNB0Ogb1rwRjeQojfJVh2SkVpFe3JsH+7s=;
        b=fJca/00AYPL5U7OCQEP0vwrCpMdodKZOIYNQbDu42uxQlCxDM4doB/69NdQ5rJ3GzG
         eUsI/D+MAw/00LVN+0VU99phHkqxmY7xBkrxYCxKPV07xkN+IldQZPThEaqsCSaqZuCA
         L5hCXtGuqdfuVZVj8wde3bkTPQEjnMHAKu1/iDQN2e0dWSU9QIVp1Qy3qR83nFZccNGe
         WHC+S96LsWP17Sk1ZUCHGsi/0rpkFDbBowM+0b++0ZZxA8P/HbsK6fyXH3dVzoy/y2R4
         HKtRvUa9Msnbn3gGltDLz/G1hXEzM7OlYKpbdlhb743nIvtdjZ5rgxeh/VUSkxCTMZ85
         ZQqg==
X-Gm-Message-State: APjAAAUEBLaSDH9PnaB/nYiWIq/ME4Y1FewIrhT++yDTzc/8kEXzNp/H
        u9d9Kz2H/UlcI2LoH6g2p/8=
X-Google-Smtp-Source: APXvYqwcc7MMitZ6e9EVXiJ4S6ssSkGdDYvRdtOz89GjYha10SkJ9jBnJkmAKGq586e0p//e14NJng==
X-Received: by 2002:a63:145a:: with SMTP id 26mr20926372pgu.433.1553472270473;
        Sun, 24 Mar 2019 17:04:30 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id 1sm17334162pfi.99.2019.03.24.17.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 17:04:29 -0700 (PDT)
Date:   Sun, 24 Mar 2019 17:04:27 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] rebase: learn --keep-base
Message-ID: <20190325000427.GA9384@archbookpro.localdomain>
References: <cover.1553354374.git.liu.denton@gmail.com>
 <xmqqy354o1l8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy354o1l8.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Mar 24, 2019 at 10:15:31PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > This series teaches rebase the --keep-base option.
> >
> > 'git rebase --keep-base <upstream>' is equivalent to
> > 'git rebase --onto <upstream>... <upstream>' or
> > 'git rebase --onto $(git merge-base <upstream> HEAD) <upstream>' .
> >
> > This seems to be a common case that people (including myself!) run
> > into; I was able to find these StackOverflow posts about this use
> > case:
> 
> Since this is 0/3 I won't complain too loudly, but read the above
> again while pretending that you didn't know what your initial
> motivating example was.  The last three lines does not explain
> anything useful to such a reader, and the reader needs to decipher
> the two sample commands to guess what you wanted to achieve.
> 
> Before "teaches rebase the --keep-base option", you must tell what
> you wanted to do with that new feature to attract readers---convince
> them your new contribution is worth their time to read over.
> 
> If I understand correctly, what "--onto $(git merge-base @{u} HEAD) @{u}"
> lets you express is:
> 
> 	no matter how much progress the upstream has made while I
> 	was away from the keyboard, I want to rebase the current
> 	topic on top of the same commit from the upstream, on which
> 	I based the current iteration of the topic.

Thanks for the clarification. I'll try my best to write future cover
letters more clearly.

> 
> I suspect that such a rebase will become no-op without "-i".  Am I
> mistaken?  I am not sure if "--keep-base" is useful without "-i".

It's useful in the case of "-x", although that is a grey area since "-x"
uses interactive machinery internally. Aside from "-x", I can't really
think of a situation where we would use "--keep-base" without "-i".

> 
> But of course, it would be useful with "-i", i.e. when you want to
> further polish the topic.  You need to give <upstream> to the command
> to let it know where their work stops and your work begins,
> i.e. letting the command figure out what commits to replay.  But in
> such a workflow, you do not want <upstream> to affect on top of what
> commit the replayed history is built.  And "keep base" would be a
> very direct way to achieve that.
> 
> 
> 

Thanks,

Denton
