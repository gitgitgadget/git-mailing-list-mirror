Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373161F463
	for <e@80x24.org>; Thu, 19 Sep 2019 17:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbfISRe2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 13:34:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37347 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbfISRe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 13:34:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so2770314pfo.4
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 10:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jAbceG5YEYKliMyyhLDIOEsvL/q1U218oNpYL0POgOE=;
        b=kOSKh95dVTVatgwUS08miPxtRJb5pOfODCTA6SBT4gzOBsWjQ4jPS6hp7IPcec4vcP
         bkFE4EIR4w481tVgfSvO94x7IB/IQ46QvyOqtbLM2DKG/J77jn/meJ1uY5b4SVwEes+1
         HiaFffQc/bSd41xhPd9utAmKQicAd713dBEAFyaqb1SJjhksohsjFSow8baV7yLSyDLY
         1OzCnPJ7tNSxbeq2EfOVfLI4gitDRIkpnFoeTosr9ly3skcXaI0j0vxLn8bzTL0vU6zq
         w6zE/ZZCwRqWzl7ccmAdMEy58K3/kFUtAUGezi4h7zFhTcRvtt5zXqVs1Se2Tuay8xUk
         yI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jAbceG5YEYKliMyyhLDIOEsvL/q1U218oNpYL0POgOE=;
        b=a1jdEKXR/JyJTByWiqd0smsQ0awPuyAOlkxFyI8C52ZMITnzdxyhGaOpkEfvEbIC41
         OU35Sp8DMGhNdx7AauARXKn+SWGYqM7FFHWIcDtefz/1AYG1zFKUEBXVpugiyYoi+2j9
         V5HNM8FqqaAEYz8veBFMguBhwb21yALSn9wrXaCNP6F/wsJgQqHwFeZY5D4juL7o/OBe
         UFQKPZwWt+rUxWn7bVDwdK7F3kSa89S2yvBegQyqzKEwJm/1/bblj9BknWtuZ9OIQAEG
         dH1JbGcmB8ZbkQlxon8Qz1CBM/GJIzLIqg43sksePwBvd4vfpAx/I7J535Olqx/iRBSJ
         mTfA==
X-Gm-Message-State: APjAAAV6Rf+upxPZI6hK/XOWblcxC9fLd3fdL57t6rUL5i6siDajRa4f
        LL+n7Cx4EN2Sb5nXtCwHZ3I=
X-Google-Smtp-Source: APXvYqxXs0s5faga9ZGtlGhUo1Wfyxnc87R2Frp/Bcbd6PdTnGl1aOdQdmOJnSfFygRAl+xI74KeUQ==
X-Received: by 2002:a62:7684:: with SMTP id r126mr11309093pfc.26.1568914466661;
        Thu, 19 Sep 2019 10:34:26 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.53])
        by smtp.gmail.com with ESMTPSA id b16sm20150544pfb.54.2019.09.19.10.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2019 10:34:25 -0700 (PDT)
Date:   Thu, 19 Sep 2019 10:34:23 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190919173423.GA70421@dentonliu-ltm.internal.salesforce.com>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

As a relatively new contributor (just less than a year), I guess I'll
share some thoughts:

On Thu, Sep 19, 2019 at 12:30:13PM -0400, Derrick Stolee wrote:
> During the Virtual Git Contributors' Summit, Dscho brought up the topic of
> "Inclusion & Diversity". We discussed ideas for how to make the community
> more welcoming to new contributors of all kinds. Let's discuss some of
> the ideas we talked about, and some that have been growing since.
> 
> Feel free to pick apart all of the claims I make below. This is based
> on my own experience and opinions. It should be a good baseline
> for us to all arrive with valuable action items.
> 
> I have CC'd some of the people who were part of that discussion. Sorry
> if I accidentally left someone out.
> 
> I. Goals and Perceived Problems
> 
> As a community, our number one goal is for Git to continue to be the best
> distributed version control system. At minimum, it should continue to be
> the most widely-used DVCS. Towards that goal, we need to make sure Git is
> the best solution for every kind of developer in every industry. The
> community cannot do this without including developers of all kinds. This
> means having a diverse community, for all senses of the word: Diverse in
> physical location, gender, professional status, age, and others.
> 
> In addition, the community must continue to grow, but members leave the
> community on a regular basis for multiple reasons. New contributors must
> join and mature within the community or the community will dwindle. Without
> dedicating effort and attention to this, natural forces may result in the
> community being represented only by contributors working at large tech
> companies focused on the engineering systems of very large groups.

From my anecdotal experience in trying to get my developer friends to
contribute, they've told me that it isn't really that much fun for them
to contribute to free software. After doing one day job, they said they
didn't really want to come home to do another one.

I guess one thing we should consider is "how do we make it more fun to
contribute to Git?" Not sure if that's a naïve goal but I feel like it
would help to keep people coming back.

> 
> It is worth noting that this community growth must never be at the cost
> of code quality. We must continue to hold all contributors to a high
> standard so Git stays a stable product.
> 
> Here are some problems that may exist within the Git community and may
> form a barrier to new contributors entering:
> 
> 1. Discovering how to contribute to Git is non-obvious.
> 
> 2. Submitting to a mailing list is a new experience for most developers.
>    This includes the full review and discussion process.
> 
> 3. The high standards for patch quality are intimidating to new contributors.
> 
> 4. Some people do not feel comfortable engaging in a community without
>    a clear Code of Conduct. This discomfort is significant and based on real
>    experiences throughout society.
> 
> 5. Since Git development happens in a different place than where users
>     acquire the end product, some are not aware that they can contribute.
> 
> II. Approach
> 
> The action items below match the problems listed above.
> 
> 1. Improve the documentation for contributing to Git.
> 
> In preparation for this email, I talked to someone familiar with issues
> around new contributors, and they sat down to try and figure out how to
> contribute to Git. The first place they went was https://github.com/git/git
> and looked at the README. It takes deep reading of a paragraph to see a
> link to the SubmittingPatches docs.

Aside from getting the first email sent, most of my time learning to
contribute to Git stemmed from the fact that there's a lot of tribal
knowledge that's not really written down anywhere. Here are some of the
smaller things that confused me:

I remember some other docs I read included howto/maintain-git.txt about
a month in. I remember feeling confused about what Junio was doing with
all of the integration branches so reading this really cleared things up
for me.

On that topic, I didn't realise the gitster/git repo existed for a while
so, from my pespective, my patches went into a black hole and then
somehow magically got incorporated into Git.

Actually, one thing that I'm still confused about is what people do with
their topic branches. I learned a long time ago not to rebase onto
master (hence why I introduced rebase --keep-base) but aside from that,
are we supposed to pull down the topic branches and edit from there or
keep working on top of a local branch? I think it might be help if
someone experienced in the community wrote a howto/contribute-to-git.txt
and just spent a while talking about their workflow in detail.

> 
> To improve this experience, we could rewrite the README to have clearer
> section markers, including one "Contributing to Git" section relatively
> high in the doc. We may want to update the README for multiple reasons.
> It should link to the new "My First Contribution" document
> (https://git-scm.com/docs/MyFirstContribution).

I agree, this would've been really helped me get started if it were
around a year ago.

> 
> 2. Add more pointers to GitGitGadget
> 
> We have a reference to GitGitGadget in the GitHub PR template to try and
> get people who try to submit a pull request to git/git to instead create
> one on GitGitGadget. However, that captures contributors who didn't read
> the docs about how to submit! (This is somewhat covered by the "My First
> Contribution" doc as well, so making that more visible will also help.)
> 
> Could we reference GitGitGadget as part of the Submitting Patches doc
> as well?
> 
> 3. Introduce a new "mentors" mailing list
> 
> >From personal experience, all new contributors at Microsoft (after Jeff
> Hostetler at least) have first had their patches reviewed privately by
> the team before sending them upstream. Each time, the new contributor
> gained confidence about the code and had help interpreting feedback from
> the list.
> 
> We want to make this kind of experience part of the open Git community.
> 
> The idea discussed in the virtual summit was to create a new mailing
> list (probably a Google group) of Git community members. The point of
> the list is for a new contributor to safely say "I'm looking for a
> mentor!" and the list can help pair them with a mentor. This must
> include (a) who is available now? and (b) what area of the code are they
> hoping to change?
> 
> As evidence that this is a good idea, please see the recent research
> paper ""We Don't Do That Here": How Collaborative Editing With Mentors
> Improves Engagement in Social Q&A Communities" [1].
> 
> [1] http://www.chrisparnin.me/pdf/chi18.pdf
> 
> When asking your first question on Stack Overflow, this group added
> a pop-up saying "Would you like someone to help you with this?". Then,
> a mentor would assist crafting the best possible question to ensure
> the asker got the best response possible.
> 
> I believe this would work in our community, too. The action items
> are:
> 
> a. Create the mailing list and add people to the list.
> 
> b. Add a pointer to the list in our documentation.
> 
> Note: the people on the mentoring list do not need to be
> "senior" community members. In fact, someone who more recently
> joined the community has a more fresh perspective on the process.

Another discouraging thing when I was just starting out was sending a
out a patch and just getting radio silence (especially the first one, I
wasn't sure if it even sent out properly!). Perhaps in the main list, we
could get people to tag with [FIRST PATCH] or something when sending in
their first patch.

If the patch is not desired, then we should explain why it wasn't
desired instead of just leaving them hanging. I know Junio is too busy
to say "hey, I'm picking this patch up" to every single patchset, but if
a patch is desired, perhaps the rest of us could pick up the slack and
say, "hey, your patchset was picked up by Junio in his gitster repo on
this branch".

> 
> 4. Add an official Code of Conduct
> 
> So far, the community has had an unofficial policy of "be nice,
> as much as possible". We should add a Code of Conduct that is
> more explicit about the behavior we want to model. This was also
> discussed in the meeting with wide approval.

From what I've personally read and experienced, I don't think that an
official Code of Conduct is really warranted. Everyone I've interacted
with has been really kind. Perhaps a new contributor might interpret the
curtness of replies here as someone being rude but I quickly learned
that it's more out of necessity since everyone is busy.

From reading the mailing list archives, I know that in the past, there
have been some flamewars and some abrasive individuals but I think
that's a problem of the past.

I also see some drawbacks to implementing a CoC as well. First of all,
it just feels like unnecessary bureaucracy. Second, I think it'll
probably cause a stir like it did when the Linux kernel introduced it.
Of course, all that noise will die down eventually but I feel like it'll
bring the wrong kind of attention to Git.

(Then again, maybe it'll attract more contributors in the process, who
knows.)

> 
> 5. Advertise that Git wants new contributors
> 
> After we put items 1-4 in place, we should reach out to the
> general tech community that we are interested in new
> contributors. It's not enough to open the door, we should
> point people to it.
> 
> This item is much less explicit about the _how_. This could
> be done at the individual level: posting to social media or
> blog posts. But perhaps there is something more official we
> could do?
> 
> III. Measurement
> 
> How do we know if any of these items make a difference? We
> need to gather data and measure the effects. With the size
> of our community, I expect that it will take multiple years
> to really see a measurable difference. But, no time like
> the present to ask "What does success look like?"
> 
> Here are a few measurements that we could use. Each "count"
> could be measured over any time frame. We could use major
> releases as time buckets: v2.22.0 to v2.23.0, for example.
> 
> 1. How many first-time contributors sent a patch?
> 
> 2. How many contributors had their first commit accepted into
>    the release?
> 
> 3. How many contributors started reviewing?
> 
> 4. How many total patches/reviews did the list receive?
> 
> What other measurements would be reasonable? We could try
> building tools to collect these measurements for the past
> to see historical trends. Based on that data, we may be
> able to set goals for the future.
> 
> With such a small community, and an expected small number
> of new contributors, it may also be good to do interviews
> with the new contributors to ask about their experience.
> In particular, we would be looking for moments where they
> had trouble or experience friction. Each of those
> moments is a barrier that others may not be clearing.

I've dropped some of my experiences here but I'd be open to do an
interview if needed.

> 
> 
> I look forward to the discussion.

Thanks for starting the discussion,

Denton
> 
> Thanks,
> -Stolee
