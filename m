From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup_pager: set MORE=R
Date: Tue, 4 Feb 2014 17:25:08 -0500
Message-ID: <20140204222507.GA6031@sigill.intra.peff.net>
References: <20140117041430.GB19551@sigill.intra.peff.net>
 <20140117042153.GB23443@sigill.intra.peff.net>
 <xmqqvbxiwh8y.fsf@gitster.dls.corp.google.com>
 <20140121054927.GD5878@sigill.intra.peff.net>
 <xmqqwqhtuojx.fsf@gitster.dls.corp.google.com>
 <20140204221220.GA5457@sigill.intra.peff.net>
 <xmqqiosu7ca2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Yuri <yuri@rawbw.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:25:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoQh-0005R4-4k
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933894AbaBDWZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:25:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:44627 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932164AbaBDWZK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:25:10 -0500
Received: (qmail 16016 invoked by uid 102); 4 Feb 2014 22:25:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Feb 2014 16:25:10 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Feb 2014 17:25:08 -0500
Content-Disposition: inline
In-Reply-To: <xmqqiosu7ca2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241576>

On Tue, Feb 04, 2014 at 02:17:57PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But there's another set of people that I was intending to help with the
> > patch, which is people that have set up LESS, and did not necessarily
> > care about the "R" flag in the past (e.g., for many years before git
> > came along, I set LESS=giM, and never even knew that "R" existed). Since
> > git comes out of the box these days with color and the pager turned on,
> > that means people with such a setup see broken output from day one.
> >
> > And I think it is Git's fault here, not the user or the packager.
> 
> I am not particularly itnterested in whose fault it is ;-)  If the
> user sets LESS himself, he knows how to set it (and if he is setting
> it automatically for all of his sessions, he knows where to do so),
> and would know better than Git about "less", his pager of choice.
> 
> If he did not know about R and did not see color, that is even
> better.  Now he knows and his update to his LESS settings will let
> him view colors in outputs from programs that are not Git.

Right. If git just disabled the color, I think that would be sane (and
that is what my patch was shooting for). But somebody who sees:

  $ git log
  ESC[33mcommit 3c6b385c655a52fd9db176ce1e01469dc9954f91ESC[mESC[33m
  (ESC[1;36mHEADESC[mESC[33m, ESC[1;32mjk/meta-makeESC[mESC[33m)ESC[m

does not necessarily know what is going on. They do not know that it is
a "less" problem, nor that their less settings are relevant. They only
see that Git is broken out of the box.

Anyway, I will leave it at that. It's an unfortunate problem, but one
not worth fixing.

-Peff
