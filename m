From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Thu, 1 Sep 2011 12:22:22 -0400
Message-ID: <20110901162222.GC15018@sigill.intra.peff.net>
References: <4E5CB0D0.7000905@drmicha.warpmail.net>
 <1314781909-19252-1-git-send-email-mgorny@gentoo.org>
 <7vy5y9xkd0.fsf@alter.siamese.dyndns.org>
 <20110831232201.GA29296@sigill.intra.peff.net>
 <20110901093450.57512480@pomiocik.lan>
 <7vbov4xnfc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:22:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzA2C-0005rM-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab1IAQW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:22:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52207
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879Ab1IAQW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:22:27 -0400
Received: (qmail 20563 invoked by uid 107); 1 Sep 2011 16:23:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 12:23:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 12:22:22 -0400
Content-Disposition: inline
In-Reply-To: <7vbov4xnfc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180539>

On Thu, Sep 01, 2011 at 09:00:39AM -0700, Junio C Hamano wrote:

> >> > To match the parsing of commit objects, I would prefer to see
> >> > "subject" to mean "the first paragraph" (usually the first line
> >> > alone but that is purely from convention), but that probably is a
> >> > separate topic.
> >> 
> >> Good idea. I suspect pretty.c:format_subject can be reused here.
> >
> > Should I fix regular 'subject' and 'body' as well, or just
> > the 'contents:' variants?
> 
> I thought you made them synonyms...

No, %(body) retains its historical usage as body+signature. If you think
it's OK to change that.

We could either leave %(subject) with its historical behavior, or fix it
to handle multi-line subjects. Although it's technically a regression to
change it, I tend to think it is simply a bug, as it doesn't match what
the rest of git (like "git log --format=%s") does.

-Peff
