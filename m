From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Sun, 8 Sep 2013 01:02:27 -0400
Message-ID: <20130908050227.GG14019@sigill.intra.peff.net>
References: <20130903170419.GA29921@google.com>
 <xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
 <20130904171356.GD2582@serenity.lan>
 <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
 <20130904183559.GA3465@sigill.intra.peff.net>
 <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
 <20130908040615.GA14019@sigill.intra.peff.net>
 <CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
 <20130908042649.GC14019@sigill.intra.peff.net>
 <CAMP44s1uasvGmCMkMF2N0eTMgOdksG0HqeidXK+159HAi4jkpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 07:02:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIX8t-0004o1-Qm
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 07:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445Ab3IHFCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 01:02:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:42322 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab3IHFCb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 01:02:31 -0400
Received: (qmail 763 invoked by uid 102); 8 Sep 2013 05:02:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Sep 2013 00:02:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 01:02:27 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1uasvGmCMkMF2N0eTMgOdksG0HqeidXK+159HAi4jkpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234183>

On Sat, Sep 07, 2013 at 11:52:10PM -0500, Felipe Contreras wrote:

> > Ah, you mean "if you think that the compare function should behave like
> > C *_cmp functions, it should be A-B". Perhaps it is simply that I do not
> > think of the function in those terms, but more like "show me the
> > differences from B to A".
> 
> But that is the problem, you are unable to ignore the implementation.
> You don't see test_cmp(), you see 'diff -u'.

Yes, I already said earlier in the thread:

  I certainly think of "test_cmp A B" as "differences from A to B", and
  the order makes sense. IOW, the "test_cmp is diff" abstraction is
  leaky, and that is fine (if it were not leaky, then order would not
  matter at all, but it clearly does).

And I do not think it is a problem. The point of the function is not to
abstract away the idea of comparison. The point is to give a hook for
people on systems without "diff -u" to run the test suite.

> > John mentioned JUnit, NUnit, and PHPUnit earlier in the thread. I
> > believe that Ruby's Test::Unit::Assertions also has
> > assert_equal(expected, actual).
> 
> That's because they all do first expect, then actual.
> 
> assert_equal( expected, actual, failure_message = nil )
> assert_not_equal( expected, actual, failure_message = nil )
> 
> That's why.

I do not see any reason why "not_equal" would not also work as
"assert_not_equal(actual, expected)". Maybe I am missing your point.

-Peff
