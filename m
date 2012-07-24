From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn SVN 1.7 fix, take 2
Date: Tue, 24 Jul 2012 18:03:00 -0500
Message-ID: <20120724230300.GA16333@burratino>
References: <500F17A3.60307@pobox.com>
 <20120724220207.GA15969@burratino>
 <500F26BF.7090501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Eric Wong <normalperson@yhbt.net>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 01:03:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sto8K-0003s2-66
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 01:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754633Ab2GXXDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 19:03:10 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46608 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab2GXXDJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 19:03:09 -0400
Received: by yenl2 with SMTP id l2so108639yen.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H/vMrsgBpM8z6hwqc6UKa4lcBjKRQ6XGowZ7eMNpERs=;
        b=Gib3Wi/rRfdwfKSI+juxpMW2UJyAHj4AdmNbzklx5JNxR3h9CnqzMDOLC0dCKJLwzZ
         ALLcbRax1Tw28zgBXVWXaFKh3UITXp4Ya02bz1S7y50z3aAeaoX9ay0XOXwKacZB9+em
         NhmvRaukufJvbN+An2hRQ6+u45XvmCsfl3I6AzrYX+LXU/gKhKhFgq+3h6+ty51yCPoj
         CBf0e5pF90lnjYiqx0Y7RySOm52UvwdDAIhk9NyNu16/eBYU1CR+uUfkytZlQ1gX49vz
         wrTL6k5T5ecoVwyXgZtO0MwKZ3BwftQ1Ei2MPLL3jJub0a7DgAryFYT3GIQWw67g1wBe
         cp3g==
Received: by 10.42.29.4 with SMTP id p4mr19061445icc.30.1343170988825;
        Tue, 24 Jul 2012 16:03:08 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dk7sm6322191igb.10.2012.07.24.16.03.07
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 16:03:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <500F26BF.7090501@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202083>

Hi again,

Michael G Schwern wrote:
> On 2012.7.24 3:02 PM, Jonathan Nieder wrote:

>> Could you send the first five patches that *are* supposed to have a
>> functional effect?  I know that they will not apply cleanly to git-svn
>> from git "master" or on top of each other; that's fine with me.  If
>> the approach looks right, interested people (read: probably Ben or I :))
>> can make the corresponding change in the code layout from "master".
[...]
> I think that would be a lot of extra work for me, create a big mess and be
> harder to understand. :-/
>
> Since I'm creating new files to store the classes, the functional changes
> cannot be applied without the class extractions, so I'd have to rewrite them.

I don't understand.  Didn't I ask to send the changes as-is and say
that *I or someone else interested* would do the work to get them to
apply?

[...]
> That should give you the information you need... if I understand what you
> need.  I feel like I don't and we're talking past each other.

Basically, you are offering a code fix that's at least worth $500.
Lots of people have wanted the bug fixed for a long time.  As long as
it does not involve sacrificing maintainability, we should apply the
fix as soon as possible!  It's great that you've done this work.

Meanwhile that change is being held hostage by lots of cleanups that
are unquestionably going in the right direction but are going to be a
pain in the neck to safely apply.  And no one has reviewed your fix
that comes _after_ the cleanups.  Maybe the fix goes in a wrong
direction --- we don't know yet.  Maybe once we understand the fix
we'll have ideas that obsolete the previous cleanups and can more
simply accomplish the same thing by organizing the code a different
way.

You are saying that, to make your life easier, we should take your
cleanups and fixes as-is, all in one big pull.  Maybe you're right!
But it will take a lot longer this way than applying a smaller set of
changes that just fixes the bug.

I am saying that that, before anything else, it would be helpful for
us to *see* the relevant patches and understand your fix.  You are
more knowledgeable than anyone else about your code, so presumably it
should be straightforward to pick out which patches are the important
ones.  Using "git format-patch -1 <commit>" you can get a patch for
each.  Then you can use your favorite text editor to edit their
subject lines and change descriptions to describe what they do and
where they fall in the series of patches you are sending.  Finally you
can use your favorite mail user agent (e.g., "git send-email") to send
out the patches.

Jonathan
