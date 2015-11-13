From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 17:52:22 +0100
Message-ID: <vpqio55j0zd.fsf@anie.imag.fr>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Fredrik Medley <fredrik.medley@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 17:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxHaT-00081Z-4f
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 17:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933228AbbKMQw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 11:52:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:40168 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933227AbbKMQw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 11:52:28 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tADGqL3U021095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 13 Nov 2015 17:52:21 +0100
Received: from anie (ensi-vpn-227.imag.fr [129.88.57.227])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tADGqM63004052;
	Fri, 13 Nov 2015 17:52:23 +0100
In-Reply-To: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
	(Fredrik Medley's message of "Fri, 13 Nov 2015 07:03:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 13 Nov 2015 17:52:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tADGqL3U021095
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1448038344.204@CyNY1gq6RTf+JiCVzOUZiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281257>

Fredrik Medley <fredrik.medley@gmail.com> writes:

> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -610,7 +610,7 @@ do_next () {
>  		read -r command rest < "$todo"
>  		mark_action_done
>  		printf 'Executing: %s\n' "$rest"
> -		${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
> +		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution

Looks good to me. Don't know why I didn't add these double quotes when I
introduced this line. Thanks for fixing it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
