From: =?UTF-8?B?R3LDqWdvcnkgUm9tw6k=?= <gregory.rome@maxim-ic.com>
Subject: Re: git bisect Vs branch
Date: Fri, 23 Oct 2009 09:09:29 +0200
Organization: Maxim Integrated Products
Message-ID: <4AE156A9.9060809@maxim-ic.com>
References: <4AE07EEB.2010101@maxim-ic.com> <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Oct 23 09:09:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1EHT-0005Ur-44
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 09:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbZJWHJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 03:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbZJWHJ2
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 03:09:28 -0400
Received: from smtp-out03.msg.oleane.net ([62.161.7.1]:36690 "EHLO
	smtp-out03.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZJWHJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 03:09:27 -0400
Received: from smtp02.msg.oleane.net (smtp02.mail.priv [172.17.20.111]) 
	by smtp-out03.msg.oleane.net with ESMTP id n9N79Um5013118
	for <git@vger.kernel.org>; Fri, 23 Oct 2009 09:09:31 +0200
Received: from zebulon.innova-card.com (6-61.252-81.static-ip.oleane.fr [81.252.61.6]) (authenticated)
	by smtp02.msg.oleane.net (MTA) with ESMTP id n9N79T4P022440
	for <git@vger.kernel.org>; Fri, 23 Oct 2009 09:09:30 +0200
X-Oleane-Rep: REPA
Received: from localhost ([127.0.0.1])
	by zebulon.innova-card.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
	for git@vger.kernel.org;
	Fri, 23 Oct 2009 09:09:29 +0200
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <adf1fd3d0910220950s50ccf8efwda891374e6480a30@mail.gmail.com>
X-Spam-Flag: NO
X-PMX-Spam: Probability=8%
X-PFSI-Info: PMX 5.5.5.374460, Antispam-Engine: 2.7.1.369594, Antispam-Data: 2009.10.23.65718 (no antivirus check)
X-Orange-Auth: dG9zbXRwQGZyLm9sZWFuZS5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131094>

Thanks Santi but I have a problem, due to the fact that the commit whic=
h has an=20
impact on my code is in origin/master or first-origin/master

When bisect checkout a commit from those branch I have none of my own=20
modifications... So I can' test if my code is good or bad excepted if I=
 can=20
merge my commits in the bisect branch...
                                                     =E1=90=81
first-origin/master  *---A---------B----------------o------C-
                           \         \                       \
origin/master              ----------B'----------U-----------C'-
                                       \           \           \
master                                 ------------U'----------C''-


I generalized the problem but I can give a real example. My problem con=
cerns an=20
Linux USB driver for MIPS based SoC. first-origin is the official kerne=
l=20
repository and origin/master is the MIPS repository.

Cheers!
Gr=C3=A9gory


Santi B=C3=A9jar wrote:
> On Thu, Oct 22, 2009 at 5:48 PM, Gr=C3=A9gory Rom=C3=A9 <gregory.rome=
@maxim-ic.com> wrote:
>> Considering the following story what is the method to find the regre=
ssion
>> with bisect?
>>
>> I cloned a git repository (origin) which derives from another one
>> (first-origin). A merge is done from first-origin to origin at each =
stable
>> release (identified by a tag).
>>
>> first-origin/master  *---A---------B-----------------------C-
>>                         \         \                       \
>> origin/master              ----------B'----------U-----------C'-
>>                                     \           \           \   mast=
er
>>                           ------------U'----------C''-
>>
>> Now, after that I merged C' I fixed the conflicts and compiled witho=
ut error
>> but I have a regression. It could come from any commit between B and=
 C or U
>> and C', and I need to modify my code to correct the issue.
>>
>> I would like to find the commit which introduce this regression by u=
sing git
>> bisect but as the history is not linear it is not so easy (1). It th=
ough to
>> create a linear history but I have no idea how to proceed...
>=20
> You just have to proceed as normal, but you may test more commits tha=
n
> with a linear history.
>=20
> The only problem is iff the culprit is a merge commit (as in the
> user-manual chapter you linked). And the "problem" is to know where
> exactly in the (merge) commit is the bug, but not the procedure.
>=20
> HTH,
> Santi
