From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Fri, 22 May 2015 17:38:53 -0400
Message-ID: <20150522213853.GA29804@peff.net>
References: <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
 <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
 <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
 <20150514063317.GA22509@peff.net>
 <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
 <xmqqfv6yj0dl.fsf@gitster.dls.corp.google.com>
 <20150514215453.GA16897@peff.net>
 <xmqq7fsaiyoy.fsf@gitster.dls.corp.google.com>
 <20150514223313.GA21149@peff.net>
 <xmqqmw0we2b7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 23:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvuej-0006Qg-8R
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 23:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbbEVVi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 17:38:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:34999 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030198AbbEVVi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 17:38:56 -0400
Received: (qmail 31272 invoked by uid 102); 22 May 2015 21:38:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 16:38:55 -0500
Received: (qmail 21217 invoked by uid 107); 22 May 2015 21:38:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 May 2015 17:38:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 May 2015 17:38:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw0we2b7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269765>

On Fri, May 22, 2015 at 02:21:16PM -0700, Junio C Hamano wrote:

> I ended up doing it as a variant of the latter, "free unless we have
> v->buffer pointing at it".

Thanks, this version looks good to me minus one micro-nit below.

> Sorry for a long delay.

No problem. I'm sometimes amazed you find time to write any patches at
all. :)

> -- >8 --
> Subject: [PATCH] commit-slab: introduce slabname##_peek() function
> 
> There is no API to ask "Does this commit have associated data in
> slab?".  If an application wants to (1) parse just a few commits at
> the beginning of a process, (2) store data for only these commits,
> and then (3) start processing many commits, taking into account the
> data stored (for a few of them) in the slab, the application would
> use slabname##_at() to allocate a space to store data in (2), but
> there is no API other than slabname##_at() to use in step (3).  This
> allocates and wasts new space for these commits the caller is only
> interested in checking if they have data stored in step (2).

s/wasts/wastes/

-Peff
