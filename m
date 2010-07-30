From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] rebase -i: add run command to launch a shell command
Date: Fri, 30 Jul 2010 12:04:24 +0200
Message-ID: <vpq1valffpz.fsf@bauges.imag.fr>
References: <1280323784-27462-1-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTinvVFvu7WvwrRC0sg8vhoepFXKewmuTr7S94LWk@mail.gmail.com>
	<vpq1van3cnl.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jul 30 12:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OemWj-0001qH-Ft
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 12:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895Ab0G3KJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 06:09:10 -0400
Received: from imag.imag.fr ([129.88.30.1]:52400 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab0G3KJI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 06:09:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o6UA4P8x000675
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 12:04:25 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OemS0-0002Zh-U0; Fri, 30 Jul 2010 12:04:24 +0200
In-Reply-To: <vpq1van3cnl.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed\, 28 Jul 2010 16\:26\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 30 Jul 2010 12:04:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152235>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Santi B=E9jar <santi@agolina.net> writes:
>
>> $ git run HEAD^4.. command arguments
>>
>> (I'm not quite sure about the syntax). Something like "git bisect ru=
n"
>> but for all the commits in the range.
>>
>>  I know you said "given points in history", maybe each approach is
>> useful for each use case.
>
> Yes, I think both approaches make sense.

I started playing with the patch, and I'm already starting to love
it ;-). For example

pick <commit1>
fixup <commit4>
run make
pick <commit2>
pick <commit3>
=2E..

Just does "the right thing": it checks that the fixup doesn't break
the commit (which is really not only a new state, but also a new
patch, so it can really break), but doesn't spend too much time
re-checking <commit2> and <commit3> (which are new states, but much
more trustworthy than the fixup since the patches are really the
same. I may check them later, but don't want to lose time with them
while hacking).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
