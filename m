From: Duane Murphy <duanemurphy@mac.com>
Subject: Re: git p4 diff-tree ambiguous argument error
Date: Thu, 10 Jul 2014 11:08:59 -0700
Message-ID: <4EECAC73-DACA-4C0F-AE97-944F0DEE490B@mac.com>
References: <1405013428825-7614774.post@n2.nabble.com>
 <53BED67D.8080006@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 21:09:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Jih-0000RR-J9
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 21:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089AbaGJTJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jul 2014 15:09:23 -0400
Received: from st11p02mm-asmtpout002.mac.com ([17.172.220.237]:63900 "EHLO
	st11p02mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813AbaGJTJX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 15:09:23 -0400
X-Greylist: delayed 3617 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jul 2014 15:09:23 EDT
Received: from [192.168.1.26]
 (70-36-184-217.dsl.static.sonic.net [70.36.184.217])
 by st11p02mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.10(7.0.4.27.9) 64bit (built Jun
  6 2014)) with ESMTPSA id <0N8I0063CD30Q320@st11p02mm-asmtp002.mac.com> for
 git@vger.kernel.org; Thu, 10 Jul 2014 18:09:02 +0000 (GMT)
In-reply-to: <53BED67D.8080006@diamand.org>
X-Mailer: Apple Mail (2.1878.6)
X-MANTSH: 1TEIXWV4bG1oaGkdHB0lGUkdDRl5PWBoaHxEKTEMXGx0EGx0YBBIZBBsTEBseGh8
	aEQpYTRdLEQptfhcaEQpMWRcbGhsbEQpZSRcRClleF2hjeREKQ04XSxseGmJCHx1SHhN9GXhzB
	xxrGxIaExgeEQpFQxcWHm9vaWtpHRkHbmtpawceaRpsB2tvEx0HEx4ebBpub28eExpoakdLSQR
	JRUcUEQpYXBcZBBoEGx4HTU4cExoaHRMFGx0EGx0YBBIZBBsTEBseGh8bEQpeWRdhE2JecBEKT
	EYXYmtrEQpDWhcdGgQZHAQbEh4EGBsdEQpEWBcYEQpESRcbEQpCRRdhWkJ9cltDR2UYRREKQk4
	XaEZCQB9IeR1HH2QRCkJMF2FBeGF7SElTGVh5EQpCbBd6f05jAUh4RVJfQxEKQkAXZm1vTV5LT
	mF6WmQRCnBoF2lCTh9sU3pCW0JnEQpwaBdhZl9iTRMbaWUYTREKcGgXa2IYG0Jyfn5tXU4RCnB
	oF2VHWkJaWUQTGGRTEQpwaBdgBVlTGHNDHnBBGhEKcGwXYlAfW1tLYV1/ZXARCnBMF2lzGWBye
	HhJfR9oEQ==
X-CLX-Spam: false
X-CLX-Score: 1011
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.12.52,1.0.14,0.0.0000
 definitions=2014-07-10_07:2014-07-10,2014-07-10,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=15 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1402240000 definitions=main-1407100203
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253198>

All local storage.

 =85Duane

On Jul 10, 2014, at 11:07 AM, Luke Diamand <luke@diamand.org> wrote:

> Is this using NFS, or local storage?
>=20
>=20
>=20
> On 10/07/14 18:30, Bill Door wrote:
>> $ git p4 sync --detect-branches --import-labels //main@all
>> ... Lots of useful information elided
>> fatal: ambiguous argument 'git-p4-tmp/8031': unknown revision or pat=
h not in
>> the working tree.
>> Use '--' to separate paths from revisions, like this:
>> 'git <command> [<revision>...] -- [<file>...]'
>> Command failed: ['git', 'diff-tree',
>> '6b3ef26a3e2635a5ff0170e15fdadb386672f8b9', 'git-p4-tmp/8031']
>>=20
>> If I re-run the command, it works the second time. Of course there a=
re
>> 73000+ commits. This is gonna take a while.
>>=20
>> I've done some debugging. It appears there is a timing problem betwe=
en
>> git-p4 and git.
>>=20
>> The failure occurs in P4Sync.searchParent(). Even though a checkpoin=
t is
>> sent to git (for fast-import) just prior to the call to searchParent=
() in
>> importChanges(), the file does not yet exist. I used pdb, paused the=
 program
>> just before the call to diff-tree and the file was missing. After th=
e
>> program exits due to the error the file exists (i.e. the OS flushed =
the
>> file). This is why re-running continues to work, there is an "old" f=
ile with
>> basically the same information laying around (dangerous).
>>=20
>> How can I get git (fast-import) to flush the file at the right time?
>>=20
>> $ git --version
>> git version 1.7.12.4
>> $ python --version
>> Python 2.6.6
>> OS: GNU/Linux 2.6.32-431.el6.x86_64
>>=20
>>=20
>>=20
>>=20
>> --
>> View this message in context: http://git.661346.n2.nabble.com/git-p4=
-diff-tree-ambiguous-argument-error-tp7614774.html
>> Sent from the git mailing list archive at Nabble.com.
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>=20
