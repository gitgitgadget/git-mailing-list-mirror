From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sun, 10 Jun 2012 15:18:54 +0200
Message-ID: <vpqvcizmhj5.fsf@bauges.imag.fr>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Javier.Roucher-Iglesias@ensimag.imag.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 15:19:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdi2p-0000d0-FH
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 15:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754561Ab2FJNS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 09:18:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:36231 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754586Ab2FJNS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 09:18:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q5AD9shW001604
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 10 Jun 2012 15:09:54 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sdi2h-0004Mz-Bc; Sun, 10 Jun 2012 15:18:55 +0200
In-Reply-To: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
	(Javier Roucher-Iglesias's message of "Sat, 9 Jun 2012 20:45:02
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 10 Jun 2012 15:09:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5AD9shW001604
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339938595.47495@1GtxLOCZcoT2/SKdYmC/WA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199601>

Javier.Roucher-Iglesias@ensimag.imag.fr writes:

> +static const char usage_msg[] =
> +"credential <fill|approve|reject>";
[...]
> +	for (i = 2; i < argc; i++)
> +		string_list_append(&c.helpers, argv[i]);

This helpers argument is still there, and is now totally undocumented. I
shouldn't have to repeat that so many times.

> --- a/git.c
> +++ b/git.c
> @@ -353,6 +353,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
>  		{ "config", cmd_config, RUN_SETUP_GENTLY },
>  		{ "count-objects", cmd_count_objects, RUN_SETUP },
> +		{ "credential", cmd_count_objects, RUN_SETUP },

Your "git credential" runs cmd_count_objects. A little bit of testing
should have found that (my remarks about lack of testing still apply).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
