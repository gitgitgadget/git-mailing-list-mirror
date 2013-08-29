From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 20:50:30 +0200
Message-ID: <vpqli3kqqkp.fsf@anie.imag.fr>
References: <20130829180129.GA4880@nysa>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF7Ir-0001Pa-GG
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070Ab3H2Sul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:50:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40659 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752093Ab3H2Sul (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 14:50:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TIoSWM007365
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 20:50:28 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF7Ic-00035y-Q3; Thu, 29 Aug 2013 20:50:30 +0200
In-Reply-To: <20130829180129.GA4880@nysa> (Felipe Contreras's message of "Thu,
	29 Aug 2013 13:01:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 20:50:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TIoSWM007365
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378407033.51019@1YxRBIGL5yithSdiH/eoHw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233335>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It has been discussed many times in the past that 'index' is not an
> appropriate description for what the high-level user does with it, and
> it has been agreed that 'staging area' is the best term.

Thanks for working on this. No time for a really detailed review, but a
few remarks.

> The term 'staging area' is more intuitive [...]
>
> The first step in moving Git towards this term, is first to add --stage
> options for every command that uses --index or --cache.

These explanations make sense. I think it would be better to put part of
it in commit messages, so that future contributors can "git blame" the
doc/implem of these --stage and find them (i.e. avoid the
misunderstanding that occured with "git stage" command which was
proposed for removal).

> After adding the new --stage options and making sure no functionality is
> lost, they can become the recommended ones in the documentation,
> eventually, the old ones get deprecated, and eventually obsoleted.

Same: putting this in the commit message would cast in stone that we
want to obsolete the old ones.

(But that was nice to have this cover-letter)

> Moreover, the --stage and --work

--work alone sounds weird. At least to me, it does not immediately imply
"working tree". It is tempting to call the option --work-tree, but git
already has a global option with that name (git --work-tree=foo bar).

Perhaps --worktree to limit the confusion?

> reset', and after these options are added, the complicated table to
> explain the different behaviors between --soft, --mixed, and --hard
> becomes so simple it's not needed any more:

I didn't understand the table, but yes, the --soft, --mixed, and --hard
is terrible, I need to read the doc whenever I do something non-trivial
with reset :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
