From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Fri, 17 Apr 2009 07:54:14 -0400
Message-ID: <20090417115414.GA29121@coredump.intra.peff.net>
References: <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de> <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net> <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de> <20090416083443.GA27399@coredump.intra.peff.net> <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de> <20090416094154.GA30479@coredump.intra.peff.net> <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Keith Cascio <keith@CS.UCLA.EDU>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 13:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lumfl-0003lM-JO
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 13:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679AbZDQLyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 07:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756247AbZDQLyW
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 07:54:22 -0400
Received: from peff.net ([208.65.91.99]:56346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495AbZDQLyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 07:54:22 -0400
Received: (qmail 15349 invoked by uid 107); 17 Apr 2009 11:54:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Apr 2009 07:54:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2009 07:54:14 -0400
Content-Disposition: inline
In-Reply-To: <7v4owok0bh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116732>

On Thu, Apr 16, 2009 at 09:52:50AM -0700, Junio C Hamano wrote:

> > Right now, I think we are safe. A few options like "--default" do take a
> > separated string argument, but saying "--default --no-defaults" seems a
> > little crazy to me (besides being confusing because they are talking
> > about two totally unrelated defaults).
> 
> Maybe you guys have already considered and discarded this as too hacky,
> but isn't it the easiest to explain and code to declare --no-defaults is
> acceptable only at the beginning?

I discarded that as "too hacky". If I had to choose my poison between
"insane string options don't work" and "option must inexplicably be at
the front", I think I take the former. It is perhaps a more difficult
rule to realize you are triggering, but it is much less likely to come
up in practice.

But I think all of this is just ending up in the same place that Keith
and I arrived at much earlier in the thread: you _are_ choosing a
poison, and his patch was meant to avoid that. The question is whether
the added code complexity is worth it.

-Peff
