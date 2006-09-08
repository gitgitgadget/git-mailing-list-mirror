From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Add git-archive [take #2]
Date: Fri, 08 Sep 2006 22:21:12 +0200
Message-ID: <4501D0B8.8060103@lsrfire.ath.cx>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com>	<7vfyf6ce29.fsf@assigned-by-dhcp.cox.net>	<44FED12E.7010409@innova-card.com>	<7vac5c7jty.fsf@assigned-by-dhcp.cox.net>	<cda58cb80609062332p356bd26bw852e31211c43d1ac@mail.gmail.com>	<7v1wqo400b.fsf@assigned-by-dhcp.cox.net>	<44FFD00E.5040305@innova-card.com>	<7vr6yo2isu.fsf@assigned-by-dhcp.cox.net>	<450019C3.4030001@innova-card.com> <7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Franck <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 22:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLmqq-0001d2-5b
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 22:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWIHUVU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWIHUVU
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 16:21:20 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:31185
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751199AbWIHUVU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 16:21:20 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id 4BB5F19023;
	Fri,  8 Sep 2006 22:21:18 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xkvqjlq.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26704>

Junio C Hamano schrieb:
> Franck Bui-Huu <vagabon.xyz@gmail.com> writes:
>=20
>> I'm sending a new version of the patchset which allows=20
>> 'git-archive' and 'git-upload-archive' command. I tried to take=20
>> into account all feedbacks made by Junio and Rene, but there are=20
>> still some open points.
>>=20
>> 1/ Allow 'git-upload-archive' command to enable/disable some=20
>> formats. This should be done by 'git-upload-archive'.
>=20
> Perhaps.  I was thinking about the way how a site administrator can=20
> configure such when upload-archive is spawned via git-daemon (for=20
> users coming from ssh and spawn an upload-archive on their own, it's=20
> their own process and upload-archive has no business deciding what is
>  allowed and what is forbidden).  Not very many clean ways I can
> think of unfortunately.

Mmpf, ssh is (one of the things) in my blind spot.  Do you mean a
ssh+git-shell connection?  One could argue that since this is a
restricted connection anyway upload-archive _has_ a right to restrict
archive format etc., too.  On a full, unrestricted ssh connection one
can start git-archive directly.  I'd do that anyway because I'm used to
do this with tar. ;-)

Anyway, I think having config options for git-upload-archive for
restricting formats and compression levels is as clean as we can get in
the absence of a way for upload-archive to detect which protocol is
used for the current connection.  Mmh, maybe an environment variable
which is set by the daemon can be used?  This is no dirtier than what
webservers do..

Ren=E9
