From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 19:10:35 +0200
Organization: At home
Message-ID: <e06hts$1ne$1@sea.gmane.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org> <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Mar 26 19:10:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNYlJ-00082H-PY
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 19:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWCZRKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Mar 2006 12:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbWCZRKm
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 12:10:42 -0500
Received: from main.gmane.org ([80.91.229.2]:55732 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751178AbWCZRKm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 12:10:42 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FNYlC-000815-EB
	for git@vger.kernel.org; Sun, 26 Mar 2006 19:10:38 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 19:10:38 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 26 Mar 2006 19:10:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18047>

Linus Torvalds wrote:

> On Sun, 26 Mar 2006, Jakub Narebski wrote:
>>
>> I wonder what is the most common case in Linux kernel or git.
>>=20
>> 1.) renaming the file in the same directory, old-file.c to new-file.=
c?
>> 2.) moving file to other directory (project reorganization),=20
>>=C2=A0=C2=A0=C2=A0=C2=A0 old-dir/file.c=C2=A0to=C2=A0new-dir/file.c?
> The kernel uses subdirectories extensively, and a lot of renames (mos=
t of
> them, I'd say) is because of that subdirectory structure.
>=20
> So the same-directory case is the unusual one, I'd say.

If (2) is common enough then discussed improvements to rename detection=
,=20
namely comparing basenames as a base for candidate selection is a good =
idea.
I wonder how common is (2) compared to (1)+(2) i.e. move to other dir=20
and rename, old-dir/old-file.c to new-dir/new-subdir/new-file.c

>> 3.) splitting file into modules, huge-file.c to file1.c, file2.c?
>> 4.) copying fragment of one file to other?
>> 5.) moving fragment of code from one file to other?
>=20
> I'd say that (5) is very common. And (4) happens a lot under certain
> circumstances (new driver, new architecture, new filesystem..).
>=20
> Doing (3) happens, but probably less often that it should ;/

Detecting (4) and (5) fast (i.e. for merges) without auxilary (helper)=20
information would probably be hard. For interrogation/porcellanish comm=
ands
(like pickaxe) would probably be easier.

--=20
Jakub Narebski
Warsaw, Poland
