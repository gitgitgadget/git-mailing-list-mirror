From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Fri, 15 Apr 2016 17:09:47 -0400
Message-ID: <20160415210947.GA21678@sigill.intra.peff.net>
References: <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com>
 <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com>
 <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
 <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com>
 <20160413220559.GC8712@sigill.intra.peff.net>
 <CAOLa=ZR7rKETM2b34B2Whw7Au-t7iFEkcNAB4ZygeQM=9Lp9zQ@mail.gmail.com>
 <20160414200530.GA26513@sigill.intra.peff.net>
 <20160414203615.GA31504@sigill.intra.peff.net>
 <CAOLa=ZSdnDFR52BJB1dm-D=gyUo=oB0aoh5pKAvwyNG5+u0P_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:09:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arB00-00033z-38
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:09:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbcDOVJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:09:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:50436 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750801AbcDOVJv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:09:51 -0400
Received: (qmail 10375 invoked by uid 102); 15 Apr 2016 21:09:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 17:09:50 -0400
Received: (qmail 14998 invoked by uid 107); 15 Apr 2016 21:09:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 17:09:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2016 17:09:47 -0400
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSdnDFR52BJB1dm-D=gyUo=oB0aoh5pKAvwyNG5+u0P_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291661>

On Sat, Apr 16, 2016 at 01:57:23AM +0530, Karthik Nayak wrote:

> I had a look at your patch and even tested it, seems solid, I like how you
> integrated all these atoms together under refname_atom_parser_internal().
> I'm squashing this in, for my re-roll. Thanks.

Great, thanks for picking it up.

> > So actually, we _do_ accept "%(upstream:short,track)" with your
> > patch, which is somewhat nonsensical. It just ignores "short" and
> > takes whatever option came last. Which is reasonable, though
> > flagging an error would also be reasonable (and I think is what
> > existing git does). I don't think it matters much either way.
> >
> 
> I think it was decided a while ago that it'd be best to ignore all and
> accept the last argument without barfing, I couldn't find the exact
> link. But I'm open to both.  But if you look at the %(align) atom,
> even that accepts mutually exclusive arguments and accepts the last
> argument without reporting an error.

Makes sense, and I'm fine with how you have it (and my patch tried to
retain that property). I just wasn't sure if it was intentional, as I
did a bad job of paying attention to earlier rounds of the series. Thank
you for keeping at it.

-Peff
