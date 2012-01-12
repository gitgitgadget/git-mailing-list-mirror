From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 22:10:22 -0500
Message-ID: <20120112031022.GC26363@sigill.intra.peff.net>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
 <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
 <20120112025445.GB25365@sigill.intra.peff.net>
 <7vehv54o6v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:10:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlB3e-0001kR-Lk
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752419Ab2ALDK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 22:10:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35626
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918Ab2ALDKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 22:10:25 -0500
Received: (qmail 27492 invoked by uid 107); 12 Jan 2012 03:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Jan 2012 22:17:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2012 22:10:22 -0500
Content-Disposition: inline
In-Reply-To: <7vehv54o6v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188426>

On Wed, Jan 11, 2012 at 07:03:36PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I see it the opposite way. People are clearly using the "$ref:$path"
> > syntax. So why would we restrict them from doing so? There are no
> > security implications (i.e., they could always just grab $ref and
> > extract $path themselves). In my view, ee27ca4a was over-eager in its
> > restrictions because I wanted it to be simple and close the hole. Now we
> > can take our time adding more code to loosen it.
> 
> Ok, so it is more like a partial revert of whatever we did. In that case,
> I'd take CMN's patch to limit the extent of the changes, as it more
> closely matches the spirit of the original ee27ca4 (archive: don't let
> remote clients get unreachable commits, 2011-11-17) that singled out and
> catered to the need of "archive" command alone. It is already part of the
> v1.7.8.1 release, so I would prefer a change to be stupid and simple.

For a maint release, I am OK with that. In the long term, I'd rather my
patches go onto master (either for 1.7.9 or for later), as I think they
are the right way to do it.

-Peff
