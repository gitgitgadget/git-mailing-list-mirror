From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: respect advice.statusHints for ahead/behind advice
Date: Mon, 03 Dec 2012 09:49:00 +0100
Message-ID: <vpqtxs31pxf.fsf@grenoble-inp.fr>
References: <20121203061656.GA20164@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 09:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfRiP-0005Eo-OH
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 09:49:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085Ab2LCItJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 03:49:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:43736 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab2LCItI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 03:49:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qB38dErL001424
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 3 Dec 2012 09:39:14 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TfRi1-0005rt-9K; Mon, 03 Dec 2012 09:49:01 +0100
In-Reply-To: <20121203061656.GA20164@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 3 Dec 2012 01:16:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 03 Dec 2012 09:39:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qB38dErL001424
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1355128755.21263@vLy946zMkuyuGvxnNScXBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211034>

Jeff King <peff@peff.net> writes:

> If the user has unset advice.statusHints, we already
> suppress the "use git reset to..." hints in each stanza. The
> new "use git push to publish..." hint is the same type of
> hint. Let's respect statusHints for it, rather than making
> the user set yet another advice flag.

Sorry, I should have made this in the patch.

With or without my suggestion below,

Acknowledged-by: Matthieu Moy <Matthieu.Moy@imag.fr>

> I left "git checkout" alone, though I'd also like to turn it off there,
> too. Should it get a separate advice option there? Should it simply
> respect statusHints (it seems odd because I know that "status" there
> means "git status", not "hints about the status of your repo")?

I'd respect the same statusHint indeed. It's the same message, so I
think the same category of users will want to disable it. The name
"statusHint" may not be the ideal one, but if you see the messages in
"git checkout" as an excerpt of "git status", it actually makes sense.

As a nice side effect, it also makes the code/patch simpler (no need to
add the "advice" argument).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
