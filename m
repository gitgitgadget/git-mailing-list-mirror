From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override ~/.gitconfig
Date: Thu, 27 Sep 2012 22:51:41 +0200
Message-ID: <vpqzk4bfaua.fsf@grenoble-inp.fr>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
	<1348757171-3223-1-git-send-email-artagnon@gmail.com>
	<20120927173532.GD1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 22:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THL41-0002YP-BZ
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 22:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab2I0Uvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 16:51:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44341 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab2I0Uvz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 16:51:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8RKkTn8005863
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2012 22:46:29 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1THL3e-0008FT-6Q; Thu, 27 Sep 2012 22:51:42 +0200
In-Reply-To: <20120927173532.GD1547@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 27 Sep 2012 13:35:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 27 Sep 2012 22:46:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8RKkTn8005863
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349383592.73314@hqaxvREdJh1zcLROiflZFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206519>

Jeff King <peff@peff.net> writes:

> Also, have you considered using a config include? Like:
>
>   $ echo '[include]path = ~/my-dotfiles/gitconfig' >~/.gitconfig
>
> It's a one-time setup, and then you get updates inside my-dotfiles
> forever. The one-time setup is annoying, but you have to bootstrap
> somehow (e.g., you're going to have to copy a .profile or similar to get
> the GIT_GLOBAL_CONFIG variable set).

I also strongly prefer symlinks or include over environment variables.
Relying on environment variables makes the setup a bit fragile, partly
because I often mess things up with my shell (e.g. I once had different
shell and environment variables in ~/.xsession and in actual shells,
hence different configuration depending on whether I launch stuff from
my window-manager or from a shell).

I could understand using environment variables for one-shot
configuration change (e.g. HOME=/tmp/ git whatever), but then $HOME is
sufficient in general.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
