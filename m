Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ED312095D
	for <e@80x24.org>; Wed, 22 Mar 2017 23:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbdCVX6B (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 19:58:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:49893 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754958AbdCVX6A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 19:58:00 -0400
Received: (qmail 4500 invoked by uid 109); 22 Mar 2017 23:57:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 23:57:59 +0000
Received: (qmail 1541 invoked by uid 111); 22 Mar 2017 23:58:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 19:58:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 19:57:55 -0400
Date:   Wed, 22 Mar 2017 19:57:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How do I copy a branch & its config to a new name?
Message-ID: <20170322235754.wver7y6hpfyotwzg@sigill.intra.peff.net>
References: <CACBZZX7NDa5o1xSu4HgZ4=kG3mx3U6ja7f3E4yAkFOHDsLdMjA@mail.gmail.com>
 <20170322225800.3h2mnnmmj2hbo36c@sigill.intra.peff.net>
 <CACBZZX47euh-K8-DUjDKr6i=g8MzmivOzA5fFTyPQjZhkzM2uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX47euh-K8-DUjDKr6i=g8MzmivOzA5fFTyPQjZhkzM2uA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 12:54:48AM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Mar 22, 2017 at 11:58 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Mar 22, 2017 at 11:46:14PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >
> >> But both of these are really just a limited special case for what I'd
> >> really like, which is given branch "foo", copy it and all its
> >> configuration to a new name "bar". I.e. both of the hacks above only
> >> set up the correct tracking info, but none of the other branch.*
> >> variables I may have set.
> >
> > I thought that's what "git branch -m" was for, though I don't know how
> > thorough it is about finding config that refers _to_ your branch (I know
> > it handles config _for_ your branch).
> >
> > There might be room for improvement there.
> 
> -m can only rename "foo" -> "bar", but I'd like to end up with a new
> "bar" with the same config as "foo"

Ah, I see. You really want "copy". In that case, yeah, I think you'd
need a new command. It might make sense for it to share implementation
with rename (and just do the "add new config" part, skipping the "drop
old config" half).

-Peff
