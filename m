Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77EA820195
	for <e@80x24.org>; Fri, 15 Jul 2016 12:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbcGOMmQ (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 08:42:16 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:58550 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbcGOMmP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 08:42:15 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bO2RN-0006J5-Rs; Fri, 15 Jul 2016 21:42:01 +0900
Date:	Fri, 15 Jul 2016 21:42:01 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Jeff King <peff@peff.net>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] blame: Allow to blame paths freshly added to the index
Message-ID: <20160715124201.mrz5ze32s7koevww@glandium.org>
References: <20160715024254.29186-1-mh@glandium.org>
 <alpine.DEB.2.20.1607151242020.6426@virtualbox>
 <20160715123245.rdpbl4tmqscyf2tx@glandium.org>
 <20160715123758.GA22395@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160715123758.GA22395@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.1-neo (2016-06-11)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 08:37:59AM -0400, Jeff King wrote:
> On Fri, Jul 15, 2016 at 09:32:45PM +0900, Mike Hommey wrote:
> 
> > > > +test_expect_success 'blame wholesale copy and more in the index' '
> > > > +
> > > > +	{
> > > > +		echo ABC
> > > > +		echo DEF
> > > > +		echo XXXX
> > > > +		echo YYYY
> > > > +		echo GHIJK
> > > > +	} >horse &&
> > > 
> > > A more common way to do this in our test scripts is by using here
> > > documents. However, in this case I would suggest
> > > 
> > > 	test_write_lines ABC DEF XXXX YYYY GHIJK >horse
> > 
> > I merely copied the pattern used in other places in the same test file.
> > Using test_write_lines or something else (what are "here documents"?)
> > would break consistency. I can also change the other similar blocks at
> > the same time, though, whichever you prefer.
> 
> A here document is this:
> 
>    cat <<-\EOF
>    ABC
>    DEF
>    XXXX
>    YYYY
>    GHIJK
>    EOF
> 
> The "<<" starts the here-doc. The "-" tells the shell to strip leading
> tabs (so you can keep it indented with the rest of the code. The "\"
> tells the shell not to interpolate (not a big deal here, but great for
> more complicated input). The "EOF" tells it where to stop.

Oh, so that's what they are called! I've used them for 20 years
without knowing :) TIL.

Mike
