From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git-Automerge
Date: Sun, 04 Apr 2010 18:53:33 +0200
Message-ID: <vpqr5mv40s2.fsf@bauges.imag.fr>
References: <w2j1f05046e1004040947k3b812063ndbc2f8da3496effb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nico =?iso-8859-1?Q?Sch=FCmann?= <nico.schuemann@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 18:57:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyT8E-0000eQ-3N
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 18:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115Ab0DDQ4s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Apr 2010 12:56:48 -0400
Received: from imag.imag.fr ([129.88.30.1]:45186 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab0DDQ4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 12:56:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o34GrYcs023382
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 4 Apr 2010 18:53:34 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NyT4o-0004Vw-0Z; Sun, 04 Apr 2010 18:53:34 +0200
In-Reply-To: <w2j1f05046e1004040947k3b812063ndbc2f8da3496effb@mail.gmail.com> ("Nico
 =?iso-8859-1?Q?Sch=FCmann=22's?= message of "Sun\, 4 Apr 2010 18\:47\:14
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 04 Apr 2010 18:53:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143932>

Nico Sch=FCmann <nico.schuemann@googlemail.com> writes:

> But the changes do not appear on the master server. I have to type
>
> # git reset --hard=A0=A0=A0=A0=A0 or
> # git checkout -f

You pushed to a checked-out branch. You shouldn't do that, and recent
Git prevent you from doing it.

The reason Git cannot do the merge automatically is that a merge can
go wrong, and may require a human interaction to resolve conflicts.
Hence, "push" never does a merge, only "pull" (and obviously local
merge) will do.

You can do

client-machine$ git push URL-OF-SERVER HEAD:tmp

to push your current HEAD to a branch named "tmp" on the server, and
then

server-machine$ git merge tmp

to merge the changes in the current branch of the server. Another
option is to have a bare repository reachable from both machines, and
both machine would push/pull to this repository (just like you'd do
with a centralized version control system).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
