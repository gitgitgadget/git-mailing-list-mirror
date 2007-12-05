From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git-checkout --push/--pop
Date: Wed, 05 Dec 2007 18:44:05 +0100
Message-ID: <877ijt2g0q.fsf@lysator.liu.se>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr> <m34peyur8r.fsf@roke.D-201> <7vir3e428i.fsf@gitster.siamese.dyndns.org> <200712042204.lB4M4SVB002260@mi1.bluebottle.com> <7vprxl1v9v.fsf@gitster.siamese.dyndns.org> <vpqir3de8t6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 20:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzjL-0007U1-23
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbXLETPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXLETPu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:15:50 -0500
Received: from main.gmane.org ([80.91.229.2]:37181 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751821AbXLETPt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:15:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IzyrV-0001ey-Bf
	for git@vger.kernel.org; Wed, 05 Dec 2007 18:20:45 +0000
Received: from dns.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 18:20:45 +0000
Received: from davidk by dns.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 18:20:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dns.vtab.com
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:TcZBP1fVrXM4NBrpZzpJkYx3Vos=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67181>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu, is this something that forgetful people would find useful?
>
> Not sure. That's obviously an interesting feature, but adding two mor=
e
> options to checkout (which is already a huge swiss-army knife) might
> not be worth the trouble.
>
> And the issue with push/pop approaches is that I usually notice I hav=
e
> to use pop after not having used push (i.e. I use "cd -" all the time=
,
> but rarely "pushd"/"popd").

It is probably more common that you want to be able to switch back to
the previous branch, than that you actually need a full stack.

So a "git checkout --previous" could be enough.  Or a set of aliases

[alias]
	co =3D !"git symbolic-ref HEAD | sed -ne 's!refs/heads/!!p' > .git/LAS=
T ; git checkout"
        pop =3D !"git co $(cat .git/LAST)"

--=20
David K=C3=A5gedal
