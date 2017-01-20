Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8A720A17
	for <e@80x24.org>; Fri, 20 Jan 2017 00:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753576AbdATAH1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 19:07:27 -0500
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:33980 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753522AbdATAHY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Jan 2017 19:07:24 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id 43C4E290075;
        Fri, 20 Jan 2017 00:07:21 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 32C766B36D;
        Fri, 20 Jan 2017 00:06:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: part65_715a1da5e2b11
X-Filterd-Recvd-Size: 3868
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Jan 2017 00:06:18 +0000 (UTC)
Message-ID: <1484870777.2707.2.camel@perches.com>
Subject: Re: [RFC for GIT] pull-request: add praise to people doing QA
From:   Joe Perches <joe@perches.com>
To:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 19 Jan 2017 16:06:17 -0800
In-Reply-To: <CA+P7+xo5N66a8-PeNRLBgwRN3rJZRbQuDnx8wCnW7L-0tz10Fg@mail.gmail.com>
References: <20170115183051.3565-1-wsa@the-dreams.de>
         <xmqqlgubc04z.fsf@gitster.mtv.corp.google.com>
         <20170119204343.xtotmjddhbum2mvr@ninjato>
         <20170119212039.3gixsrk7qco45wjo@sigill.intra.peff.net>
         <CA+P7+xo5N66a8-PeNRLBgwRN3rJZRbQuDnx8wCnW7L-0tz10Fg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.3-0ubuntu0.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-01-19 at 15:42 -0800, Jacob Keller wrote:
> On Thu, Jan 19, 2017 at 1:20 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Jan 19, 2017 at 09:43:45PM +0100, Wolfram Sang wrote:
> > 
> > > > As to the implementation, I am wondering if we can make this somehow
> > > > work well with the "trailers" code we already have, instead of
> > > > inventing yet another parser of trailers.
> > > > 
> > > > In its current shape, "interpret-trailers" focuses on "editing" an
> > > > existing commit log message to tweak the trailer lines.  That mode
> > > > of operation would help amending and rebasing, and to do that it
> > > > needs to parse the commit log message, identify trailer blocks,
> > > > parse out each trailer lines, etc.
> > > > 
> > > > There is no fundamental reason why its output must be an edited
> > > > original commit log message---it should be usable as a filter that
> > > > picks trailer lines of the selected trailer type, like "Tested-By",
> > > > etc.
> > > 
> > > I didn't know about trailers before. As I undestand it, I could use
> > > "Tested-by" as the key, and the commit subject as the value. This list
> > > then could be parsed and brought into proper output shape. It would
> > > simplify the subject parsing, but most things my AWK script currently
> > > does would still need to stay or to be reimplemented (extracting names
> > > from tags, creating arrays of tags given by $name). Am I correct?
> > > 
> > > All under the assumption that trailers work on a range of commits. I
> > > have to admit that adding this to git is beyond my scope.
> > 
> > This sounds a lot like the shortlog-trailers work I did about a year
> > ago:
> > 
> >   http://public-inbox.org/git/20151229073832.GN8842@sigill.intra.peff.net/
> > 
> >   http://public-inbox.org/git/20151229075013.GA9191@sigill.intra.peff.net/
> > 
> > Nobody seemed to really find it useful, so I didn't pursue it.
> > 
> > Some of the preparatory patches in that series bit-rotted in the
> > meantime, but you can play with a version based on v2.7.0 by fetching
> > the "shortlog-trailers-historical" branch from
> > https://github.com/peff/git.git.
> > 
> > And then things like:
> > 
> >   git shortlog --ident=tested-by --format='...tested a patch by %an'
> > 
> > work (and you can put whatever commit items you want into the --format,
> > including just dumping the hash if you want to do more analysis).
> > 
> > -Peff
> 
> This sounds interesting to me! When I have some more time to take a
> look at this i might see if I can revive it.

Can the terminology please be standardized to what
was once called bylines?

https://patchwork.kernel.org/patch/9307703/

