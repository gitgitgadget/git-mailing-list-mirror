Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CB21F463
	for <e@80x24.org>; Thu, 19 Sep 2019 22:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406306AbfISWQS (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 18:16:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:55298 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2406298AbfISWQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 18:16:16 -0400
Received: (qmail 8872 invoked by uid 109); 19 Sep 2019 22:16:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Sep 2019 22:16:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5020 invoked by uid 111); 19 Sep 2019 22:18:29 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Sep 2019 18:18:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Sep 2019 18:16:15 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "gitster@pobox.com" <gitster@pobox.com>, garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
Message-ID: <20190919221615.GA25636@sigill.intra.peff.net>
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 19, 2019 at 12:30:13PM -0400, Derrick Stolee wrote:

> Feel free to pick apart all of the claims I make below. This is based
> on my own experience and opinions. It should be a good baseline
> for us to all arrive with valuable action items.

First off, thanks for starting this conversation on the list.  I agree
with 99% of what you said, so I'll quote sparingly below, and just cover
the parts where I have something interesting to add.

> 1. Improve the documentation for contributing to Git.
> 
> In preparation for this email, I talked to someone familiar with issues
> around new contributors, and they sat down to try and figure out how to
> contribute to Git. The first place they went was https://github.com/git/git
> and looked at the README. It takes deep reading of a paragraph to see a
> link to the SubmittingPatches docs.
> 
> To improve this experience, we could rewrite the README to have clearer
> section markers, including one "Contributing to Git" section relatively
> high in the doc. We may want to update the README for multiple reasons.
> It should link to the new "My First Contribution" document
> (https://git-scm.com/docs/MyFirstContribution).

I suspect some people may end up at:

  https://git-scm.com/community

when figuring out how to get involved. That discusses the mailing list
itself, but is mostly from the perspective of "how do I ask a question".
I think it could definitely cover some more things:

  - how to get involved by submitting a patch

  - how to get involved in some _other_ way (say, by reviewing or
    participating in discussions)

  - what kind of behavior we expect (and participants can expect) on the
    list

Most of those things would probably be links to other places (e.g., the
first one pointing to MyFirstContribution), but to me it makes sense as
a general landing page for "what is this community and how do I interact
with it".

We take PRs at:

  https://github.com/git/git-scm.com

but I'm happy to apply patches if somebody doesn't want to use GitHub.
The file you'd want to touch is app/views/community/index.html.erb
(there are instructions for spinning up a local version of the site in
its README, but if you open a PR it will also get auto-deployed to a
staging site where you can check formatting, etc).

> We have a reference to GitGitGadget in the GitHub PR template to try and
> get people who try to submit a pull request to git/git to instead create
> one on GitGitGadget. However, that captures contributors who didn't read
> the docs about how to submit! (This is somewhat covered by the "My First
> Contribution" doc as well, so making that more visible will also help.)
> 
> Could we reference GitGitGadget as part of the Submitting Patches doc
> as well?

Hmm, I thought we did, but it looks like it's just in CONTRIBUTING. From
my perspective as a reviewer of such patches, I don't mind seeing more
GGG submissions. I.e., I think the tool is mature enough that I don't
mind us letting more people know that it's an option.

> 4. Add an official Code of Conduct
> 
> So far, the community has had an unofficial policy of "be nice,
> as much as possible". We should add a Code of Conduct that is
> more explicit about the behavior we want to model. This was also
> discussed in the meeting with wide approval.

I agree, and will send a separate message going into more detail.

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

This point is the one I'm least on board with. Not because I'm not
thrilled to have new contributors, but that to some degree I think the
open source system relies heavily on intrinsic motivations like
scratching your own itch. I'm worried that advertising "hey, we need
people to work on stuff!" then brings in people who are well-meaning but
don't necessarily care much about Git in particular. And it becomes an
administrative headache to try to figure out things for them to do, or
get them acclimated to the community.

I.e., I think we want to grow the community a bit more organically,
which should be more sustainable in the long run.

So I think any advertising would be more about making it clear that _if_
you have an idea, we're very interested in welcoming newcomers. And that
to me falls under a lot of the points already made above: making the
process more clear and more inviting to people who are already thinking
about contributing.

-Peff
