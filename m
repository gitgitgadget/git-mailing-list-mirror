From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] Make 'diff_populate_filespec()' use the new   'strbuf_readlink()'
Date: Thu, 18 Dec 2008 18:28:02 +0100
Message-ID: <494A8822.8090601@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0812171034520.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171042120.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171042500.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171043180.14014@localhost.localdomain>	<alpine.LFD.2.00.0812171043440.14014@localhost.localdomain> <20081218121118.3635c53c@crow> <494A80D3.7070605@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Burton <markb@ordern.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Dec 18 18:29:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDMgk-0007kh-6R
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 18:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbYLRR2L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 12:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYLRR2L
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 12:28:11 -0500
Received: from india601.server4you.de ([85.25.151.105]:53302 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYLRR2K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 12:28:10 -0500
Received: from [10.0.1.101] (p57B7E582.dip.t-dialin.net [87.183.229.130])
	by india601.server4you.de (Postfix) with ESMTPSA id 639162F805F;
	Thu, 18 Dec 2008 18:28:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <494A80D3.7070605@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103474>

Ren=C3=A9 Scharfe schrieb:
> Mark Burton schrieb:
>> Howdy folks,
>>
>> When I compile this latest version of diff.c on a i686 dual-core Pen=
tium box
>> I see:
>>
>> diff.c: In function =E2=80=98diff_populate_filespec=E2=80=99:
>> diff.c:1781: warning: passing argument 2 of =E2=80=98strbuf_detach=E2=
=80=99 from incompatible pointer type
>>
>> The same code compiles without warning on a x86_64 AMD box. Both
>> machines are running stock Ubuntu 8.04.
>>
>> Does it need a cast on some architectures?
>=20
> The type of the size member of struct stat is off_t, while strbuf_det=
ach expects
> a size_t pointer.  This patch should fix the warning:

Nevermind, I somehow missed the last "t" in line 1760..  The patch work=
s
nevertheless. 8-)

Ren=C3=A9
