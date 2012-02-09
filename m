From: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: ANNOUNCE: Git for Windows 1.7.9
Date: Thu, 09 Feb 2012 14:25:46 +0100
Message-ID: <4F33C95A.10006@atlas-elektronik.com>
References: <OF7242D083.08C458C8-ONC125799F.0043D7D2-C125799F.0047B5A4@dcon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>,
	Pat Thoyts <patthoyts@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Feb 09 14:25:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvU0R-00014v-PJ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 14:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab2BINZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 08:25:43 -0500
Received: from mail96.atlas.de ([194.156.172.86]:11681 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2BINZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 08:25:42 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id 4D67910076;
	Thu,  9 Feb 2012 14:25:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id V76-MDVoRp4a; Thu,  9 Feb 2012 14:25:39 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu,  9 Feb 2012 14:25:38 +0100 (CET)
Received: from [10.200.54.97] (as112671.atlas.de [10.200.54.97])
	by mgsrv01.atlas.de (Postfix) with ESMTP id C26982716A;
	Thu,  9 Feb 2012 14:25:38 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <OF7242D083.08C458C8-ONC125799F.0043D7D2-C125799F.0047B5A4@dcon.de>
X-Enigmail-Version: 1.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190290>

Am 09.02.2012 14:00, schrieb karsten.blees@dcon.de:
> Stefan N=E4we <stefan.naewe@atlas-elektronik.com> wrote on 09.02.2012=
=20
> 09:11:03:
>=20
>> Am 09.02.2012 08:45, schrieb Stefan N=E4we:
>>> Am 01.02.2012 12:23, schrieb Pat Thoyts:
>>>> This release brings the latest release of Git to Windows users.
>>>>
>>>> Pre-built installers are available from
>>>> http://code.google.com/p/msysgit/downloads/list
>>>>
>>>> Further details about the Git for Windows project are at
>>>> http://code.google.com/p/msysgit/
>>>
>>> I'm getting errors from 'git repack -Ad' with this version on Windo=
ws=20
> XP:
>>>
>>> $ /bin/git repack -Ad
>>> Counting objects: 147960, done.
>>> Delta compression using up to 2 threads.
>>> Compressing objects: 100% (35552/35552), done.
>>> Writing objects: 100% (147960/147960), done.
>>> Total 147960 (delta 110699), reused 147960 (delta 110699)
>>> Deletion of directory '.git/objects/01/' failed. Should I try again=
?=20
> (y/n)
>>> Deletion of directory '.git/objects/05/' failed. Should I try again=
?=20
> (y/n) n
>>> Deletion of directory '.git/objects/07/' failed. Should I try again=
?=20
> (y/n) n
>>> Deletion of directory '.git/objects/0c/' failed. Should I try again=
?=20
> (y/n) n
>>> Deletion of directory '.git/objects/10/' failed. Should I try again=
?=20
> (y/n)
>>> ....
>>>
>>>
>>> A bisection pointed me to this commit (https://github.
>> com/msysgit/git/commit/19d1e75):
>>>
>>>  "Win32: Unicode file name support (except dirent)"
>>>
>>> When I reset "/git" to this commit and recompile, 'git gc' and=20
>> 'git repack -Ad'
>>
>>   s/this commit/parent of this commit (c5d4ecfe)/
>>
>=20
> c5d4ecfe just adds unicode conversion functions without using them=20
> anywhere, so I doubt that this commit has anything to do with the err=
or.

Right. But the commit that comes after it: 19d1e75

> Besides, that code was merged only this week, so its not even in the=20
> pre-built v1.7.9 installer.

I built the installer myself.
=20
> Have you checked virus scanners or other background jobs that might k=
eep=20
> the directories open?

I tried that on a physical machine with an on-access virus scanner
enabled and disabled, and also on a virtual machine (VirtualBox) with
no virus scanner installed. Makes no difference.

I also used "Process Explorer" (www.sysinternals.com) to find any
other process that might have the directory open, but there wasn't any.
If you know any other tools for that, let me know.

Regards,
  Stefan
--=20
----------------------------------------------------------------
/dev/random says: Aren't cats just widdle furry balls of love?
python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6=
e696b2e636f6d'.decode('hex')"
