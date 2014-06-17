From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 4/4] commit: Add commit.verbose configuration
Date: Tue, 17 Jun 2014 17:39:28 -0400
Message-ID: <20140617213926.GA18994@sigill.intra.peff.net>
References: <cover.1403033723.git.caleb@calebthompson.io>
 <2a0ed28d8ef50ce432c7680c1f01eb0f52891134.1403033723.git.caleb@calebthompson.io>
 <20140617212132.GC13848@sigill.intra.peff.net>
 <xmqqy4wvjjyu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:39:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx16N-00033m-Tj
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965234AbaFQVjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:39:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:46387 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964863AbaFQVjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:39:31 -0400
Received: (qmail 29636 invoked by uid 102); 17 Jun 2014 21:39:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 Jun 2014 16:39:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jun 2014 17:39:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4wvjjyu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251957>

On Tue, Jun 17, 2014 at 02:37:45PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Jun 17, 2014 at 02:39:00PM -0500, Caleb Thompson wrote:
> >
> >> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> >> index 35a4d06..471bd8f 100755
> >> --- a/t/t7507-commit-verbose.sh
> >> +++ b/t/t7507-commit-verbose.sh
> >> @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
> >>  	exec grep '^diff --git' "$1"
> >>  EOF
> >>  
> >> +write_script check-for-no-diff <<-'EOF'
> >> +	! check-for-diff
> >> +EOF
> >
> > Don't you need "$PWD/" or similar here, since check-for-diff is not in our path?
> 
> I actually would prefer a simpler
> 
> 	! grep '^diff --git' "$1"
> 
> that does not depend on what other parts of the tests have done.

Yeah, if it is that simple, I would agree (I did not even look at the
definition of check-for-diff, and assumed it was more complicated :) ).

-Peff
