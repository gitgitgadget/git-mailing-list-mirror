From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Advice on strategy for "temporary" commits
Date: Fri, 09 Mar 2007 11:15:01 +0100
Organization: At home
Message-ID: <esrbub$bg$1@sea.gmane.org>
References: <e1dab3980703080639i4c553e89nb931c2aea45b023b@mail.gmail.com> <20070308163239.GH22713@fieldses.org> <e1dab3980703080907v58739287p18bc2797db7d209e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 09 11:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPc5b-00084a-Pt
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 11:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993099AbXCIKMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 9 Mar 2007 05:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993101AbXCIKMj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 05:12:39 -0500
Received: from main.gmane.org ([80.91.229.2]:48908 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993099AbXCIKMi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 05:12:38 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HPc5U-0000yc-V7
	for git@vger.kernel.org; Fri, 09 Mar 2007 11:12:36 +0100
Received: from host-81-190-29-212.torun.mm.pl ([81.190.29.212])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 11:12:36 +0100
Received: from jnareb by host-81-190-29-212.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Mar 2007 11:12:36 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-212.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41793>

[Cc: git@vger.kernel.org]

David Tweed wrote:

> So, at this point I need to ask an embarassingly basic
> question: how do I "change branches" from T (say), in order to commit
> to a different branch A, without changing the contents of
> the working directory back to match what it was at the
> time of the last commit to A?
[...]]
> So I'm on the temporary branch and have been doing
> temporary commits to it and we hit an hour mark.
> Cron wants to commit what's _currently_ in my working
> directory as a new head to the "archival branch" A
> and then swap back the temporary branch to
> commit it on that branch and carry on, ie, make
> the diagram look like:
>=20
> a-----------a-----------a-----------a
> =A0\ =A0 =A0 =A0 =A0 =A0$ =A0 =A0 =A0 =A0 =A0 $ =A0 =A0 =A0 =A0 =A0 $
> =A0 \-t---t---t---t---t---t---t---t---t
>=20
> AIUI neither git-branch nor git-checkout provide
> a way to do this. (Clearly the git datastructures
> can represent this situation, I'm just not sure how
> to ask the tools to do it.)

Try if "git checkout -m" does what you wanted. Or simply
do a merge of "more often" branch into "less often" branch,
perhaps simply not recording it as a merge with=20
"git merge --squash" followed by "git commit".

By the way, you know that you can --amend a commit?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
