From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 10:42:57 -0400
Message-ID: <20111006144257.GB21558@sigill.intra.peff.net>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:43:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBpAT-0007X5-Iq
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 16:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935847Ab1JFOnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 10:43:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54396
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758277Ab1JFOnD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 10:43:03 -0400
Received: (qmail 8508 invoked by uid 107); 6 Oct 2011 14:43:02 -0000
Received: from 208.177.47.101.ptr.us.xo.net (HELO sigill.intra.peff.net) (208.177.47.101)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Oct 2011 10:43:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Oct 2011 10:42:57 -0400
Content-Disposition: inline
In-Reply-To: <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182957>

On Wed, Oct 05, 2011 at 11:19:17AM -0700, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > Git has survived w/o needing to lock branches till now.
> 
> Careful. Git has survived without your patch series till now, as people
> learned to be careful when they use separate workdirs and avoid certain
> things, to the point that they are not necessarily aware that they are
> avoiding them (one good practice is to keep the HEADs of non-primary
> workdirs detached).
> 
> Does that mean what your patch aims to do is unnecessary? I think not.

It seems to me that things like receive.denyCurrentBranch and
receive.denyDeleteCurrent are just special hand-rolled versions of the
same concept.

Could they be implemented using this kind of branch locking? Moreover, I
think they would need to be to cope with new-workdir, as the definition
of "current" stops being "referenced by HEAD", but becomes much larger.

-Peff
