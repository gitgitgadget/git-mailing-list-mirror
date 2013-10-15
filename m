From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 15:33:27 +0200
Message-ID: <20131015133327.GA22723@shrek.podlesie.net>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 15:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW4kj-0008Tf-2m
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 15:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445Ab3JONdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 09:33:32 -0400
Received: from shrek-wifi.podlesie.net ([93.179.225.50]:53126 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932395Ab3JONdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 09:33:31 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id E2AC963; Tue, 15 Oct 2013 15:33:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <525d35e766ad4_55661275e7426@nysa.notmuch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236182>

On Tue, Oct 15, 2013 at 07:32:39AM -0500, Felipe Contreras wrote:
> Krzysztof Mazur wrote:
> > 
> > But with core.mode = next after upgrade you may experience incompatible
> > change without any warning.
> 
> Yes, and that is actually what the user wants. I mean, why would the user set
> core.mode=next, if the user doesn't want to experencie incompatible changes? A
> user that sets this mode is expecting incompatible changes, and will be willing
> to test them, and report back if there's any problem with them.

With your patch, because it's the only way to have 'git add' v2.0.
But if another git v2.0 incompatible change will be added it will not
be warned, because with core.mode=next he decided to enable also
future changes and that's why I would never set that.

> 
> > I think it's better to keep the old behavior by default and warn the user if
> > with new behavior the result might be different. So the user:
> > 
> > 	a) knows about the change
> > 
> > 	b) may set appropriate option to enable the new default or keep
> > 	   the old behavior and disable the warning
> > 
> > 	c) may report that he does not like that change
> 
> But that's what we are doing already. Look at the test I wrote, it's testing
> the warnings for the current version of Git.

With pull.default we did that, but with git add v2.0 now we only warn
the user. With your patch he can enable new git add (and disable warning),
but he also enables future incompatible changes and disables
warnings for such changes. He also cannot keep the old behaviour and
disable the warning.

> 
> > I don't see the change in "git add" as an improvement, because
> > removing files with "git add" IMHO is more confusing than ignoring
> > such files. Maybe introducing new command - "git update" for instance -
> > which is equivalent to new "git add" and teaching new users to use it
> > instead of "git add" is better.
> 
> I agree. At first I simply ignored the changes because I didn't have the
> patience to figure out what exactly did they mean. Now I was forced to
> understand them to write this patch, and I'm also forcing myself to use this
> behavior.
> 
> 'git add' removing files is counter-intutive, 'git stage' (currently an alias
> to 'git add') might make more sense.

Yeah, 'git stage' as an alias to 'git add -A' is much more intuitive.

Krzysiek
