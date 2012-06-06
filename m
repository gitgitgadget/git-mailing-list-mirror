From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 06 Jun 2012 22:03:48 +0200
Message-ID: <vpqvcj48axn.fsf@bauges.imag.fr>
References: <1338817674-22877-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Lucien Kong <Lucien.Kong@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:04:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScMSg-0007Wc-6j
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 22:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168Ab2FFUD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 16:03:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56249 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758164Ab2FFUDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 16:03:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q56Jt1XS008447
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jun 2012 21:55:01 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ScMSL-00016x-9Q; Wed, 06 Jun 2012 22:03:49 +0200
In-Reply-To: <1338978856-26838-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	(Lucien Kong's message of "Wed, 6 Jun 2012 12:34:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Jun 2012 21:55:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q56Jt1XS008447
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339617303.74522@/cxupmjNBBI7Ay5ruVAlrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199348>

Lucien Kong <Lucien.Kong@ensimag.imag.fr> writes:

> @@ -210,11 +210,29 @@ rebase.autosquash::
>  
>  OPTIONS
>  -------
> -<newbase>::
> -	Starting point at which to create the new commits. If the
> -	--onto option is not specified, the starting point is
> -	<upstream>.  May be any valid commit, and not just an
> -	existing branch name.
> +-x <cmd>::
> +--exec <cmd>::
> +	Automatically add "exec" followed by <cmd> between each commit
> +	applications. Using this option along with --autosquash adds
> +	the exec line after the squash/fixeup series only. <cmd>
> +	stands for shell commands. The --exec option has to be
> +	specified. (see INTERACTIVE MODE below)

It would make sense to split that into two patches, one to fix --onto's
documentation, and the next one to add --exec. I won't insist on that
though (but maybe others will).

> ++
> +This has to be used along with the `--interactive` option explicitly.
> +You may execute several commands between each commit applications.
> +For this, you can use one instance of exec:
> +	git rebase -i --exec "cmd1; cmd2; ...".
> +You can also insert several instances of exec, if you wish to
> +only have one command per line for example:
> +	git rebase -i --exec "cmd1" --exec "cmd2" ...

This formats badly in asciidoc (try "make doc" and see the generated
HTML).

Try this:

This has to be used along with the `--interactive` option explicitly.
You may execute several commands between each commit applications.
For this, you can use one instance of exec:
+
	git rebase -i --exec "cmd1; cmd2; ...".
+
You can also insert several instances of exec, if you wish to
only have one command per line for example:
+
	git rebase -i --exec "cmd1" --exec "cmd2" ...



-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
