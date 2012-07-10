From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] branch: introduce --set-upstream-to
Date: Tue, 10 Jul 2012 19:08:35 +0200
Message-ID: <vpq394zo86k.fsf@bauges.imag.fr>
References: <1341939181-8962-1-git-send-email-cmn@elego.de>
	<1341939181-8962-2-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Jul 10 19:08:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sodvh-0000QZ-2B
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jul 2012 19:08:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab2GJRIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jul 2012 13:08:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51259 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754083Ab2GJRIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 13:08:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6AH7I1t014377
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 10 Jul 2012 19:07:18 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SodvQ-0008UV-Dx; Tue, 10 Jul 2012 19:08:36 +0200
In-Reply-To: <1341939181-8962-2-git-send-email-cmn@elego.de> ("Carlos
 =?iso-8859-1?Q?Mart=EDn?=
	Nieto"'s message of "Tue, 10 Jul 2012 18:52:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 10 Jul 2012 19:07:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6AH7I1t014377
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342544840.58447@ODKIBTDB6Wyq/yVfYgpozQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201264>

Carlos Mart=EDn Nieto <cmn@elego.de> writes:

> The new options allows us to type
>
>     git branch --set-upstream-to origin/master

This is cool :-).

>  Documentation/git-branch.txt |    9 ++++++++-
>  builtin/branch.c             |   15 +++++++++++++--

I think this deserves a few new tests (probably in t/t3200-branch.sh).

> +-u <upstream>::
> +--set-upstream-to=3D<upstream>::
> +	Set up <branchname>'s tracking information so <upstream> is
> +	considered <branchname>'s upstream branch. If no branch is
> +	specified it defaults to the current branch.

Perhaps "if <branchname> is not specified, then it defaults to the
current branch.". The current wording does not make it very clear if "n=
o
branch is specified" refers to <branchname> or <upstream> (although the
second option would be plain silly).

> +	} else if (new_upstream) {
> +		struct branch *branch =3D branch_get(argv[0]);
> +
> +		if (!ref_exists(branch->refname))
> +		  die(_("branch '%s' does not exist"), branch->name);

Indentation (2 spaces -> tab).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
