From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC 2/2] Automatically transform .git/{branches,remotes} into .git/config
Date: Mon, 28 Nov 2005 16:03:54 +0100
Message-ID: <200511281603.54433.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511211455120.13775@wbgn013.biozentrum.uni-wuerzburg.de> <200511281359.04741.Josef.Weidendorfer@gmx.de> <20051128134808.GQ22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Nov 28 16:05:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgkY3-0006l1-CC
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 16:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVK1PD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 10:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbVK1PD7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 10:03:59 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:2969 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1750781AbVK1PD6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 10:03:58 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 1766E2888;
	Mon, 28 Nov 2005 16:03:57 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <20051128134808.GQ22159@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12886>

On Monday 28 November 2005 14:48, Petr Baudis wrote:
> Dear diary, on Mon, Nov 28, 2005 at 01:59:04PM CET, I got a letter
> where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> > (2) project config (in .git/project.conf)
> 
> What are you going to keep in it? There isn't much of stuff which is not
> per-user or per-instance. I can't think of anything now, but there is no
> list of configuration variables to check yet.

Project global configurations could be:
- .git/info
- .git/hooks
- default for encoding of commit messages
- relationship of public project branches (perhaps access rights)
- project description, maintainers, public branch descriptions
- central repository URL
- ...

> (Upstream maintainer email is interesting, OTOH it alone doesn't seem to
> justify the mechanism by itself; also, the upstreams may be different
> based on where you cloned the project from, etc.)

Hmm.. this even could be seen as another level: origin specific

> > For (2), git-clone should copy some files, e.g. the .git/project.conf
> > or .git/info/exclude. But project config probably should be kept
> > up to date among all repositories for a project, i.e. it should be
> > version controlled itself, but independent from the project.
> > We could use a project config head .git/refs/projectconfig for this;
> > of course post-1.0 material.
> 
> If you still want per-project config, why should it be independent from
> the project? Actually, like you have .gitignore, having something like
> .gitconfig

That doesn't work well with configuration which should be global to the
whole history of the original project, e.g. .git/info/exclude, or maintainer
information.

> in project root would be by far the simplest - if you want 
> separate head, your merging and stuff gets quite more complicated, as
> well as actually branching the project config, etc.

Project configuration probably always should be up to date, so:
* always update when fetching/pulling project branches
* always push when pushing project branches

Josef
