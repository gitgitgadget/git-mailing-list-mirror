From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: Enhance unspecified push default warning
Date: Thu, 03 Oct 2013 08:48:22 +0200
Message-ID: <vpqr4c2kfyh.fsf@anie.imag.fr>
References: <CAKYC+eLGS6ocdE7CTV25E2xMRaHijmQbFBc3tAyx3cNpXfC_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Coder Coder5000 <coder5000@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 03 08:48:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRci9-0007BD-N8
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 08:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749Ab3JCGsa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 02:48:30 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44543 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752898Ab3JCGs3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 02:48:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r936mMDB020881
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 3 Oct 2013 08:48:22 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VRchz-0000c3-9q; Thu, 03 Oct 2013 08:48:23 +0200
In-Reply-To: <CAKYC+eLGS6ocdE7CTV25E2xMRaHijmQbFBc3tAyx3cNpXfC_sg@mail.gmail.com>
	(Coder Coder's message of "Wed, 2 Oct 2013 16:48:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Oct 2013 08:48:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r936mMDB020881
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1381387706.31708@Xw25FzjE1h/UtkIkTO25Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235682>

Coder Coder5000 <coder5000@gmail.com> writes:
^^^^^^^^^^^^^^^
Please, use your real identity in your From: field (git send-email may
help).

> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -174,6 +174,15 @@ N_("push.default is unset; its implicit value is
> changing in\n"
>     "\n"
>     "  git config --global push.default simple\n"
>     "\n"
> +   "When push.default is set to matching git will push all local branches\n"
> +   "to the remote branches with the same (matching) name.  This will no\n"
> +   "longer be the default in Git 2.0 because a branch could be\n"
> +   "unintentionally pushed to a remote.\n"
> +   "\n"
> +   "In Git 2.0 the new push.default of simple will push only the current\n"
> +   "branch to the same remote branch used by git pull.   A push will\n"
> +   "only succeed if the remote and local branches have the same name.\n"
> +   "\n"

It is becoming a monster-warning, but I think this is a good change.
People who still see the warning are those who did not upgrade for a
while (and therefore probably the ones needing the most explanation).
And it's meant to be a one-time warning anyway.

Judging by the question asked on stackoverflow
( http://stackoverflow.com/questions/13148066/warning-push-default-is-unset-its-implicit-value-is-changing-in-git-2-0 )
and its popularity, telling the users to read the docs did not work very
well.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
