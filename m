From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git-daemon breakage in 1.5.4
Date: Wed, 6 Feb 2008 11:12:23 +0100
Message-ID: <27E0A387-5A6B-4577-AAF4-ACE65A24E306@wincent.com>
References: <BE051395-F4E1-428B-89B3-5D01BEA42C71@wincent.com> <7vr6fr9noj.fsf@gitster.siamese.dyndns.org> <C8E50E14-B50F-4385-A581-B69262E8E6A5@wincent.com> <47A98092.2070509@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>, srp@srparish.netq
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhHE-0008Hf-To
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761148AbYBFKMl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2008 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761142AbYBFKMk
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:12:40 -0500
Received: from wincent.com ([72.3.236.74]:60485 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761124AbYBFKMk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 05:12:40 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m16ACOb6018118;
	Wed, 6 Feb 2008 04:12:26 -0600
In-Reply-To: <47A98092.2070509@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72790>

El 6/2/2008, a las 10:40, Johannes Sixt escribi=F3:

>> This fails with the "remote end hung up unexpectedly" error:
>>
>>  # /usr/local/bin/git-daemon --inetd --base-path=3D/blah -- /blah
>
> If you run this from the command line, you can't expect it to do =20
> anything
> useful: It communicates with the client via stdin and stdout.

Strangely, it worked with 1.5.3.8. But I just tried to reproduce it =20
and now I can't, so there must have been some error in my procedure. =20
Doh. The bizarre thing is that in preparing these emails I tested it =20
at least twice, which means I must have made the exact same mistake at =
=20
least twice...

> Which makes me think that you xinetd doesn't pass a PATH to git-daemo=
n
> that includes /usr/local/bin. Add this to your /etc/xinetd.d/git:
>
>    env =3D PATH=3D/bin:/usr/bin:/usr/local/bin
>
> (not tested).

That works. Thanks.

It's an acceptable workaround (the other is installing /usr instead =20
of /usr/local). Seeing as it worked in 1.5.3.8, does this qualify as =20
breakage, or should we not worry about it?

Cheers,
Wincent
