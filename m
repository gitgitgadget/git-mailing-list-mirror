From: Technext <varuag.chhabra@gmail.com>
Subject: =?UTF-8?Q?Identifying_user_who_ran_=E2=80=9Cgit_reset=E2=80=9D_command?=
Date: Fri, 20 Feb 2015 21:46:29 -0700 (MST)
Message-ID: <1424493989740-7625788.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 21 05:46:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP1xj-00067H-6t
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 05:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbbBUEqa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 23:46:30 -0500
Received: from mwork.nabble.com ([162.253.133.43]:60556 "EHLO mwork.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755122AbbBUEqa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 23:46:30 -0500
Received: from mjim.nabble.com (unknown [162.253.133.84])
	by mwork.nabble.com (Postfix) with ESMTP id 808ED14897EE
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 20:46:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264204>

I came across a problem recently. One of the developers committed some
changes in a branch. When he checked the branch log (git checkout branc=
h;
git log), the commit (say, abc) was showing up but when he checked the =
log
for a file (git log <file_name>), which was part of the given commit (a=
bc),
the associated commit (abc) was not showing up; instead, an older commi=
t id
(say, xyz) was there.

When the issue came to my notice, I tried using "git log --follow
<file_name>" to check complete history of a file just to make sure whet=
her
the file was renamed to its current name. The output of "git log --foll=
ow
<file_name>" was actually showing the commit id (abc) that was missing =
in
the output of "git log <file_name>" command. On asking developer whethe=
r the
file was renamed, i came to know that no renames were done ever for tha=
t
file. This was confusing and i was stuck because i was not able to figu=
re
out what happened. Later, it turned out that another developer while pu=
shing
his code encountered merge conflict and instead of resolving it, he sim=
ply
did a "git reset ." and the HEAD got shifted.

Q.1) Is there any way i could have figured out about the "git reset" co=
mmand
that the other developer executed on his machine? FYI, i have admin acc=
ess
to Git.

Q.2) Is there any way we can control such things from happening in futu=
re?
I=E2=80=99m not sure whether this can be controlled using hook because =
this is not a
=E2=80=98push=E2=80=99 command. It's something that's being done just b=
efore push. Please
correct me if I=E2=80=99m mistaken. The biggest problem that I see here=
 is that
every developer has the rights to commit, which I feel is not right. I =
feel,
even restricting it cannot be foolproof but it can certainly bring down=
 such
occurrences significantly. Any suggestions?



--
View this message in context: http://git.661346.n2.nabble.com/Identifyi=
ng-user-who-ran-git-reset-command-tp7625788.html
Sent from the git mailing list archive at Nabble.com.
