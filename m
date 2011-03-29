From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 15:01:38 -0400
Message-ID: <20110329190138.GA23599@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <20110329143547.GB10771@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4eAo-0006fI-Ho
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 21:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753138Ab1C2TBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 15:01:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34859
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942Ab1C2TBo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 15:01:44 -0400
Received: (qmail 31700 invoked by uid 107); 29 Mar 2011 19:02:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 15:02:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 15:01:38 -0400
Content-Disposition: inline
In-Reply-To: <20110329143547.GB10771@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170308>

On Tue, Mar 29, 2011 at 10:35:47AM -0400, Jeff King wrote:

> On Tue, Mar 29, 2011 at 12:05:09PM +0200, Michael J Gruber wrote:
> 
> > -		if (!prefixcmp(arg+13, "refs/"))
> > +		if (!prefixcmp(arg+offset, "refs/"))
> >  			/* happy */;
> > -		else if (!prefixcmp(arg+13, "notes/"))
> > +		else if (!prefixcmp(arg+offset, "notes/"))
> >  			strbuf_addstr(&buf, "refs/");
> >  		else
> >  			strbuf_addstr(&buf, "refs/notes/");
> > -		strbuf_addstr(&buf, arg+13);
> > +		strbuf_addstr(&buf, arg+offset);
> >  		string_list_append(revs->notes_opt.extra_notes_refs,
> >  				   strbuf_detach(&buf, NULL));
> 
> This issue is not introduced by your patch, but maybe it is a good
> opportunity to refactor this to use expand_notes_ref from notes.c?

Oops, I just realized this is in builtin/notes.c in master. I had
already written a patch for another topic that made it globally
accessible. :)

-Peff
