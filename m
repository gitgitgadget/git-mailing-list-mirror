From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] subtree: fix argument validation in add/pull/push
Date: Wed, 27 Nov 2013 20:19:29 +0100
Message-ID: <87siuhfy9q.fsf@thomasrast.ch>
References: <1385577249-29269-1-git-send-email-Anthony.Baire@irisa.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Anthony Baire <Anthony.Baire@irisa.fr>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:19:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlkeI-0000jc-Kb
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab3K0TTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 14:19:42 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:60692 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab3K0TTl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 14:19:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5B48E4D65A0;
	Wed, 27 Nov 2013 20:19:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PGl9fh8SqDMk; Wed, 27 Nov 2013 20:19:30 +0100 (CET)
Received: from linux-1gf2.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id C10D44D659F;
	Wed, 27 Nov 2013 20:19:29 +0100 (CET)
In-Reply-To: <1385577249-29269-1-git-send-email-Anthony.Baire@irisa.fr>
	(Anthony Baire's message of "Wed, 27 Nov 2013 19:34:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238457>

Anthony Baire <Anthony.Baire@irisa.fr> writes:

> When working with a remote repository add/pull/push do not accept a
> <refspec> as parameter but just a <ref>. They should accept any
> well-formatted ref name.
[...]
>  - update the doc to use <ref> instead of <refspec>
[...]
>  OPTS_SPEC="\
>  git subtree add   --prefix=<prefix> <commit>
> -git subtree add   --prefix=<prefix> <repository> <commit>
> +git subtree add   --prefix=<prefix> <repository> <ref>
>  git subtree merge --prefix=<prefix> <commit>
> -git subtree pull  --prefix=<prefix> <repository> <refspec...>
> -git subtree push  --prefix=<prefix> <repository> <refspec...>
> +git subtree pull  --prefix=<prefix> <repository> <ref>
> +git subtree push  --prefix=<prefix> <repository> <ref>
>  git subtree split --prefix=<prefix> <commit...>
[...]
> @@ -68,7 +68,7 @@ COMMANDS
>  --------
>  add::
>  	Create the <prefix> subtree by importing its contents
> -	from the given <refspec> or <repository> and remote <refspec>.
> +	from the given <commit> or <repository> and remote <ref>.

AFAICS you are changing refspec->commit in the manpage, but commit->ref
in the usage message for 'subtree add'?  How does this line up?

-- 
Thomas Rast
tr@thomasrast.ch
