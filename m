From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2 (v3)] reset: make the output more user-friendly.
Date: Sat, 22 Aug 2009 09:52:41 +0200
Message-ID: <vpq8whc8euu.fsf@bauges.imag.fr>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
	<1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
	<1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v3a7k767j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 09:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MelPW-00028T-GI
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 09:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242AbZHVHxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 03:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbZHVHxF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 03:53:05 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54015 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932398AbZHVHxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 03:53:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7M7nlJb000509
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 22 Aug 2009 09:49:47 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MelOz-000881-Dz; Sat, 22 Aug 2009 09:52:41 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MelOz-0001XQ-Ba; Sat, 22 Aug 2009 09:52:41 +0200
In-Reply-To: <7v3a7k767j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 21 Aug 2009 22\:44\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sat, 22 Aug 2009 09:49:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7M7nlJb000509
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251532189.27274@GOTpskrnXbNW101F8jODrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126801>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  Will queue.

Thanks,

> However, I'd change the justification.

Fine with me.

> The output from reset in question is merely an informative side effect, as
> opposed to what you actively ask "git diff" to give as its primary output.
> As such, your "consistency" argument is pretty weak.  There is no reason
> to expect that the informative message to resemble one particular format
> (namely, --name-status) and not another (e.g. --stat or --name-only),

I agree that chosing --name-status over, like, --stat is rather
arbitrary. But Git has IMHO far too many languages for talking about
changes (--stat, --name-status, 'git status' itself, the 'git ls-files
-t' that I just discovered, and this 'bla: locally modified').
Reducing the number of formats by one is a good thing to me.

> Informative output from "git checkout $branch" when there are local
> changes is a much better precedent to refer to.

Yes.

> I am somewhat inclined to suggest that we should drop the new "Unstaged
> changes after ..." message, though.

I've thought about this too. The new format already looks much less
like an error message, which was really the problem I was solving. But
one advantage of the message contains two relevant informations:
"unstaged" and "after".

Intuitively, I would have thought that "git reset" was reporting what
it was doing, as it was doing it. So to me (before experimenting a bit
more and looking at the source code),

M	foo.txt
M	bar.txt

would mean "I've just reseted foo.txt and bar.txt, which were locally
modified", while actually "git reset" can very well show this message
after reseting only foo.txt, just informing the user that bar.txt is
also modified. So, at least to me, the semantics was very unclear, and
while I would have understood immediately with the one-liner message.

In short: no strong objection to remove this message, but to me it is
usefull.

-- 
Matthieu
