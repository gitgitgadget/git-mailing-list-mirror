From: "Klishevich, Yauheni" <yklishevich@scnsoft.com>
Subject: read-tree bug
Date: Tue, 6 May 2014 12:35:27 +0000
Message-ID: <CF8EB1C1.996%yklishevich@scnsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 06 19:47:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQY-0008Bg-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757461AbaEFMfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2014 08:35:50 -0400
Received: from mail4.scnsoft.com ([93.171.207.9]:17644 "EHLO mail2.scnsoft.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756459AbaEFMfr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 08:35:47 -0400
Received: from SRV-SCN-MBX2.scnsoft.com (10.20.1.84) by
 srv-scn-mbx1.scnsoft.com (10.20.1.83) with Microsoft SMTP Server (TLS) id
 15.0.775.38; Tue, 6 May 2014 15:35:28 +0300
Received: from SRV-SCN-MBX2.scnsoft.com ([fe80::e1f5:7334:ca34:3ec1]) by
 srv-scn-mbx2.scnsoft.com ([fe80::e1f5:7334:ca34:3ec1%14]) with mapi id
 15.00.0775.031; Tue, 6 May 2014 15:35:28 +0300
Thread-Topic: read-tree bug
Thread-Index: AQHPaSeoIWkS6oy84UubKFhYuyGk0w==
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.2.58]
Content-ID: <EA5C38C7C79B1E4E9C7C6BD9C85948B9@scnsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248191>

Hello!

I have some troubles with git command =B3read-tree=B2.

I have big project and I try to add shared library to subdirectory. So =
I
made the following in my project (on master)

git remote add git@bitbucket.org:ijin1984/groundwork.git
git fetch groundwork
git checkout =ADb gwbranch groundwork/master
git checkout master
git read-tree --prefix=3Dmb/trunk/src/ru.uralsib.dbo.client.iphone/libs=
/ -u
gwbranch
git commit =ADm =B3add groundwork to libs=B2
After that I make small change in one file inside libs (for example in
"mb/trunk/src/ru.uralsib.dbo.client.iphone/libs/groundwork/notes.txt=B2=
 and
commit with=20
git commit =ADa =ADm =B3test commit=B2

Then I made:=20
git checkout gwbranch
git merge --squash -s subtree --no-commit master

And after this instead of merging I find the whole main project in subd=
ir
=B3groundwork/Groundwork/Base.lproj=B2.

If I do the 5-th command with =8Bprefix option value equal to for examp=
le
=B3libs=B2 tether than something like =B3subdir/subsubdir/=8A/libs=B2 -=
 all works
fine.

I think that it is bag, because I experimented quite a lot with deferre=
nt
values. I think that problem in directory name with dots, i.e.
"ru.uralsib.dbo.client.iphone=B2.

Could you please help me with this issue. If you need to add some more
info about this case I will provide.

Thanks in advance.


Best regards,=20
Eugene Klishevich
iOS-developer
skype: eugene.klishevich
