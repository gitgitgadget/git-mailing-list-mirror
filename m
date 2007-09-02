From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: [ANNOUNCE] GIT 1.5.3
Date: Sun, 02 Sep 2007 14:36:02 +0200
Message-ID: <fbeanj$mfq$1@sea.gmane.org>
References: <7vodglr32i.fsf@gitster.siamese.dyndns.org> <fbdt3q$lcf$1@sea.gmane.org> <Pine.LNX.4.64.0709021157120.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 14:36:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRohB-00019U-5y
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 14:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbXIBMgm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Sep 2007 08:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbXIBMgm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 08:36:42 -0400
Received: from main.gmane.org ([80.91.229.2]:41809 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964958AbXIBMgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 08:36:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IRogn-0007dG-GM
	for git@vger.kernel.org; Sun, 02 Sep 2007 14:36:29 +0200
Received: from chello089076029142.chello.pl ([89.76.29.142])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 14:36:29 +0200
Received: from arekm by chello089076029142.chello.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 14:36:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: chello089076029142.chello.pl
User-Agent: KNode/0.10.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57322>

Johannes Schindelin wrote:

> Hi,
>=20
> On Sun, 2 Sep 2007, Arkadiusz Miskiewicz wrote:
>=20
>> Junio C Hamano wrote:
>>=20
>> > The latest feature release GIT 1.5.3 is available at the usual
>> > places:
>>=20
>> Hm,
>>=20
>> [...]
>>
>> *** t0001-init.sh ***
>> * FAIL 1: plain
>>=20
>>                 (
>>                         unset GIT_DIR GIT_WORK_TREE &&
>>                         mkdir plain &&
>>                         cd plain &&
>>                         git init
>>                 ) &&
>>                 check_config plain/.git false unset
>=20
> Please try the verbose mode: cd t/ && sh t0001-init.sh -i -v.  If tha=
t
> does not show you _what_ the problem is, try "sh -x [...]".
>=20
> If you still cannot find what the problem is, please tell us what pla=
tform
> you're running on, and show us the output of the "-i -v" invocation.

=46ound out why this happens. My /bin/sh is pdksh (not bash).

AAAA was never set and:

/bin/sh (pdksh)
[arekm@carme-pld ~]$ unset AAAA
[arekm@carme-pld ~]$ echo $?
1

/bin/bash
[arekm@carme-pld ~]$ unset AAAA
[arekm@carme-pld ~]$ echo $?
0

It's pdksh bug, susv3 says "Unsetting a variable or function that was n=
ot
previously set shall not be considered an error and does not cause the
shell to abort."

Going to fix pdksh then.

> Ciao,
> Dscho

--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
