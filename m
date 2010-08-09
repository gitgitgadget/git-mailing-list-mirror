From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: workflow with blessed, lieutenant, and developers
Date: Mon, 09 Aug 2010 09:57:42 +0200
Message-ID: <vpqr5i8dxqh.fsf@bauges.imag.fr>
References: <20100809092152.5f32646a@packard.rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Mon Aug 09 09:58:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiNFJ-00035Z-F8
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 09:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676Ab0HIH6B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 03:58:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60070 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618Ab0HIH6A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 03:58:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o797tKgg019583
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Aug 2010 09:55:20 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OiNEs-00031A-Mu; Mon, 09 Aug 2010 09:57:42 +0200
In-Reply-To: <20100809092152.5f32646a@packard.rktmb.org> (Mihamina Rakotomandimby's message of "Mon\, 9 Aug 2010 09\:21\:52 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Aug 2010 09:55:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o797tKgg019583
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281945322.92288@WdnIjr4FtwN91xHCsYCB3A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152956>

Assuming you actually want what you want:

Mihamina Rakotomandimby <mihamina@gulfsat.mg> writes:

> 1=B0) What command line do developers use to push to me but not to th=
e
> blessed (origin)?

=46or example:

  git remote add submission <your repository URL>

and then, submit with

  git push HEAD:submission/branch-name

> 2=B0) After they pushed to me, I have the choice to "approve" or "rej=
ect"
> a commit: what is the keyword and git option for that?

Actually, you have the choice between "push" and "don't push", and you
can complement the later with "git branch -D" to delete the branch.

> 3=B0) I push the merge of approved commits to the blessed repository:
> what keywords and git options?

What do you want that "git push" doesn't do?


Now, you may not really want this ;-). Here are some alternatives:

* Use a system like github/gitorious/giroco/gitolite, that allows you
  to manage a set of repositories with shared storage, on a single
  site. Take gitorious, for example. People would clone the blessed
  repository (like http://gitorious.org/project/repo.git) online
  (costs almost nothing thanks to shared storage). They get a remote
  repository like http://git.gitorious.org/~user/project/own-repo.git.
  Then get a local copy. They would push to
  http://git.gitorious.org/~user/project/own-repo.git, notify you of
  the changes (by email, or using gitorious itself), and you'd pull
  from them and push to the blessed repository. This way, each user
  has his own private local repository, and his submission repository.
  You avoid people messing their submission with each other.

* Look at code review tools like gerrit. I've never used them so I
  can't say much more.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
