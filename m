From: Jeff King <peff@peff.net>
Subject: Re: Re* [PATCH] gitweb: make remote_heads config setting work.
Date: Wed, 21 Nov 2012 14:31:15 -0500
Message-ID: <20121121193115.GB16280@sigill.intra.peff.net>
References: <20121105235047.GA78156@redoubt.spodhuis.org>
 <7vk3tvqthw.fsf@alter.siamese.dyndns.org>
 <20121109163710.GD19725@sigill.intra.peff.net>
 <7vpq37rk3v.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Phil Pennock <phil@apcera.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:31:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbG1E-0006hZ-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab2KUTbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:31:18 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54428 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768Ab2KUTbR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:31:17 -0500
Received: (qmail 9429 invoked by uid 107); 21 Nov 2012 19:32:10 -0000
Received: from ip68-100-44-35.dc.dc.cox.net (HELO sigill.intra.peff.net) (68.100.44.35)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Nov 2012 14:32:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2012 14:31:15 -0500
Content-Disposition: inline
In-Reply-To: <7vpq37rk3v.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210166>

On Tue, Nov 20, 2012 at 02:21:40PM -0800, Junio C Hamano wrote:

> > Good catch. I think the "return" in the existing code suffers from the
> > same problem: it will bail on non-word characters in the $mi part, but
> > that part should allow arbitrary characters.
> 
> I am tired of keeping the "expecting reroll" entries and having to
> worry about them, so let's do this
> 
> -- >8 --
> Subject: [squash] gitweb: make remote_heads config setting work
> 
> Only the top-level and bottom-level names are case insensitive and
> spelled without "_".  Protect future support of subsection names
> from name mangling.

I think the end result is fine, though you are really fixing a bug here
(the /\W/ check is moved up), and then also putting the remote_heads
fix (s/_//g) into the right place. IOW, if you are going to squash, you
should probably note the bug-fix part in the commit message explicitly.

-Peff
