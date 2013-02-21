From: Jeff King <peff@peff.net>
Subject: Re: "git branch --contains x y" creates a branch instead of checking
 containment
Date: Thu, 21 Feb 2013 10:58:28 -0500
Message-ID: <20130221155827.GA20640@sigill.intra.peff.net>
References: <51261A6B.5020909@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 16:58:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8YXu-0002Yh-Vw
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 16:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755467Ab3BUP6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 10:58:30 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55509 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754540Ab3BUP6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 10:58:30 -0500
Received: (qmail 27552 invoked by uid 107); 21 Feb 2013 16:00:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 11:00:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 10:58:28 -0500
Content-Disposition: inline
In-Reply-To: <51261A6B.5020909@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216779>

On Thu, Feb 21, 2013 at 02:00:27PM +0100, Per Cederqvist wrote:

> That command does something completely different,
> though. The "--contains x" part is silently ignored,
> so it creates a branch named "y" pointing at HEAD.
> 
> Tested in git 1.8.1.1 and 1.8.1.4.
> 
> In my opinion, there are two ways to fix this:
> 
>  - change the "git branch" implementation so
>    that --contains implies --list.

I think that is the best option, too. In fact, I even wrote a patch. :)

It's d040350 (branch: let branch filters imply --list, 2013-01-31), and
it's already in v1.8.2-rc0.

-Peff
