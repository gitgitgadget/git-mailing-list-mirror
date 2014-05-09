From: Jeff King <peff@peff.net>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Thu, 8 May 2014 20:11:45 -0400
Message-ID: <20140509001145.GA8734@sigill.intra.peff.net>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
 <20140508212647.GA6992@sigill.intra.peff.net>
 <874n10ot2m.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri May 09 02:11:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiYPn-0007EE-VY
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 02:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbaEIALs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 20:11:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:47818 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753520AbaEIALr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 20:11:47 -0400
Received: (qmail 8827 invoked by uid 102); 9 May 2014 00:11:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 May 2014 19:11:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2014 20:11:45 -0400
Content-Disposition: inline
In-Reply-To: <874n10ot2m.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248464>

On Thu, May 08, 2014 at 11:32:01PM +0200, David Kastrup wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 08, 2014 at 01:52:38PM -0700, Junio C Hamano wrote:
> >
> >>              (                                         103) 
> >>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
> >>              (                                         105)         test...
> >>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
> >>              (                                         107)         test...
> >> 
> >> which does away with the misleading information altogether.
> >> 
> >> I myself is leaning towards the latter between the two, and not
> >> overriding "-b" but introducing another "cleanse the output of
> >> useless bottom information even more" option.
> >
> > Though I rarely use boundary commits, this one makes the most sense to
> > me (when I do use them, I just mentally assume that the information in
> > the boundary line is useless; this is just making that more apparent).
> 
> It is unclear to me what "this one makes the most sense to me" is
> referring to, in particular whether it encompasses the "and not
> overriding" part of the paragraph.

Sorry, I should have been more clear. I meant that the output format
shown there makes the most sense of the ones shown.

I'd actually be inclined to say the opposite of what Junio is saying
there: that "-b" should blank the author field as well as the commit
sha1. I'd even go so far as to say that "-b" should probably be the
default when boundary commits are in use. I cannot think of a time when
I have found the boundary information useful, and the IMHO the output
above is less confusing than what we produce now. But I admit I haven't
thought very hard on it.

-Peff
