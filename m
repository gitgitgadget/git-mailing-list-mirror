From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Tue, 4 Mar 2014 20:05:29 -0500
Message-ID: <20140305010529.GA11923@sigill.intra.peff.net>
References: <20140304174806.GA11561@sigill.intra.peff.net>
 <CAPig+cTzOxn5t0JOwxQyVrU___QPAQvwHR-zqFccaEQw+mYUCA@mail.gmail.com>
 <20140305003721.GA11509@sigill.intra.peff.net>
 <CAPig+cRqyG_JXSO-DsdP0mAjfmgS+FUCxLz+0+rHeUXrjmcjJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 02:05:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL0HA-0001Gz-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 02:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216AbaCEBFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 20:05:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:33073 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755733AbaCEBFb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 20:05:31 -0500
Received: (qmail 27039 invoked by uid 102); 5 Mar 2014 01:05:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Mar 2014 19:05:31 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Mar 2014 20:05:29 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRqyG_JXSO-DsdP0mAjfmgS+FUCxLz+0+rHeUXrjmcjJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243412>

On Tue, Mar 04, 2014 at 08:00:44PM -0500, Eric Sunshine wrote:

> >> > +int commit_grafts_loaded(void)
> >> > +{
> >> > +       return !!commit_graft_nr;
> >> > +}
> >>
> >> Did you mean !!commit_graft ?
> >
> > Shouldn't they produce the same results?
> 
> Yes they should, but the use of !! seemed to imply that you wanted to
> apply it to the pointer value. (If you indeed intended to use
> commit_graft_nr, then 'return commit_graft_nr', without !!, would have
> been sufficient and idiomatic C.)

I just wanted to normalize the return value to a boolean 0/1. Even when
the input is an int, it eliminates surprises when you try to assign the
result to a bitfield or other smaller-width type.

-Peff
