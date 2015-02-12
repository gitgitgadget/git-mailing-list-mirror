From: Jeff King <peff@peff.net>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 07:12:58 -0500
Message-ID: <20150212121258.GA28801@peff.net>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
 <20150212092824.GA19626@peff.net>
 <54DC9014.1010200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org,
	Fabian Ruch <bafain@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLsdv-0007O4-5k
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 13:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbbBLMND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 07:13:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:48153 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755288AbbBLMNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 07:13:01 -0500
Received: (qmail 11578 invoked by uid 102); 12 Feb 2015 12:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 06:13:02 -0600
Received: (qmail 24266 invoked by uid 107); 12 Feb 2015 12:13:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 12 Feb 2015 07:13:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2015 07:12:58 -0500
Content-Disposition: inline
In-Reply-To: <54DC9014.1010200@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263732>

On Thu, Feb 12, 2015 at 12:35:48PM +0100, Michael Haggerty wrote:

> > I assume you are already munging in your editor the template provided by
> > "git commit" after the squash? What would be really nice, IMHO, is if
> > there was a way to set the author during that edit (e.g., by moving one
> > of the "Author:" lines to the top of the file). That would cover your
> > use case, I think, and would also be useful in general.
> 
> If only Git supported options on todo list lines [1], this could be
> implemented via a "--use-author" option:
> 
>     pick --use-author 1234556 blah
>     squash 84392ab etc
>     fixup 49106a5 another
> 
> Happily, this would work with fixup, too, without forcing the user to go
> into the editor. Also, it wouldn't require metadata to be read in-band
> from the commit message.

Yes, that would be nice, but I don't think David is using a sequencer
todo list here at all. It's just:

  git merge --squash pr/100
  git commit

-Peff
