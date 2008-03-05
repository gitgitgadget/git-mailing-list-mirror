From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: [fast-import] LF after reset not optional
Date: Wed, 5 Mar 2008 22:07:15 +0100
Message-ID: <20080305210715.GA10686@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 22:27:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX18y-0002z9-BO
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999AbYCEV0m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2008 16:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613AbYCEV0m
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:26:42 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:32838
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbYCEV0l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Mar 2008 16:26:41 -0500
X-Greylist: delayed 1155 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2008 16:26:41 EST
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id A58FA333E4
	for <git@vger.kernel.org>; Wed,  5 Mar 2008 22:07:19 +0100 (CET)
Received: from userid 1000 by plumber with local (Exim 4.69) 
	  id 1JX0pX-0002o9-Te
	  for git@vger.kernel.org; Wed, 05 Mar 2008 22:07:15 +0100
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76270>

Hello.

Maybe I'm doing something wrong, but I can't get the "reset" command to
work as advertised in git-fast-import(1), without an extra LF at the
end.

This input:

-8<-
commit refs/heads/master
mark :1
committer Joe R. Developer <joe@random.com> 1204726629 +0100
data <<EOF
=46irst commit.
EOF
M 644 inline foo.txt
data <<EOF
Hello, world!
EOF
reset refs/tags/tag1
from :1
reset refs/tags/tag2
from :1
-8<-

fails with:

  fatal: Unsupported command: from :1

Adding an extra LF before the second reset fixes the issue. I tested
this issue seems to present in the "next" branch in addition to 1.5.4.3=
=2E

Cheers,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- I couldn't find anything in there for days. I kept reaching in for
  strawberries and coming up with liver -- that's not pleasant.
- I promise not to touch the fridge again.
                -- Sookie and Lorelai

