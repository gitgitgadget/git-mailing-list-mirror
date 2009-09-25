From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git stash list shows timestamp in stead of "stash number",
	when setting date = local for log in config
Date: Fri, 25 Sep 2009 15:29:20 -0700
Message-ID: <20090925222920.GZ14660@spearce.org>
References: <49578b170909150756k3c19912dv28615053a6bd0f7d@mail.gmail.com> <20090924070121.GD24486@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alf Kristian St??yle <alf.kristian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:29:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJIb-0004Dj-Cb
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbZIYW3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 18:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbZIYW3R
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:29:17 -0400
Received: from george.spearce.org ([209.20.77.23]:60481 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbZIYW3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 18:29:16 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2D59838151; Fri, 25 Sep 2009 22:29:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090924070121.GD24486@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129127>

Jeff King <peff@peff.net> wrote:
> On Tue, Sep 15, 2009 at 04:56:41PM +0200, Alf Kristian St??yle wrote:
> > When doing a "git stash list" I get this strange stash record:
> > stash@{Tue Sep 15 16:28:12 2009}: WIP on master: 2262276 ...
> > 
> > I have a global config setting on log:
> > 
> > [log]
> > date = local
> > 
> > If setting the date config to default or removing the setting, the
> > stash record looks correct:
> > stash@{0}: WIP on master: 2262276 ...
> 
> The patch below implements the former. The only downside I can think of
> is if somebody is relying on "log.date" to set the output format for
> reflogs, because they really like the date version better. In that case,
> I think we should wait for them to complain (which I doubt will happen),
> and then add a log.reflogDates config option to appease them.
> 
> Shawn, reflogs are your thing. Any comments?

I agree.  I doubt anyone is relying on log.date to reformat the
output of `git reflog show` or `git stash list`, so this is probably
a reasonable change to make.  Even if they were trying to use that,
its a bug.

Care to wrap this up in a patch?
 
-- 
Shawn.
