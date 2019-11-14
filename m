Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D20B1F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 10:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKNKBs (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 05:01:48 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:55839 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfKNKBs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 05:01:48 -0500
Received: by mail-wm1-f50.google.com with SMTP id b11so4982935wmb.5
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 02:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6s9CGa74YWu+YZOdftW9tXOqVXGw4RpJBM1Bb1UgSP4=;
        b=NQepRVSde3PaMeGkhbOP6ntNEFFjxUeWGJjk4/bG3/lj8FvY/3jX/o0N1N7vg7DTdd
         lAfBbGZ8Ra/HDukKPqfbILcNs+xvpgfDhxqTFlULywDpDmvhjGS9EPGZp/It1+Z0V1BE
         t21v+2n2AGO/l7mU7LRvfsd9kfGty7OD1yZZjvPRBOg98caNb+jFWDNXZvsrZMjVa1j2
         mhD/9BW+v7L/OCiaeJ5GyxkppS0FBI5kWV7g8jpWyozXugO8ZjnAR1nsI9gcFCHXzANh
         J7zxk+sNJnVhwxSOKrQ5Yo7G3mAVoA6kPsPPasDYh7tLWru4FTsO2qNv/EKlbxwwPHEE
         3qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6s9CGa74YWu+YZOdftW9tXOqVXGw4RpJBM1Bb1UgSP4=;
        b=g2uvBEwqhvuodWrawUENrGCXGi91h+GN/dUMC/m4HpEf+AgkduCiCDx9DEgBlTb+Fc
         f/+JE88nQSDyRjwzFZayCvuhx3VfZ8lYCPeRHieweVen+ljrkNHjvr/kULhMTvDpR7EF
         XkZVMA+Wg224L3rT9t3i3kJ3KoPB4X1sUZtNxnZjtfx6TMSNPDr+3veM/XuKjkpWJOUw
         wu7XxpGHDkj5XiqF424zc3uwG4rUgxe9WM4JS0yXobtyAkfvE5rsVW6vL3riIE9oQuZL
         imzVTMrJZMctkhYLVKAzQS1kZV0cfQl5as5n+lsCk8dgut0qLylE/QV6iPZMeC2CpWZS
         sLXA==
X-Gm-Message-State: APjAAAXqlwBl7XHrswMPSnvIwp7JxGOLaYi7vSkwemwjNJMv8yVDuDYP
        THwDeWyEfpPQ9BxvlNpFIZ4=
X-Google-Smtp-Source: APXvYqxSUAEao+yMAQXWfhaSACZSdTsfufc9T6yPRIvanXVCSleKRg/QYd7fsNc09wPSpGZ1JflspA==
X-Received: by 2002:a1c:3b08:: with SMTP id i8mr6740205wma.56.1573725705072;
        Thu, 14 Nov 2019 02:01:45 -0800 (PST)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id d18sm6714441wrm.85.2019.11.14.02.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 02:01:43 -0800 (PST)
Date:   Thu, 14 Nov 2019 10:01:43 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Garima Singh <garimasigit@gmail.com>
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20191114100143.GA119027@cat>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <CABPp-BFXs4qes20S+9AZd++p3epW4eJ7Vu7zU_PdDysZ_D-yrg@mail.gmail.com>
 <20191112184547.GA38770@google.com>
 <nycvar.QRO.7.76.6.1911122100220.46@tvgsbejvaqbjf.bet>
 <CAP8UFD2qjUa=y81YPVSMcuEcDkrkrV=j912qySmG83pig=dFDg@mail.gmail.com>
 <20191113150624.GC3047@cat>
 <20191114023100.GD22855@google.com>
 <20191114060833.czrj7v3pf3hnkafg@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114060833.czrj7v3pf3hnkafg@yadavpratyush.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/14, Pratyush Yadav wrote:
> On 13/11/19 06:31PM, Emily Shaffer wrote:
> > Christian's suggestion of a Google Group list was good enough for me.
> > For now, the permission settings are as follows:
> > 
> >  - Group visibility: Anyone. (So it can be easier to discover and
> >    advertise.)
> >  - View topics: Group members only. (Maybe we want to open this up so
> >    it's easier for non-member Git contributors to take a look at what's
> >    going on.... but maybe if they're interested they can just join the
> >    group :) )
> 
> FWIW, I think this should be open to all. Most of the time I first look 
> at a few posts of a list before joining, just to get an idea if the list 
> is actually what I'm interested in. Restricting topic visibility to 
> group members only makes doing that impossible. In fact, that's just 
> what I did before writing this email. I wanted to see what kind of 
> messages are on the list/group before making up my mind if I want to be 
> a part of it.
> 
> So unless there's some strong reasons to keep it member-only, I vote for 
> opening it up.

I do agree with the original decision and think we should keep it
member-only.  As Peff mentioned somewhere else in the thread, this
makes the group less daunting to post to.  One of the distinct
advantages of having a separate mentoring list is to make the process
of starting to contribute less scary.

I believe that not having all messages public on the internet as
someone is learning to contribute creates an environment where people
are more likely and comfortable with trying to seek out help.

Of course anyone can join the group, so if someone really wants to see
the messages they can, but at least not everyone on the internet can
stumble upon them, e.g. through web searches.

> >  - Post: Group members only. (My thinking is that once you're asking for
> >    someone's time and effort to help mentor you, you can volunteer the
> >    time and effort needed to push the join button and optionally filter
> >    your inbox ;) )
> 
> This I agree with. If you're looking for mentorship, or are providing 
> mentorship, you should at least join the group :)
> 
> >  - Join group: Anyone. (Let's make the barrier to entry low.)
> > 
> > https://groups.google.com/forum/#!forum/git-mentoring/new
> > 
> > git-mentoring@googlegroups.com
> 
> -- 
> Regards,
> Pratyush Yadav
