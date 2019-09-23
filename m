Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C22921F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438090AbfIWSHS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:07:18 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35306 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390851AbfIWSHS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:07:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id y21so10308038wmi.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gJOZpIEKI39YvUsmsme9dtRjoF28EPGmzL6Do9eN8NU=;
        b=NJPOigSMf+yyR1di4GKgQZQvj8lGpA5HRvMszSW/BFReo99+WFwKcCEsq5yJfmcRhT
         dV1I0DpDa8a9lQIUZ8sSIQuqqlRilAGdVbrSSy/P+KTExWqD/oZmpCa0kCKZJUBhUiNs
         3MXgcPAcqNKLF8TaWJQqK0Lp5s+e7cAYRQDnbKHtt3t5zwejgqgo2PWdJHbDFBQLagBL
         St2I8npdEqs/N6Wwss26qClrNcXjD/pcTJNduANn84feR+A5HlUPbl9pPGLGMIzLk9g6
         Xgp2R/Kzkizk62Q4GhnLRU4muYFvstkxllSu52uqDoS/8hzQz8imSSADI7eh3AQfJg+h
         fPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gJOZpIEKI39YvUsmsme9dtRjoF28EPGmzL6Do9eN8NU=;
        b=HvjKcCkPxsmUi1IM7FvECdsQC2TB6JeYe2klpIq4dAXW4tKmgD5iBYICgKcqTavxgD
         s/Ud0mPvM+rexoNpUv2WAtBy7apDAJjv5KOwi1eCqYFXwjBWJQcByTaMAnoHxmsdvD3Y
         S6nLmaqKcFJq3o7Q3rYOYV3mUzPWHCSYrIa4MlBb3z21gneHVgTE7hzk2h3Tu6mlbkas
         BVECPICCSLBRuVlvD3TAjg3t0pN82ZsjNoRrHsykdauV8helCCyo4stHnBfqwk0Cm4RG
         ykqhESPRWmOZ2EyyDgeGmOkKp87XLQa/jT53P/5K/FLoJuIfoplf10ePVqJtNqQ/yV9q
         5LoQ==
X-Gm-Message-State: APjAAAV06i5mT4FUyBeJkbXJtfrerT53lvBVane7FVjS5ELI6Vyh8eBe
        8OKJIiz3K0/6C2naGMVHyFc=
X-Google-Smtp-Source: APXvYqy4nTb63lE19R/j5fF196p9EYvmQYwjNeZt1xcMcu9jUxk9Nj+NHibQYwLtIlNcv13ldLKZAA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr707951wml.10.1569262036144;
        Mon, 23 Sep 2019 11:07:16 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id k24sm12846174wmi.1.2019.09.23.11.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 11:07:15 -0700 (PDT)
Date:   Mon, 23 Sep 2019 20:07:09 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923180649.GA2886@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190904194114.GA31398@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904194114.GA31398@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 03:41:15PM -0400, Jeff King wrote:
> The project page has a section to point people in the right direction
> for first-time contributions. I've left it blank for now, but I think it
> makes sense to point one (or both) of:
> 
>   - https://git-scm.com/docs/MyFirstContribution
> 
>   - https://matheustavares.gitlab.io/posts/first-steps-contributing-to-git
> 
> as well as a list of micro-projects (or at least instructions on how to
> find #leftoverbits, though we'd definitely have to step up our labeling,
> as I do not recall having seen one for a while).

And we should make sure that all microprojects are indeed micro in
size.  Matheus sent v8 of a 10 patch series in July that started out
as a microproject back in February...

Here is one more idea for microprojects:

  Find a group of related preprocessor constants and turn them into an
  enum.  Also find where those constants are stored in variables and
  in structs and passed around as function parameters, and change the
  type of those variables, fields and parameters to the new enum.



