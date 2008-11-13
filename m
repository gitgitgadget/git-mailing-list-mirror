From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: bugreport: git does not like subseconds
Date: Thu, 13 Nov 2008 17:57:43 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811131752450.16134@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0811131722360.13330@fbirervta.pbzchgretzou.qr> <alpine.LFD.2.00.0811130842550.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 17:59:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0fX2-0004dL-0D
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 17:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYKMQ5p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 11:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbYKMQ5p
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 11:57:45 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:54865 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbYKMQ5o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 11:57:44 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 3D36818167FEC; Thu, 13 Nov 2008 17:57:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 3653B1D3C06CA;
	Thu, 13 Nov 2008 17:57:43 +0100 (CET)
In-Reply-To: <alpine.LFD.2.00.0811130842550.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100886>


On Thursday 2008-11-13 17:45, Linus Torvalds wrote:
>On Thu, 13 Nov 2008, Jan Engelhardt wrote:
>>=20
>> Git does not like subseconds in $GIT_{AUTHOR,COMMITTER}_DATE,
>> and somehow does time travel instead. Perhaps this is a Glibc
>> limitation? Running openSUSE 11's glibc-2.8(which is actually
>> a 2.7 snapshot I think: glibc-2.8-2008042513.tar.bz2).
>
>This should have been fixed by 9f2b6d2936a7c4bb3155de8efec7b10869ca935=
e=20
>("date/time: do not get confused by fractional seconds").
>
>But maybe that hasn't made it into any release yet? It's in master, bu=
t=20
>maybe it never made it into stable? Junio?

Seems so:

$ git describe 9f2b6d2936a7c4bb3155de8efec7b10869ca935e
v1.6.0-3-g9f2b6d2

$ git merge-base 9f2b6d2936a7c4bb3155de8efec7b10869ca935e v1.6.0.3
result: dba9194a49452b5f093b96872e19c91b50e526aa

$ git describe dba9194a49452b5f093b96872e19c91b50e526aa
v1.6.0-1-gdba9194

Which means it's not in; -forest also verifies it:

[v1.6.0.x goes here]
^
=E2=94=82
=E2=94=9C =E2=94=82     =E2=94=82 mailinfo: re-fix MIME multipart bound=
ary parsing
=E2=94=82 =E2=94=82   =E2=94=8C=E2=94=80=E2=94=82=E2=94=80[fix]=E2=94=80=
=E2=94=80date/time: do not get confused by fractional seconds
=E2=94=82 =E2=94=82   =E2=94=9C =E2=94=82 Start 1.6.1 cycle
=E2=94=9C=E2=94=80=E2=89=A1=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=82
=E2=94=9C =E2=94=82     =E2=94=82 Start 1.6.0.X maintenance series
=E2=94=9C=E2=94=80=E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=82=E2=94=80[v1.6.0]=E2=94=80=E2=94=80GIT 1.6.0
