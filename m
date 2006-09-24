From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Fixes git-cherry algorithmic flaws
Date: Sun, 24 Sep 2006 21:25:17 +0200
Organization: At home
Message-ID: <ef6m2g$cnk$1@sea.gmane.org>
References: <Pine.LNX.4.58.0608071328200.22971@kivilampi-30.cs.helsinki.fi> <20060924000051.GI20017@pasky.or.cz> <7virjem3tp.fsf@assigned-by-dhcp.cox.net> <20060924111737.GL20017@pasky.or.cz> <7vodt59mxa.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0609242104080.32175@kivilampi-30.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Sep 24 21:25:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRZbb-0000eY-KU
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 21:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWIXTZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 24 Sep 2006 15:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWIXTZd
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 15:25:33 -0400
Received: from main.gmane.org ([80.91.229.2]:39907 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750994AbWIXTZc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 15:25:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GRZbL-0000cY-Vx
	for git@vger.kernel.org; Sun, 24 Sep 2006 21:25:20 +0200
Received: from host-81-190-26-109.torun.mm.pl ([81.190.26.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 21:25:19 +0200
Received: from jnareb by host-81-190-26-109.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 24 Sep 2006 21:25:19 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-109.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27691>

Ilpo J=E4rvinen wrote:

> On Sun, 24 Sep 2006, Junio C Hamano wrote:

>> I wonder if we can kill it by introducing a new rev notation and
>> using regular rev-list family of commands instead.
>>=20
>> What we want here is a way to say "give me commits that are in B
>> but not in A, but before returning a commit see if there is an
>> equivalent change in the set of commits that are in A but not in
>> B, and filter it out".
>=20
> I think that your formalization is very close to what I was expecting=
 to=20
> get (sort of one-way definition)... However, my git-cherry way produc=
es=20
> "difference" but on a higher level (than git-diff) since it includes =
both=20
> + and - "changes". Of course, when I have then modified one of the=20
> changesets slightly, I have different patch id, and thus + and - with=
 same=20
> log message (with verbose), which IMHO is a good thing to notice,=20
> especially if I return to the work after 2 weeks or so :-). =20
>=20
> A real life example: In a branch, I have changed tcp_packets_in_fligh=
t=20
> (~10 callers) to input sk instead of tp in a single changeset and >10=
=20
> minor changesets. I would love to see tcp_packets_in_fligth change=20
> information just once when doing diffing topic-old topic-new during c=
herry=20
> picking, instead of a lengthy diff full of search-and-replace "noise"=
,=20
> which increases possiblity of an human error...
>=20
> But anyway, I'm not claiming that your approach is less useful...

+1 on an idea that git-cherry is "diff of logs". Perhaps to add some he=
ader.
Of course use patch_ids _and_ the commit message to compare (we can hav=
e
both match, patch id match only, commit message match only, and commit
title (first line) match only), but that can be selected using options.=
=20
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
