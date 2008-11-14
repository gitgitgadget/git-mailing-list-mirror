From: Francis Galiegue <fg@one2team.com>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 20:09:51 +0100
Organization: One2team
Message-ID: <200811142009.51803.fg@one2team.com>
References: <1226647174-15844-1-git-send-email-sam@vilain.net> <1226655681.17731.4.camel@maia.lan> <7vfxlu9lhs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>, Francis Galiegue <fge@one2team.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L145u-00086L-Df
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 20:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbYKNTLV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2008 14:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbYKNTLU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 14:11:20 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:47484 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754AbYKNTLU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 14:11:20 -0500
Received: from smtp.olympe.o2t (138.193.65-86.rev.gaoland.net [86.65.193.138])
	by ns35774.ovh.net (Postfix) with ESMTP id F050D92C002;
	Fri, 14 Nov 2008 20:11:08 +0100 (CET)
Received: from erwin.kitchen.eel (unknown [10.8.0.6])
	by smtp.olympe.o2t (Postfix) with ESMTP id 893E17001F;
	Fri, 14 Nov 2008 20:11:18 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vfxlu9lhs.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101003>

Le Friday 14 November 2008 20:05:19 Junio C Hamano, vous avez =E9crit=A0=
:
[...]
> >  	fd =3D mkstemp(buffer);
> > -	if (fd < 0 && dirlen && (errno !=3D EPERM)) {
> > +	if (fd < 0 && dirlen && (errno !=3D EACCESS)) {
>
> Is this accepting the two as equivalents???
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Well, looking at mkdir(2), it says:

       EPERM  The file system containing pathname does not support the=20
creation of directories.

Hmm, err... git would fail at an earlier point anyway, wouldn't it? Eve=
n git=20
init would fail there.

--=20
=46rancis Galiegue
ONE2TEAM
Ing=E9nieur syst=E8me
Mob : +33 (0) 6 83 87 78 75
Tel : +33 (0) 1 78 94 55 52
fge@one2team.com
40 avenue Raymond Poincar=E9
75116 Paris
