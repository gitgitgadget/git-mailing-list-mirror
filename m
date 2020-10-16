Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A4C433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C402083B
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 01:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbgJPB7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 21:59:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:33958 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729810AbgJPB7i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 21:59:38 -0400
Received: (qmail 26324 invoked by uid 109); 16 Oct 2020 01:59:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 16 Oct 2020 01:59:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4334 invoked by uid 111); 16 Oct 2020 01:59:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 21:59:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 21:59:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] Clarify and expand description of --signoff
Message-ID: <20201016015937.GA3335046@coredump.intra.peff.net>
References: <20201015215933.96425-1-bkuhn@sfconservancy.org>
 <59E3B060-63E3-41C2-A7C4-5B2C888F8D68@gmail.com>
 <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daWenXds=0BW0CXa=4MOF2UxDeQ8DF2+7V9-WkKwCFCDBw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 06:54:30PM -0700, Junio C Hamano wrote:

> > > Documentation/git-commit.txt    | 13 ++++++++-----
> > > Documentation/merge-options.txt | 13 ++++++++-----
> > > 2 files changed, 16 insertions(+), 10 deletions(-)
> >
> > Since the changes are exactly the same in the two files, maybe
> > a preparatory patch that creates 'signoff.txt' and includes it
> > in 'git-commit.txt' and 'merge-options.txt' would be a good idea ?
> 
> I actually think we are OK with two duplicated and leave that for
> later clean-up. The more important would be to polish the text into
> a good enough state quickly.
> 
> Another thing we should not forget is to update our SubmittingPatches
> document. Since we are placing extra stress on that there is NO
> inherent meaning in "sign off" and it is largely up to each project,
> we should set a good example explaining what it means to THIS
> project to sign your patches off, and SubmittingPatches is the
> document to do so. Without such an update, I think the update
> to these two files we see in this patch is incomplete.

I agree we should be leading by example here.

We do already say pretty clearly what signed-off-by means in the
project:

  $ grep -A14 '\[\[sign-off]]' Documentation/SubmittingPatches 
  [[sign-off]]
  === Certify your work by adding your "Signed-off-by: " line
  
  To improve tracking of who did what, we've borrowed the
  "sign-off" procedure from the Linux kernel project on patches
  that are being emailed around.  Although core Git is a lot
  smaller project it is a good discipline to follow it.
  
  The sign-off is a simple line at the end of the explanation for
  the patch, which certifies that you wrote it or otherwise have
  the right to pass it on as an open-source patch.  The rules are
  pretty simple: if you can certify the below D-C-O:
  
  [[dco]]
  .Developer's Certificate of Origin 1.1

What should we change there? We could perhaps bring up signoffs earlier
or more prominently. Or tie it in to the git-commit docs by saying
explicitly: these are _our_ project rules for signoffs.

-Peff
