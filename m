From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] i18n: use test_i18ncmp in t2020 (checkout --detach)
Date: Fri, 13 Apr 2012 19:30:10 -0400
Message-ID: <20120413233010.GA16663@sigill.intra.peff.net>
References: <20110320090111.GA15641@sigill.intra.peff.net>
 <20110320090918.GB15948@sigill.intra.peff.net>
 <20120413225901.GA13220@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 01:30:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIpwa-00053B-DD
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 01:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318Ab2DMXaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 19:30:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33580
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757263Ab2DMXaN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 19:30:13 -0400
Received: (qmail 14432 invoked by uid 107); 13 Apr 2012 23:30:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 19:30:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 19:30:10 -0400
Content-Disposition: inline
In-Reply-To: <20120413225901.GA13220@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195454>

On Fri, Apr 13, 2012 at 05:59:01PM -0500, Jonathan Nieder wrote:

> When v1.7.5-rc0~19^2~1 (checkout: clear commit marks after detached-orphan
> check, 2011-03-20) added a check that the human-readable message
> 
> 	Your branch is behind 'master' by 1 commit, and can be fast-forwarded.
> 
> is not suppressed by a previous commit walk, it forgot that the
> message might be different when git is configured to write output in
> another language.  Skip the output check in that case.

I think it is not "forgot" but "predates" in this case. The commit
introducing the problem is 8a5b749 (i18n: format_tracking_info "Your
branch is behind" message, 2012-02-02). But obviously your fix is
correct either way.

> ---
> Hi,
> 
> Jeff King wrote:
> 
> > When leaving a detached HEAD, we do a revision walk to make
> > sure the commit we are leaving isn't being orphaned.
> > However, this leaves crufty marks in the commit objects
> > which can confuse later walkers, like the one in
> > stat_tracking_info.
> >
> > Let's clean up after ourselves to prevent this conflict.
> 
> Very nice thing to do.  Thanks.

A minor complaint, but the format of your email left me confused for
several minutes, as I didn't remember writing that or working in this
area recently. It turns out that it is because this commit was from over
a year ago.

-Peff
