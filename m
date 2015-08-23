From: Jeff King <peff@peff.net>
Subject: Re: List tags for a certain branch
Date: Sun, 23 Aug 2015 14:58:23 -0400
Message-ID: <20150823185822.GA8005@sigill.intra.peff.net>
References: <20150823170751.GA24194@sigill.intra.peff.net>
 <0322fd40-7473-4faa-840f-8be27f555435@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: CoDEmanX <codemanx@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 20:58:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTaTO-0001Gr-87
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 20:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728AbbHWS60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 14:58:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:48793 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752430AbbHWS6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 14:58:25 -0400
Received: (qmail 4669 invoked by uid 102); 23 Aug 2015 18:58:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 13:58:25 -0500
Received: (qmail 16795 invoked by uid 107); 23 Aug 2015 18:58:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 14:58:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Aug 2015 14:58:23 -0400
Content-Disposition: inline
In-Reply-To: <0322fd40-7473-4faa-840f-8be27f555435@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276423>

On Sun, Aug 23, 2015 at 08:06:39PM +0200, CoDEmanX wrote:

> > in a future version of git you should be able to do "git tag 
> --merged" to get the tags that are "merged" to a particular branch. 
> 
> Would it return every tag in the branch, even if it was created in
> that branch, and not merged from somewhere else? If no, than it's not
> what I am looking for. 
> 
> (Or more precisely: would it give a list of all tags, that point to
> commits present in the specified branch, regardless of whether these
> commits were originally done in that branch or merged from another
> branch? I hope my understanding of git is correct here...)

Yes, it would show all tags that are present in the history leading up
to that branch tip[1]. Git tracks a DAG of the history; it does not
remember "which branch" a particular action happened on.

-Peff

[1] Actually the argument to "--merged" does not need to be a branch at
    all. It is really a commit, so you could specify a tag, an extended
    sha-1 expression, etc.
