From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git at Better SCM Initiative comparison of VCS (long)
Date: Mon, 15 Sep 2008 02:37:47 +0200
Message-ID: <200809150237.48460.jnareb@gmail.com>
References: <200809131906.18746.jnareb@gmail.com> <200809141948.07160.jnareb@gmail.com> <20080914194802.GH28210@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Alexey Mahotkin <squadette@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 02:39:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf27N-0002fj-WD
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 02:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597AbYIOAh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 20:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYIOAh5
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 20:37:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:12611 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414AbYIOAh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 20:37:56 -0400
Received: by wx-out-0506.google.com with SMTP id h27so753673wxd.4
        for <git@vger.kernel.org>; Sun, 14 Sep 2008 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=O+a6sFilJGVTEfnrzJm0UVk1BGowm8GXwQ/rbENQrC8=;
        b=VdWxuNNMpBble36CDHPLdt/YJNtViK3WR0JUs9YbAh6zVAvSYs0pHRlFwoNJC1m9o4
         RB4J+bOGg95ujSVusdHB+Npwm8Q9gawPMysqmQqevF7Zz8D4qs37DlFrD0Yv7tvO4SFd
         soU3NukHE0FGmbQXypoKkZp7BS64joNpwCjOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=efHqPb3qgXkdyToROyDXbCrR9KqjTYeZZIQlYj0+1uhypc/1fHbYKcxwQ6tOzBUwQZ
         iu0+oz4iEk/jWYgNYAW8dLTaA4sqImJhd6Ui/3b/KL/qlpTnqMQzVkUzygZly1CxwtqE
         NcN9kZs3dKhEQ1gzFB9YqH2yASsVJ5yIv5ZfQ=
Received: by 10.103.171.6 with SMTP id y6mr4952905muo.101.1221439074174;
        Sun, 14 Sep 2008 17:37:54 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.251.193])
        by mx.google.com with ESMTPS id s10sm25812063muh.12.2008.09.14.17.37.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Sep 2008 17:37:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080914194802.GH28210@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95870>

On Sun, 14 Sep 2008, Dmitry Potapov wrote:
> On Sun, Sep 14, 2008 at 07:48:05PM +0200, Jakub Narebski wrote:

> > > Another thing here is that "git commit" is local, so I am not sure
> > > if this question includes network operations...
> > 
> > Well, I think this session would be better titled "Atomic Operations"
> > or just "Atomicity".  Although I'm not sure if for example in Git
> > all operations are atomic under all conditions...
> 
> I believe that all git basic operations are atomic. In fact, you either
> got a new revision with new SHA-1 or don't. Aborting operation may
> leave some dangling objects, but it is okay, because they will be
> garbage collected later. But I am not sure about additional utilities
> such as git-svn. Git-svn uses rebase as it dcommits, being interrupted,
> it may leave you in some strange state. It is possible to recover but
> it may be not obvious for newbies. Other than that, I think everything
> is very resilient to any interruption.

I was thinking here about long-lasting and multiple-parts operations
like for example git-clone.  Nevertheless we would never be in
inconsistent state.
 
> > > So, perhaps, it should be two separate points:
> > > - ability to preserve history of rename (with detail clarification
> > >   of what it means)
> > > - ability to show renames in the project history
> > 
> > That are points '1' and '2' on my list, perhaps stated bit differently:
> > showing renames in full history / history of project as whole, and
> > following history of a single file across renames.
> 
> I did not mean '1' and '2' as priorities, but that it is slightly
> different features and both can be titled as support of renaming.

I didn't mean '1' and '2' as priorities; they are more or less equal,
although I would say that '1' might be prerequisite to '2'.  '0' is
however a base which must be satisfied for tool to be named to have
"rename support".
 
> > > 
> > > Git tracks content rather than file-ids, and therefore it uses heuristics
> > > for rename detection.  This approach has an advantage of being able to
> > > preserve history for code lines between files, which usually happens much
> > > more often than file renaming.
> > 
> > I would rather write
> > 
> >   Renames are supported for most practical purposes[1]. By design Git
> >   does heuristic <i>rename detection</i> (based on similarity score of
> >   pathnames and file contents), instead of doing rename tracking (which
> >   usually is based on some kind of file-ids).  This approach allows for
> >   more generic content tracking of code movement (which usually happens
> >   much often than wholesame file renaming), e.g. in "git blame -C -C".
> 
> Sounds good to me. Perhaps, I would drop '(which usually... file-ids)'
> to make the sentence a bit shorter.

O.K.

(But I would wait a bit for final proposal, with sending patch for
scm-comparison.xml to Alexey and Shlomi.)

> > > > scm>         <section id="tracking_uncommited_changes">
> > > > scm>             <title>Tracking Uncommited Changes</title>
> > > > scm>             <expl>
> > > > scm>                 Does the software have an ability to track the changes in the
> > > > scm>                 working copy that were not yet committed to the repository?
> > > > scm>             </expl>
> > > > 
> > > > This also should be made more clean.  Does it mean for example ability
> > > > to tell which files have changed, or ability to diff working copy to
> > > > either last comitted changes, or to any revision available in repository?
> > > 
> > > Also, ability to diff one or more specified files in the working copy to
> > > some specified revision.
> > 
> > Right.
> > 
> > I'm not sure now if "Tracking Uncommitted Changes" is a good name for
> > this feature / criterion, but I don't have definite idea for change...
> 
> Actually, I don't like this name either. In particular, the word
> "tracking". Perhaps, "Showing Uncommitted Changes" would be a better
> name. Yet, ability to show diff between the working copy as some
> arbitrary version should be listed as a separate feature.

I don't have good name either. It is <something> about Uncommitted Changes.
Dealing with, or support for, or something...
 
-- 
Jakub Narebski
Poland
