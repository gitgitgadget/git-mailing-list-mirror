From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: [BUG?] git checkout $commit -- somedir doesn't drop files
Date: Tue, 17 Sep 2013 21:06:59 +0200
Message-ID: <20130917190659.GA15588@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 21:07:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM0c8-0000G6-B6
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371Ab3IQTHB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 15:07:01 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51094 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab3IQTHA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 15:07:00 -0400
Received: from dude.hi.pengutronix.de ([2001:6f8:1178:2:21e:67ff:fe11:9c5c])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1VM0bz-0002OE-Vz
	for git@vger.kernel.org; Tue, 17 Sep 2013 21:06:59 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1VM0bz-000520-Ur
	for git@vger.kernel.org; Tue, 17 Sep 2013 21:06:59 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:21e:67ff:fe11:9c5c
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234903>

Hello,

after these commands:

	$ git init
	$ mkdir subdir
	$ echo a > subdir/a
	$ git add subdir/a
	$ git commit -m a
	$ echo more a >> subdir/a
	$ echo b > subdir/b
	$ git add subdir/*
	$ git commit -m b
	$ git checkout HEAD^ -- subdir

I'd expect that subdir/b is removed from the index as this file didn't
exist in HEAD^ but git-status only reports:

	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	modified:   subdir/a
	#

Is this intended?

(I'm using git 1.8.4.rc3 as shipped by Debian (package version
1:1.8.4~rc3-1).)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
