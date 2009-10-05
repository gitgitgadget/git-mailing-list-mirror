From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Reserve a slot for argv[0] in default_arg.
Date: Mon, 5 Oct 2009 14:45:32 -0400
Message-ID: <20091005184532.GA20078@coredump.intra.peff.net>
References: <1254576571-29274-1-git-send-email-urkedal@nbi.dk>
 <20091004133333.GA13894@sigill.intra.peff.net>
 <20091004141355.GA15783@eideticdew.org>
 <20091004182746.GA22995@coredump.intra.peff.net>
 <7v4oqen6my.fsf@alter.siamese.dyndns.org>
 <20091005063649.GA25040@eideticdew.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>
To: Petter Urkedal <urkedal@nbi.dk>
X-From: git-owner@vger.kernel.org Mon Oct 05 20:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muscp-0000FY-J0
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 20:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754542AbZJESqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 14:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbZJESqT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 14:46:19 -0400
Received: from peff.net ([208.65.91.99]:39451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754111AbZJESqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 14:46:18 -0400
Received: (qmail 19336 invoked by uid 107); 5 Oct 2009 18:49:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 14:49:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 14:45:32 -0400
Content-Disposition: inline
In-Reply-To: <20091005063649.GA25040@eideticdew.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129575>

On Mon, Oct 05, 2009 at 08:36:49AM +0200, Petter Urkedal wrote:

> On 2009-10-04, Junio C Hamano wrote:
> > It is a command specific aliasing mechanism; not even I use the feature
> > these days, since "alias.*" is much easier to use.  But there is no strong
> > need to remove it either; it is not too much hassle to keep it for people
> > who do use it.  Perhaps deprecate it and remove it in the long run?
> 
> I didn't know about alias.*.  Excellent.  I'll be using that.

Yeah, showbranch.default really seems pointless now. Especially
confusing is the fact that it doesn't do whitespace-splitting, so you
can't do:

  git config showbranch.default "--topo-order branch1 branch2"

but instead have to set multiple config variables.

I think deprecation makes sense, but I am in no hurry to get rid of it.
I mainly just wouldn't want people to think it was a useful thing to
learn. :)

> The code is slightly nicer to, I think, but you can probably drop "+ 20"
> in the grow-case now.

I think it could actually just be switched to use ALLOC_GROW.

-Peff
