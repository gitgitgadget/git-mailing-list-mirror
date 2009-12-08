From: walter harms <wharms@bfs.de>
Subject: Re: help: bisect single file from repos
Date: Tue, 08 Dec 2009 14:41:42 +0100
Message-ID: <4B1E5796.2090201@bfs.de>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net> <4B1D27B6.7010900@bfs.de> <200912080917.17220.chriscool@tuxfamily.org>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 14:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI0KY-00081f-3z
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 14:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129AbZLHNlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Dec 2009 08:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755069AbZLHNlu
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 08:41:50 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:51853 "EHLO mx.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966AbZLHNlt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 08:41:49 -0500
Received: from mail.sz.bfs.de (mail.sz.bfs.de [192.168.0.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx.sz.bfs.de (BfS Mail Relay SZ) with ESMTP
	id 291AC288AD1; Tue,  8 Dec 2009 14:41:55 +0100 (CET)
Received: from localhost (unknown [192.168.2.47])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id 005D4E38EA;
	Tue,  8 Dec 2009 14:41:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bfs.de
Received: from mail.sz.bfs.de ([192.168.2.193])
	by localhost (amavis-sz.sz.bfs.de [192.168.2.47]) (amavisd-new, port 10024)
	with ESMTP id YYL7LfIihhcp; Tue,  8 Dec 2009 14:41:44 +0100 (CET)
Received: from dc-slave2-fr.fr.bfs.de (unknown [10.177.18.200])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id E4519E38FA;
	Tue,  8 Dec 2009 14:41:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 78F2ADB26D;
	Tue,  8 Dec 2009 14:41:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 45E9FDB261;
	Tue,  8 Dec 2009 14:41:43 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at fr.bfs.de
Received: from dc-slave2-fr.fr.bfs.de ([127.0.0.1])
	by localhost (dc-slave2-fr.fr.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1fM4cLcmxIso; Tue,  8 Dec 2009 14:41:42 +0100 (CET)
Received: from [134.92.181.33] (unknown [134.92.181.33])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id C9A24DB260;
	Tue,  8 Dec 2009 14:41:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <200912080917.17220.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134870>



Christian Couder schrieb:
> Hi,
>=20
> On lundi 07 d=C3=A9cembre 2009, walter harms wrote:
>> Michael J Gruber schrieb:
>>> walter harms venit, vidit, dixit 07.12.2009 13:59:
>>>> Hi list,
>>>> i am new to git (using: git version 1.6.0.2).
>>> though your git is not that new ;)
>>>
>>>> I would like to bisect a single file but i have only commit id, no
>>>> tags.
>>>>
>>>> Background:
>>>> I have a copy of the busybox git repos, and i know there is (perha=
ps)
>>>> a bug in ash.c.
>>>>
>>>> how can i do that ?
>>> You don't need any tags for bisecting. The man page of git-bisect h=
as
>>> several examples on how to use it. Do you have a test script which
>>> exposes the bug?
>> unfortunately no, the error shows up very nicely when booting my
>> embdedded system but not else (this is the reason i would to bisect =
that
>> file only and not busybox completely). And from the man pages i got =
the
>> impression that it is only possible the start with a tag.
>=20
> The man page says:
>=20
> git bisect start [<bad> [<good>...]] [--] [<paths>...]
>=20
> and then:
>=20
> "This command uses git rev-list --bisect to help drive the binary sea=
rch=20
> process to find which change introduced a bug, given an old "good" co=
mmit=20
> object name and a later "bad" commit object name."


i am sorry, i am not familiar with git and when i am stating i am looki=
ng
for examples first. the examples in my man page are like
git bisect start v2.6.20-rc6 v2.6.20-rc4
there is nothing like:
git bisect start 6a87a68a6a8 65a76a8a68a7

I ASSUME that you can use tags like "v2.6.20-rc6" and commit-id like "6=
a87a68a6a8"
interchangeable but that was not clear from beginning.
BTW did you notice the sentence says "commit object name" not "commit i=
d" ? when
you are starting you are not familiar with the wording so you do not ma=
ke the connection.


>> i already had the hint that i need to do:
>> git bisect start bad_commit_id good_commit_id -- ash.c
>=20
> So did you try that?
>=20

not yet, we are still using an older version of BB for production. So t=
here is no hurry.
The problem is that we can not found the reason for the bug. NTL i plan=
 for this week.


>> Ntl, there is one more question, how can i make sure that
>> i use the right version ?
>=20
> If you mean the right git version, then I think any 1.6.X should be e=
nough.
>=20
>> first i toughed  that cherry-pick is the right=20
>> idea but it seems that that will apply onyl certain patches ?
>=20
> If you want to find the commit that introduced a bug, then you should=
 not=20
> need cherry-pick.
>=20

mmh, no, the idea was to use something like

git "checkou" <id>  and having a version that represents THAT moment.


re,
 wh

> Regards,
> Christian.
>=20
