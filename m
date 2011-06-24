From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] stash: Add --include-untracked option to stash and remove all untracked files
Date: Fri, 24 Jun 2011 22:31:10 +0200
Message-ID: <vpqei2jj7jl.fsf@bauges.imag.fr>
References: <1308612986-26593-1-git-send-email-david@porkrind.org>
	<1308945726-20910-1-git-send-email-david@porkrind.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Caldwell <david@porkrind.org>
X-From: git-owner@vger.kernel.org Fri Jun 24 22:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QaD2R-0006TY-Uj
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 22:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab1FXUbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 16:31:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58276 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab1FXUbb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 16:31:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p5OKV8x6015266
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 24 Jun 2011 22:31:08 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QaD1y-0005TF-E0; Fri, 24 Jun 2011 22:31:10 +0200
In-Reply-To: <1308945726-20910-1-git-send-email-david@porkrind.org> (David
	Caldwell's message of "Fri, 24 Jun 2011 13:02:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 24 Jun 2011 22:31:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p5OKV8x6015266
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1309552271.803@H2tduC7yiNthHgekQ+pZNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176314>

David Caldwell <david@porkrind.org> writes:

> The --include-untracked option acts like the normal "git stash save" but
> also adds all untracked files in the working directory to the stash and then
> calls "git clean --force --quiet"

Great you did it, that's indeed something I missed with git stash.

> +	(test -z "$untracked" || test -z $(untracked_files))

Shouldn't there be double quotes around $(untracked_files)?

> +		-u|--include-untracked)
> +			untracked=untracked
> +			;;
> +		-a|--all)
> +			untracked=all
> +			;;

I first thought of --all as a complement of --include-untracked, but in
your proposal, a simple

  git stash --all

is accepted. If you go this way, maybe there should be more symetry in
option naming. For example, --all could be --include-ignored.

Or you can consider that --all is short and sweet, and go for it ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
