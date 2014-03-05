From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 19:37:22 -0500
Message-ID: <20140305003721.GA11509@sigill.intra.peff.net>
References: <20140304174806.GA11561@sigill.intra.peff.net>
 <CAPig+cTzOxn5t0JOwxQyVrU___QPAQvwHR-zqFccaEQw+mYUCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 01:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKzq2-0005UX-Mm
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 01:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759AbaCEAh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 19:37:27 -0500
Received: from cloud.peff.net ([50.56.180.127]:33055 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751565AbaCEAhY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 19:37:24 -0500
Received: (qmail 25121 invoked by uid 102); 5 Mar 2014 00:37:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Mar 2014 18:37:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2014 19:37:22 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTzOxn5t0JOwxQyVrU___QPAQvwHR-zqFccaEQw+mYUCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243409>

On Tue, Mar 04, 2014 at 06:36:07PM -0500, Eric Sunshine wrote:

> On Tue, Mar 4, 2014 at 12:48 PM, Jeff King <peff@peff.net> wrote:
> > diff --git a/commit.c b/commit.c
> > index 6bf4fe0..886dbfe 100644
> > --- a/commit.c
> > +++ b/commit.c
> > @@ -114,6 +114,11 @@ static unsigned long parse_commit_date(const char *buf, const char *tail)
> >  static struct commit_graft **commit_graft;
> >  static int commit_graft_alloc, commit_graft_nr;
> >
> > +int commit_grafts_loaded(void)
> > +{
> > +       return !!commit_graft_nr;
> > +}
> 
> Did you mean !!commit_graft ?

Shouldn't they produce the same results?

-Peff
