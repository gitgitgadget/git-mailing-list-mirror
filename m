From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v4 1/4] commit test: Use test_config instead of git-config
Date: Thu, 12 Jun 2014 11:04:59 -0700
Message-ID: <20140612180459.GA15556@hudson.localdomain>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io>
 <1402511079-17735-2-git-send-email-caleb@calebthompson.io>
 <20140612084152.GA6095@hudson.localdomain>
 <20140612135051.GA35824@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:05:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wv9N9-0001Tw-PW
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889AbaFLSFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:05:05 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:57993 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaFLSFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:05:03 -0400
Received: by mail-pb0-f48.google.com with SMTP id rr13so1248475pbb.7
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=auVA25Jkrk0OYJd3cRwBZv9uj0J06C+JyGQNGggpyZs=;
        b=bbkj6JkcD1XSFm0tTxYF95gqZ+PjiVZ4D4UX/EyegPsROlQ4rsUA1VtxpUdvU3RhCj
         ODFQvQ+84Y+zpWMQNN56bnprPGt+geg8p63qrpU4S+plXNCnhHxp2hbEw9MWZyaDBHy9
         BFF1evJp1FUoUJ91cEEJvjdHUcFydhIbcyylPnDjEWnrE7QqgPPP4N0/jdAV7w7YGmAJ
         r5Ss7mmbsO7xMIOsxXUvK0gSc1vGbJaRDH/yrbkPuk1zSHdvyP/NTdJz9wEkXFM4CWua
         4YOiEoOPfVxDDafN6MsAMWOr5lP3sRpWljID3D6nsXj+eNoWYQSxS5z+UnV3J/gPlBim
         Z/9A==
X-Received: by 10.67.22.33 with SMTP id hp1mr22460800pad.134.1402596302316;
        Thu, 12 Jun 2014 11:05:02 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id io6sm8405685pac.44.2014.06.12.11.05.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 11:05:01 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Caleb Thompson <caleb@calebthompson.io>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140612135051.GA35824@sirius.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251467>

Caleb,

On Thu, Jun 12, 2014 at 08:51:31AM -0500, Caleb Thompson wrote:
> I assume that you're running it against master?
> 
> I rebased the branch yesterday, but I'll give it another shot. Obviously I
> didn't use git-am, but I can try that.
> 
> Caleb Thompson
> 
> On Thu, Jun 12, 2014 at 01:41:52AM -0700, Jeremiah Mahler wrote:
> > On Wed, Jun 11, 2014 at 01:24:36PM -0500, caleb@calebthompson.io wrote:
> > > Some of the tests in t/t7507-commit-verbose.sh were still using
> > > git-config to set configuration. Change them to use the test_config
> > > helper.
> > >
> > > Signed-off-by: Caleb Thompson <caleb@calebthompson.io>
> > > ---
> > >  t/t7507-commit-verbose.sh | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> > > index 2ddf28c..6d778ed 100755
> > > --- a/t/t7507-commit-verbose.sh
> > > +++ b/t/t7507-commit-verbose.sh
> > > @@ -43,7 +43,7 @@ test_expect_success 'verbose diff is stripped out' '
> > >  '
> > >
> > >  test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> > > -	git config diff.mnemonicprefix true &&
> > > +	test_config diff.mnemonicprefix true &&
> > >	git commit --amend -v &&
> > >	check_message message
> > >  '
> > > @@ -71,7 +71,7 @@ test_expect_success 'diff in message is retained with -v' '
> > >  '
> > >
> > >  test_expect_success 'submodule log is stripped out too with -v' '
> > > -	git config diff.submodule log &&
> > > +	test_config diff.submodule log &&
> > >	git submodule add ./. sub &&
> > >	git commit -m "sub added" &&
> > >	(
> > > --
> > > 2.0.0
> > >
> >
> > It is probably something dumb on my part but for some reason I cannot
> > apply this patch using 'git am'.  After I save the patch to a Maildir
> > from Mutt and run git am...
> >
> >   jeri@hudson:~/git$ ./git-am ct1.patch
> >   Applying: commit test: Use test_config instead of git-config
> >   fatal: corrupt patch at line 15
> >   Patch failed at 0001 commit test: Use test_config instead of git-config
> >   The copy of the patch that failed is found in:
> >      /home/jeri/git/.git/rebase-apply/patch
> >   When you have resolved this problem, run "git am --continue".
> >   If you prefer to skip this patch, run "git am --skip" instead.
> >   To restore the original branch and stop patching, run "git am --abort".
> >   jeri@hudson:~/git$
> >
> > The second patch in the series applies fine.  And I have applied other
> > patches this way without issue.  Can anyone confirm this problem?
> >
> > --
> > Jeremiah Mahler
> > jmmahler@gmail.com
> > http://github.com/jmahler

Thanks for checking.  Unfortunately the problem persists for me.

It seems to be related to there not being a space at the left most part
of the patch.  It is just a tab with no space.  So 'git am' has a
problem because it is expecting to remove a space and there isn't one.
See the attached screenshots with tabs highlighted.

How are you preparing your patches.  'git format-patch' with a 'git
send-email'?

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
