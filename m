From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib-functions: fix logic error in test_must_fail
Date: Tue, 24 Nov 2015 19:10:41 -0500
Message-ID: <20151125001040.GA19620@sigill.intra.peff.net>
References: <5654895C.2000909@ramsayjones.plus.com>
 <20151124210822.GG7174@sigill.intra.peff.net>
 <5654FB50.4000102@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 01:10:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1NfZ-0005j6-VU
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 01:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbbKYAKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 19:10:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:33603 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753794AbbKYAKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 19:10:43 -0500
Received: (qmail 32227 invoked by uid 102); 25 Nov 2015 00:10:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 18:10:43 -0600
Received: (qmail 20517 invoked by uid 107); 25 Nov 2015 00:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Nov 2015 19:10:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Nov 2015 19:10:41 -0500
Content-Disposition: inline
In-Reply-To: <5654FB50.4000102@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281657>

On Wed, Nov 25, 2015 at 12:05:36AM +0000, Ramsay Jones wrote:

> >   ...
> >   if ! list_contains "$_test_ok" success && test "$exit_code" -eq 0
> >   then
> > 	return 0
> >   fi
>     ^^
> Is this intended to be part of the if..elif.. chain, or a separate
> initial conditional? Hmm, actually it doesn't matter since it has
> exactly the same logic error as the original patch ... :-D

I meant it as part of the same one, but yeah, it has the wrong "return"
(I noticed it when writing up the real patch as a SQUASH on top of
Lars's topics).

> > They don't fail consistently. It's a SIGPIPE race.
> 
> Yes, and unfortunately I can't get it to happen for me.
> Which platforms has it been observed on?

I haven't tried to reproduce it, but I think it was seen originally in
the Travis build.

-Peff
