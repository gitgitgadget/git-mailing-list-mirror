From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: accessing oldest reflog entry with ref@{N}?
Date: Wed, 19 Jun 2013 14:50:59 +0200
Message-ID: <20130619125059.GD20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 19 14:51:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpHqu-0000QU-5C
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 14:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab3FSMvD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Jun 2013 08:51:03 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:51004 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427Ab3FSMvB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 08:51:01 -0400
Received: from localhost6.localdomain6 (e179060230.adsl.alicedsl.de [85.179.60.230])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LsNui-1U9NXA1VMW-012GHW; Wed, 19 Jun 2013 14:51:00 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:uSv482lOlK1q3JK2GcY78AdIIfNH12G4Vj9fyYUoK+Q
 Rvy9e6boyItgtLG1o8hdZrj4gEn5N/HVqrIrrB1Hy3Gvm3Vks0
 4mDzF21XtLSjHOm2ymeRhnG+5vM+H9/C//aQTQJUW8ns2TZNDj
 G5fpjpWVp4nc5eCldCxF6T2kEWw8OQKZBbCDueauOgwOg8nWZY
 EEKS/C8j7P/Zpjz4U97mKqF6Z7jKAP9SLtPGggT1y6d+Dzo8i1
 zRmNJ10PDhfrh6imd7jtVhTyrYhwbLp2h+xLtjpTcYs9za/reY
 c5dIrR/pUPmZWYZ73We60IlTVAzrQotIQIQzNuYPCT8yIMZ5g7
 5JBmlJ+URnnr06rPgDas3mCBe3mV8XEWwRyhgW6pX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228394>

Hi,

after a couple of months of inactivity I recently updated my git clone
from the main repo, and later ran 'git gc', which, of course,
dutifully pruned the old reflog entries, leaving my reflogs quite
shallow:

$ git reflog master
0dbd8125 master@{0}: merge origin/master: Fast-forward
f3828dc0

Then later I had to access the previous state, which I usually do with
master@{1}, but not this time:

$ git log --oneline -1 master@{1}
fatal: Log for 'master' only has 1 entries.

Annoyed, I just copy-pasted the sha and got the job done.

However, I wonder why it didn't worked.  'git reflog' didn't print
master@{1} or any message for the oldest entry, but I can live without
that.  The sha is undoubtedly there, however, so git should know where
master@{1} points and should "Just Work", shouldn't it?


Thanks,
G=E1bor
