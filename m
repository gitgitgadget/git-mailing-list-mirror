From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Why is it important to learn git?
Date: Thu, 23 Jul 2009 01:07:39 +0400
Message-ID: <20090722210738.GA25324@dpotapov.dyndns.org>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:08:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTj2u-0004wF-La
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbZGVVH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZGVVH7
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:07:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:40036 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbZGVVH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:07:57 -0400
Received: by fg-out-1718.google.com with SMTP id e12so988531fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+GL7tSzTfptb7HMr/FA1yViniQA2lKBBIl7xmGJuq60=;
        b=ERDkF5A0XwDjetq4CkMQl+u8ZERElZUVUKhXjamMzWM9EumYSsBvkVzLXR9WF0NSZN
         YmhD0/wJXfykaVEz8HHC6vwf1qLEYdC5adujFcgwgyo46GNTSFou8bPzCw1FgFh+9H38
         C+bchyJPbQ3GHZp246wY9B78fbG2ADbf0j3T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XPC8trlqaaveW3fLGw4uD+8ZBfF11Amg52aqLiP0UWlqeBy1Y/wlvLLmdq/I9jigTR
         YTuDBTTh4igeZizCjjr6M2RSbpTrXFTN70YPYy5iJUmeQ9bxRtUI7uEsgPZkFVl92FQa
         Dm7kN7mEFSzj8JdBPm2si6xjpuO14CNoN2zvg=
Received: by 10.86.28.16 with SMTP id b16mr1167349fgb.53.1248296877077;
        Wed, 22 Jul 2009 14:07:57 -0700 (PDT)
Received: from localhost (ppp91-77-225-54.pppoe.mtu-net.ru [91.77.225.54])
        by mx.google.com with ESMTPS id l19sm1940740fgb.26.2009.07.22.14.07.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 14:07:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123775>

On Tue, Jul 21, 2009 at 11:08:31PM -0600, Tim Harper wrote:
> 
> How has mastering the advanced features of git helped you to be a
> better programmer?

I don't think that features itself make as big difference as the fact
Git provides you much more flexibility in choosing a more appropriate
workflow than you have with any centralized VCS. (Yes, you will still
find many Git features handy even if you work with it as you did with
CVS, but you will miss most benefits of Git).

To really understand what benefits Git offers, you have to realize first
what is wrong CVS and CVS-like VCSes. Unfortunately, it is difficult to
explain just in a few words. Some implementation deficiency of CVS is
obvious (and it was addressed in some CVS clones like Subversion), but
more fundamental problems are far less obvious even for people who used
CVS for many years.

To be fair to CVS, it is far from the worst VCS. There are some insane
lock-based VCS, which were so painful to use (mostly due to these
exclusive locks but often due to some other insanity too) that anyone
who worked with may think about CVS as a really nice system...

In some way, CVS was really revolutionary for its time, because it used
the copy-modify-merge paradigm instead of excluding locking, which was
dominant before the CVS era. Those exclusive locks not only could not
work over the Internet, they were so excruciatingly annoying even if
everyone was sitting in the same room... Despite some initial skepticism
about essentially the lock-free VCS, I think it is safe to say now that
the copy-modify-merge paradigm won. Period.

However, if you look at the support of this paradigm in CVS and other
centralized VCSes, it is very limited in every aspect:
- copy: you can have a copy only one revision. (it may not be a big
  issue unless you like to work offline and to look at history).
- modify: there is no problem with modification itself, but you cannot
  save your changes without committing that to the official repo, which
  is not such a good thing if they are not ready yet or were not reviewed
  properly.
- merge: well.. I don't think there is any sane person who enjoyed
  merging branches in CVS... The only merge that was _relatively_ easy
  to do was merging your worktree with the upstream. Even that is not
  perfect in CVS, because you cannot save your changes before merge. So,
  if you made a mistake during 'cvs update', you risk to losing your
  work... Also, there is no possibility to review the merge later or to
  delegate to someone else when its resolution happens to be tricky...

The above limitations have further consequences with negatively affect
co-operation among developers. For instance, it is very difficult to
organize the review process with any centralized VCS. Typically, a
review process may require saving and share your work with reviewer
without committing it to the central repo. Also, this work should be
split into logical steps to make review easier. The only way to do that
with a centralized VCS is to use some patch management system on top of
it.... and at that point you may ask whether you want to learn two
systems with overlapping functionality and not so well integrated with
each other?

Another important reason why feature branches are so useful is that they
allow to postpone the decision about integration of some feature to the
master branch to the time when you convince that it is ready and useful.
In a "centralized" workflow, people often commit as they progress to
their goal, but some ideas may not so good as they initially appeared.
At the time when you realize that, your changes already intervened with
other people changes. There is no easy way to remove them cleanly. And,
some work even if it is useful may be not ready to the time when you
planned to realize a new version. This results in unnecessary delays in
release.

There are more problems with the "centralized" workflow used by CVS and
alike. They may be not very noticeable on small projects, but it tends
to get worse as any project growths over time.


So, the main advantage of Git is not in the number of features (and Git
has plenty of them despite of efforts to limit them to only truly useful
for many users), but its conceptual wholeness and flexibility, which
allows you to choose the appropriate workflow for your needs.


Dmitry
