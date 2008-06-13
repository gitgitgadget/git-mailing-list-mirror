From: =?UTF-8?B?RmxvcmlhbiBLw7ZiZXJsZQ==?= <FloriansKarten@web.de>
Subject: [JGIT PATCH v4] Implementation of fnmatch and the ignore rules
Date: Fri, 13 Jun 2008 20:30:34 +0200
Message-ID: <4852BCCA.4030404@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 20:32:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7E3u-0003MU-IM
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 20:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYFMSaw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbYFMSaw
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 14:30:52 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:57769 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbYFMSav (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 14:30:51 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 53CD8E3F1A0C;
	Fri, 13 Jun 2008 20:30:46 +0200 (CEST)
Received: from [84.150.79.9] (helo=[192.168.1.50])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1K7E2w-00020N-00; Fri, 13 Jun 2008 20:30:46 +0200
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-Enigmail-Version: 0.95.6
X-Sender: FloriansKarten@web.de
X-Provags-ID: V01U2FsdGVkX1+avbsOD2nkZe0oZkSZG6Zg1X+8saldePJmw7Nc
	V4kULB+RvcLoKNcLUDsXfD4U0IVmm0/Zw+JabCQabo8GJYBAAe
	wbPSbKUyhEbRHZlpIgyA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84907>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi

Thanks for the suggestions and comments, the new patches are available =
here:
http://repo.or.cz/w/egit/florian.git?a=3Dshortlog;h=3Drefs/heads/mailin=
glist-patches-4

I will send them as a reply to this email soon.


The most noticeable change is that I improved the fnmatch functionality=
=2E

All character classes of the type [:class:] work now.
Other character classes, including the character classes [=3Dclass=3D] =
and
[.class.] will cause a InvalidPatternException. The last two aren't
supported at my bash neighter, but are defined in the POSIX standard.

Two other implementation differences are:

The bash shell doesn't support the full range of digits, but my
implementatiton does. e.g. =DB=B9 (U+06F9 EXTENDED ARABIC-INDIC DIGIT N=
INE)

A pattern like [[:] results in a InvalidPatternException in my
implementation. The shell has there a strange behavior: if the files "[=
"
and ":" exists then "ls [[:]" shows only ":".


The other main change is that I introduced a AbstractTestCase class
which which offers functionality to create temporary folders.
RepositoryTestCase extends now from this new class.

An other patch reducing the duplication between AbstractTestCase and
RepositoryTestCase class will follow soon, if you like the change.


I also updated all license statements to the 3-clause BSD.

Even if you don't like the last change (the AbstractTestCase change) it
would be cool if you would accept at least some patches.

Best regards,
=46lorian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIUrzK59ca4mzhfxMRAg+XAKDUoEdpil0+qqZ0pgMx/yJYKd2ztwCfe4aI
fqJ25VXnX2RWEay9aH4Np6Y=3D
=3D4i44
-----END PGP SIGNATURE-----
