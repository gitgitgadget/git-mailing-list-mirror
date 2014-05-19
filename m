From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: bug: autostash is lost after aborted rebase
Date: Mon, 19 May 2014 11:16:34 +0200
Message-ID: <vpqlhtym8lp.fsf@anie.imag.fr>
References: <20140519005719.GB38299@tequila>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Karen Etheridge <ether@cpan.org>
X-From: git-owner@vger.kernel.org Mon May 19 11:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmJgf-0001Gr-9c
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 11:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbaESJQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 05:16:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37182 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbaESJQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 05:16:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s4J9GXnl013388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 May 2014 11:16:33 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4J9GYJR015864;
	Mon, 19 May 2014 11:16:34 +0200
In-Reply-To: <20140519005719.GB38299@tequila> (Karen Etheridge's message of
	"Sun, 18 May 2014 17:57:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 19 May 2014 11:16:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4J9GXnl013388
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1401095797.09385@/g5CNxYBm+YVs3ON+YOvPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249567>

[ Cc-ing Ramkumar ]

Karen Etheridge <ether@cpan.org> writes:

> scenario: 
> - edit some tracked files; do not add them to the index
> - "git config rebase.autostash true"
> - "git rebase -i HEAD~3" (an autostash will be created)
> - delete the entire buffer and save/exit the editor - this will abort the
>   rebase
>
> poof, the autostash is gone (it is not reapplied) -- it must be explicitly
> applied again via the SHA that was printed earlier.

Indeed. Confirmed, even with pu (I thought I remembered seeing a fix on
the list, but I must have mixed up with something else).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
