From: Jeff King <peff@peff.net>
Subject: Re: Confusing git pull error message
Date: Sun, 13 Sep 2009 17:36:09 -0400
Message-ID: <20090913213609.GA6993@sigill.intra.peff.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com>
 <20090912211119.GA30966@coredump.intra.peff.net>
 <7v1vmar353.fsf@alter.siamese.dyndns.org>
 <20090913204231.GA8654@coredump.intra.peff.net>
 <7vfxaqpnpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 23:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mmwk4-0002qq-SC
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 23:36:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbZIMVgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 17:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbZIMVgI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 17:36:08 -0400
Received: from peff.net ([208.65.91.99]:40260 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754461AbZIMVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 17:36:07 -0400
Received: (qmail 20626 invoked by uid 107); 13 Sep 2009 21:36:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Sep 2009 17:36:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Sep 2009 17:36:09 -0400
Content-Disposition: inline
In-Reply-To: <7vfxaqpnpa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128420>

On Sun, Sep 13, 2009 at 01:57:37PM -0700, Junio C Hamano wrote:

> > What you have here is precisely what we observed. But I think one of the
> > complaints was to say more explicitly "that ref doesn't exist on the
> > remote", which I think should be the case if we have got to this point
> > (anything else would have triggered an error in fetch).
> 
> Wouldn't you get into the situation with this?
> 
> 	[remote "origin"]
>         	fetch = refs/heads/master:refs/heads/master
> 	[branch "master"]
>         	remote = origin
>                 merge = refs/heads/next
> 
> I think saying "does not exist" will repeat the same mistake of
> overguessing you are trying to rectify.

You are right, of course. I think your wording makes sense, then
(otherwise we get stuck with "well, we didn't fetch it. Maybe because it
didn't exist. Or maybe because your configuration didn't include it.").

-Peff
