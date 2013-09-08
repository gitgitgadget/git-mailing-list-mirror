From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Sun, 8 Sep 2013 00:26:49 -0400
Message-ID: <20130908042649.GC14019@sigill.intra.peff.net>
References: <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
 <xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
 <20130904171356.GD2582@serenity.lan>
 <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
 <20130904183559.GA3465@sigill.intra.peff.net>
 <CAMP44s3O=cHAtHOj41MccBDOausukb49MV-E6jib6n6czs+p3Q@mail.gmail.com>
 <20130908040615.GA14019@sigill.intra.peff.net>
 <CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 06:27:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIWad-0008Pl-40
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 06:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab3IHE0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 00:26:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:42070 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab3IHE0x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 00:26:53 -0400
Received: (qmail 31286 invoked by uid 102); 8 Sep 2013 04:26:53 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Sep 2013 23:26:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Sep 2013 00:26:49 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s16RZ9JguL=NPcD8TE-gdG7vGEa5KLHzv4bf_VLLEhPRw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234175>

On Sat, Sep 07, 2013 at 11:13:10PM -0500, Felipe Contreras wrote:

> > If the reasoning is "cmp(actual, expect) makes more sense to humans"
> > then I do not think it is universal.
> 
> No.
> 
> ---
> A(ny) sanely defined "compare A with B" function should yield the
> result of subtracting B from A, i.e. cmp(A,B) should be like (A-B).
> That is what you feed qsort() and bsearch() (it is not limited to C;
> you see the same in "sort { $a <=> $b }").  The definition naturally
> makes "cmp(A,B) < 0" like "A < B" and "cmp(A,B) > 0" like "A > B".
> ---

Ah, you mean "if you think that the compare function should behave like
C *_cmp functions, it should be A-B". Perhaps it is simply that I do not
think of the function in those terms, but more like "show me the
differences from B to A".

> > Otherwise why would so many
> > existing test frameworks do it the other way?
> 
> Which many existing frameworks do it the other way?

John mentioned JUnit, NUnit, and PHPUnit earlier in the thread. I
believe that Ruby's Test::Unit::Assertions also has
assert_equal(expected, actual).

> > Or any number of variations. I'm sure you will say "but those seem
> > awkward and unlike how I think about it". But that was my point; it
> > seems to be a matter of preference.
> 
> Really? You think any sane human being would prefer:
> 
> Computer, given that we expect B, how does A differ?
> 
> To:
> 
> Computer, compare A with B

I already said that is how I think about it. If you want to call me not
sane, feel free. But I do not see that this line of discussion is going
anywhere productive.

-Peff
