From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] Make git-{pull,rebase} no-tracking message friendlier
Date: Wed, 29 Feb 2012 09:09:01 +0100
Message-ID: <vpqbooit61u.fsf@bauges.imag.fr>
References: <1330013115-26355-1-git-send-email-cmn@elego.de>
	<vpq399wc4ns.fsf@bauges.imag.fr>
	<1330487854.691.24.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Feb 29 09:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ebQ-0002VL-1s
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 09:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115Ab2B2IJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Feb 2012 03:09:31 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57919 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191Ab2B2IJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 03:09:30 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1T84tA4002689
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 Feb 2012 09:04:55 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S2eas-0006Qe-I0; Wed, 29 Feb 2012 09:09:02 +0100
In-Reply-To: <1330487854.691.24.camel@centaur.lab.cmartin.tk> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Wed, 29 Feb 2012 04:57:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 29 Feb 2012 09:04:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1T84tA4002689
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331107498.4142@rZLoPeLCn6P78rbP+KOR8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191816>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> $example is a caller-given string which already contains the whole
> command (i.e. it's already 'git rebase <upstream branch>' or 'git pul=
l
> <repository> <branch>').

OK, I didn't remember the exact message.

> In this patch I've moved that command to its own paragraph so the
> usage part of the output gets more visibility.

I prefer this, yes.

Perhaps we could go further and try to guess a remote and a branch name
to give in the example. "git push" already does that to some extend:

  $ git -c push.default=3Dtracking push
  fatal: The current branch my-branch has no upstream branch.
  To push the current branch and set the remote as upstream, use
 =20
      git push --set-upstream origin my-branch

i.e. if there's a remote configured, then using it in the example makes
sense. I'm not sure if using the current branch name in the example
would also be a good thing (it usually is for "push" because most users
would push to a branch with the same name on the remote end).

It may also make sense not to suggest "git remote add" if there's
already a remote configured. Otherwise, the case, which is probably the
most common, of:

  git clone http://example.com/repo
  cd repo
  git checkout -b new-branch
  git pull

is made far more complex than it should for the newcommer.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
