From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] Add git-archive
Date: Fri, 08 Sep 2006 22:21:30 +0200
Message-ID: <4501D0CA.7000206@lsrfire.ath.cx>
References: <cda58cb80609050516v699338b9y57fd54f50c66e49e@mail.gmail.com> <7vfyf6ce29.fsf@assigned-by-dhcp.cox.net> <44FED12E.7010409@innova-card.com> <44FF2C37.2010400@lsrfire.ath.cx> <ednb29$u0u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 22:21:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLmqy-0001eq-Tv
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 22:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbWIHUVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 16:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbWIHUVb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 16:21:31 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:35025
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751201AbWIHUVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 16:21:30 -0400
Received: from [10.0.1.3] (p508E5573.dip.t-dialin.net [80.142.85.115])
	by neapel230.server4you.de (Postfix) with ESMTP id 7B44619055;
	Fri,  8 Sep 2006 22:21:29 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ednb29$u0u$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26707>

Jakub Narebski schrieb:
> Rene Scharfe wrote:
>=20
>> IMHO should work like in the following example, and the code above=20
>> cuts off the Documentation part:
>>=20
>> $ cd Documentation $ git-archive --format=3Dtar --prefix=3Dv1.0/ HEA=
D howto | tar tf -=20
>> v1.0/howto/=20
>> v1.0/howto/isolate-bugs-with-bisect.txt ...
>>=20
>> I agree that simple subtree matching would be enough, at least for=20
>> now.
>=20
> What about
>=20
> $ git-archive --format=3Dtar --prefix=3Dv1.0/ HEAD:Documentation/howt=
o

That is fine, too (cutting off Documentation/howto).

My comment above was about the piece of code that handles cd'ing around=
 in
the repository.  git-tar-tree ignores the current working directory -- =
you
always get the full tree put into your tar file, and you have to do the
"trick" you mentioned if you want to archive only a subtree.  This is a=
 bit
strange, so I think we should do it right from the start in git-archive=
=2E

Ren=E9
