From: Andreas Ericsson <ae@op5.se>
Subject: Re: git pull is slow
Date: Fri, 11 Jul 2008 15:34:33 +0200
Message-ID: <48776169.20705@op5.se>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Hennig <mailing_list@arcor.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 15:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHInd-0005Fa-Rs
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 15:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYGKNfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jul 2008 09:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbYGKNfj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 09:35:39 -0400
Received: from mail.op5.se ([193.201.96.20]:35052 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbYGKNfi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 09:35:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1ECE61B803F4;
	Fri, 11 Jul 2008 15:35:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.982
X-Spam-Level: 
X-Spam-Status: No, score=-3.982 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.417, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UkAhexVpGSy6; Fri, 11 Jul 2008 15:35:09 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.180])
	by mail.op5.se (Postfix) with ESMTP id 48F2C1B80007;
	Fri, 11 Jul 2008 15:35:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <g57jkp$ekm$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88118>

Stephan Hennig wrote:
> Stephan Hennig schrieb:
>=20
>> I am observing very large data transfers when pulling from the
>> repository at <URL:http://repo.or.cz/w/wortliste.git>.
>=20
> Here's the output of a recent pull:
>=20
>> unknown@COMMODORE ~/Themen/trennmuster/repository/wortliste (master)
>> $ git pull
>> Enter passphrase for key '/x/home/.ssh/id_rsa':
>> remote: Counting objects: 15, done.=E2=86=90[K
>> remote: Compressing objects: 100% (7/7), done.=E2=86=90[K)   =E2=86=90=
[Kts:   8% (1/12)
>> remote: Total 12 (delta 5), reused 12 (delta 5)=E2=86=90[K
>> Unpacking objects: 100% (12/12), done.
>> From git+ssh://xxx@repo.or.cz/srv/git/wortliste
>>    d905095..d0c6a33  master     -> origin/master
>>  * [new tag]         dehyph-exptl-v0.13 -> dehyph-exptl-v0.13
>> Updating d905095..d0c6a33
>> Fast forward
>>  wortliste=E2=86=90[m |   19 =E2=86=90[32m+++++++++++=E2=86=90[m=E2=86=
=90[31m--------=E2=86=90[m
>>  1 files changed, 11 insertions(+), 8 deletions(-)=E2=86=90[m
>=20
> After the line containing "remote: Compressing objects:" had been
> printed several MB have been transferred.
>=20

Seems like you're being bitten by a bug we had some months back,
where the client requested full history for new tag objects.

Does this bug still show up if you use the latest git from
master of git.git?

I *think* v1.5.4.3-440-g41fa7d2 fixed the issue, but I'm
not 100% certain as the commit message doesn't mention anything
about any bugs being solved. Otoh, I vaguely remember the first
bug-reporter being told to try 'next', and afair, that solved it
for him/her.

> Does it matter that the original clone has been performed with plain =
git
> protocol?  I have only later changed the url in .git/config to use gi=
t+ssh.
>=20

No, that doesn't matter in the slightest.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
