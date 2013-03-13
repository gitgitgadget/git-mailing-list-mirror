From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] add: respect add.updateroot config option
Date: Wed, 13 Mar 2013 10:07:34 +0100
Message-ID: <vpqr4jjd5wp.fsf@grenoble-inp.fr>
References: <20130313040845.GA5057@sigill.intra.peff.net>
	<20130313041037.GB5378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 13 10:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFhfV-0005Zb-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 10:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab3CMJHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 05:07:51 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51601 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab3CMJHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 05:07:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r2D97X5S007930
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 13 Mar 2013 10:07:34 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UFheo-0004tt-Re; Wed, 13 Mar 2013 10:07:34 +0100
In-Reply-To: <20130313041037.GB5378@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 13 Mar 2013 00:10:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 13 Mar 2013 10:07:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2D97X5S007930
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363770458.7299@erlGjEIv+yy7m8HUgScZOw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218043>

Jeff King <peff@peff.net> writes:

> For users who have read and accepted the warning, there is no way to
> jump directly to the future behavior and silence the warning.

I think the idea makes sense. The transition period is necessary for
people who use different versions of Git (which includes anybody
writting and distributing scripts), but for poor mortals who only use a
single version of Git, it's nice to be able to jump to the future
behavior once for all as soon as possible.

Your patch doesn't advertise the option in the warning message, which I
think is good. You may mention it the commit message that this is a
deliberate choice.

> +add.updateroot::

Detail: option names are normally camelCased => updateRoot.

I think the option name needs a bit more thinking. Without reading the
doc,

[add]
	updateRoot = false

would be a very tempting thing to try. Perhaps explicitly warning when
add.updateroot is set to false would avoid possible confusion.

In case you had missed it, here's a previous piece of discussion on the
subject:

http://thread.gmane.org/gmane.comp.version-control.git/216818/focus=216846

I liked David's suggestion of using future.* to mean "start using
behavior from the future right now".

> +	which they were called. In a future version of git, this behavior

Capital "Git".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
