Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F78B1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 18:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935856AbeFRSlP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 14:41:15 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44783 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935578AbeFRSlO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 14:41:14 -0400
Received: by mail-pf0-f194.google.com with SMTP id h12-v6so8601848pfk.11
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mOj9zmgHedzGelRvM0cu+W5Dm8IUrROTSB4iiQzP1es=;
        b=Eyo7y5PuGxq/FzByhleailCG1bq5Onj3tbsjTQA0+A4MMS+5QjhmicRDlDk+5POnH6
         I2Lgb8gLTne2GlUDkZ9mRqm28smEUwvFfRszTkuQlKlpDBPJQqFnBWTDnq7OmWkp/rlm
         Du7M0a2WxwolFwOwxZn4ZnEl/UAErFD/rBcWRqKeSLAecIyaK0mmOAuFC7faQnNl2knL
         qv9/aXZT0W6fANGp+ACo6pRZYt/33cP7rmzlZZnYj/tc7o7TbKYZhzOv0nzzsAUpQlTh
         GmUKg+qZFTDh6xeSzKXLtyxghsItnrBczUmC4F/BMUaRUTHflTd4MoMN+V/vbQJ3c5dN
         0z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mOj9zmgHedzGelRvM0cu+W5Dm8IUrROTSB4iiQzP1es=;
        b=RZEHJiL5oLMgz1UBm1YzuJtEFHu16I4wOouHAvEUB46q677SGW8wDrCwhOr+x/cAfv
         jWdCElJrSMPUSFs7BGV8peQ+Jj+SGRoYd9mrILcc2rDzD3iFE9QgCzWuBg3xG5ywZUYz
         jXzi/1Fo/xfe1tQDGojDDAXm11d/ictJ/WkgI/QEFfhlwcomHMyQNyaB0egoAdAL7k7x
         Qoo0pYIrdzrq4PzeKTCzc+CCtTsNg+p9Op6blJjR2vbpVKU8q5A2I3VPmeWRjWDr8nAP
         vjdFO3TArmutlm8FuMNQrD7sNKPJXB6GrPgWQP+CEnezSZNjNMkbVuX/AvFnYS8apnCj
         993w==
X-Gm-Message-State: APt69E1jHIt7AugSEwP7pgtUdre198+fxOMLxuHvgTN4JjAsqEzY9sNz
        BNj3GY0M8v+LdcyNKJwGXN1GUA==
X-Google-Smtp-Source: ADUXVKK0O82D610nvpGtot8H4SmHJnGjBO/gTSUWYqNRMYCbhw+EcNdJKtQxMoM+Jc+GYDICvSG+Vw==
X-Received: by 2002:a63:b147:: with SMTP id g7-v6mr11792096pgp.379.1529347273848;
        Mon, 18 Jun 2018 11:41:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id r26-v6sm38515821pfj.180.2018.06.18.11.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 11:41:12 -0700 (PDT)
Date:   Mon, 18 Jun 2018 11:41:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 00/15] Kill the_index part 1, expose it
Message-ID: <20180618184111.GC73085@google.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
 <CABPp-BG1n4u78JScxrnUc1gecXFjKbwLWMxKKs+ZO17DdH3zvg@mail.gmail.com>
 <CACsJy8Bib-CFxUs5YBzcgo7LPDospdgSAn+-asCf-YrYnUxqXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8Bib-CFxUs5YBzcgo7LPDospdgSAn+-asCf-YrYnUxqXA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/17, Duy Nguyen wrote:
> On Sun, Jun 17, 2018 at 9:02 AM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Fri, Jun 15, 2018 at 10:41 PM, Nguyễn Thái Ngọc Duy
> > <pclouds@gmail.com> wrote:
> > > This is the beginning of the end of the_index. The problem with
> > > the_index is it lets library code anywhere access it freely. This is
> > > not good because from high level you may not realize that the_index is
> > > being used while you don't want to touch index at all, or you want to
> > > use a different index instead.
> > >
> > > This is a long series, 86 patches [1], so I'm going to split and
> > > submit it in 15-20 patches at a time. The first two parts are trivial
> > > though and could be safely fast tracked if needed.
> >
> > You post this small little patch about unpack-trees.c, mentioning you
> > don't know if it's even correct, and bait me into reviewing it and
> > then spring on me that it's actually nearly 100 patches that need
> > review...   Very sneaky.  ;-)
> 
> To be fair, it's all Brandon's fault. If he didn't kick the_index out
> of dir.c, it would not conflict with one of my out-of-tree patches in
> unpack-trees.c, catch my attention and make me go down this rabbit
> hole :D

Haha well this is something I've wanted to do for over a year now, glad
you've decided to run with it :)

I guess I've gotten pretty good at getting people to go down rabbit
holes.  First Stefan with the object store refactoring and now you with
the index stuff.  All because I wanted git to be more object oriented
and have less global state ;) 

-- 
Brandon Williams
