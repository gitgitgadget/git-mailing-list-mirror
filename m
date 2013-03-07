From: Jeff King <peff@peff.net>
Subject: Re: fetch --no-tags with and w/o --all
Date: Wed, 6 Mar 2013 19:20:38 -0500
Message-ID: <20130307002038.GA31571@sigill.intra.peff.net>
References: <1879950.i2j8pjGADy@gandalf>
 <7vboawp4zy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Cristian Tibirna <ctibirna@giref.ulaval.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 01:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDOa2-0003yd-Rl
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 01:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab3CGAUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 19:20:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38623 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754830Ab3CGAUk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 19:20:40 -0500
Received: (qmail 32155 invoked by uid 107); 7 Mar 2013 00:22:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 19:22:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 19:20:38 -0500
Content-Disposition: inline
In-Reply-To: <7vboawp4zy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217563>

On Wed, Mar 06, 2013 at 01:56:01PM -0800, Junio C Hamano wrote:

> Cristian Tibirna <ctibirna@giref.ulaval.ca> writes:
> 
> > Hello
> >
> > $ git --version
> > git version 1.7.10.4
> >
> > $ git fetch origin --no-tags
> > does what it says
> >
> > $ git fetch --all --no-tags
> > still gets all the tags from the remote.
> >
> > Is this known?
> 
> Because --all (or --multiple) to iterate through all remotes
> does not pass accept any command line refspecs, using these options
> with --no-tags and/or --tags should be diagnosed as an error, but it
> appears that the error checking is not done.

Or we could just pass them through. Looks like this was already fixed by
8556646 (fetch --all: pass --tags/--no-tags through to each remote,
2012-09-05), which is in v1.7.12.2 and higher.

-Peff
