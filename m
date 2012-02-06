From: Jeff King <peff@peff.net>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 6 Feb 2012 15:14:40 -0500
Message-ID: <20120206201440.GB30776@sigill.intra.peff.net>
References: <7v39axc9gp.fsf@alter.siamese.dyndns.org>
 <7vaa55ar4v.fsf@alter.siamese.dyndns.org>
 <20120130215043.GB16149@sigill.intra.peff.net>
 <7vobtcbtqa.fsf@alter.siamese.dyndns.org>
 <20120206043012.GD29365@sigill.intra.peff.net>
 <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com>
 <20120206050637.GA4263@sigill.intra.peff.net>
 <4F2F94AC.6010800@alum.mit.edu>
 <20120206085707.GA24149@sigill.intra.peff.net>
 <7vpqdr7rn0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUxb-0007ZA-Kf
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab2BFUOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:14:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58930
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046Ab2BFUOm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 15:14:42 -0500
Received: (qmail 30640 invoked by uid 107); 6 Feb 2012 20:21:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 15:21:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 15:14:40 -0500
Content-Disposition: inline
In-Reply-To: <7vpqdr7rn0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190095>

On Mon, Feb 06, 2012 at 10:17:55AM -0800, Junio C Hamano wrote:

> > PS I probably would have done it as:
> >
> >      git init vendor
> >      cd vendor
> >      import import import
> >      cd ..
> >
> >      git init project
> >      cd project
> >      git fetch ../vendor master:vendor
> >
> >    but I don't think there's anything wrong with your approach (in fact,
> >    it's slightly more efficient).
> 
> Probably I am slower than my usual slow self this morning. Does Michael's
> approach go like this:
> 
> 	git init project
>         cd project
>         import import import
>         git branch -m vendor
>         git checkout -b master
> 
> to fork from third-party codebase?

I thought it would have been:

  git init project
  cd project
  git checkout -b vendor
  import import import
  git checkout -b master
  modify modify modify

but he can probably say more.

-Peff
