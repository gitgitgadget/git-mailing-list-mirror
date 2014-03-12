From: Jeff King <peff@peff.net>
Subject: Re: New GSoC microproject ideas
Date: Wed, 12 Mar 2014 15:21:08 -0400
Message-ID: <20140312192108.GA1601@sigill.intra.peff.net>
References: <532049A7.6000304@alum.mit.edu>
 <xmqq1ty7me6a.fsf@gitster.dls.corp.google.com>
 <87wqfzi5wa.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Fabian <bafain@gmail.com>,
	Quint Guvernator <quintus.public@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:21:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNoiK-0000vS-FZ
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbaCLTVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:21:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:38254 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750736AbaCLTVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:21:10 -0400
Received: (qmail 28819 invoked by uid 102); 12 Mar 2014 19:21:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 14:21:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 15:21:08 -0400
Content-Disposition: inline
In-Reply-To: <87wqfzi5wa.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243967>

On Wed, Mar 12, 2014 at 08:16:53PM +0100, David Kastrup wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Here is another, as I seem to have managed to kill another one ;-)
> >
> > -- >8 --
> >
> > "VAR=VAL command" is sufficient to run 'command' with environment
> > variable VAR set to value VAL without affecting the environment of
> > the shell itself, but we cannot do the same with a shell function
> > (most notably, "test_must_fail");
> 
> No? bash:
> 
> dak@lola:/usr/local/tmp/lilypond$ zippo()
> > {
> > echo $XXX
> > echo $XXX
> > }
> dak@lola:/usr/local/tmp/lilypond$ XXX=8 zippo
> 8
> 8

Try:

  zippo() {
    echo $XXX
  }
  XXX=8 zippo
  zippo

XXX remains set after the first call under dash (but not bash). I
believe "ash" has the same behavior.

-Peff
