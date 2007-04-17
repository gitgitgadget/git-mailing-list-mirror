From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: Re: GIT vs Other: Need argument
Date: Tue, 17 Apr 2007 14:45:20 +0400
Message-ID: <20070417104520.GB4946@moonlight.home>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pietro Mascagni <pietromas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 12:45:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdlBi-0004Df-Ar
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 12:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbXDQKp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 06:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbXDQKp1
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 06:45:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:38417 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbXDQKp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 06:45:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so134808uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 03:45:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=TY6HmYEVlUfTSevfFBAZFsW4Qs73eCWZVz8tGDzecdXr8X5r36BufbNgz5/Dc0uHDhjwoI5e/re0DdEteLqlKNhmdUbRe42RRBra6j52Szsz3Gn61WGFsx6XHNVY0f8MvfKYqGrKz/RTTVWdPpGr8wbJrRmLT1UkPVfOgx8BIQk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=T0IoIz+fWJN6H8eNr693XAhWfcwXZSnzJtw1xebkownzrOstRSILC8X2Oa/G9qXavIxxU6dZLRSwKW0AgIgRn2191vzZG85CLy8zx3JtBYpERFWDdC8XaU64x8ECgbDt60K0J9PC7yUPLHEucIxUtiFVlkLyaV/PToWgqFqCf+I=
Received: by 10.67.71.15 with SMTP id y15mr388738ugk.1176806724610;
        Tue, 17 Apr 2007 03:45:24 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id o24sm854435ugd.2007.04.17.03.45.23;
        Tue, 17 Apr 2007 03:45:24 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id 581183A7C4;
	Tue, 17 Apr 2007 14:45:21 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l3HAjKQ6007460;
	Tue, 17 Apr 2007 14:45:20 +0400
Content-Disposition: inline
In-Reply-To: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44761>

On Tue, Apr 17, 2007 at 10:02:18 +0100, Pietro Mascagni wrote:
> So, in 15 seconds, how does one argue that GIT is vastly superior to
> other version control software, especially CVS.

I think you are not talking about choosing SCM for a new project, as
it is even _hard to imagine_ that one would consider CVS nowadays :).
And if you are trying to convince people to do the migration from CVS
to GIT, then technical points alone won't probably help you.  GIT, and
actually most modern SCMs, are superior to CVS not simply because they
have some CVS's features improved, and some nice features added.
Modern SCMs implement completely different workflow model.  GIT's own
power in its rich toolset, but until people learn (or at least are
willing to learn) what the workflow is, and how it is supported by
these tools, there's little advantage in migration.  You can't really
explain why 'git commit; git push' into some central repository is
better than 'cvs commit', and pushing after every commit is what
people will be doing at first ;).  You should also realize that the
whole process is probably already built around CVS (CVS-specific
hooks, scripts that access CVS, say, for nightly testing, etc), that
would also have to be reimplemented.

You may consider another route: create a GIT mirror of CVS repository,
and update it, say, daily, with git-cvsimport.  Clone from this
mirror, and work with your own GIT tree, pushing back to CVS with
git-cvsexportcommit.  Yes, you will be dealing with problems that
wouldn't be there in the first place if everyone would use GIT, and
you will basically use CVS workflow, but still, this way is quite
manageable.  Then approach the most promising guy in the company, and
explain to him how you benefit from using GIT (gitk/qgit, git-bisect,
StGIT are among your friends here :)).  As the saying goes, "Better to
see once, then to hear about a hundred of times".  You are not
interested in instant migration, and then being blamed if anything
would go wrong.  When you will grow sufficient number of GIT experts
in your company, then you will raise the migration question again.


Good luck!

-- 
   Tomash Brechko
