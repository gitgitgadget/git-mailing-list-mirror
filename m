From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range
	completion
Date: Mon, 14 Jul 2008 08:47:19 +0200
Message-ID: <20080714064719.GA26446@atjola.homenet>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:48:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHrD-0004zR-7P
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbYGNGrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbYGNGrY
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:47:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:58849 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753532AbYGNGrY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:47:24 -0400
Received: (qmail invoked by alias); 14 Jul 2008 06:47:21 -0000
Received: from i577BB7AC.versanet.de (EHLO atjola.local) [87.123.183.172]
  by mail.gmx.net (mp008) with SMTP; 14 Jul 2008 08:47:21 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18KhJRgbEcKDM+EeUrL8aZlz8pvgHnRaNuzTlxRpH
	tXcAPlver/1A3K
Content-Disposition: inline
In-Reply-To: <20080714062755.GA15992@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88386>

On 2008.07.14 06:27:55 +0000, Shawn O. Pearce wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
> > > >=20
> > > > Does it fix this one too:
> > > >=20
> > > > 	git show origin/pu:Makef<tab>
> > > >=20
> > > > which totally screws up and becomes
> > > >=20
> > > > 	git show Makefile
> > > >=20
> > > > dropping the version specifier?
>=20
> What is $COMP_WORDBREAKS set to in your shell?  In mine it
> appears to be:
>=20
> 	" \"'@><=3D;|&(:"
>=20
> which is the I believe the shell default.
>=20
> Bj=F6rn Steinbrink (doener on #git) is running bash 3.2.39 from
> Debian and has the same setting, and the completion works correctly
> there too.  He reports that removing : from COMP_WORDBREAKS will
> get the behavior you are reporting as broken.
>=20
> I have to say, this sounds to me like you (or some package on your
> system) modified COMP_WORDBREAKS away from the default that other
> distributions use and that is what is breaking us here.  Since we
> can have only one setting for this variable in the shell I do not
> thing it would be a good idea for our completion package to force
> a specific setting upon the user.

Seems that gvfs comes with a completion script that deliberately drops
the : from COMP_WORDBREAKS. Do you have that installed Linus?

Bj=F6rn
