From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda
 conditions
Date: Wed, 4 Sep 2013 14:36:00 -0400
Message-ID: <20130904183559.GA3465@sigill.intra.peff.net>
References: <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
 <20130903111006.GJ29840@goldbirke>
 <CAMP44s349-v6xtCvbDzycVj1wBwTdAgLmuGxB0pYn6CmHYkM1Q@mail.gmail.com>
 <20130903150855.GK29840@goldbirke>
 <20130903170419.GA29921@google.com>
 <xmqqli3co7ov.fsf@gitster.dls.corp.google.com>
 <20130904171356.GD2582@serenity.lan>
 <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 04 20:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHHwF-0005l7-LO
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 20:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab3IDSgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 14:36:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:38567 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755093Ab3IDSgD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 14:36:03 -0400
Received: (qmail 25843 invoked by uid 102); 4 Sep 2013 18:36:02 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Sep 2013 13:36:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Sep 2013 14:36:00 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1u54o5c4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233855>

On Wed, Sep 04, 2013 at 10:38:03AM -0700, Junio C Hamano wrote:

> >> This is way off tangent, but I am somewhat sympathetic to Felipe's
> >> "compare actual with expect", with reservations.
> >
> > This isn't an argument either way, but note that JUnit (and NUnit and
> > PHPUnit) all have assertEquals methods that take the arguments in the
> > order "expect, actual".  I've always assumed that Git's test framework
> > was imitating that,...
> 
> No.  See 82ebb0b6 (add test_cmp function for test scripts,
> 2008-03-12).  The "test_cmp" was a replacement for "diff -u", and
> the same order we fed "diff -u", i.e. expect then actual, was
> carried over.

I don't think it was intentional at the time. But over the intervening 5
years, I have noticed that I certainly think of "test_cmp A B" as
"differences from A to B", and the order makes sense. IOW, the "test_cmp
is diff" abstraction is leaky, and that is fine (if it were not leaky,
then order would not matter at all, but it clearly does).

But let's take a step back. This seems like an endian-ness issue to me.
I.e., some people prefer one order for test assertions, and other people
prefer the other. Is anyone actually right, or is this simply a matter
of preference? And if it is simply a matter of preference, then why
bother going through the pain of changing the current project standard?

Though I prefer the current, I can certainly live and adapt to a changed
standard, and I do not mind doing so if there is a good reason. But I've
yet to see any argument beyond "it is not what I like". Which to me
argues for the status quo as the path of least resistance.

-Peff
