From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Tue, 22 Jan 2013 08:39:36 +0100
Message-ID: <vpq1uddoedj.fsf@grenoble-inp.fr>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
	<20130121222248.GA3586@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 08:40:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxYSs-0007Eg-93
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 08:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab3AVHjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 02:39:43 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56837 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab3AVHjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 02:39:42 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r0M7daUC020327
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Jan 2013 08:39:36 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxYSG-0003AX-S6; Tue, 22 Jan 2013 08:39:36 +0100
In-Reply-To: <20130121222248.GA3586@elie.Belkin> (Jonathan Nieder's message of
	"Mon, 21 Jan 2013 14:22:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 22 Jan 2013 08:39:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0M7daUC020327
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359445176.71945@iIb/RIyw/Aj1PN428MnBog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214207>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Would it be possible to make this conditional on cwd not being at the
> toplevel (the case where "git add -u :/" and "git add -u ." have
> different behavior)?  E.g.,
>
> 		static const char *here[2] = { ".", NULL };
> 		if (prefix)
> 			warning(...);

I thought about this too, after writting the patch. Actually, I still I
it makes sense to warn even from the toplevel, since the point is to
teach people to stop using pathless "git add -u" for a while, so I'd say
it's easier to teach this in every condition. OTOH, the next step
(forbidding pathless "git add -u") can still allow it from the toplevel
to minimize the pain.

But I'm starting to be convinced ;-).

Any other thought on the question?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
