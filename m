From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/5 v2] unpack_trees_options: update porcelain messages
Date: Tue, 15 Jun 2010 15:05:30 +0200
Message-ID: <vpqfx0ozbs5.fsf@bauges.imag.fr>
References: <1276604576-28092-1-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-2-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-3-git-send-email-diane.gasselin@ensimag.imag.fr>
	<1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 15 15:06:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOVqI-00021W-Lk
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 15:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0FONGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 09:06:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34260 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab0FONGI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 09:06:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FCvUop018210
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 14:57:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OOVpa-0003Wv-Ob; Tue, 15 Jun 2010 15:05:30 +0200
In-Reply-To: <1276604576-28092-4-git-send-email-diane.gasselin@ensimag.imag.fr> (Diane Gasselin's message of "Tue\, 15 Jun 2010 14\:22\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 14:57:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FCvUop018210
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277211454.82334@nME+SBXiNCAQHb8t7g3AkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149181>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> -	msgs.would_overwrite = malloc(sizeof(char) * 72);
> +	msgs.would_overwrite = malloc(sizeof(char) * 80);
>  	sprintf((char *)msgs.would_overwrite,
> -		"Your local changes to '%%s' would be overwritten by %s.  Aborting.",
> +		"Your local changes to the following files would be overwritten by %s:\n%%s",

I hate hardcoded string length (these magic 80 and 72). Can't it be
stg like

const char * const msg = "Your local changes to ....";
msg.would_overwrite = malloc(strlen(msg) + strlen(cmd) + something);
sprintf(msg.would_overwrite, msg, ...);

instead?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
