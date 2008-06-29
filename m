From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 13/13] Build in merge
Date: Sun, 29 Jun 2008 10:11:13 +0200
Organization: At home
Message-ID: <g47g31$6ca$1@ger.gmane.org>
References: <20080628023355.GH2058@genesis.frugalware.org> <ed4b7f44474d6b9398fb0752740ede264bea25b2.1214620551.git.vmiklos@frugalware.org> <7vprq0fzum.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 29 10:12:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCs1R-0002rR-LO
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 10:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYF2ILd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jun 2008 04:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbYF2ILc
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 04:11:32 -0400
Received: from main.gmane.org ([80.91.229.2]:40388 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbYF2ILa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 04:11:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KCs0M-0002On-Aj
	for git@vger.kernel.org; Sun, 29 Jun 2008 08:11:26 +0000
Received: from abvq210.neoplus.adsl.tpnet.pl ([83.8.214.210])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 08:11:26 +0000
Received: from jnareb by abvq210.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 08:11:26 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq210.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86785>

Junio C Hamano wrote:
> Miklos Vajna <vmiklos@frugalware.org> writes:

>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (!remote_head)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0die(=
"%s - not something we can merge", argv[0]);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0update_ref("initial pull", "=
HEAD", remote_head->sha1, NULL, 0,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0DIE_ON_ERR);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0reset_hard(remote_head->sha1=
, 0);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
>=20
> Makes one wonder reset_hard() (aka "read-tree --reset -u HEAD") ever =
fail
> and return here (iow, without calling die()). =A0The answer is luckil=
y no
> in this case, but it is somewhat unnerving to reviewers.

Do we have some guidelines on how to mark such non-returning calls,
or how to mark unreachable code (splint, formerly lclint, uses for
this /*@ unreachable @*/ annotation)?
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
