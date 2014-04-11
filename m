From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 0/9] Introduce publish tracking branch
Date: Fri, 11 Apr 2014 19:25:02 +0200
Message-ID: <vpqd2gng4nl.fsf@anie.imag.fr>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
	<vpqtxa0jkfo.fsf@anie.imag.fr>
	<20140411142504.GA25376@nysa.casa.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 19:29:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYfGa-0005wB-SC
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 19:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbaDKR26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 13:28:58 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35380 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735AbaDKR2p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 13:28:45 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3BHP0fJ003004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2014 19:25:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3BHP2nk006105;
	Fri, 11 Apr 2014 19:25:02 +0200
In-Reply-To: <20140411142504.GA25376@nysa.casa.local> (Felipe Contreras's
	message of "Fri, 11 Apr 2014 09:25:04 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Apr 2014 19:25:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3BHP0fJ003004
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397841903.43053@pXq7sVrgGRLlOnbeuTktrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246111>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> My patch series only affects push.default=simple, perhaps you have a
> different configuration.

Good catch. I have push.default=upstream (essentially for compatibility
with old Git versions, I'd prefer simple actually).

> Maybe we want the publish branch to override any push.default, so:

Not sure actually. If a user says "push.default=upstream", it seems
weird to push to something other than upstream indeed. What's clear to
me is that your patch in its current form clearly makes "simple" a much
better default than "upstream" (good news, it it the default!).

That said, the advice given by "git status" is clearly wrong:

> >   $ git status
> >   On branch master
> >   Your branch is ahead of 'origin/new' by 4 commits.
> >     (use "git push" to publish your local commits)

It should say (use "git push origin new" to publish your local commits)
with push.default=upstream and the current behavior of the patch.

Perhaps argumentless "git push" could warn when push.default=upstream
and branch.<name>.publish is configured, I'm not sure.

Sorry, more questions and "I'm not sure" than actual suggestion :-(.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
