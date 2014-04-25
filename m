From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Revert "Stop starting pager recursively"
Date: Fri, 25 Apr 2014 20:49:52 +0200
Message-ID: <vpqoazpdz1r.fsf@anie.imag.fr>
References: <20140421204622.GA9532@logfs.org>
	<20140425182928.GA29904@logfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@logfs.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:50:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdlCD-000740-Hj
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbaDYSt5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2014 14:49:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35916 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbaDYSt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 14:49:56 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s3PInocb016326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Apr 2014 20:49:50 +0200
Received: from anie.imag.fr (ensi-vpn-250.imag.fr [129.88.57.250])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3PInqqK003735;
	Fri, 25 Apr 2014 20:49:52 +0200
In-Reply-To: <20140425182928.GA29904@logfs.org> (=?iso-8859-1?Q?=22J=F6rn?=
 Engel"'s message of
	"Fri, 25 Apr 2014 14:29:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Apr 2014 20:49:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3PInocb016326
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1399056591.51542@PTUXQNjnw30sRvGD1lYIfA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247093>

J=F6rn Engel <joern@logfs.org> writes:

> On Mon, 21 April 2014 16:46:22 -0400, J=F6rn Engel wrote:
>>=20
>> This reverts commit 88e8f908f2b0c56f9ccf8134d8ff9f689af9cc84.
>>=20
>> Caused a usability regression for me and foul language for my cowork=
ers.
>
> Ping.

How do you solve the problem that the commit you revert was solving? Th=
e
commit you propose to revert says in its message:

    git-column can be used as a pager for other git commands, something
    like this:
   =20
        GIT_PAGER=3D"git -p column --mode=3D'dense color'" git -p branc=
h
   =20
    The problem with this is that "git -p column" also has $GIT_PAGER s=
et so
    the pager runs itself again as another pager. The end result is an
    infinite loop of forking.

There's probably a solution, but you can't ignore the problem (or
someone else will later try to solve the infinite loop and revert your
commit, and so on ...).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
