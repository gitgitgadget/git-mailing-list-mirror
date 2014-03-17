From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] branch.c: simplify chain of if statements
Date: Mon, 17 Mar 2014 08:23:40 +0100
Message-ID: <vpqsiqhz3sz.fsf@anie.imag.fr>
References: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dragos Foianu <dragos.foianu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:24:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPRu4-0000Zr-GB
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 08:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756238AbaCQHXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 03:23:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50720 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbaCQHXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 03:23:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2H7NeGe012741
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Mar 2014 08:23:40 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2H7NeOI021495;
	Mon, 17 Mar 2014 08:23:40 +0100
In-Reply-To: <1395004962-18200-1-git-send-email-dragos.foianu@gmail.com>
	(Dragos Foianu's message of "Sun, 16 Mar 2014 23:22:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 17 Mar 2014 08:23:40 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2H7NeGe012741
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1395645821.9552@oWF4jFNlWaQtzuVePTy94g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244226>

Dragos Foianu <dragos.foianu@gmail.com> writes:

> +	const char *verbose_prints[4] = {
> +		"Branch %s set up to track remote branch %s from %s%s",
> +		"Branch %s set up to track local branch %s%s",
> +		"Branch %s set up to track remote ref %s%s",
> +		"Branch %s set up to track local ref %s%s"
> +	};
> +	char *verbose_rebasing = rebasing ? " by rebasing." : ".";
> +

This seems to be a "lego construct" that makes translation harder: are
you sure that the "by rebasing" will be at the end of the sentence in
any languages?

Also, this lacks the _() on verbose_rebasing, which isn't translatable
anymore after your patch.

I personnally think that the table-driven approach is wrong here, it
makes the code shorter but much harder to read.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
