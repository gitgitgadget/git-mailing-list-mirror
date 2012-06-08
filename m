From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Warnings before rebasing -i published history
Date: Fri, 08 Jun 2012 10:52:04 +0200
Message-ID: <vpqfwa618zv.fsf@bauges.imag.fr>
References: <1339104053-7782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
	<7vwr3ieo0i.fsf@alter.siamese.dyndns.org>
	<20120608093257.Horde.eeddeHwdC4BP0aqpIrqTaVA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Fri Jun 08 10:52:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scuve-0007WW-D8
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 10:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933920Ab2FHIwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 04:52:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39371 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933916Ab2FHIwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 04:52:12 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q588hLtZ026628
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 10:43:21 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ScuvN-0007Mm-9I; Fri, 08 Jun 2012 10:52:05 +0200
In-Reply-To: <20120608093257.Horde.eeddeHwdC4BP0aqpIrqTaVA@webmail.minatec.grenoble-inp.fr>
	(konglu@minatec.inpg.fr's message of "Fri, 08 Jun 2012 09:32:57
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 10:43:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q588hLtZ026628
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339749804.32982@C2XxtAR7BJqQmMuD2wuymQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199470>

konglu@minatec.inpg.fr writes:

> The fact is that the input of sed is "$1" itself. An redirecting the output
> of sed to the same input doesn't seem to work.

No, reading and writing to the same file usually doesn't work (unless
you have a very good reason to do it). But using printf seems weird. It
just forces the shell to hold the whole output of sed in memory to be
able to pass it to printf.

Isn't a more conventional way to do that

sed -e '...' "$1" >"$1".new
mv "$1".new "$1"

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
