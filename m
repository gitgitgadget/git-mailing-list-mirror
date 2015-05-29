From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] potential error in parsing git checkout options?
Date: Fri, 29 May 2015 14:23:02 +0200
Message-ID: <vpqiobb7eu1.fsf@anie.imag.fr>
References: <854038739.144343.1432895421483.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>
To: Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri May 29 14:24:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyJJi-0003EG-0i
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 14:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbbE2MXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 08:23:09 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40088 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbbE2MXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 08:23:07 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4TCN1SG027273
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 14:23:01 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4TCN2Gs031585;
	Fri, 29 May 2015 14:23:02 +0200
In-Reply-To: <854038739.144343.1432895421483.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Guillaume Pages's message of "Fri, 29 May 2015 12:30:21 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 14:23:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4TCN1SG027273
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433506983.26084@eCsW45QXs/w/oQw6o/tnKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270238>

Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> Git version : 2.4.1.652.g8fd8657 
>
> When we run git checkout -babar, we would expect an error message like 
> "unknown switch 'a' " and we get "Switched to a new branch 'abar'".

Yes, the option-parser accepts sticked form (-bbranch) and unsticked (-b
branch). This is the convention with most Unix commands (try "grep -e
foo" Vs "grep -efoo").

It gets more confusing for "git -amend" Vs "git --amend", which got a
special-case to avoid confusion (strictly speaking, it should have been
equivalent to "git commit -a -m end").

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
