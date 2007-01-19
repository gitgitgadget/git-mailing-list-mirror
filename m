From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Decoding git show-branch output
Date: Fri, 19 Jan 2007 23:17:19 +0100
Organization: At home
Message-ID: <eorg06$f1o$1@sea.gmane.org>
References: <17840.50115.999227.260259@lisa.zopyra.com> <8aa486160701190613j6493daccofc259a8b17c0f1d1@mail.gmail.com> <17841.13791.627478.602602@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Jan 19 23:17:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H822h-0003bW-Ei
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 23:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXASWQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 17:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbXASWQ4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 17:16:56 -0500
Received: from main.gmane.org ([80.91.229.2]:41665 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964939AbXASWQz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 17:16:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H822T-0005VH-T9
	for git@vger.kernel.org; Fri, 19 Jan 2007 23:16:49 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 23:16:49 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 19 Jan 2007 23:16:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37208>

[Cc: git@vger.kernel.org]

Bill Lear wrote:

> I'm not sure if this is sane: is it ok to clone the company repo,
> then push from that clone into a bare repo, then from there to
> the company one? =A0Is git doing some sort of weird, silent pseudo-me=
rge
> that we don't understand, thus generated what appears to be a very
> tangled, albeit brief, history, when we examine it?

It is quite sane, I think, to use bare repositories as "gateways".
=20
> I have read about 8 documents on git, experimented with it
> extensively, and, at our company, I am arguably the "git expert"; I
> thought that I had done all of my work on my local repo's master
> branch, and only pushed from that branch up to our company repo. =A0Y=
et,
> qgit shows that one of my first commits (to fix a few simply typos in
> documentation) goes off onto another branch. =A0git-show-branch shows
> "[master~3^2~9] Fix a few typos" for this. =A0I'm very confused how t=
his
> could have happened, and I want to ensure we are doing things in a wa=
y
> that is predictable...

Nether push nor fetch does do merges. What can do merges (if not in
fast-forward case, i.e. in case where only one side did any changes), i=
s
pull (but it doesn;t do this silently). I suspect that pulling from
different repositories (probably into different tracking branches, or
without use of tracking branches) might be the culprit.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
