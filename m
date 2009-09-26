From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how optparse can go horribly wrong
Date: Sat, 26 Sep 2009 12:25:27 -0700
Message-ID: <20090926192527.GF14660@spearce.org>
References: <20090925233226.GC14660@spearce.org> <20090926015127.GA12994@vidovic> <fabb9a1e0909260644w781d3c3h4fca22e3b7d97768@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 21:25:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrcti-0004eF-5l
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 21:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbZIZTZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZIZTZY
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 15:25:24 -0400
Received: from george.spearce.org ([209.20.77.23]:49609 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427AbZIZTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 15:25:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C256B38151; Sat, 26 Sep 2009 19:25:27 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0909260644w781d3c3h4fca22e3b7d97768@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129168>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Sat, Sep 26, 2009 at 03:51, Nicolas Sebrecht <nicolas.s.dev@gmx.fr> wrote:
> > Doing this only to -m flag would break consistency. That said, I don't
> > have any opinion in disallowing the sticked form for _all_ short
> > options.
> 
> Perhaps instead disallow it for short options that do not take a
> one-symbol argument, that is -n4 makes a lot of sense to me, but -m"my
> commit message here" not so much.

-1 on that, because long, long, long ago when I worked on -m support
for commit I remember insisting that -mfoo and -m foo should be
the same.  I often do `git commit -a -mwip` or something to save my
branch state and come back later.

What I think we should do is not allow cuddling of short options
when the final option takes more than 1 character worth of argument.
Thus `git commit -a -mfoo` is OK, but `git commit -amfoo` is not.

-- 
Shawn.
