From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Tue, 06 Sep 2011 09:39:05 +0200
Message-ID: <vpqvct69l2e.fsf@bauges.imag.fr>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org>
	<20110902000039.GB9339@sigill.intra.peff.net>
	<4E6088F9.5070102@drmicha.warpmail.net>
	<20110902152947.GB19213@sigill.intra.peff.net>
	<7v4o0uncq0.fsf@alter.siamese.dyndns.org>
	<20110902162524.GC19690@sigill.intra.peff.net>
	<CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 09:39:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0qFr-0004lF-VF
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 09:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab1IFHjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 03:39:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39357 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752825Ab1IFHja (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 03:39:30 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p867c6CY009311
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Sep 2011 09:38:08 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R0qFO-0005Cc-8H; Tue, 06 Sep 2011 09:39:06 +0200
In-Reply-To: <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
	(Shawn Pearce's message of "Mon, 5 Sep 2011 11:15:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Sep 2011 09:38:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p867c6CY009311
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1315899493.94076@tIF58JqSzkBTGfFLBiY1cA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180775>

Shawn Pearce <spearce@spearce.org> writes:

> Again, the repository owner would notice on their next push, and
> notify people the repository is not to be trusted.

For simple attack, yes. But if the server is compromised, you can't
trust it anymore to error out on non-fast-forward. I don't think it
would be very complex to write a modified Git server that would come
back to the official history before a push, and re-introduce faulty
commits right after. pushers wouldn't notice, and fetchers would get
compromised history.

OTOH, non-fast-forward fetches can be reliably detected client-side, and
I like being able to think "whatever the server does, I don't care
because I'm using Git".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
