From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: [PATCH] gitignore(5): Allow "foo/" in ignore list to match directory
 "foo"
Date: Thu, 31 Jan 2008 13:29:27 +0100
Message-ID: <47A1BF27.7080802@users.sourceforge.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com> <6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com> <alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org> <47A06EF9.60704@users.sourceforge.net> <7vprvjgi9v.fsf@gitster.siamese.dyndns.org> <47A1733E.9040103@users.sourceforge.net> <7vhcgue5nr.fsf_-_@gitster.siamese.dyndns.org> <7v63xae4lf.fsf_-_@gitster.siamese.dyndns.org> <20080131094124.GA25546@coredump.intra.peff.net> <7vfxwecmfe.fsf@gitster.siamese.dyndns.org> <20080131104256.GF25546@coredump.intra.peff.net> <alpine.LSU.1.00.0801311128190.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 31 13:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKYjO-0005rS-KW
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 13:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764684AbYAaMky convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Jan 2008 07:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765352AbYAaMky
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 07:40:54 -0500
Received: from pisces.et.put.poznan.pl ([150.254.29.122]:36944 "EHLO
	pisces.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764684AbYAaMkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 07:40:53 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by pisces.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0VCU3HS018796;
	Thu, 31 Jan 2008 13:30:05 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.74] (pc1074.et.put.poznan.pl [150.254.11.74])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0VCTRD19047;
	Thu, 31 Jan 2008 13:29:28 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <alpine.LSU.1.00.0801311128190.23907@racer.site>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.31.41437
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72130>

* Johannes Schindelin [31 I 2008 12:38]:
> Just to add my two eurocents: I think the patch is complicated enough=
 that=20
> we could go the other way round: while parsing the ignore entries, we=
 can=20
> plainly state that entries with a trailing slash are ignored:
>=20
> -- snipsnap --
> [PATCH] Warn if an ignore/exclude entry ends in a slash
>=20
> Git does not like ignore entries ending in a slash; they will be igno=
red.
> So just be honest and warn the user about it.
>=20
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

I agree that this is a reasonable remedy for this issue. So:

Acked-by: Adam Pi=C4=85tyszek <ediap@users.sourceforge.net>

BTW, the warning message is a bit "hidden" between the "Changed" and=20
"Untracked" parts of a status message, e.g.:

=3D=3D=3D=3D=3D >8 =3D=3D=3D=3D=3D
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   src/Makefile
#       modified:   src/ofdm.cpp
#
warning: Ignoring ignore entry because of trailing slash: results/
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       results/
no changes added to commit (use "git add" and/or "git commit -a")
=3D=3D=3D=3D=3D >8 =3D=3D=3D=3D=3D

Is it possible to make warnings displayed in red or yellow colour on=20
terminals that support colours?

BR,
/Adam


--=20
=2E:.  Adam Piatyszek (ediap)  .:.....................................:=
=2E
=2E:.  ediap@users.sourceforge.net  .:................................:=
=2E
