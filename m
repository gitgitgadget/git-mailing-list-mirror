From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git drawbacks?
Date: Wed, 11 Nov 2009 02:43:31 +0300
Message-ID: <20091110234331.GM27126@dpotapov.dyndns.org>
References: <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com> <20091109210631.GJ27126@dpotapov.dyndns.org> <loom.20091110T093334-810@post.gmane.org> <20091110140428.GL27126@dpotapov.dyndns.org> <loom.20091110T154312-665@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 00:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N80ND-00082p-0Y
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 00:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655AbZKJXnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 18:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757186AbZKJXnb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 18:43:31 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:45976 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbZKJXna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 18:43:30 -0500
Received: by fxm21 with SMTP id 21so584843fxm.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 15:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=99Pari1VazyYAyEknV3DsGMRdPDJfkHgTV2PBje10e8=;
        b=rec5vXvEbeMF5HqjT66rKnhYmfn3766sC4WPTwqXQtLXGyq94vIMV9SLWX2MZVH7mF
         CMYDocSU7PDmM8in61GhLcN3KMVvBSe6r7hKYgbGqKuJC70jWJFQbriLWnW4RWrDrJC1
         RlGeEBrAsM/vLFbTbKGUHITr5b332XTVA+310=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w1Fp6/SMpXaPplpjPo2ENzJPd+Q8n4PADCtvXz71G2ZAenEnPzxnL4Gle+0vWAya5Q
         ZZy7zidWTAnMmmxpQJ6ewIUtpPbNtJY2kD2BinVxiyQRLjSiYo1Tjt2uHOVbPXB2BHfH
         X1r4KeLvGYteD7NiCvcOVuzbtiU8iI1M7lPDU=
Received: by 10.204.150.69 with SMTP id x5mr705661bkv.197.1257896614792;
        Tue, 10 Nov 2009 15:43:34 -0800 (PST)
Received: from localhost (ppp85-140-126-241.pppoe.mtu-net.ru [85.140.126.241])
        by mx.google.com with ESMTPS id 16sm413541bwz.15.2009.11.10.15.43.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 15:43:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20091110T154312-665@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132604>

On Tue, Nov 10, 2009 at 02:54:43PM +0000, Dmitry Smirnov wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
> 
> > And then if you really want
> > to have good and clean history, you need more than just a branch. You
> > should be able to amend your previous commits while you work on some
> > feature. With Git, it is trivial, you just run 'git rebase -i' and may
> > edit some previous commits, correct comments, squash fix-ups, etc...
> > How can you model that? By creating another branch and moving patches
> > to it by hands... Well, it is not very productive time spending, and
> > the cost of branch becomes even more prominent.
> 
> This is a cool feature, but it contradicts to my understanding of VCS. 

Yes, it may *appear* to contradict one of basic axioms of any VCS --
history is immutable, but here is the rule -- you never ever rebase or
change in any other way the public history of the official repository.
So once your commits hit the master branch, you should never try to
change them. This may be enforced through Git hooks.

However, when we speak about history of commits in your private feature
branch then no one cares about how you have arrived to these series of
patches more than in what order you have edited your files. What really
matters is the end result -- our patches are clean and easy to review.

Now, what is 'public' history or what is not. If no one has seen your
commits then it is clearly not public. If your commits are integrated
to the main development branch ('master') then they are clearly public.
However, many Git users have an international branch (often called as
proposed updates or 'pu' for short). The 'pu' branch is regularly
rewound, so no one should based their work on it. It is more for review
and additional testing of things that may not ready yet. When your
branch is merged to 'pu', it considered to be a fair play to re-write
your patches. However, you should do that in the way that will not
cause problems for people who review your changes.

Finally, when you re-write some branch using interactive rebase or
something else. Your old changes do not disappear immediately from your
repository. Git has 'reflog', which keeps _all_ commits in your local
repository for 30 days (or whatever time your choose). So, if you did
something wrong during rebase, you can always go back to the original
version, though you will hardly ever need that feature unless you do
something really stupid...


> BTW, as I undestood it, it is just a feature that can be implemented 
> in any VCS (if you have access to its internals).

At least, not so simple. Have you heard about Mercurial? It is another
DVCS, which in many aspects similar to Git, but the underlying backend
is very different. I do not follow it very closely, but for a long time
it did not have 'rebase' and users were advised to use Mercurial Queues
instead, which is patch management system on top of Mercurial. While Git
has its own implementations of patch management systems on top of Git
such as StGit and recently TopGit, I do not think they come even close
when it comes to easy to use in everyday work, especially if you do not
want to be bothered with thinking about patch management.

Much power of Git and its flexibility comes from clean separation of the
underlying storage format and repository history.  This makes 'rebase'
almost trivial in Git (unless you have merges in rebased history and you
try to preserve them), while with many other VCSes, those changes will
require significant changes to the underlying storage, which may be
difficult to implement safely and efficiently. The price that Git has to
pay for its flexibility is the need to run the garbage collection to
purge loose objects and compact all objects in one compressed pack...


Dmitry
