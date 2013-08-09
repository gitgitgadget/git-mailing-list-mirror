From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: git should not use a default user.email config value
Date: Fri, 9 Aug 2013 20:00:49 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1308091956060.28970@herc.mirbsd.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:17:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7t7b-00017D-LI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031021Ab3HIURK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Aug 2013 16:17:10 -0400
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:27211 "EHLO
	herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030954Ab3HIURJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Aug 2013 16:17:09 -0400
X-Greylist: delayed 700 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Aug 2013 16:17:09 EDT
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.5/8.14.5) with ESMTP id r79K0nLH014038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Aug 2013 20:00:53 GMT
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <20130809194214.GV14690@google.com>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232023>

Jonathan Nieder dixit:

>Can you say a little more about your setup?  In a university
>environment with sysadmin-managed email and /etc/mailname set up
>correctly it is handy that people can start working without doing

Ah okay. We don=E2=80=99t have /etc/mailname set up I think and,
additionally, the Unix user name doesn=E2=80=99t match the eMail
localpart, so that won=E2=80=99t work anyway.

Though we=E2=80=99re having a very heterogenous desktop environment
nowadays so I can=E2=80=99t really know all specifics.

At least, I think, most devs seem to use the Unix git client
now, whereas for svn they use the one that comes with Eclipse=E2=80=A6

>I wonder if it's too gentle and long to get the point across.  Would
>something the following (including the guesses in the message for
>easier copy-pasting) help?

Definitely not. It needs to fail hard if user.email is not set,
i.e. refuse to accept the commit.

>is set and not set.  Git already notices the cases where the guessed
>email address ends with ".(none)" and errors out, and it could make
>sense to be more aggressive.

The guessed addresses are like 'denge@pc-bn-041.lan.tarent.de'
instead of 'd.enge@tarent.de' which is the correct Kolab address
(this information can be publicly accessed since the project I
noticed it in is on our public FusionForge instance, so I don=E2=80=99t
think sharing specifics is bad here, but please don=E2=80=99t hammer ou=
r
poor trainee with spam now). So they=E2=80=99re a =E2=80=9Ccorrect=E2=80=
=9D unix username
at a correct FQDN (which, thanks to split-horizon, even would
work internally, except there=E2=80=99s of course no MTA set up) and
won=E2=80=99t be caught by *.(none) matches.

Hope this helps.

Thanks,
//mirabilos
--=20
tarent solutions GmbH
Rochusstra=C3=9Fe 2-4, D-53123 Bonn =E2=80=A2 http://www.tarent.de/
Tel: +49 228 54881-393 =E2=80=A2 Fax: +49 228 54881-314
HRB AG Bonn 5168 =E2=80=A2 USt-ID (VAT): DE122264941
Gesch=C3=A4ftsf=C3=BChrer: Boris Esser, Sebastian Mancke
