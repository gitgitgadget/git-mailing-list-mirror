From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [REGRESSION] git var GIT_EDITOR fails without tty
Date: Mon, 22 Mar 2010 15:59:47 +0100
Message-ID: <20100322145947.GA1709@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 16:00:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntj6i-0001VG-Bs
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0CVO7v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 10:59:51 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59540 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab0CVO7u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 10:59:50 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ntj6b-0002mb-Av; Mon, 22 Mar 2010 15:59:49 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Ntj6Z-000155-BE; Mon, 22 Mar 2010 15:59:47 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142937>

Hello,

since b4479f074760a788dd4e353b8c86a7d735afc53e git send-email (and
others) use git var GIT_EDITOR.  This is OK as such but it breaks the
post-receive hooks that I use on several repositories.

When called they don't have a tty, and this makes git var fail:

	user@host:~$ ssh localhost "git var GIT_EDITOR"
	fatal: Terminal is dumb, but EDITOR unset

IMHO git send-email should only call $(git var GIT_EDITOR) when it
actually needs it.

(Note I'm using the Debian packaged version of git.  I don't think this
problem is Debian specific, I didn't check though.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
