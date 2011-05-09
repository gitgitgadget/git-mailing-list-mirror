From: Jeff King <peff@peff.net>
Subject: Re: Separate default remotes for pulling and pushing
Date: Mon, 9 May 2011 18:06:38 -0400
Message-ID: <20110509220638.GB3719@sigill.intra.peff.net>
References: <1FDDE878-C81A-4318-836B-7F8BED51A981@gmail.com>
 <BANLkTinJDUa7sXjKHo81bG7KbnspxZ88oA@mail.gmail.com>
 <20110509081708.GA5871@sigill.intra.peff.net>
 <D0FA0C3F-8DA8-4607-A0A6-F9AFAB3EC3CE@gmail.com>
 <20110509111019.GD9060@sigill.intra.peff.net>
 <53DAF1E7-9906-4BF4-A64B-FE16BF5977F5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: David Lee <davidomundo@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:06:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJYbQ-0006eE-PE
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 00:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309Ab1EIWGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 18:06:41 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46157
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932286Ab1EIWGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 18:06:40 -0400
Received: (qmail 12733 invoked by uid 107); 9 May 2011 22:08:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 18:08:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 18:06:38 -0400
Content-Disposition: inline
In-Reply-To: <53DAF1E7-9906-4BF4-A64B-FE16BF5977F5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173270>

On Mon, May 09, 2011 at 12:01:53PM -0700, David Lee wrote:

> > But now we have precedence questions. If I have config like:
> > 
> >  [push]
> >    defaultRemote = my-mirror
> > 
> >  [branch "foo"]
> >    remote = origin
> >    merge = refs/heads/master
> > 
> > which remote should be the default for "git push"? Obviously if I'm not
> > on "foo", it should be my-mirror. But if I am, should push.defaultRemote
> > take precedence? Should there also be a branch.*.pushRemote config that
> > takes precedence over branch.*.remote?
> > 
> > I have to admit that I have never found the branch.*.remote config to be
> > useful for any of my workflows, so I am not really sure how people use
> > it.
> 
> What about removing the branch.*.remote config by default, and if it's
> not set, then it defaults to whatever the repo-wide setting is for
> defaultRemote? Then a branch.*.remote would override the
> defaultRemote, and a branch.*.pushRemote would again override that.

The branch.*.remote config does much more, though. For example, it is
part of the "upstream" branch config. So getting rid of it is definitely
not an option.

-Peff
