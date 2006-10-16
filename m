From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many changes
Date: Mon, 16 Oct 2006 22:29:57 +0200
Organization: At home
Message-ID: <eh0q39$mb$1@sea.gmane.org>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org> <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com> <87ejt8p5l9.fsf@rho.meyering.net> <Pine.LNX.4.64.0610161038200.3962@g5.osdl.org> <Pine.LNX.4.64.0610161109430.7697@alien.or.mcafeemobile.com> <Pine.LNX.4.64.0610161130090.3962@g5.osdl.org> <Pine.LNX.4.64.0610161225470.7697@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Oct 16 22:30:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZZ6C-0004Bn-PH
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 22:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbWJPUaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 16 Oct 2006 16:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422888AbWJPUaH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 16:30:07 -0400
Received: from main.gmane.org ([80.91.229.2]:10978 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422891AbWJPUaG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 16:30:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZZ5s-00045A-2k
	for git@vger.kernel.org; Mon, 16 Oct 2006 22:29:52 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 22:29:52 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 16 Oct 2006 22:29:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28987>

Davide Libenzi wrote:

> I ended up using this one:
>=20
> #define XDL_HASHLONG(v, b) ((((unsigned long) (v) >> ((CHAR_BIT *
sizeof(unsigned long)) - (b))) + \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned lon=
g) (v)) & ((1UL << (b)) - 1))
>=20
> The GR_PRIME selection does not make me feel good, and the 'static in=
line'=20
> is puked-over by certain C compilers. It'd be probably fine to just u=
se a=20
> simple function, though the above should work just fine.
>=20
> real =A0 =A00m0.665s
> user =A0 =A00m0.655s
> sys =A0 =A0 0m0.010s
>=20
> (Opteron 252)

Could you please do and post benchmarks for other solutions?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
