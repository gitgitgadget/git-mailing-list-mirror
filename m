From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] microproject for GSOC
Date: Fri, 14 Mar 2014 18:10:57 +0100
Message-ID: <vpq4n30aeou.fsf@anie.imag.fr>
References: <1394815367-9706-1-git-send-email-ubuntu2012@126.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: ubuntu733 <ubuntu2012@126.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:11:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOVda-0002qw-HV
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 18:11:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbaCNRLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 13:11:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52014 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182AbaCNRLI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 13:11:08 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2EHAt0F032191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2014 18:10:55 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2EHAv69027126;
	Fri, 14 Mar 2014 18:10:57 +0100
In-Reply-To: <1394815367-9706-1-git-send-email-ubuntu2012@126.com> (ubuntu's
	message of "Sat, 15 Mar 2014 00:42:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 14 Mar 2014 18:10:56 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2EHAt0F032191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395421856.45881@iT6E9x+pAF8OVgqwPDkSmw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244098>

Hi,

Welcome to the Git community, and welcome to the GSOC program. Below are
some comments to give you a taste of what a review looks like on this
list. Do take the comments seriously (they should be addressed), but
don't take them badly: critic is meant to be constructive.

ubuntu733 <ubuntu2012@126.com> writes:
^^^^^^^^^

Please, use a real name when you contribute to Git.

> Apply for GSOC.The microprojects is rewriter diff-index.c

This part of your message will become the commit message (i.e. cast in
stone forever in git.git's history). The point is not that you want to
apply for GSOC, but what the patch does and more importantly why it does
it.

> +#define REMOVE 1

If the code is to be removed, then remove it. That's why we use a
version control system ;-).

> -	while ((e = readdir(dir)))
> -		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> -			string_list_insert(list, e->d_name);
> -
> +	while ((e = readdir(dir))) {
> +		while(is_dot_or_dotdot(e->d_name))

Missing space between "while" and "(".

> +                      break;

Broken indentation (indent with space).

This while (...) break; seems really weird to me: if the condition is
false, then you exit the loop because it's a while loop, and if the
condition is true, you exit the loop because of the break. Isn't that a
no-op?

> +		string_list_insert(list, e->d_name);
> +              }

Broken indentation (misplaced }).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
