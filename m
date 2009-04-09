From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC 1/6] send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 04:14:44 -0400
Message-ID: <20090409081443.GB17221@coredump.intra.peff.net>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 10:23:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpXM-0003xa-Kc
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757821AbZDIIVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 04:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756491AbZDIIV3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:21:29 -0400
Received: from peff.net ([208.65.91.99]:42789 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757458AbZDIIV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 04:21:28 -0400
Received: (qmail 14389 invoked by uid 107); 9 Apr 2009 08:14:47 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.0.130)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 09 Apr 2009 04:14:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Apr 2009 04:14:44 -0400
Content-Disposition: inline
In-Reply-To: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116148>

On Wed, Apr 08, 2009 at 09:25:25AM -0500, Michael Witten wrote:

> Firstly, I presume that someone is electing to use this option, so it is
> almost by definition not annoying for that person.

Sure, obviously only people who enable it will be affected. I was
thinking of it more in terms of group economics: how many people _will_
enable it, because they think the payoff outweighs the annoyance.

And perhaps you can argue that it has negligible group cost. The
code is small and not likely to introduce new bugs. So the only costs
are whatever any sender is willing to pay themselves. And in that sense,
if even one person uses it, it is a net win.

> Secondly, it seems reasonable to drop into another VC, screen window, or
> terminal instance, and then set send-email a-running. For instance, with
> a 14-patch series, one could set `--delay 60' and then let send-email
> run happily for the next 14 minutes with nary a thought.

Except for your 10-minute "no activity, so let's suspend to ram"
timeout. ;) But I think we can assume since the user is opting in to the
feature that they don't have a problem with it.

> Frankly, I don't care how other people's patch series appear to me. I care
> about how mine appear to others. Is this irrational? Probably, but I'm kind
> of OC; I want my patch series to look like it's in order for everyone.

No, it's not irrational. We spend time proofreading, cleaning up
patches, etc, because we know other people will read them. And a little
effort by the sender can often save a lot of effort by many readers. And
people do it out of politeness, perhaps, or altruism, or simply because
it encourages others to spend the effort for them.

But I would personally find such a delay annoying (especially 60
seconds, which I consider to be huge), and I feel that by threading and
using sane date fields, I have done enough for the reader.

> I have worked with 2 major mail clients that both display by date received:
> 
>   * Mac OS X's Mail
>   * Gmail

Somebody reported in the thread I referenced earlier that gmane's web
interface has the same problem; I didn't check it myself, though.

> There's nothing simpler than slowing the rate of outgoing email. It doesn't
> even have to be used; it is completely unintrusive and fully automated. It
> even works with the confirmation. Best of all, it didn't take much code to
> implement.

I disagree that it's unintrusive (and I understand that you don't think
it is, and that there may be others like you, but I am pointing out
there are others who think the opposite). But given that it's optional,
and it's not very much code, I don't have a strong objection. My
original comment was that I was dubious whether it would work: however,
I was thinking you would set it to a few seconds. Setting it to 60
seconds, I can imagine it would have an impact.

-Peff
