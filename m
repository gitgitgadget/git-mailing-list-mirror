From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Mon, 11 Mar 2013 16:37:59 +0100
Message-ID: <vpq8v5uueug.fsf@grenoble-inp.fr>
References: <vpqd2v686fi.fsf@grenoble-inp.fr> <513DF4D1.6000500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, felipe.contreras@gmail.com
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 11 16:38:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF4o3-0005aT-4o
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 16:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab3CKPiD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 11:38:03 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33715 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752041Ab3CKPiC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 11:38:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2BFbwVr028555
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 11 Mar 2013 16:37:58 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UF4nX-000093-Ip; Mon, 11 Mar 2013 16:37:59 +0100
In-Reply-To: <513DF4D1.6000500@gmail.com> (Manlio Perillo's message of "Mon,
	11 Mar 2013 16:14:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 11 Mar 2013 16:37:58 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2BFbwVr028555
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363621078.30405@p7EgIFubJtBuVyy8/1hBHA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217880>

Manlio Perillo <manlio.perillo@gmail.com> writes:

> I have the same system, but I can't reproduce the problem.
> What is the content of your .zshrc file?

I could reproduce with ~/.zshrc containing just:

----------------------------------------------
fpath=(${HOME}/usr/etc/zsh ${fpath})

autoload -Uz compinit
compinit

eval "`dircolors`"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
----------------------------------------------

${HOME}/usr/etc/zsh contains two links _git and git-completion.bash
pointing to Git's completion scripts in contrib/.

Removing any line aboves removes the segmentation fault.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
