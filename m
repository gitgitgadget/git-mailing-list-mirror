From: Bill Priest <priestwilliaml@yahoo.com>
Subject: git svn dcommit -n rebuilds revmap w/ 1.5.4.rc0.1187.gc1e8d
Date: Wed, 19 Dec 2007 11:04:40 -0800 (PST)
Message-ID: <784879.48443.qm@web55007.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 19 20:06:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J54E6-0006AL-4p
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 20:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbXLSTEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 14:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbXLSTEm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 14:04:42 -0500
Received: from web55007.mail.re4.yahoo.com ([206.190.58.141]:23950 "HELO
	web55007.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751715AbXLSTEm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 14:04:42 -0500
Received: (qmail 48515 invoked by uid 60001); 19 Dec 2007 19:04:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=JKVISQF0n+vXSV0dOI3j/2Tx645ohai0Fe3HZQ5ulVwbqB+8zbbNq6AdxfZN4QSU1deTUNpREOe6WlD59CrpAFlSUlgVpok2VVwjPK6aW+OJFlZB9021dpbd4NomQCNCwrh/oiYI3wxmePuJ+1pvlX2zrHEx4kFMqcbMKMpRCRw=;
X-YMail-OSG: Vjxo0UQVM1mo5DGggJ1dFe_0YZ0pndjFVSkil8kOtIO6kJGPyvtsrI4GQRe9xfKXuWQRkiMUuMvbjzgWVOAi4DoMLwZuW.1sh9o7gCs2IIpPUnO8rFjyfprZYnphDg--
Received: from [12.44.137.148] by web55007.mail.re4.yahoo.com via HTTP; Wed, 19 Dec 2007 11:04:40 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68931>

All,
  I had been experiencing commit slow downs (> 15
seconds) so I decided to test it out on 1.5.4.rc0.  I
use committed a file and it too ~5 seconds which is
slower than it used to be but much better (I'll need
to do an apples to apples test to quantify it better;
e.g. check in the same file w/ a repository in the
same state).  In the course of using 1.5.4.rc0 I did a
git svn dcommit -n and observed the following:

> git svn dcommit -n
Rebuilding
.git/svn/mss_release_2.1B3/.rev_map.59aec714-b326-0410-a24e-830352df6fdd
...
r2918 = 992aa04a75fffdbdb65bae815905f96d5e3ef6bd
r2920 = e68e7f5aead05fc9e7a151e95f43b8283b0ed670
Done rebuilding
.git/svn/mss_release_2.1B3/.rev_map.59aec714-b326-0410-a24e-830352df6fdd
Committing to
svn://lucille/var/lib/svnrepos/svnMSS/branches/mss_release_2.1B3
...
diff-tree b7cc4c3d32478277c1cdf13e3abdc9dd4a225826~1
b7cc4c3d32478277c1cdf13e3abdc9dd4a225826
diff-tree 0bbb656391f5a888d07c98ccce01a4c753ef4997~1
0bbb656391f5a888d07c98ccce01a4c753ef4997
> git svn dcommit -n
Committing to
svn://lucille/var/lib/svnrepos/svnMSS/branches/mss_release_2.1B3
...
diff-tree b7cc4c3d32478277c1cdf13e3abdc9dd4a225826~1
b7cc4c3d32478277c1cdf13e3abdc9dd4a225826
diff-tree 0bbb656391f5a888d07c98ccce01a4c753ef4997~1
0bbb656391f5a888d07c98ccce01a4c753ef4997
> git --version
git version 1.5.4.rc0.1187.gc1e8d

Notice the Rebuilding doesn't seem to be honoring the
-n "dry run" switch.

I'm not sure of the implications.  Is this something
that I should worry about the .revmap being out of
sync w/ what has actually been dcommit'ed?

Bill
PS.  The new path relative status is nice.



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ 
