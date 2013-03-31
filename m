From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Sun, 31 Mar 2013 17:43:18 -0400
Message-ID: <20130331214318.GA24646@sigill.intra.peff.net>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
 <20130328153547.GA3337@sigill.intra.peff.net>
 <CALkWK0=a0wmUe-rjK8Gg8izc0FdXYzChSrgp+W-JNsECsDf+yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 31 23:44:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMQ2h-00010i-DZ
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 23:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab3CaVnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 17:43:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50170 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab3CaVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 17:43:20 -0400
Received: (qmail 26438 invoked by uid 107); 31 Mar 2013 21:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Mar 2013 17:45:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Mar 2013 17:43:18 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0=a0wmUe-rjK8Gg8izc0FdXYzChSrgp+W-JNsECsDf+yA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219644>

On Mon, Apr 01, 2013 at 02:21:22AM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > [...]
> 
> So, you're saying: don't test compound statements for failure, since
> anything in the chain could fail and propagate failure.  I should only
> test simple git-foo commands for failure?

Right.

> > Sometimes it's annoyingly verbose to break down a compound function. But
> > I think in this case, you can make your tests more robust by just
> > checking the affirmative that the ref is still where we expect it to be,
> > like:
> >
> >   check_push_result up_repo $the_first_commit heads/master
> 
> Doesn't that change the meaning of the test though?  I really like how
> the original tests read.

Does it? I thought the original was:

  test_must_fail check_push_result up_repo $the_commit heads/master

which is checking that we did _not_ push $the_commit to up_repo.
Checking that without a negative means confirming that what _used_ to be
there is still there, which is $the_first_commit.

But I didn't actually run it, so I might be wrong about what is supposed
to be there after the (lack of) push.

-Peff
