From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: On using receive.denyNonFastForwards and advice.pushNonFastForward
Date: Mon, 09 Jul 2012 10:36:55 +0200
Message-ID: <vpqobnpz5y0.fsf@bauges.imag.fr>
References: <CAE1pOi1M-fdMJtZw9MNL2R6zWvpXvWVo4ros_NSCQtLmQb6TOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 10:37:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1So9St-0007RS-2S
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 10:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446Ab2GIIhA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 04:37:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35694 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751764Ab2GIIg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 04:36:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q698ZWHE020714
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 9 Jul 2012 10:35:32 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1So9Si-0005Vc-2L; Mon, 09 Jul 2012 10:36:56 +0200
In-Reply-To: <CAE1pOi1M-fdMJtZw9MNL2R6zWvpXvWVo4ros_NSCQtLmQb6TOQ@mail.gmail.com>
	(Hilco Wijbenga's message of "Sun, 8 Jul 2012 14:26:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 09 Jul 2012 10:35:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q698ZWHE020714
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1342427732.66184@i6srFvlPijKbkKxZTq3pSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201197>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> I was wondering how hard it would be to make "git push" more adamant
> about not pushing non-ff updates. So I wanted to see the effects of
> receive.denyNonFastForwards

This changes the behavior only if you use --force (or some magic refspec
starting with +). If you never used --force or +refspecs, you never did
a non-fast-forward push.

> and advice.pushNonFastForward.

Activated by default, so if you never did anything about it, it was
already active.

> Apparently, linear history and FF-only updates are not the same thing?

No, they are not. non-FF means you're trying to push a commit which is
not a direct descendant of the remote one, i.e. you're trying to
override the remote history with yours. See 'NOTE ABOUT FAST-FORWARDS'
in "man git-push".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
