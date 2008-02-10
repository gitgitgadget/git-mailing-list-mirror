From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 05:13:53 -0500
Message-ID: <20080210101353.GA26568@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <7vtzkihkx5.fsf@gitster.siamese.dyndns.org> <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com> <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 11:14:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO9Cg-0001kq-Q6
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 11:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320AbYBJKN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 05:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbYBJKN5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 05:13:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3134 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754246AbYBJKN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 05:13:56 -0500
Received: (qmail 25673 invoked by uid 111); 10 Feb 2008 10:13:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 10 Feb 2008 05:13:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 10 Feb 2008 05:13:53 -0500
Content-Disposition: inline
In-Reply-To: <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73329>

On Sat, Feb 09, 2008 at 06:24:30PM -0800, Junio C Hamano wrote:

> > Still, the big fat ![rejected] do seem over the top when I know it
> > really means "stale".
> If "stale" can be proven cheaply, I think it would be a very
> good change to introduce [rejected] vs [stale].

I think there is still one problem with that: you are not splitting the
cases into "rejected" and "stale". You are splitting them into
"rejected, or we didn't have enough information to determine staleness"
and "definitely stale"[1]. So in the cases that it works perfectly, it may
be a useful distinction; but it might end up confusing people when the
same situation produces different results depending on what has been
fetched locally.

-Peff

[1]: Actually, you can further split into "definitely rejected",
"definitely stale", and "undetermined" but I don't think that is being
proposed.
