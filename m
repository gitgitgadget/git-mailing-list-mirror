From: Dietmar Winkler <dietmarw@gmx.de>
Subject: [Bug] %[a|c]d placeholder does not respect --date= option in combination
 with git archive
Date: Thu, 03 Mar 2011 10:30:16 +0100
Message-ID: <4D6F5FA8.5030105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 10:30:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pv4rk-0003uU-Qj
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 10:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab1CCJa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 04:30:26 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:34232 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756636Ab1CCJaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 04:30:21 -0500
Received: (qmail invoked by alias); 03 Mar 2011 09:30:18 -0000
Received: from pc88180.hit.no (EHLO [128.39.88.180]) [128.39.88.180]
  by mail.gmx.net (mp016) with SMTP; 03 Mar 2011 10:30:18 +0100
X-Authenticated: #223389
X-Provags-ID: V01U2FsdGVkX18Fq95wEaMF57R0c6qUqjQDiP7j2zO6QN4PC8Vxpb
	k1dDnVuKHTwrIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.1.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168384>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It seems like that the place holders %ad and %cd do not respect the
- --date= option when used as part of the export substitution.

In my file I have the place holder $Format:%ad$ and in .git/config the
setting log.date = short is present.

I can very this the date setting by running
	git log --pretty=format:%ad
and I get:
2011-03-03
2011-02-28
2011-02-28
2011-02-28
2011-02-28


Now if I run on the same repo
	git archive --format=zip HEAD -o out.zip
and check the place holder in the exported zip file it is actually
replaced with:

Thu, 3 Mar 2011 10:06:43 +0100

and not

2011-03-03

The same happens with the place holder %cd

/Dietmar/


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iJwEAQECAAYFAk1vX6gACgkQCXG8gXafJGFfHwQApYJ/y0bS0D97fMKGjjBjjZQv
sOrPbwxIaPII2RGeRqxlQLjDL2kYnXHObTor+3rLWbNHLXPjjPw/2r4YIeCxz/f+
vA8ro9o4dTAyvGiUc/xUhu/U4XaVuV4Rl3QX83oaGmuefHRGc5/esex4R4mnzVdW
QBPVvqqs25gyiu7zV6s=
=lVtM
-----END PGP SIGNATURE-----
