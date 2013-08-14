From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git should not use a default user.email config value
Date: Wed, 14 Aug 2013 10:37:34 +0200
Message-ID: <vpq38qcmzw1.fsf@anie.imag.fr>
References: <52060EF9.2040504@alum.mit.edu>
	<7vvc3d1o01.fsf@alter.siamese.dyndns.org>
	<CAH5451nHfOaBzFzkrGvw+TyRj==cVpKF_QdXsTxnn5tTr1c0dw@mail.gmail.com>
	<20130812123921.GA16088@sigill.intra.peff.net>
	<CAH5451=PK15n4U-3Mb_TLevF3-r+vrpk1PXD15Oo1A2KFc5i_w@mail.gmail.com>
	<20130812154520.GA18215@sigill.intra.peff.net>
	<CAH5451=WKXUNzovXquFii=EdkeQXJEQ96_CRRebgQW6ow_19VA@mail.gmail.com>
	<20130813114635.GA16506@sigill.intra.peff.net>
	<7vsiydy2i1.fsf@alter.siamese.dyndns.org>
	<vpqsiycn33b.fsf@anie.imag.fr>
	<20130814074035.GB5095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thorsten Glaser <tg@mirbsd.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 10:38:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9Wat-0003dX-DP
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 10:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484Ab3HNIiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 04:38:10 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49319 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab3HNIiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 04:38:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r7E8bXKK008197
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Aug 2013 10:37:33 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V9WaE-0007EU-E3; Wed, 14 Aug 2013 10:37:34 +0200
In-Reply-To: <20130814074035.GB5095@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 Aug 2013 03:40:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Aug 2013 10:37:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7E8bXKK008197
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1377074258.15944@YQMwsIv4dwyAbyQxa0kOqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232272>

Jeff King <peff@peff.net> writes:

> This whole discussion is basically implementing conditional config.
> [...] The problem is that it would be tricky to do in a
> backwards-compatible way.

That could be done with "conditional comments" like

# if <some-condition> then
[core]
        pager = less
# endif

That's rather ugly, and the implementation would be even more ugly, but
backward-compatible.

> [1] I used to run into this with pager.*, which originally could only be
>     a bool, but later learned to take custom pagers. I solved it with:
>
>       git config --file .gitconfig-pager pager.diff ...
>       git config --global include.path .gitconfig-pager

Same here, with push.default = upstream, which breaks old versions of
Git ;-).

(I have a recent Git on my desktop, and my $HOME is shared with a server
running Debian oldstable)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
