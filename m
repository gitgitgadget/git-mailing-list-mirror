From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] send-email: do not prompt for explicit repo ident
Date: Wed, 14 Nov 2012 12:05:05 -0800
Message-ID: <20121114200505.GA13317@sigill.intra.peff.net>
References: <20121113164845.GD20361@sigill.intra.peff.net>
 <20121113165327.GF12626@sigill.intra.peff.net>
 <20121114171827.GE6858@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:05:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYjDA-0000GK-1q
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 21:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423244Ab2KNUFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 15:05:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48620 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423097Ab2KNUFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 15:05:08 -0500
Received: (qmail 6425 invoked by uid 107); 14 Nov 2012 20:05:57 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 15:05:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 12:05:05 -0800
Content-Disposition: inline
In-Reply-To: <20121114171827.GE6858@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209748>

On Wed, Nov 14, 2012 at 09:18:27AM -0800, Jonathan Nieder wrote:

> > The test scripts need to be adjusted to not expect a prompt
> > for the sender, since they always have the author explicitly
> > defined in the environment. Unfortunately, we cannot
> > reliably test that prompting still happens in the implicit
> > case, as send-email will produce inconsistent results
> > depending on the machine config (if we cannot find a FQDN,
> > "git var" will barf, causing us to exit early;
> 
> At first this sounded like a bug to me --- how could the user keep
> working without the sysadmin intervening?
> 
> But then I remembered that the user can set her name and email in
> .gitconfig and probably would want to in such a setup anyway.

Right. They would already have to to make commits, for example.

> When someone writes such a test, I think it could check that git
> either prompts or writes a message advising to configure the user
> email, no?  Waiting until later for that seems fine to me, though.

Yes. The problem is that the behavior and output are dependent on
factors outside the test suite, so we would have to check that one of
the possible expected outcomes happens. But I think there are really
only two such outcomes (neglecting that the ident itself can have
arbitrary content, but we do not have to check the actual content).

-Peff
