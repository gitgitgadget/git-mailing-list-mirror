From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] git-cvsimport.perl: use human readable names for option values
Date: Mon, 3 Nov 2008 11:32:20 +0100
Organization: One2team
Message-ID: <200811031132.20590.fg@one2team.com>
References: <200811031031.59196.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 11:34:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwwll-0001lr-2B
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 11:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991AbYKCKdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 05:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbYKCKdf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 05:33:35 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:41121 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947AbYKCKde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 05:33:34 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id 40B1C92C011
	for <git@vger.kernel.org>; Mon,  3 Nov 2008 11:33:28 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id AA6C57001F
	for <git@vger.kernel.org>; Mon,  3 Nov 2008 11:33:32 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200811031031.59196.fg@one2team.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99930>

Le Monday 03 November 2008 10:31:59 Francis Galiegue, vous avez =E9crit=
=A0:
> Hello,
>
> As I am keen to make my company use git eventually, but they have a r=
eally,
> really messy CVS tree that git-cvs*.perl cannot handle right now, I'v=
e
> decided to have a serious look at the code.
>

As stated in one mail I sent earlier on, the real problem is that=20
git-cvsimport won't detect empty branches for two reasons:

* it relies on cvsps output, which doesn't tell about it either;
* however, it doesn't make use of another file that cvsps generates in=20
$HOME/.cvsps by default, which can help about giving this information.

I'll try the following:

* instead of capturing cvsps output directly, I'll use its -p option, w=
hich=20
has the advantage of generating one file per patchset;
* I'll consolidate the information of the other generated file in a has=
h and=20
correlate the information found in there with the individual patchset: =
my=20
hope is that I'll be able to detect so-far undetected branches and crea=
te=20
them.

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
