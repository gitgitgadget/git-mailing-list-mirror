From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Mon, 07 Sep 2009 13:20:08 +0200
Message-ID: <vpq63bv9f2v.fsf@bauges.imag.fr>
References: <20090906064454.GA1643@coredump.intra.peff.net>
	<20090906064816.GC28941@coredump.intra.peff.net>
	<7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
	<20090906072322.GA29949@coredump.intra.peff.net>
	<7vzl98fr22.fsf@alter.siamese.dyndns.org>
	<20090907094457.6117@nanako3.lavabit.com>
	<20090907082430.GA17997@coredump.intra.peff.net>
	<vpqeiqjf90u.fsf@bauges.imag.fr>
	<20090907085405.GA17968@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 13:20:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkcH1-0000qu-TH
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 13:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZIGLU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 07:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbZIGLU3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 07:20:29 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38266 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbZIGLU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 07:20:29 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n87BGRcT012123
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Sep 2009 13:16:27 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MkcGW-0004Hy-Rx; Mon, 07 Sep 2009 13:20:08 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MkcGW-00082f-QW; Mon, 07 Sep 2009 13:20:08 +0200
In-Reply-To: <20090907085405.GA17968@coredump.intra.peff.net> (Jeff King's message of "Mon\, 7 Sep 2009 04\:54\:05 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 07 Sep 2009 13:16:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n87BGRcT012123
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252926990.34553@5B6vHuxXueCL16P/jlhgVw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127919>

Jeff King <peff@peff.net> writes:

> I'm not sure it solves the problem. The point of "message.all" was to
> easily say "I'm an expert, so turn off useless advice". But now I would
> have to manually re-enable any messages that I _do_ want to see. And of
> course I don't see them to know that I want them, so I have to read
> through the config documentation and decide on each one.

Well, if it was _that_ important, I'd go for your suggestion of a
message hierarchy message.advice.foo, message.info.bar and so, with
the possibility of enabling/disabling a subhierarchy with a config
option. Now, I really get the feeling that this is overkill...

> So I think "be verbose, but let the user quiet us" is probably
> better than "be quiet, but let the user make us louder", because it is
> easier to discover verbose things. Which implies to me that
> "message.all", if it exists at all, should be limited in scope to just
> advice.

Yup, you convinced me for the last implication.

Otherwise, one setting "message.all = false" would never even notice
that another very cool informative message was added to Git in its
latest version.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
