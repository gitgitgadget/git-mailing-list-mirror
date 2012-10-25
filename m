From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] git-pull: Avoid merge-base on detached head
Date: Thu, 25 Oct 2012 05:34:41 -0400
Message-ID: <20121025093441.GH8390@sigill.intra.peff.net>
References: <1351024796-28174-1-git-send-email-hordp@cisco.com>
 <1351024796-28174-2-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 11:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJq5-0006Lc-G9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162Ab2JYJep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:34:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56019 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964920Ab2JYJeo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:34:44 -0400
Received: (qmail 6912 invoked by uid 107); 25 Oct 2012 09:35:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 05:35:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 05:34:41 -0400
Content-Disposition: inline
In-Reply-To: <1351024796-28174-2-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208375>

On Tue, Oct 23, 2012 at 04:39:56PM -0400, Phil Hord wrote:

> git pull --rebase does some clever tricks to find the base
> for $upstream , but it forgets that we may not have any
> branch at all.  When this happens, git merge-base reports its
> "usage" help in the middle of an otherwise successful
> rebase operation, because git-merge is called with one too
> few parameters.
> 
> Since we do not need the merge-base trick in the case of a
> detached HEAD, detect this condition and bypass the clever
> trick and the usage noise.

Makes sense. I notice there is no test with your patch. It sounds from
the description like the operation still may succeed, but we just get
cruft on stderr?

-Peff
