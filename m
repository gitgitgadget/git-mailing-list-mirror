From: =?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <lukass@etek.chalmers.se>
Subject: Re: [PATCH] git-am: Don't accept an mbox on stdin of we already have
 a .dotest directory
Date: Thu, 20 Jul 2006 21:35:25 +0200
Organization: Chalmers
Message-ID: <44BFDAFD.10101@etek.chalmers.se>
References: <44BE95D0.9090708@etek.chalmers.se> <20060720143353.GK13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 20 21:36:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3eJ0-0001Yq-NA
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 21:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWGTTf1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 20 Jul 2006 15:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWGTTf1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 15:35:27 -0400
Received: from anubis.medic.chalmers.se ([129.16.30.218]:13479 "EHLO
	anubis.medic.chalmers.se") by vger.kernel.org with ESMTP
	id S1030320AbWGTTf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jul 2006 15:35:26 -0400
X-Medic-Info: 3d9a.44bfdafd.0 NwO1WUmXySejAP53 dynamic-client
Received: from [192.168.0.82] (153.29.227.87.static.kba.siw.siwnet.net [87.227.29.153])
	by anubis.medic.chalmers.se (Postfix) with ESMTP id B9173312E5;
	Thu, 20 Jul 2006 21:35:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.4) Gecko/20060603 Thunderbird/1.5.0.4 Mnenhy/0.7.4.666
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060720143353.GK13776@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24034>

Petr Baudis wrote:
> Dear diary, on Wed, Jul 19, 2006 at 10:28:00PM CEST, I got a letter
> where Lukas Sandstr=F6m <lukass@etek.chalmers.se> said that...
>> Signed-off-by: Lukas Sandstr=F6m <lukass@etek.chalmers.se>
>> ---
>=20
> Please don't be afraid of putting stuff to commit message. It can onl=
y
> improve things. :-)
>=20
>> # git format-patch -k -3 master..conflict | git am -k -3
>> =3D> git-am fails with a conflict message
>> # git reset --hard
>>
>> # git format-patch -k -3 master..ok | git am -k -3
>> =3D> git am fails with the same conflict message as above,
>> =3D> since it's trying to apply the old .dotest directory
>>
>> With the patch it complains about an old .dotest
>> directory instead.
>=20
> I think this rather means that git reset --hard should clear the .dot=
est
> directory, or something (perhaps just warn)...

But the .dotest directory is user-selectable in git-am.

>=20
>> -	test ",$#," =3D ",0," ||
>> +	if test ",$#," !=3D ",0," || ! tty -s
>=20
> ...but this looks like a horrible idea. Does this mean that git-am ca=
n't
> be now ran without a terminal? (E.g. in a cron/at job, inside a procm=
ail
> rule etc.) That's bad.
>=20

This would only stop it from running without a terminal if you have an =
old
=2Edotest directory lying around, ie. you already have a failed am-sess=
ion.
git-am wouldn't work in this case before either, all the patch does is =
to
give a better error-message.

/Lukas
