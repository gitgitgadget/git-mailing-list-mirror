From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Fri, 16 Nov 2012 12:11:08 -0800
Message-ID: <20121116201107.GA5740@sigill.intra.peff.net>
References: <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
 <7vvcd6954q.fsf@alter.siamese.dyndns.org>
 <20121115172845.GA20298@sigill.intra.peff.net>
 <7vzk2i6s9h.fsf@alter.siamese.dyndns.org>
 <20121116190811.GB2310@sigill.intra.peff.net>
 <CAMP44s2+0vFUwK+ATe-jDTRYG=kE=zFF4X_JAMZExgVw0Vtfgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 21:11:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZSG5-0003z9-NO
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 21:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480Ab2KPULM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 15:11:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50615 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab2KPULL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 15:11:11 -0500
Received: (qmail 30608 invoked by uid 107); 16 Nov 2012 20:12:00 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Nov 2012 15:12:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2012 12:11:08 -0800
Content-Disposition: inline
In-Reply-To: <CAMP44s2+0vFUwK+ATe-jDTRYG=kE=zFF4X_JAMZExgVw0Vtfgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209904>

On Fri, Nov 16, 2012 at 08:57:43PM +0100, Felipe Contreras wrote:

> > I'm not sure how orthogonal it is. The latter half of my series is about
> > exposing the user_ident_sufficiently_given() flag. If we go with
> > Felipe's patch, then that exposed information has no users, and it may
> > not be worth it (OTOH, it's possible that some third-party script may
> > want it).
> 
> Well, who is using user_ident_sufficiently_given() in the first place?
> I think 'git commit' might be suffering from the same problem that
> prompted you to split it.

It is just `git commit` now. It does not suffer from the problems that
prompted the author/committer split:

  http://article.gmane.org/gmane.comp.version-control.git/209635

To expand on what I wrote there, we cannot hit case 2 because we always
ask for the committer within the same process. Case 1 is not
interesting, because we would only fail to show it if is identical to a
non-implicit committer (so even if it was implicit, we know that it is a
sane value).

-Peff
