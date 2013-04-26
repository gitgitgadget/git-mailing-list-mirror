From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Fri, 26 Apr 2013 15:23:55 +0200
Message-ID: <vpqk3npctn8.fsf@grenoble-inp.fr>
References: <517298D4.3030802@drmicha.warpmail.net>
	<043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
	<7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
	<5177AE7F.1040400@drmicha.warpmail.net>
	<7vehdzesr9.fsf@alter.siamese.dyndns.org>
	<vpqwqrrolpl.fsf@grenoble-inp.fr>
	<7v38ufdaih.fsf@alter.siamese.dyndns.org>
	<517A6C0C.1020506@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 26 15:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVidY-0002XC-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 15:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031Ab3DZNYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 09:24:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51726 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab3DZNYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 09:24:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r3QDNsQe020851
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 26 Apr 2013 15:23:54 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UVid2-0001wW-32; Fri, 26 Apr 2013 15:23:56 +0200
In-Reply-To: <517A6C0C.1020506@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 26 Apr 2013 13:59:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 26 Apr 2013 15:23:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r3QDNsQe020851
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1367587439.66804@5yUumfa6d51Cnfox1oDtHQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222532>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> BTW, textconv does not have to be slow - just use textconv-cache.

Right, thanks for reminding me about this, I had forgotten its existance ;-).

> I'm still looking for a way to at least treat "git grep" and "git show
> blob" the same way.

I agree they should be treated similarly.

> - Implement the --textconv option but leave the default as is. I did
> that for "git grep" already (just drop 7/7)

That seems sensible.

> but it seems to be cumbersome for "git show blob". I have to recheck.

It should be possible to have a tri-state for the --[no-]textconv
option: unset, set to true or set to false. But the code sharing between
log, show and diff might make that non-trivial.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
