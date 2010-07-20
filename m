From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Question about 'branch -d' safety
Date: Tue, 20 Jul 2010 15:34:22 +0200
Message-ID: <vpq630a5lb5.fsf@bauges.imag.fr>
References: <20091230065442.6117@nanako3.lavabit.com>
	<m3lj9jknlr.fsf@localhost.localdomain>
	<20100711065505.GA19606@localhost>
	<201007110916.29567.jnareb@gmail.com>
	<20100711133730.GA10338@localhost> <20100717093006.GA11452@localhost>
	<7v7hkrpcrk.fsf@alter.siamese.dyndns.org>
	<AANLkTilOhFqhg1ulWEZUceNmrf0djZti9E1Y2QzTRgaN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 15:39:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObD2f-0003tu-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 15:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856Ab0GTNjY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 09:39:24 -0400
Received: from imag.imag.fr ([129.88.30.1]:64888 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372Ab0GTNjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 09:39:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6KDYMZg006431
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 20 Jul 2010 15:34:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ObCxi-00021T-Hk; Tue, 20 Jul 2010 15:34:22 +0200
In-Reply-To: <AANLkTilOhFqhg1ulWEZUceNmrf0djZti9E1Y2QzTRgaN@mail.gmail.com>
 (=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue\, 20
 Jul 2010 13\:19\:55 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 20 Jul 2010 15:34:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151312>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jul 19, 2010 at 18:06, Junio C Hamano <gitster@pobox.com> wro=
te:
>> Clemens Buchacher <drizzd@aon.at> writes:
>>
>>> Pros and cons for "undeleting branches":
>>>
>>> + safety net
>>> It should not be easy to lose information with git.
>>
>> I am personally not very convinced by this argument when it comes to=
 the
>> cases where the user actively asks us to remove something.
>
> [...]
>
> As Will Palmer pointed out, being able to tell newbies "Don't worry,
> you aren't going to break it" is a very powerful thing to be able to
> tell newbies and experienced users using Git.

Also, one of the _very_ cool things with Git is that advance users can
tell newbies "don't worry, if you break it, I'll be able to repair
it". And advanced users are almost always able to repair beginner's
mistake after the fact (in my case, it's often about teachers helping
students, but it works also in other situations).

"branch -d" (and even more "branch -D") deleting the reflog is one of
the few exceptions to this rule: dumb users can shoot themselves in
the foot (which is normal) but then the doctor cannot undo it easily.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
