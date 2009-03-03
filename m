From: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <torarnv@gmail.com>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial branch
Date: Tue, 3 Mar 2009 18:04:05 +0100
Message-ID: <49AD6305.8040909@gmail.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 18:06:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeY3z-00046x-70
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbZCCRD6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 12:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752416AbZCCRD6
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 12:03:58 -0500
Received: from hoat.troll.no ([62.70.27.150]:43385 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbZCCRD5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 12:03:57 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 55FB020F43;
	Tue,  3 Mar 2009 18:03:55 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 4BA8620F35;
	Tue,  3 Mar 2009 18:03:55 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n23H3sd0032358;
	Tue, 3 Mar 2009 18:03:55 +0100
Received: from [172.24.90.10] ( [172.24.90.10])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Tue, 03 Mar 2009 18:03:54 +0100 (CET)
In-Reply-To: <7vr61eblde.fsf@gitster.siamese.dyndns.org>
References: <49AD5F0D.8000700@gmail.com>
References: <7vr61eblde.fsf@gitster.siamese.dyndns.org>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112120>

Junio C Hamano wrote:
> Tor Arne Vestb=F8 <torarnv@gmail.com> writes:
>=20
>> If you would like to contribute to the stable 1.6 branch, do:
>>   $ git clone -n git://git.foo.com/project.git
>>   $ cd project
>>   $ git checkout -t origin/1.6
>>   $ git branch -D master
>> Which is not so nice and inviting.
>=20
> If you are working on 1.6 maintenance track, why discard 'master'?

One example I can think of is if master is moving a lot faster than the=
=20
maintenance track, and you are not interested in master.

[box:/tmp/downstream] $ git branch
* 1.6
   master

[box:/tmp/downstream] $ git pull --rebase
Current branch 1.6 is up to date.

[box:/tmp/downstream] $ git push
To file:///tmp/upstream
  ! [rejected]        master -> master (non-fast forward)
error: failed to push some refs to 'file:///tmp/upstream'

In that case you would either have to ff master all the time (requiring=
=20
a checkout or rebase magic), or do an explicit "git push origin 1.6".

Neither good options when you are trying to teach people that git push=20
is the way you submit changes.

Tor Arne
