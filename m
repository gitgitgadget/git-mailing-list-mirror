From: Jeff King <peff@peff.net>
Subject: Re: Migrating away from SHA-1?
Date: Thu, 14 Apr 2016 22:22:33 -0400
Message-ID: <20160415022233.GE22112@sigill.intra.peff.net>
References: <570D78CC.9030807@zytor.com>
 <CAGZ79kaUN0G7i0GNZgWU7ZzJvWY=k=Rc6tqWvJsTu8gcRhP5bA@mail.gmail.com>
 <1460502934.5540.71.camel@twopensource.com>
 <20160414015324.GA16656@thunk.org>
 <1460654583.5540.87.camel@twopensource.com>
 <71A5D062-FCCD-42E5-80A8-AA9D8DE20604@zytor.com>
 <20160414224051.GD16656@thunk.org>
 <20160415021327.GC22112@sigill.intra.peff.net>
 <xmqq37qnehrm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Theodore Ts'o <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
	David Turner <dturner@twopensource.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:22:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtP7-00007N-5m
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752463AbcDOCWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:22:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:49919 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751906AbcDOCWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:22:36 -0400
Received: (qmail 8035 invoked by uid 102); 15 Apr 2016 02:22:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:22:36 -0400
Received: (qmail 6049 invoked by uid 107); 15 Apr 2016 02:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 22:22:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 22:22:33 -0400
Content-Disposition: inline
In-Reply-To: <xmqq37qnehrm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291597>

On Thu, Apr 14, 2016 at 07:18:53PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > [2] Somewhere in the list archive is my patch to find partial
> >     collisions like "git commit --sha1=31337", and I did in fact use
> >     that micro-optimization. That, along with multi-threading, made it
> >     feasible to do 6-8 character prefixes, as I recall.
> 
> In our testsuite, we have a test that uses many objects, all of
> which have object names that begin with 10 '0' characters.

Can you give more details on which test? 10 zeroes is 40 bits, which
means that by random chance, only about one in a trillion objects would
match that. We certainly didn't hit that randomly, and it seems like it
would be computationally expensive to have come up with the input for
even one such object, let alone "many".

-Peff
