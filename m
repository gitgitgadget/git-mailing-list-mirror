From: Ben Clifford <benc@hawaga.org.uk>
Subject: current HEAD in bash prompt
Date: Thu, 17 Nov 2005 18:39:49 +1000
Message-ID: <9C44605A-4F0F-42FA-A8ED-A4F7EFA24C32@hawaga.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Nov 18 05:45:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecy4i-0004Ne-3i
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKREmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 Nov 2005 23:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVKREmJ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:42:09 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:25609 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1750707AbVKREmI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 23:42:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jAI4efsW005048;
	Fri, 18 Nov 2005 04:40:45 GMT
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12197>

After getting a bit confused when having too many branches, and for =20
people who don't mind extra forks and like too much info in their =20
prompt, I've recently started using this:

export PS1=3D'!\! [\j] \u@\h:\w$(output-git-head-or-blank)\$ '

where output-git-head-or-blank is:

#!/bin/bash

PS_GIT=3D$(git-symbolic-ref HEAD 2>/dev/null) && echo "[$(basename =20
$PS_GIT)]" && exit

# else output nothing


When in a non-git directory, you get a non-git prompt (of course, =20
modify this to whatever you want)

!502 [0] benc@piva:~$

and when in a git directory you get (a truncated form of) whatever =20
today's head points at:


!502 [0] benc@piva:~$ cd src/globe
!503 [0] benc@piva:~/src/globe[master]$


--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
