Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36956C433E1
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C442207D3
	for <git@archiver.kernel.org>; Fri, 29 May 2020 03:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391803AbgE2DY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 23:24:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:59634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgE2DYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 23:24:55 -0400
Received: (qmail 971 invoked by uid 109); 29 May 2020 03:24:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2020 03:24:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20541 invoked by uid 111); 29 May 2020 03:24:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 May 2020 23:24:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 May 2020 23:24:54 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
Message-ID: <20200529032454.GB1271617@coredump.intra.peff.net>
References: <20200528231608.59507-1-emilyshaffer@google.com>
 <20200529002757.GD114915@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529002757.GD114915@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 05:27:57PM -0700, Jonathan Nieder wrote:

> > --- a/app/views/shared/ref/_debugging.html.erb
> > +++ b/app/views/shared/ref/_debugging.html.erb
> > @@ -2,5 +2,6 @@
> >  <ul class='unstyled'>
> >    <li><%= man('git-bisect') %></li>
> >    <li><%= man('git-blame') %></li>
> > +  <li><%= man('git-bugreport') %></li>
> >    <li><%= man('git-grep') %></li>
> >  </ul>
> 
> Where does this show up on the rendered page?  Is it
> https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Debugging?

No, it's in the command-list in:

  https://git-scm.com/docs

in the section "debugging".

> Is there a way to preview how it renders?

Yes. :) You can clone the repo and build using the instructions in the
README (including importing at least one version's worth of manpages to
render). It's a minor-ish pain to do so if you're not used to working
with Ruby or Rails.

We also spin up a staging deploy for any PRs opened against that repo,
though I _think_ it won't do so for PRs opened from another fork (since
it can read the production database; we don't care for our project,
which contains no secrets, but many projects would).

-Peff
