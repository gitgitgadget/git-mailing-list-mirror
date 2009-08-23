From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH 2/2 (v3)] reset: make the output more user-friendly.
Date: Sun, 23 Aug 2009 12:42:29 +0200
Message-ID: <vpqiqgevmju.fsf@bauges.imag.fr>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
	<1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
	<1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
	<7v3a7k767j.fsf@alter.siamese.dyndns.org>
	<vpq8whc8euu.fsf@bauges.imag.fr>
	<7vmy5r1cpo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 12:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfAZN-0001QF-Le
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 12:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755980AbZHWKmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 06:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755929AbZHWKmf
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 06:42:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51145 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755883AbZHWKme (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 06:42:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n7NAdWFJ005805
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 23 Aug 2009 12:39:32 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MfAWr-000303-S8; Sun, 23 Aug 2009 12:42:29 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MfAWr-0000kW-Pn; Sun, 23 Aug 2009 12:42:29 +0200
In-Reply-To: <7vmy5r1cpo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 22 Aug 2009 19\:33\:07 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 23 Aug 2009 12:39:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7NAdWFJ005805
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1251628773.23473@ULKmuS7F8MKVUjv9h364BQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126855>

Junio C Hamano <gitster@pobox.com> writes:

> Two conflicting/competing thoughts come to mind:
>
>  1. Perhaps we should add a similar "explanation" for the list of paths
>     with changes upon switching branches with "git checkout" for
>     consistency.

Actually, I had never paid much attention to this message for
checkout. Just checked, and I got it wrong too ;-). I thought checkout
was showing me the files it was modifying, that wasn't it.

That said, I'm not a heavy user of local branches, so I'm a bad judge
on what should be the behavior.

>  2. Such an "explanation" of what the output means would help the first
>     time people, but would everybody stay "first time" forever?  Would the
>     explanation become just another wasted line in valuable screen real
>     estate after people gain experience?

Yes, and this is a much more general issue than just checkout/reset.
For example, the output of 'git status' is very nice to newbies:

  # On branch master
  # Changed but not updated:
  #   (use "git add <file>..." to update what will be committed)
  #   (use "git checkout -- <file>..." to discard changes in working directory)
  #
  #       modified:   git.c
  #
  no changes added to commit (use "git add" and/or "git commit -a")

But out of these 8 lines, only two contain real informations, and the
(use "git bla") are just noise to expert users.

I've been thinking of a configuration option, like "core.expertuser"
or "ui.expertuser" that would let users disable these informative
messages on demand. I'm not sure how good the idea is.

--
Matthieu
