From: David Aguilar <davvid@gmail.com>
Subject: Re: Feature Request: enhance Git-GUI's Checkout Branch screen
Date: Thu, 3 Sep 2015 21:42:24 -0700
Message-ID: <20150904044224.GA20164@gmail.com>
References: <CALsXy+0FN1A-E-GF-chPrOpZSt-Wg8afL8BReqaUnBHDj=3NXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, SysAdmin <sysadmin@uniteddrugs.com>,
	IT Dev2 <john.kobinski@uniteddrugs.com>
To: John Medema <john.medema@uniteddrugs.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 06:42:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXipt-0000Pb-DT
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 06:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbbIDEm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 00:42:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34341 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbIDEm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 00:42:28 -0400
Received: by padhy16 with SMTP id hy16so9806994pad.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 21:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4iARaTay1Bfirf/Squnk+VddiCIrlSIiLUbRG7n6GtE=;
        b=U2ND0jJKBIikB4R1Q3v7QfIBTl0BVg6lQH+WeXPwX8dRQg7tNd+WtkYGVXW2OTmO+6
         XnlmbRoMsuytQ5dtC4ahF/0+BRhGjhK/P7YPBQMt9TkWYJxrl9f6GG0AIuEKfkehAIU6
         wgUzC6ngLPPVl/tA34Mnm6nKtCvLJzjNl+NeoM8gc1fE0XKdgMZtNBHWHUcCrtbavsHe
         eWAyGI6PhnQk/tlj30nit9bl4oqTY+RNEg8YKmTYRIdD7U0ubO5s1IFagiGdevVMtBsD
         nJgAqZlcHRj1BUtrhaSBZTxs3j3Q0TJ1fLzALmvekyyJ3bJdiQsb3UHh0c+JmqKHF5Cc
         Jo1Q==
X-Received: by 10.68.200.40 with SMTP id jp8mr4001452pbc.16.1441341747515;
        Thu, 03 Sep 2015 21:42:27 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by smtp.gmail.com with ESMTPSA id dh1sm795495pbd.49.2015.09.03.21.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2015 21:42:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALsXy+0FN1A-E-GF-chPrOpZSt-Wg8afL8BReqaUnBHDj=3NXA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277284>

On Thu, Sep 03, 2015 at 10:08:24AM -0700, John Medema wrote:
> Git gurus, throw this one on your to-do list:
> 
> This is a feature request to enhance the Git GUI to make it easier to
> checkout non-existing branches that exist upstream. Apologies if this
> is not the correct place for feature requests.
> 
> Scenario: Upstream repo has 4 branches - master, develop, maint, test.
> Local repo has only a master branch. In the command line, to switch to
> a local copy of the test branch, it is a simple "git checkout test".
> The git command automatically realizes your requested branch doesn't
> exist but origin does have a branch named test, so it a) creates a
> local branch off of origin/develop, b) sets the appropriate pull link,
> and c) sets the appropriate push link. In effect, the git command line
> hides the fact that the user doesn't know the branch doesn't exist and
> creates it as the user was expecting it to exist as. The Git GUI has
> no shortcut like this.
> 
> For reference, from the man page for git-checkout:
> "If <branch> is not found but there does exist a tracking branch in
> exactly one remote (call it <remote>) with a matching name, treat as
> equivalent to "git checkout -b <branch> --track <remote>/<branch>".
> 
> Currently, in order to checkout a non-existing branch in the GUI you
> must go to the Branch Menu, click Create, select the "Tracking Branch"
> radio, select the branch, then go back up and name the branch the
> exact same name (to ease new user confusion). For a new user who just
> wants a copy of the remote branch, it is very unintuitive to create a
> new branch.
> 
> Fortunately, you already have some explicit warning messages after the
> Checkout Branch screen if the user intuitively tries to checkout the
> tracking branch, but even then a new user rarely realizes what they
> have gotten themselves into. At best, they know that they must find
> help (just for trying to checkout a branch).
> 
> In order to implement this feature effectively, I suggest that the
> Checkout Branch screen be modified in one of two ways (exclusive):
> 
> Option A:
> Merge the Local and Tracking Branch lists into one box keeping their
> entries separate by their full name ("master" and "origin/master"). If
> a user selects a remote branch, ask the user whether to create the
> local branch or move to the detached HEAD state (current
> functionality).
> 
> Option B (preferred):
> Keep the Local and Tracking Branch lists separate (as they are now),
> and keep the Tracking Branch list as-is. However, on the Local Branch
> screen, select include the existing branches in normal font but also
> include potential local branches based off of the remote in italics
> (or greyed-out, or asterisked, etc). Selecting an italicized entry
> creates the new branch from the tracking branch, without user
> interaction.

How about Option C?

What git-cola[1] has done for the longest time is when the
remote branch is selected it strips of the remote part and
automatically fills in the name field with that.  e.g. it fills
in "todo" when "origin/todo" is selected.

Mixing remote branches with pseudo-branches in the UI would
complicate it, so that seems like it could be made simpler.
Italics, asterisks, those are all signs that they shouldn't
be displayed next to each other.

I think the UI is fine as-is.  If it were just tweaked to
automatically fill in that field, like git-cola does, then it
can stay simple and make this use case easier.

If you're looking for other interesting usability things that
could be improved about git-gui, take a look at the
keyboard-driven user interface features in git-cola.  It's
optimized for keyboard-centric use.

[1] https://github.com/git-cola/git-cola
-- 
David
