From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 14:35:05 +0200
Message-ID: <20131015123505.GA3097@shrek.podlesie.net>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 14:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW3qH-0003ZB-6A
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 14:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759038Ab3JOMfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 08:35:10 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:51342 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759018Ab3JOMfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 08:35:09 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 8DDDC63; Tue, 15 Oct 2013 14:35:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525c63b6711fa_197a905e845b@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236180>

On Mon, Oct 14, 2013 at 04:35:50PM -0500, Felipe Contreras wrote:
> Krzysztof Mazur wrote:
> > On Sat, Oct 12, 2013 at 02:04:45AM -0500, Felipe Contreras wrote:
> > > So that we can specify general modes of operation, specifically, add the
> > > 'next' mode, which makes Git pre v2.0 behave as Git v2.0.
> > > 
> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > > ---
> > 
> > I don't think that single option it's a good idea. From the user's
> > point of view I think that the way push.default was introduced and
> > will be changed is much better. So maybe it's better to just add
> > "core.addremove" option instead?
> 
> Maybe, but what happens when we start doing changes for v3.0? As a user, I
> don't and to figure out which are the new configurations that will turn v3.0
> behavior on, I just want to be testing that mode, even if I'm not following Git
> development closely. If I find something annoying with core.mode = next, I
> report the problem to the mailing list, which is good, we want to know problems
> with the backward-incompatible changes that will be introduced before it's too
> late, don't we?

But with core.mode = next after upgrade you may experience incompatible
change without any warning. I think it's better to keep the old behavior
by default and warn the user if with new behavior the result might be
different. So the user:

	a) knows about the change

	b) may set appropriate option to enable the new default or keep
	   the old behavior and disable the warning

	c) may report that he does not like that change

> 
> I'd be fine with having *both* a fine-tuned option to trigger each specific
> behavior, and another one that turns all those fine-tuned options on that are
> meant for v2.0.
> 
> Unfortunately, I don't see much interest from Git developers in either.
> 

I think that most users have already set the push.default, so "git add"
is the only problem. If Junio really wants to change "git add" he should
be interested in allowing user to use it now.

I don't see the change in "git add" as an improvement, because
removing files with "git add" IMHO is more confusing than ignoring
such files. Maybe introducing new command - "git update" for instance -
which is equivalent to new "git add" and teaching new users to use it
instead of "git add" is better.

Krzysiek
