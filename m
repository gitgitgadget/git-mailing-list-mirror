From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] simplified the chain if() statements of  install_branch_config() function in branch.c
Date: Mon, 10 Mar 2014 09:23:15 +0100
Message-ID: <vpqd2huihsc.fsf@anie.imag.fr>
References: <loom.20140310T083649-236@post.gmane.org>
	<loom.20140310T085652-521@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Nemina Amarasinghe <neminaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMvUc-0004UH-JD
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 09:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaCJIXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 04:23:22 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54332 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbaCJIXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2014 04:23:19 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2A8NF77026705
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Mar 2014 09:23:15 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2A8NFtc016064;
	Mon, 10 Mar 2014 09:23:15 +0100
In-Reply-To: <loom.20140310T085652-521@post.gmane.org> (Nemina Amarasinghe's
	message of "Mon, 10 Mar 2014 07:58:45 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 10 Mar 2014 09:23:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2A8NF77026705
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395044596.19868@nqb+l5NtfG2S7RmpbMl8Cg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243711>

Nemina Amarasinghe <neminaa@gmail.com> writes:

> Nemina Amarasinghe <neminaa <at> gmail.com> writes:
>
> Sorry for the first patch. Something went wrong. This is the correct one

Please, re-read Documentation/SubmittingPatches. In short, don't inline
patch headers and don't forget the sign-off.

> Subject: [PATCH] simplified the chain if() statements of
>  install_brach_config() function in branch.c

Keep the subject line short (ideally <50 characters), and avoid past
tense. We usually use imperative (the patch asks the codebase to
refactor itself => "simplify if statements ...". We usually prefix the
subject line with the place/subsystem where the change is done =>
"branch.c: simplify if ...".

> -		else if (!remote_is_branch && origin)
> -			printf_ln(rebasing ?
> -				  _("Branch %s set up to track remote ref %s by rebasing.") :
> -				  _("Branch %s set up to track remote ref %s."),
> -				  local, remote);
> -		else if (!remote_is_branch && !origin)
> +		else if (!remote_is_branch && (origin || !origin))

Is it me, or is (origin || !origin) a tautology?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
