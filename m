From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/4] Add git-archive
Date: Sat, 09 Sep 2006 17:02:35 +0200
Message-ID: <4502D78B.6000905@lsrfire.ath.cx>
References: <450019C3.4030001@innova-card.com>	 <11576347251776-git-send-email-vagabon.xyz@gmail.com>	 <7vodtrnl0f.fsf@assigned-by-dhcp.cox.net>	 <45013114.1070808@innova-card.com> <4501D0C5.702@lsrfire.ath.cx> <cda58cb80609090731w7c66dcfbrbababb6c38d29bf6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 17:02:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM4Lw-0007MN-3k
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 17:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWIIPCg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 9 Sep 2006 11:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWIIPCg
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 11:02:36 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:32725
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932248AbWIIPCf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 11:02:35 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id 172A7801A;
	Sat,  9 Sep 2006 17:02:34 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609090731w7c66dcfbrbababb6c38d29bf6@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26752>

=46ranck Bui-Huu schrieb:
> 2006/9/8, Rene Scharfe <rene.scharfe@lsrfire.ath.cx>:
>> > +     url =3D strdup(ar->remote);
>>
>> xstrdup()
>>
>=20
> ok, but need to rebase...

Why?  On a similar note , can we use Junio's pu branch (and soon his
next branch) as our base for further work?

>> > +     if (list) {
>> > +             if (!remote) {
>> > +                     for (i =3D 0; i < ARRAY_SIZE(archivers); i++=
)
>> > +                             printf("%s\n", archivers[i].name);
>> > +                     exit(0);
>> > +             }
>> > +             die("--list and --remote are mutually exclusive");
>> > +     }
>>
>> Not sure if we really need a list option.  I guess it only really
>> makes sense if we have more than five formats.  I have no _strong_
>> feelings against it, though. *shrug*
>>
>=20
> well it's almost free to add it, and no need any maintenance if we ad=
d
> a new archiver backend, so I would say let it.

I thought a bit about it, and I can now see a good use case for --list:
checking the capabilities of a remote site.  Unfortunately this is
currently forbidden.  Why?  git-archive --list writes to stdout, so the
result can be transported the same way an archive would.

Ren=E9
