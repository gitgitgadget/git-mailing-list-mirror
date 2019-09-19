Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B701F464
	for <e@80x24.org>; Thu, 19 Sep 2019 20:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbfISUn2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 16:43:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35707 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfISUn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 16:43:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id y10so842368plp.2
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LK5wD/i7gH9m3TPjxw5yGgd9fxHTn4leqAO5HTSWVcA=;
        b=Xy+rrlci7zTMS4clrM2yjrJZKN1jHRtt5kZ6YevqNOu8HOl1XvAvCZP5bdzkmEOLEx
         Q02kGK+KVGv/wbb1Q2zcjT2TOAHk1oBbhoolPVdOUMzQ9n+ybUPR3CgrBs6+4Ol8kihB
         uWTMAgVQM55zrI78SYWfbnb9KQVtoCqz5Bt+0/jVfqi8dbHExqa6oaqWvkz6KN/ghDAy
         JzIXEpEw9mtKVIEOK/l5cM+BdfHoFSnLyxOnxJM++chhkEpSDHh7nc77ADNAhCbnMOix
         OtaDFF8MPiDdo4aTsmRLHylg4irDRju2GQG2w1NuYuLZrOwQNw09/ZKZbkfqc7A+OLOc
         ZaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LK5wD/i7gH9m3TPjxw5yGgd9fxHTn4leqAO5HTSWVcA=;
        b=p8nfxAscg+8rkPT2L4cp2T3p/JmFoxCZ6iY5wlbnANx0T0lsW53muY47HBmzuTTVDu
         19k6LrcuBuLzau6nLPhXyiqVw+zPhNW4kA31VkhOTc1THDiq0YS8dkhSV5/KFiaxkb2F
         RsBn0G+Nok9BsJRx1NBNy1F7gLKpxAOZIUYMD8eciMz/JhSrZ5kWBCK2ikKshKe+t0J0
         EAZsZ2spygdhvtMPqXedRN3RV7iWty2jJ0WlNl3Om1ommZQPMCGJMQ/Bgj4Af6rfdpL6
         tkNWunh5Jnuy/qWE6DX9fP69xcqwxt6DDclDogS5SwItxUeaNJYq5Y6GduVpTgQLMglJ
         /9sQ==
X-Gm-Message-State: APjAAAV9/YmbOPcTzhUr6yiJ9iT6iKA1VA5INBZWdkEp2vjShdRFPYiP
        kMu6Yi3NsceKx5Cdcy+94RERnw==
X-Google-Smtp-Source: APXvYqxcTLACaBE5siC5PuWGIs/CP6LxeiioBc4iqtw9DJUXNUKoD1jxTMWY1qH2jXW8bW/avWkCnA==
X-Received: by 2002:a17:902:9a05:: with SMTP id v5mr12359942plp.237.1568925806821;
        Thu, 19 Sep 2019 13:43:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id u10sm11582567pfm.71.2019.09.19.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 13:43:26 -0700 (PDT)
Date:   Thu, 19 Sep 2019 13:43:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190919204321.GA116396@google.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
 <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 10:34:23AM -0700, Denton Liu wrote:
> Aside from getting the first email sent, most of my time learning to
> contribute to Git stemmed from the fact that there's a lot of tribal
> knowledge that's not really written down anywhere. Here are some of the
> smaller things that confused me:

+1 to unwritten knowledge. I learned quite a lot from comments on my
early reviews about utilities and patterns which I had no idea existed.
I'd love to see more and better-organized documentation in Git project
(in fact, that's one of my goals for this year - a contributor's manual,
which was one of the topics discussed at the virtual summit).

> Another discouraging thing when I was just starting out was sending a
> out a patch and just getting radio silence (especially the first one, I
> wasn't sure if it even sent out properly!). Perhaps in the main list, we
> could get people to tag with [FIRST PATCH] or something when sending in
> their first patch.
> 
> If the patch is not desired, then we should explain why it wasn't
> desired instead of just leaving them hanging. I know Junio is too busy
> to say "hey, I'm picking this patch up" to every single patchset, but if
> a patch is desired, perhaps the rest of us could pick up the slack and
> say, "hey, your patchset was picked up by Junio in his gitster repo on
> this branch".

I wonder how feasible it really is to expect people to review more/more
quickly than they are today. It might be more realistic to try to temper
folks' expectations in the new contributor documentation.

This might also be a problem which starts to disappear as the number of
contributors rises...

> > 
> > 4. Add an official Code of Conduct
> > 
> > So far, the community has had an unofficial policy of "be nice,
> > as much as possible". We should add a Code of Conduct that is
> > more explicit about the behavior we want to model. This was also
> > discussed in the meeting with wide approval.
> 
> From what I've personally read and experienced, I don't think that an
> official Code of Conduct is really warranted. Everyone I've interacted
> with has been really kind. Perhaps a new contributor might interpret the
> curtness of replies here as someone being rude but I quickly learned
> that it's more out of necessity since everyone is busy.
> 
> From reading the mailing list archives, I know that in the past, there
> have been some flamewars and some abrasive individuals but I think
> that's a problem of the past.

I disagree pretty strongly - I think that the fact that we did have
problems in the past indicates that we're at risk for similar problems
in the future.

In my opinion, a code of conduct shouldn't be introduced to deal with
behavior when it arises - that invites parties to feel that they're
being targeted for behavior that "used to be okay". We introduce a CoC
to protect ourselves in the future, and to maintain the pleasant
community we have today.

> I also see some drawbacks to implementing a CoC as well. First of all,
> it just feels like unnecessary bureaucracy. Second, I think it'll
> probably cause a stir like it did when the Linux kernel introduced it.
> Of course, all that noise will die down eventually but I feel like it'll
> bring the wrong kind of attention to Git.

As a member of >1 groups which are prone to receiving harassment online,
I don't find it unnecessary at all for there to be a path for me to
escalate and resolve harassment I am the victim of.

As for the stir in the Linux kernel, I find it interesting that most of
the attempts to revert the CoC came via Github PRs - which the kernel
does not use. Another way of saying that is that most of those attempts
came from people who did not regularly contribute to the kernel, and did
not care enough about contributing to it in the future to discover the
correct contribution process.

I realize I'm taking a hard line here, but I'm not sure how "Git wants
to protect its contributors from harassment" is the "wrong" kind of
attention. If I weren't contributing to Git actively and I saw that
news, I would feel inspired and optimistic (again, speaking as a member
of groups which are often harassed online and in tech).

> (Then again, maybe it'll attract more contributors in the process, who
> knows.)


I totally understand where you're coming from, Denton, that it's not a
problem now and so it may not be worth the effort+press. But I wonder
how many folks we're missing out on patches from because they don't
think they will have recourse if they find the community to be
toxic/unwelcoming to them? We really don't have a way to know. I'm
worried that we're restricting the community to those who either
feel it's unlikely that they'll be targeted, or feel they can weather
harassment if they receive it - which narrows the diversity of our
contributor base by quite a lot.

 - Emily
