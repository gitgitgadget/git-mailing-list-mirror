From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] git-pull: Avoid merge-base on detached head
Date: Fri, 26 Oct 2012 08:48:10 -0400
Message-ID: <20121026124810.GC1455@sigill.intra.peff.net>
References: <1351024796-28174-1-git-send-email-hordp@cisco.com>
 <1351024796-28174-2-git-send-email-hordp@cisco.com>
 <20121025093441.GH8390@sigill.intra.peff.net>
 <508989FD.7090101@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 14:49:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRjMJ-0002gd-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 14:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700Ab2JZMsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 08:48:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37800 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932591Ab2JZMsN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 08:48:13 -0400
Received: (qmail 22198 invoked by uid 107); 26 Oct 2012 12:48:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Oct 2012 08:48:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2012 08:48:10 -0400
Content-Disposition: inline
In-Reply-To: <508989FD.7090101@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208437>

On Thu, Oct 25, 2012 at 02:50:37PM -0400, Phil Hord wrote:

> >> git pull --rebase does some clever tricks to find the base
> >> for $upstream , but it forgets that we may not have any
> >> branch at all.  When this happens, git merge-base reports its
> >> "usage" help in the middle of an otherwise successful
> >> rebase operation, because git-merge is called with one too
> >> few parameters.
> >>
> >> Since we do not need the merge-base trick in the case of a
> >> detached HEAD, detect this condition and bypass the clever
> >> trick and the usage noise.
> > Makes sense. I notice there is no test with your patch. It sounds from
> > the description like the operation still may succeed, but we just get
> > cruft on stderr?
> >
> 
> Yes, that's correct.

OK. I'd rather not worry about a test then, as it would necessarily be
flaky with respect to what git-pull might generate on its stderr. I've
queued your patch in 'next'.

Thanks.

-Peff
