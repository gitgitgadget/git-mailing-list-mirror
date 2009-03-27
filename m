From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 14:44:13 +0100
Message-ID: <vpq63hvdqs2.fsf@bauges.imag.fr>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	<37fcd2780903270524x1987a622wb9e693be41fc02c4@mail.gmail.com>
	<49CCE421.16918.2582FE84@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: "Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 14:50:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnCRT-00069j-52
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 14:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbZC0NsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 09:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbZC0NsK
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 09:48:10 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:56894 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752757AbZC0NsI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 09:48:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n2RDiEnF012158;
	Fri, 27 Mar 2009 14:44:14 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LnCM1-0001iS-NL; Fri, 27 Mar 2009 14:44:13 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LnCM1-0003v0-Kt; Fri, 27 Mar 2009 14:44:13 +0100
In-Reply-To: <49CCE421.16918.2582FE84@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> (Ulrich Windl's message of "Fri\, 27 Mar 2009 14\:35\:13 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Fri, 27 Mar 2009 14:44:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114891>

"Ulrich Windl" <ulrich.windl@rz.uni-regensburg.de> writes:

> I don't understand:
> If I modify files, then do a make, then do check-in/check-out (and the file times 
> are unchanged), how would that affect make?

>From "make"'s point of view, chechout is just a modification of the
file (as any other modification you would do with a text editor). If
you compile foo.c to foo.o, then checkout another version of foo.c,
then you want foo.c to be recompiled. If checkout modifies the
timestamp to pretend it was modified before foo.o, then make thinks
the file is up to date.

> If I do an "update/merge from remote" (there is no total ordering of release 
> numbers anyway) without a "make clean" before, I'm having a problem
> anyway.

No, you don't have a problem. Recompiling files after they're modified
is the job of make, and it just does it. make doesn't know about
revision numbers or identifiers, just timestamps.

-- 
Matthieu
