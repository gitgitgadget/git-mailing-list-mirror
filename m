From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 15:57:45 +0200
Message-ID: <vpqfw5v1wva.fsf@grenoble-inp.fr>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<vpqvcer4xvo.fsf@grenoble-inp.fr>
	<CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:59:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJPTV-0001I3-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755673Ab2JCN6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:58:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54375 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2JCN6o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:58:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q93DqF60028955
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2012 15:52:15 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TJPSL-0004Bw-LZ; Wed, 03 Oct 2012 15:57:45 +0200
In-Reply-To: <CAB9Jk9BTCaV7RDx6_K+MKOeJTdOQPOwvnGM0UNxg9S8KMo4D4Q@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 13:52:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Oct 2012 15:52:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q93DqF60028955
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349877137.30862@paBWqdPvYkIjzdux+8BoEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206897>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> [...] making then the orphan branch point to the master one, i.e.
> becoming a non-orphan one.

I understand both parts of the sentense, but not the "i.e.".

And I still don't see a concrete problem. "two branches point to the
same commit" is not a problem, it's an observation. I have branches
pointing to the same commit all the time.

>> I ended up with a branch "master" and a branch "new-branch", both
>> pointing to the same commit. The new branch _is_ created.
>
> Exactly, it is created, but it is not an orphan ... or more precisely,
> it is sometimes, depending on how fast you are to enter the second
> commit command. This time-dependent behaviour is what I am talking
> about.

You don't understand what an orphan branch is.

What "git checkout --orphan && git commit" does is that it creates a
commit that doesn't have parent (hence the name orphan, btw). It does in
your case. You _do_ create an orphan commit regardless of the timing.

The fact that another branch points to the same commit is a different
matter, and you still didn't explain why this was problematic.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
