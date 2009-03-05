From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: can not clone via git:// anymore
Date: Thu, 05 Mar 2009 10:16:54 +0100
Message-ID: <49AF9886.7090106@cetrtapot.si>
References: <49AE64F2.1090405@cetrtapot.si> <49AE7B23.1070008@drmicha.warpmail.net> <49AE8208.7090204@cetrtapot.si> <20090304142459.GB17874@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:20:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9kN-0008Na-Pi
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbZCEJSl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 04:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbZCEJSj
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:18:39 -0500
Received: from zimbra-mta.cetrtapot.si ([89.212.80.172]:55939 "EHLO
	zimbra-mta.cetrtapot.si" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbZCEJSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:18:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id 1D82B19FA22;
	Thu,  5 Mar 2009 10:18:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra-mta.cetrtapot.si
Received: from zimbra-mta.cetrtapot.si ([127.0.0.1])
	by localhost (zimbra-mta.cetrtapot.si [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auEHXDtxdlEZ; Thu,  5 Mar 2009 10:18:35 +0100 (CET)
Received: from [172.31.65.135] (unknown [192.168.66.2])
	by zimbra-mta.cetrtapot.si (Postfix) with ESMTP id C813319F9D6;
	Thu,  5 Mar 2009 10:18:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <20090304142459.GB17874@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112278>

Jeff King wrote:
> On Wed, Mar 04, 2009 at 02:28:40PM +0100, Hinko Kocevar wrote:
>=20
>> git-daemon was/is running:
>>
>> CETRTAPOT\zidarhw@zidar:~$ ps -ef | grep git
>> root      3207     1  0 14:15 ?        00:00:00 runsvdir -P /etc/ser=
vice log: d user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown:=
 invalid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: in=
valid user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: inval=
id user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid =
user: `gitlog:adm'?chown: invalid user: `gitlog:adm'?chown: invalid use=
r: `gitlog:adm'?chown: invalid user: `gitlog:adm'?
>> root      3208  3207  0 14:15 ?        00:00:00 runsv git-daemon
>> root      3373  3208  0 14:16 ?        00:00:00 git-daemon --verbose=
 --base-path=3D/var/cache /var/cache/git
>> 11418     3399  2762  0 14:16 pts/0    00:00:00 grep git
>=20
> See all the runsvdir errors? That probably means that git-daemon's lo=
g
> output is going nowhere, since the log is not running. Which means
> eventually the pipe from git-daemon to the log will get full, and
> git-daemon will block writing out the log. And then stop dealing with
> requests.
>=20
> So even if restarting helps now, it may fill up again unless you fix =
the
> logging problem (presumably by creating the right "gitlog" user).

I added the 'gitlog' user yesterday too, when I noticed that unusual ru=
nsvdir line.

ps output:
CETRTAPOT\zidarhw@zidar:~$ ps -ef | grep git
git       5547     1  0 Mar04 ?        00:00:00 /usr/bin/git-daemon --r=
euseaddr --verbose --detach --base-path=3D/home/git/repositories/ --exp=
ort-all

Thank you!

--=20
Hinko Ko=C4=8Devar, OSS developer
=C4=8CETRTA POT, d.o.o.
Planina 3, 4000 Kranj, SI EU
tel     ++386 (0) 4 280 66 03
e-mail  hinko.kocevar@cetrtapot.si
http    www.cetrtapot.si
