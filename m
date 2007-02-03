From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t9200 still failing...
Date: Sat, 3 Feb 2007 10:56:13 -0500
Message-ID: <DBACB5AE-7C40-4D44-85BB-76F30BE96E36@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 16:56:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDNFU-0003vo-Cd
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 16:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946299AbXBCP4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Feb 2007 10:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946478AbXBCP4Q
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Feb 2007 10:56:16 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:35062 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946299AbXBCP4P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Feb 2007 10:56:15 -0500
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 0A2A61FFD0EE
	for <git@vger.kernel.org>; Sat,  3 Feb 2007 15:56:14 +0000 (UTC)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38567>

I got sidetracked by work and buying a house, so I didn't get to =20
mention it at the time the attempted fix was committed, but t/t9200-=20
git-cvsexportcommit.sh still is failing on test 8, even in latest =20
master.  I'm still getting the message about a file being in =20
my .gitignore:

> The following paths are ignored by one of your .gitignore files:
> =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5/=E4/=F6=
/=20
> g=E5rdets=E5g=E5rdet.txt
> Use -f if you really want to add them.

What I don't understand is that there are no .gitignore files in the =20
test repo and the .git/info/exclude file only has comments.  This =20
seems like it might actually be a subtle bug in git-add, although I'm =20
betting it's more OS X filesystem oddness.  I'm trying to look into =20
it, but thought that maybe someone with more experience with the code =20
might catch it first.

Things I've discovered:
- A "git status" appropriately shows =C5 as untracked.
- Terminal.app seems to ignore attempts to type =C5.
- Using "git add . && git commit" by hand in the test repo seems to =20
work (using git version 1.5.0.rc2.g73a2)

~~ Brian
