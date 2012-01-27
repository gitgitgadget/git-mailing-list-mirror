From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 00:57:22 -0500
Message-ID: <20120127055722.GD23633@sigill.intra.peff.net>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
 <4F211C0C.7060400@viscovery.net>
 <CACsJy8ASXrmBvxj4DxjGiqYhPkr1Yp02CAyMqKrfyfrzaAw-2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 06:57:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqeoU-0006W3-Gp
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 06:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab2A0F50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 00:57:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46329
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab2A0F5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 00:57:25 -0500
Received: (qmail 2358 invoked by uid 107); 27 Jan 2012 06:04:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 27 Jan 2012 01:04:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2012 00:57:22 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8ASXrmBvxj4DxjGiqYhPkr1Yp02CAyMqKrfyfrzaAw-2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189197>

On Fri, Jan 27, 2012 at 10:47:29AM +0700, Nguyen Thai Ngoc Duy wrote:

> > What happens if a ref cannot be resolved, for example due to repository
> > corruption? Does git just emit an error and then carries on, or does it
> > always die? Can I run at least git-fsck in such a case?
> 
> Moreover, if I specify sha-1 in the config (it's discouraged but not
> forbidden from the code), can git-prune remove the blob?

Yes. I don't think we want to get into connectivity guarantees for
config (because they can be quite complex, and involve files totally
outside the repo). I think it's OK for the user to be responsible for
either using a ref, or making sure that a bare sha1 they point to is
reachable from a ref.

-Peff
