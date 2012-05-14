From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Update "gc" behavior in commit, merge, am, rebase and
 index-pack
Date: Mon, 14 May 2012 16:11:01 -0400
Message-ID: <20120514201100.GA3740@sigill.intra.peff.net>
References: <1336810134-3103-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.02.1205121326380.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon May 14 22:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SU1bp-0001ZD-D3
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 22:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273Ab2ENULE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 16:11:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43042
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932227Ab2ENULD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2012 16:11:03 -0400
Received: (qmail 24710 invoked by uid 107); 14 May 2012 20:11:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 May 2012 16:11:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 May 2012 16:11:01 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1205121326380.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197806>

On Sat, May 12, 2012 at 01:36:28PM -0400, Nicolas Pitre wrote:

> > Instead, we could just inform users that "gc" should be run soon in
> > commonly used commands (this patch also reinstates "gc" check in
> > commit, which was lost at the sh->C conversion). [1] and [2] can annoy
> > users constantly with warnings. This patch shows the warning at most
> > once a day.
> 
> I agree with this.  However don't bother making this once a day.  There 
> is no harm in warning every time.

I don't mind seeing a warning every time I run "git commit" myself, but
aren't there things which run "merge" and "commit" in a loop? For
example, "git rebase -m"? Warning 20 times when 20 commits are rebased
seems excessive.

-Peff
