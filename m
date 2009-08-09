From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH v2] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Sun, 09 Aug 2009 20:35:16 +0200
Message-ID: <vpq63cwdee3.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
	<87prb6r9d1.fsf@iki.fi> <vpqab2aqqia.fsf@bauges.imag.fr>
	<7vy6pujmsc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:41:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaDKk-00075E-E2
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbZHISlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbZHISlW
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:41:22 -0400
Received: from imag.imag.fr ([129.88.30.1]:59685 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbZHISlW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 14:41:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n79IZHhQ013428
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Aug 2009 20:35:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MaDEi-0000vC-4I; Sun, 09 Aug 2009 20:35:16 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MaDEi-00039M-2z; Sun, 09 Aug 2009 20:35:16 +0200
In-Reply-To: <7vy6pujmsc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 08 Aug 2009 09\:25\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 09 Aug 2009 20:35:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125364>

Junio C Hamano <gitster@pobox.com> writes:

> Instead of saying "Merge in", we could say "Integrate" to cover both
> practices.

I'm fine with both. I consider rebasing as a kind of merging, but ...

> I also happen to think that the mention of --force falls into the
> same category as "try shooting and then study if it hurgs".

Depending on the context. In the case of

git push
git commit --amend
git push

Pointing the user to 'git pull' is probably the thing which hurts the
most. And to me, the name --force already means "yes, I know what I'm
doing". My proposal was "[...] use git push --force to discard the
remote changes." which warns enough about the danger.

> So how about phrasing it like this?
>
>     Non-fast forward pushes were rejected because you would discard remote
>     changes you have not seen.  Integrate them with your changes and then
>     push again. See 'non-fast forward' section of 'git push --help'.

I thing not pointing to 'git pull' in the message really defeats the
purpose of the patch. I don't find an error message only telling me
"go read the doc as you should have done from the beginning" really
helps.

-- 
Matthieu
