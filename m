From: Thorsten Glaser <tg@mirbsd.de>
Subject: Re: git should not use a default user.email config value
Date: Sat, 10 Aug 2013 12:06:08 +0000 (UTC)
Message-ID: <Pine.BSM.4.64L.1308101202260.28970@herc.mirbsd.org>
References: <20130809134236.28143.75775.reportbug@tglase.lan.tarent.de>
 <20130809194214.GV14690@google.com> <20130809223758.GB7160@sigill.intra.peff.net>
 <20130809231928.GY14690@google.com> <20130810064717.GB30185@sigill.intra.peff.net>
 <52060EF9.2040504@alum.mit.edu> <20130810102834.GA6237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 14:51:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V88e7-0003x3-SB
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 14:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933264Ab3HJMvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Aug 2013 08:51:47 -0400
Received: from eurynome.mirbsd.org ([81.169.181.30]:29483 "EHLO
	eurynome.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933222Ab3HJMvq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Aug 2013 08:51:46 -0400
X-Greylist: delayed 2084 seconds by postgrey-1.27 at vger.kernel.org; Sat, 10 Aug 2013 08:51:46 EDT
Received: from herc.mirbsd.org (root@herc.mirbsd.org [IPv6:2a01:198:25d:0:202:b3ff:feb7:54e8])
	by eurynome.mirbsd.org (8.14.5.Beta0/8.14.3) with ESMTP id r7ACGtK9015554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Sat, 10 Aug 2013 12:17:00 GMT
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.5/8.14.5) with ESMTP id r7AC68Ef012530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sat, 10 Aug 2013 12:06:12 GMT
X-X-Sender: tg@herc.mirbsd.org
In-Reply-To: <20130810102834.GA6237@sigill.intra.peff.net>
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232096>

Jeff King dixit:

>It was not clear to me whether his site has /etc/mailname. If it does

Some may, some may not but=E2=80=A6

>But from his description, the machine may even have a split-horizon na=
me
>in /etc/mailname, and we can do nothing at all about that.

=E2=80=A6 that won=E2=80=99t happen. The problem is that they may have
the correct domain there but the localpart will still
be wrong because Kolab localparts are not Unix usernames.


Jonathan Nieder dixit:

>I thought that on other operating systems people typically don't have
>an /etc/mailname.  How does trusting the file when present hurt?

Right, MirBSD doesn=E2=80=99t have it, and I don=E2=80=99t think OpenBS=
D
added it since we forked.


Jeff King dixit:

>On Sat, Aug 10, 2013 at 11:59:21AM +0200, Michael Haggerty wrote:
>
>> I intentionally don't set user.email in my ~/.gitconfig because I us=
e
>> different identities (on the same machine) depending on what project=
 I

=46or me that=E2=80=99s also true, but I set a default one at the momen=
t
which is still better than having an unroutable one (on my private
laptop, ${unix_username}@${fqdn} does work, but only as long as my
laptop is powered on, has got IPv6 Internet, and the sending MTA
has IPv6 Internet, so=E2=80=A6 it=E2=80=99s mostly unroutable).

While I used a fallback for this scenario (me, privately), I=E2=80=99d
also benefit from git refusing to accept commits by default.

>So if I understand your use case, then you would be even happier if
>rather than giving a warning, git simply barfed and said "please set
>your identity before committing"?

Exactly. That=E2=80=99s what I think he said, and what I asked for too.

Thanks,
//mirabilos (working with many OSS projects)
--=20
I believe no one can invent an algorithm. One just happens to hit upon =
it
when God enlightens him. Or only God invents algorithms, we merely copy=
 them.
If you don't believe in God, just consider God as Nature if you won't d=
eny
existence.		-- Coywolf Qi Hunt
