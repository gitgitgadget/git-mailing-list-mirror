From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Sun, 06 May 2012 12:03:49 +0200
Message-ID: <vpqobq1mxru.fsf@bauges.imag.fr>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Sun May 06 12:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQyK2-00074i-M8
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 12:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196Ab2EFKD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 06:03:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42387 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab2EFKD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 06:03:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q469umfd023657
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2012 11:56:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SQyJi-0007nZ-Q4; Sun, 06 May 2012 12:03:50 +0200
In-Reply-To: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
	(Antonio Ospite's message of "Sat, 5 May 2012 13:26:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 May 2012 11:56:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q469umfd023657
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336903011.26422@w/iWybdDge2Ef8zosCwK7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197160>

Antonio Ospite <ospite@studenti.unina.it> writes:

> Maybe this -x option should conflict with -i to simplify its "execute
> the command after each commit" semantics (what if it is combined with -i
> and 'x/exec' lines?).

Actually, implementation-wise, it's simpler to have '-x' imply '-i', and
suggest a todo-list containing 'x' lines. Then, the code would simply
have to add these "x whatever" lines, and let the
"git-rebase--interactive.sh" mechanics do the job. That would show the
"x whatever" lines to the user, but that can be seen as added value,
since it gives an opportunity to the user to remove or edit some of them
if needed.

I'm not familiar with the code behind non-interactive rebase, but it
doesn't seem to use the same todo-list at all. Maybe the sequencer would
help, I don't know.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
