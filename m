From: Andreas Ericsson <ae@op5.se>
Subject: Re: Rebase a whole tree from one commit to another?
Date: Sat, 16 May 2009 09:35:33 +0200
Message-ID: <4A0E6CC5.5090503@op5.se>
References: <4A0DC4CD.1030401@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat May 16 09:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5ERm-0006tf-Oq
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 09:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbZEPHfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 May 2009 03:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbZEPHfg
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 03:35:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:17988 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbZEPHfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 03:35:36 -0400
Received: by fg-out-1718.google.com with SMTP id 16so818073fgg.17
        for <git@vger.kernel.org>; Sat, 16 May 2009 00:35:36 -0700 (PDT)
Received: by 10.86.59.2 with SMTP id h2mr4540007fga.30.1242459336334;
        Sat, 16 May 2009 00:35:36 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.163.94])
        by mx.google.com with ESMTPS id e11sm727404fga.16.2009.05.16.00.35.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 16 May 2009 00:35:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A0DC4CD.1030401@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119341>

Dirk S=FCsserott wrote:
> Hi alltogether.
>=20
> Let's say I have the following history:
>=20
>     | | | | branch-c
>     | | | |
>     | | |/  branch-b
>     | | |
>     | |/    branch-a
>     | |
>     |/
>     | master
>=20
> Now I checkout master, do some changes, and commit them to the master=
=20
> branch. Let's call that new-master:
>=20
>    | new-master
>    | | | | | branch-c
>    | | | | |
>    | | | |/  branch-b
>    | | | |
>    | | |/    branch-a
>    | | |
>    | |/
>     \| master
>=20
> I want to rebase my branches a, b, c to the new master. The clumsy wa=
y=20
> would be:
>=20
>     git rebase new-master branch-a
>     git rebase branch-a   branch-b
>     git rebase branch-b   branch-c
>=20
> The question is: Is there a way to rebase the whole tree (master ->=20
> branch-a -> branch-b -> branch-c) from master to new-master with a=20
> single command?
>=20

No. You could merge all the branches that forked from master, rebase
the merged branch to new-master and then undo the merge-commit though,
but that would still mean three commands (and most likely some
conflict resolution). Assuming you have (a lot) more than three
branches, this might be a way forward for you.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
