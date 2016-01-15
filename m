From: Jeff King <peff@peff.net>
Subject: Re: Find main branch
Date: Fri, 15 Jan 2016 13:02:53 -0500
Message-ID: <20160115180253.GA9590@sigill.intra.peff.net>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
 <20160114213113.c700484c7e3acddc467d0e75@domain007.com>
 <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
 <CAGyf7-H2jSW0vJZ7ng1OcN7X5tvs+sEuGUH4yMSpJ_-wwUcoTQ@mail.gmail.com>
 <20160114211335.GB10825@sigill.intra.peff.net>
 <xmqq1t9ikaxb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bryan Turner <bturner@atlassian.com>,
	pedro rijo <pedrorijo91@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 19:03:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK8iC-0007sa-90
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 19:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbcAOSC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 13:02:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:54516 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751781AbcAOSCz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 13:02:55 -0500
Received: (qmail 4499 invoked by uid 102); 15 Jan 2016 18:02:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 13:02:55 -0500
Received: (qmail 21959 invoked by uid 107); 15 Jan 2016 18:03:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 13:03:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 13:02:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1t9ikaxb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284194>

On Fri, Jan 15, 2016 at 09:30:24AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It would be nice if "git ls-remote" just had some way of printing the
> > capabilities.
> 
> I would agree that it would be nice to give an option to ls-remote
> to show which ones are symrefs pointing at what.  You are being more
> ambitious than that, but I am not sure I would agree it is a good
> idea.
> 
> Most normal capabilities have no value to ordinary end users, and
> the symref= thing is interesting for them only because there isn't
> such an option in ls-remote (hence "capabilities" thing could be
> used as a poor-man's substitute).

I thought it might be nice for any porcelain which tries to wrap
`ls-remote`, make some decision based on the capabilities, and then
invoke another plumbing command. But I guess that is probably slightly
crazy, and nobody is doing it.

Something like `ls-remote --symrefs` probably would be a better place to
start.

-Peff
