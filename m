From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sun, 10 Sep 2006 11:49:13 +0200
Organization: At home
Message-ID: <ee0n1g$7jj$1@sea.gmane.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <Pine.LNX.4.64.0609081944060.27779@g5.osdl.org> <17666.13716.401727.601933@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0609082054560.27779@g5.osdl.org> <e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com> <Pine.LNX.4.64.0609091022360.27779@g5.osdl.org> <e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com> <Pine.LNX.4.64.0609091256110.27779@g5.osdl.org> <e5bfff550609092049t5e016cacr2502ce81bbb6489e@mail.gmail.com> <7vpse4uzos.fsf@assigned-by-dhcp.cox.net> <e5bfff550609092123t1d8b6c70s5750fbb787534812@mail.gmail.com> <7virjwuxrz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 10 11:49:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMLw1-0004I2-09
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 11:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWIJJs4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Sep 2006 05:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWIJJs4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 05:48:56 -0400
Received: from main.gmane.org ([80.91.229.2]:2245 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750839AbWIJJsz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 05:48:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMLvj-0004DR-17
	for git@vger.kernel.org; Sun, 10 Sep 2006 11:48:47 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 11:48:47 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 11:48:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26789>

Junio C Hamano wrote:

> I am starting to suspect that introducing "generation" header to
> the commit objects might actually be a very good thing. =A0For
> one thing, rev-list will automatically get the topology always
> right if we did so.
>=20
> We obviously need to update 'convert-objects' and tell everybody
> that they need to rewrite their history if we take this route.
> That kind of flag-day conversion used to be an Ok thing to do,
> but it is getting harder and harder these days for obvious
> reasons, though.

Wouldn't it be possible to have not that more complex code if some
of the commit objects (newer) would have "generation" header, and some
of them (older) wouldn't have it? Git would use generation header if it=
 is
present, and current heuristic timestamp based code if it is not presen=
t.

It would be better of course if the new commits have correct "generatio=
n"
header, so insertion of "new" commit after "old" commit would have some
extra overhead...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
