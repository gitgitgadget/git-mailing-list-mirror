From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 02 Feb 2007 17:09:47 +0100
Organization: At home
Message-ID: <epvnln$fmn$1@sea.gmane.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: mercurial@selenic.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 17:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD0xs-0003sf-Nu
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 17:08:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945958AbXBBQIh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 11:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945959AbXBBQIh
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 11:08:37 -0500
Received: from main.gmane.org ([80.91.229.2]:33347 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945958AbXBBQIh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 11:08:37 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HD0xj-0005ln-RY
	for git@vger.kernel.org; Fri, 02 Feb 2007 17:08:31 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 17:08:31 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 17:08:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git,gmane.comp.version-control.mercurial.general
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38508>

Mark Wooding wrote:

> Jakub Narebski <jnareb@gmail.com> wrote:
> 
>> BTW does Mercurial have tags?
> 
> Yes.  Mercurial stores tags in text files, one per line, mapping the tag
> name to a SHA1 hash of the tagged revision.  There are two files of
> tags: `local' tags go into .hg/tags (or somesuch) and don't get copied
> by clone; global tags go into .hgtags and do get copied (of course,
> since they're part of the source tree).

Gaaah. Why anyone would want to have non-propagated tags?

Do I understand correctly that Mercurial doesn't have annotated tags
(this also means that it doesn't have PGP/GPG signed tags), and only
equivalent of git lightweight tags?
 
> If I may be opinionated for a bit: this is barking for two reasons:
> 
>   * The tags files grow by having lines added to the bottom.  Files of
>     this kind are almost ideal for causing merge conflicts, and there's
>     no automatic means for resolving them.  (I actually wrote a custom
>     tags merger recently -- if anyone wants it, just mail me.)

Such a merger (merge strategy) would be also useful for other log-like
files, e.g. ChangeLogs and such.

>   * If I visit a tag, and then decide I want to visit some other, more
>     recent tag, I'm screwed because it obviously didn't exist in that
>     old revision.  Tying tags to the revision history in this way is
>     truly daft.

In git tags are direct or indirect (via tag object, creating annotated
tag) pointers to points in revision history (in DAG of commits). Well,
you can tag any object, which is used for example in git.git to store
out-of-tree junio GPG key used to sign release tags.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
