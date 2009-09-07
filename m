From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] push: make non-fast-forward help message configurable
Date: Mon, 07 Sep 2009 10:34:25 +0200
Message-ID: <vpqeiqjf90u.fsf@bauges.imag.fr>
References: <20090906064454.GA1643@coredump.intra.peff.net>
	<20090906064816.GC28941@coredump.intra.peff.net>
	<7v8wgsk0rw.fsf@alter.siamese.dyndns.org>
	<20090906072322.GA29949@coredump.intra.peff.net>
	<7vzl98fr22.fsf@alter.siamese.dyndns.org>
	<20090907094457.6117@nanako3.lavabit.com>
	<20090907082430.GA17997@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:34:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZge-0005cw-4y
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbZIGIeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZIGIen
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:34:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39803 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752021AbZIGIen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:34:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n878W4Qg008921
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Sep 2009 10:32:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MkZg9-0007Wh-Ac; Mon, 07 Sep 2009 10:34:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MkZg9-0007gx-9C; Mon, 07 Sep 2009 10:34:25 +0200
In-Reply-To: <20090907082430.GA17997@coredump.intra.peff.net> (Jeff King's message of "Mon\, 7 Sep 2009 04\:24\:31 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Sep 2009 10:32:05 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n878W4Qg008921
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252917125.28496@39qib+LGITTL65Rbib//6Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127905>

Jeff King <peff@peff.net> writes:

> On Mon, Sep 07, 2009 at 09:44:57AM +0900, Nanako Shiraishi wrote:
>
>> You may be fixated at the sha1 part of the message when you find this
>> message annoying, but I disagree strongly. I always appreciate the
>> assurance this message gives me that I counted the number of commits
>> correctly, whether I say HEAD^^^^ or HEAD~7.
>
> Let me add a "me too" to Nanako's comments.

I guess it depends on one's workflow. If you usually cut-and-paste
sha1's, then the message is superfluous, while if you usually use
magic revspec, it is useful.

So, it's probably a good idea to make this configurable.

> So really they are two different conceptual types of message. And while
> I have no problem with an argument of "I _personally_ find this clutter
> and would like to configure it off", I don't think such an option should
> go under "advice.*". My patch had "message.all" (which will become
> "advice.all")

To me, this is an argument in favor of keeping "message", to allow the
same mechanism for these different types of messages.

But I think the individual message.* should not be just true/false
switch, but could be always/auto/never :

- always: show the message, regardless of message.all
- auto (the default): rely on message.all to decide whether to show
  the message
- never: never show it.

So you could say "message.all = false" and "message.resetShowsNewHead
= always".

But maybe that's just overkill, dunno...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
