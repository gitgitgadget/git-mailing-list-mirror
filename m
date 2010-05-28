From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: cvs update vs. git pull
Date: Fri, 28 May 2010 11:54:18 +0200
Message-ID: <vpqhblss65x.fsf@bauges.imag.fr>
References: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Moser <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Fri May 28 11:54:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHwHG-00046x-Nl
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 11:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010Ab0E1Jye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 05:54:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42791 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754655Ab0E1Jyd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 05:54:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o4S9lA03008092
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 28 May 2010 11:47:10 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OHwGg-0000Ke-Cy; Fri, 28 May 2010 11:54:18 +0200
In-Reply-To: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
 (=?iso-8859-1?Q?=22Ren=E9?= Moser"'s message of "Fri\, 28 May 2010
 11\:21\:12 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 28 May 2010 11:47:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o4S9lA03008092
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1275644832.91484@9c2P+SobHkzqVkVEcOgB+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147923>

Ren=E9 Moser <mail@renemoser.net> writes:

> One problem we have is, that if there is a commit to cvs while the cv=
s
> update of the build job is running (and this takes 20 minutes), then =
we
> get some inconsistence, the build will fail.

Git will also bring a big performance improvement here. The duration
of the "git pull" will be mostly O(number of modifications since last
pull), not O(total number of files).

> So the question is, if we would use git, this inconsistence would not=
 be
> possible because the git pull will get the state of the sha1. Right?

Actually, if you use almost anything but CVS (i.e. even SVN can do
that), you will get "atomic commits", i.e. a commit touching multiple
files is either seen as completed or not seen at all.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
