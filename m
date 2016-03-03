From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature request: Configurable prefixes for git commit --fixup and --squash
Date: Thu, 03 Mar 2016 16:59:02 +0100
Message-ID: <vpq1t7rlfi1.fsf@anie.imag.fr>
References: <CALHmdRz3ffgifH2BZK14B=4LGFqOeTWpRarD+RAFx8AtwwMidg@mail.gmail.com>
	<20160303132128.GE1766@serenity.lan>
	<CALHmdRwgDjRJMQSPzp34aS25ZHg-mr458QeyYgyp85q8g34Aig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, authmillenon@riot-os.org, john@keeping.me.uk
To: Martine Lenders <mlenders@riot-os.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:59:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abVes-0002ZO-Ks
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 16:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbcCCP7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 10:59:18 -0500
Received: from mx2.imag.fr ([129.88.30.17]:41277 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbcCCP7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 10:59:17 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u23Fx0cQ008441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Mar 2016 16:59:00 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u23Fx2sI030813;
	Thu, 3 Mar 2016 16:59:02 +0100
In-Reply-To: <CALHmdRwgDjRJMQSPzp34aS25ZHg-mr458QeyYgyp85q8g34Aig@mail.gmail.com>
	(Martine Lenders's message of "Thu, 3 Mar 2016 15:33:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 03 Mar 2016 16:59:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u23Fx0cQ008441
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457625545.38501@HR/kGClLiiXy+yA7Koi8Gg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288185>

Martine Lenders <mlenders@riot-os.org> writes:

> Hi John,
> yes, it can be anywhere in the commit message and I already thought
> about using a hook for generating the commit message too, but the
> problem is then, that `git rebase` won't pair up the commit for
> squashing/fixing up with the original commit.

It won't match if you put it in the subject line, but John's proposal is
to put it at the bottom (i.e. in the body). This won't disturb "git
rebase --autosquash".

> Maybe another approach could be to allow for a configuration of a
> string that is ignored when matching the commit messages in `git
> rebase`.

I wish I could write commit messages like

fixup! deadbeef: fix typo (foo -> bar)

So that the commit message contains both the instruction for "rebase
--autosquash" and a quick explanation of what the commit is doing (as
usual commit messages).

AFAIK, it's not possible currently but shouldn't be hard to implement.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
