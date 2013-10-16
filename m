From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Wed, 16 Oct 2013 16:06:34 -0700
Message-ID: <20131016230634.GO9464@google.com>
References: <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
 <CAEBDL5V8wfbQTZ5do-UMRpSsxRN8bFaHVnG7kRNfP0t+oYbfNg@mail.gmail.com>
 <525e0e1b28c87_81a151de743f@nysa.notmuch>
 <CAEBDL5We2wshgMZcTXoDziXskKvb9s2=2DEZtXRBgbTiitCOZQ@mail.gmail.com>
 <525ee9d93c3af_3983c19e7caa@nysa.notmuch>
 <8629441933A94862982C5CDD6BF47690@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Szakmeister <john@szakmeister.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Krzysztof Mazur <krzysiek@podlesie.net>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 01:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWaAt-0007N7-EE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 01:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760423Ab3JPXGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 19:06:39 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43012 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3JPXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 19:06:38 -0400
Received: by mail-pd0-f180.google.com with SMTP id y10so1685723pdj.11
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 16:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mu5hhh0E0kNQraHJcMOa0AU/GscgFAcSjU/t9oYvMCk=;
        b=QjWYvDEhdJHps4DzvVNRCguzLjxRcHRYtPgjpYKqDqchu0fstx/31Pj/N51Ue9chrE
         hDA4BFQHabV/kz5+pVy5PfPW3EFYoSL20VTDq24uAzTKMe6zI5tU+y1/KlNxSOdb+OPf
         D8X5nlq5/T9P395FLJQzRm0A5UmOuwOQG4gsGTu4NeZBVZspWrBuYDkFCq9w8WaF7xH3
         wMgKm+iY08ij1R5f4XWYnApOiK6jb/OOqmz0Sn/eoCC8YkWjjoAywOYM2ZZ+YHR2yZLN
         b7+DPUhs2csbpBuBSbnhVx0lcV3Q22KdPxz9K5X1p0z8XNCSf/X6NnoPClg3aLH0iM9q
         D0aA==
X-Received: by 10.68.254.132 with SMTP id ai4mr5267223pbd.51.1381964798336;
        Wed, 16 Oct 2013 16:06:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nj9sm93535842pbc.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 16:06:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8629441933A94862982C5CDD6BF47690@PhilipOakley>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236281>

Philip Oakley wrote:

> Would this be a good time to suggest a specific wording should be
> proposed (or a reminder of what was proposed repeated) for the
> documentation of this option. It will be the documentation that
> users will refer to when they need to know, rather than the list
> discussions.

It's not clear to me that this config item is a good idea.

What is the intended use?  If someone wants to test that their scripts
will continue to work with git 2.0, wouldn't testing a 2.0 release
candidate (or the current state of the 'jch' branch until one exists)
be the simplest way to do that?  If someone just likes the proposed
behavior changes and wants to start using them right away, maybe we
can help them by releasing 2.0 sooner ;-), or by advertising the
fairly simple changes in commandline usage to get the new behaviors:

	Instead of "git add", use "git add -A".

	When using "git add -u" or "git add -A" from a subdirectory
	of the toplevel, specify "git add -u ." explicitly unless you
	want it to apply to the whole tree (in which case use
	"git add -u :/").

	Instead of letting "git push" guess, name the branch you
	want to push: "git push origin master".  Or set
	'[push] default = simple' in your configuration.

	Pass --prefix to "git svn clone".

The downside of configuration like the proposed core.next is that it
is hard to explain ("What do you mean that I can't roll back to the
pre-2.0 behavior in Git 2.0 by setting this configuration setting to
an appropriate value?"), users or scripts can rely on it, and
configuration variables tend to accumulate and never be removed.  If
we really want a run-time switch for this, I suspect an appropriately
named environment variable would work better, since we have a history
of being able to remove those without alarming people.

My two cents,
Jonathan
