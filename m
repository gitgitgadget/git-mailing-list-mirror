From: Jan Kasprzak <kas@fi.muni.cz>
Subject: Re: segfault when cloning over https
Date: Fri, 30 Jan 2009 11:43:22 +0100
Message-ID: <20090130104322.GK23133@fi.muni.cz>
References: <20090129184523.GI23133@fi.muni.cz> <alpine.DEB.1.10.0901291944030.5789@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Jan 30 11:44:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSqrl-0007Ms-SC
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 11:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbZA3Kn2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 05:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZA3Kn2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 05:43:28 -0500
Received: from minas.ics.muni.cz ([147.251.4.40]:58763 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751025AbZA3Kn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 05:43:27 -0500
Received: from anxur.fi.muni.cz (anxur.fi.muni.cz [147.251.48.3])
	by minas.ics.muni.cz (8.13.8/8.13.8/SuSE Linux 0.8) with ESMTP id n0UAhMvf016995;
	Fri, 30 Jan 2009 11:43:23 +0100
Received: by anxur.fi.muni.cz (Postfix, from userid 11561)
	id A5A471F6114; Fri, 30 Jan 2009 11:43:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0901291944030.5789@yvahk2.pbagnpgbe.fr>
User-Agent: Mutt/1.4.2.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (minas.ics.muni.cz [147.251.4.35]); Fri, 30 Jan 2009 11:43:23 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107788>

Daniel Stenberg wrote:
: On Thu, 29 Jan 2009, Jan Kasprzak wrote:
:=20
: >without problems, but when I change http to https, it either segfaul=
ts or=20
: >fails with heap corruption detected:
:=20
: >/lib64/libnsspem.so[0x7f845f3ee9c4]
: >/lib64/libnss3.so[0x7f846210dc4d]
: >/lib64/libnss3.so(PK11_CreateGenericObject+0x42)[0x7f846210ded2]
: >/usr/lib64/libcurl.so.4[0x14b129]
:=20
: This is a libcurl built to use a Fedora-patched NSS library for the S=
SL=20
: stuff. You could try to build your own libcurl with a different SSL l=
ibrary=20
: to see if that works fine, as then we could narrow this down a bit...

	Good guess! When I manually rebuild libcurl without nss and
with SSL, it works. I have forwarded this to Fedora bugzilla as

https://bugzilla.redhat.com/show_bug.cgi?id=3D483222

	Thanks,

-Yenya

--=20
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - privat=
e}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18=
A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/bl=
og/ |
>>  If you find yourself arguing with Alan Cox, you=E2=80=99re _probabl=
y_ wrong.  <<
>>     --James Morris in "How and Why You Should Become a Kernel Hacker=
"  <<
