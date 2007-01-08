From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Mon, 8 Jan 2007 08:17:35 -0500
Message-ID: <20070108131735.GA2647@coredump.intra.peff.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 14:17:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3uNh-0000mX-Fz
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 14:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXAHNRi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 08:17:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbXAHNRi
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 08:17:38 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1478 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751517AbXAHNRi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 08:17:38 -0500
Received: (qmail 785 invoked from network); 8 Jan 2007 08:17:48 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 8 Jan 2007 08:17:48 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Jan 2007 08:17:35 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36254>

On Mon, Jan 08, 2007 at 03:19:48AM -0800, Junio C Hamano wrote:

> I decided to fast-track this one.  With a handful fix-ups, this
> is now at the tip of 'next'.

I haven't seen the code, waiting for kernel.org to mirror, but I have a
question...

> The primary difference from the one we discussed, and then has
> been sitting in 'pu', is that coming back from the detached HEAD
> state is allowed only with '-f' or to a branch that is a
> fast-forward of HEAD.

Hrm. So does that mean this doesn't work (without -f):

  git checkout v1.4.0
  ... look around ...
  git checkout v1.2.0

I think a better (but more expensive) check would be "coming back from
the detached HEAD is allowed only with '-f' or if HEAD is an ancestor
of any non-HEAD ref."

-Peff
