From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] stripspace: Implement --count-lines option
Date: Thu, 15 Oct 2015 18:52:54 +0200
Message-ID: <vpqzizkysyh.fsf@grenoble-inp.fr>
References: <1444911524-14504-1-git-send-email-tklauser@distanz.ch>
	<1444911524-14504-3-git-send-email-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Thu Oct 15 18:53:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zmlm8-0004Oy-P7
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 18:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbJOQxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 12:53:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35250 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885AbbJOQxE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 12:53:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9FGqpXh011152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 15 Oct 2015 18:52:52 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9FGqsxe023432;
	Thu, 15 Oct 2015 18:52:54 +0200
In-Reply-To: <1444911524-14504-3-git-send-email-tklauser@distanz.ch> (Tobias
	Klauser's message of "Thu, 15 Oct 2015 14:18:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 15 Oct 2015 18:52:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9FGqpXh011152
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445532773.23894@Blb3CeD2y/VP6+IehHA4FQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279673>

Tobias Klauser <tklauser@distanz.ch> writes:

> --- a/Documentation/git-stripspace.txt
> +++ b/Documentation/git-stripspace.txt
> @@ -9,7 +9,7 @@ git-stripspace - Remove unnecessary whitespace
>  SYNOPSIS
>  --------
>  [verse]
> -'git stripspace' [-s | --strip-comments] < input
> +'git stripspace' [-s | --strip-comments] [-C | --count-lines] < input

I'm not sure it's a good idea to introduce a one-letter shortcut (-C).
In scripts, --count-lines is self-explanatory hence more readable than
-C (which is even more confusing since "git -C foo stripspace" and "git
stripspace -C" have totally different meanings. Outside scripts, I'm not
sure the command would be useful. I'd rather avoid polluting the
one-letter-option namespace.

> +Use 'git stripspace --count-lines' to obtain:
> +
> +---------
> +|5$
> +---------

In the examples above, I read the | as part of the input (unlike $ which
is used only to show the end of line). So the | should not be here. I
don't think you need the $ either, the --count-lines option is no longer
about trailing whitespaces.

> +static const char * const usage_msg[] = {

Stick the * to usage_msg please.

No time to review the rest for now sorry.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
