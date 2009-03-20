From: Jeff King <peff@peff.net>
Subject: Re: Gnome chose Git
Date: Fri, 20 Mar 2009 16:03:46 -0400
Message-ID: <20090320200346.GD26934@coredump.intra.peff.net>
References: <877i2lbvt7.fsf@iki.fi> <49C249B9.7010001@drmicha.warpmail.net> <1cd1989b0903190643p19a40718yc4fd2730aab0a9a0@mail.gmail.com> <49C24D9B.1060301@drmicha.warpmail.net> <1cd1989b0903190701uac4602dl1d2c3cace45a9938@mail.gmail.com> <20090319151610.GO23521@spearce.org> <1cd1989b0903190850p1a08991y754904e7799c7879@mail.gmail.com> <20090319201405.GD17028@coredump.intra.peff.net> <49C354CC.2020108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pat Notz <patnotz@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:06:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkkyC-0007fk-DM
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 21:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbZCTUEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbZCTUEA
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 16:04:00 -0400
Received: from peff.net ([208.65.91.99]:42122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622AbZCTUD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2009 16:03:59 -0400
Received: (qmail 10707 invoked by uid 107); 20 Mar 2009 20:04:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 20 Mar 2009 16:04:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2009 16:03:46 -0400
Content-Disposition: inline
In-Reply-To: <49C354CC.2020108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113999>

On Fri, Mar 20, 2009 at 09:33:16AM +0100, Michael J Gruber wrote:

> > But do note that reflogs expire eventually, so you will want to also
> > look at gc.reflogexpire and gc.reflogexpireunreachable if you want to
> > keep this as an activity log forever.
> 
> In any case, reflogs are local. I would assume that accountability
> tracking should be public and transparent. Depends on the use case, of
> course.

I think the use case was auditing "when did this code get into the repo,
and by whom". Which is inherently a local thing, since you are talking
about when it got into a central repo.

As for public and transparent, reflogs are only the database mechanism;
git already has the hooks in place for writing every ref change to this
mechanism, and it stores everything you need.  They would just need some
way of publishing the information. I think it was you who suggested
notes, which would be one way of doing so; you could also publish tags
indexed by pusher (since we may or may not actually care about fast
lookup from commit to pusher here), or even just a web page.

-Peff
