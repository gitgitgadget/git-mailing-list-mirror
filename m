From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: [PATCH] Python scripts audited for minimum compatible version
 and checks added.
Date: Mon, 24 Dec 2012 00:21:50 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121224052150.GA24686@thyrsus.com>
References: <20121220141855.05DAA44105@snark.thyrsus.com>
 <20121220144813.GA27211@sigill.intra.peff.net>
 <20121220150252.GA24387@thyrsus.com>
 <7vsj7060nj.fsf@alter.siamese.dyndns.org>
 <7vk3sc2hx9.fsf@alter.siamese.dyndns.org>
 <7vr4mgnj2v.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 24 06:22:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn0Ut-0002rD-BL
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 06:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab2LXFWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 00:22:19 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:33437
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab2LXFWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 00:22:17 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id CA0544411F; Mon, 24 Dec 2012 00:21:50 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vr4mgnj2v.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212096>

Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I needed something like this on top of it to get it pass t5800.
> >
> > diff --git a/git_remote_helpers/git/__init__.py b/git_remote_helpers/git/__init__.py
> > index 776e891..5047fd4 100644
> > --- a/git_remote_helpers/git/__init__.py
> > +++ b/git_remote_helpers/git/__init__.py
> > @@ -1,3 +1,5 @@
> > +import sys
> > +
> >  if sys.hexversion < 0x02040000:
> >      # The limiter is the subprocess module
> >      sys.stderr.write("git_remote_helpers: requires Python 2.4 or later.")
> 
> Ping?  Is the above the best fix for the breakage?

Sorry, I missed this the first time around.  Yes, I think it is.
 
> If it weren't __init__, I'd silently squash it in, but the filename
> feels a bit more magic than the ordinary *.py files, so I was worried
> there may be some other rules involved what can and cannot go in to
> such a file, hence I've been waiting for an ack or alternatives.

Nope, no special rules.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
