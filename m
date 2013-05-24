From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git stash deletes/drops changes of
Date: Fri, 24 May 2013 11:40:07 +0200
Message-ID: <20130524094006.GM12252@machine.or.cz>
References: <AANLkTin-BIxgQE5CO2cLhCYJAGHFxiXPquyozKc308DS@mail.gmail.com>
 <loom.20130523T185301-635@post.gmane.org>
 <87sj1d5ous.fsf@linux-k42r.v.cablecom.net>
 <7vd2shcnx7.fsf@alter.siamese.dyndns.org>
 <87obc15mq5.fsf@linux-k42r.v.cablecom.net>
 <20130523235711.GJ12252@machine.or.cz>
 <20130524082253.GY27005@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jim Greenleaf <james.a.greenleaf@gmail.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 24 11:40:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfoTz-00042n-4m
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 11:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760227Ab3EXJkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 05:40:14 -0400
Received: from pasky.or.cz ([84.242.80.195]:48154 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760129Ab3EXJkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 05:40:11 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4FA5017000A6; Fri, 24 May 2013 11:40:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130524082253.GY27005@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225338>

On Fri, May 24, 2013 at 09:22:53AM +0100, John Keeping wrote:
> On Fri, May 24, 2013 at 01:57:12AM +0200, Petr Baudis wrote:
> >   Just to clear up on what the best practice is, I'd imagine the setup
> > to be something like:
> > 
> > 	(a) Makefile contains inclusion of Makefile.include.
> > 
> > 	(b) There is a file like Makefile.include.template containing
> > 	a template to be copied over and filled by the user.
> > 
> > 	(c) Makefile contains code that makes sure all variables that
> > 	are supposed to be set are set and obsolete variables are not,
> > 	since there is no mechanism to cause e.g. a merge conflict
> > 	on change of Makefile.include.template.
> > 
> > Is there a better way to solve this?
> 
> I think the best practice would be what Git itself does ;-)
> 
> The Makefile sets default values for all parameters, some of which are
> inferred based on the system.  It then includes config.mak, which allows
> the user to override any of these values.

So that's pretty similar to what I described, modulo the filenames.
I'd say it's more friendly if you don't need to tweak any of the
defaults in the common case, but less friendly if you always need to
tweak something/everything (you really want a template file then
and not covering (c) is a problem).

-- 
				Petr "Pasky" Baudis
	For every complex problem there is an answer that is clear,
	simple, and wrong.  -- H. L. Mencken
