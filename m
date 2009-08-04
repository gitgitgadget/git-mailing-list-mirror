From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How to push properly a la subversion
Date: Tue, 4 Aug 2009 16:04:47 +0400
Message-ID: <20090804120446.GD10264@dpotapov.dyndns.org>
References: <4A7095CE.8030307@gmail.com> <20090729195044.GA27178@dpotapov.dyndns.org> <111060c20907300111u4345b1f1x784229c066fb3f88@mail.gmail.com> <20090730115448.GB27178@dpotapov.dyndns.org> <111060c20908040017y753a3cb4mbc4d7654192a5d1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Stigler <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 14:06:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYImr-0004XM-AT
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 14:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754688AbZHDMG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 08:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754628AbZHDMG1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 08:06:27 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:41278 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbZHDMG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 08:06:26 -0400
Received: by ewy10 with SMTP id 10so261773ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 05:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/ETYD6gTgN84E//XxPP9bCpIA5Ohvjtc7+u8DQpDHuo=;
        b=YrGInIZ+fLjFgQovv4pT4ERghT/qIpU01CzPVNrEVjsFeBqORD12l3+VfSLAX4vkK7
         JLLSgZcOPVuVDiYCQMCKSs9iEzByqZ5zECimYTRHDn8EATTCd178GJem/GzbEtzxtSy/
         c+Wb4ISMY2t54hTY+g/d9QfrcglZGgBRF9j6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=d8liDmoVfPFvFmEvrHg5goat+ep7sYIBRxwfbvRS16HnBEJT04xnK4/aWkoi4fBiGf
         Pz3/aX7twX2wRYXID+JDr8oK+A7rdH8b5eutK2w8GGRqF4cQFQrizGwRPXmYkozwiWwO
         kQrSY5mM9mZ/mbqM4z/N9CkBu5dkMs1VxOUBo=
Received: by 10.210.79.3 with SMTP id c3mr6596191ebb.16.1249387585302;
        Tue, 04 Aug 2009 05:06:25 -0700 (PDT)
Received: from localhost (ppp91-76-18-80.pppoe.mtu-net.ru [91.76.18.80])
        by mx.google.com with ESMTPS id 5sm1979450eyh.46.2009.08.04.05.06.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 05:06:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <111060c20908040017y753a3cb4mbc4d7654192a5d1a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124778>

On Tue, Aug 04, 2009 at 09:17:45AM +0200, Matthieu Stigler wrote:
> 
> This was a source of confusion for me and I did not get it
> immediately. Maybe be help page git-svn crash course could be more
> detailed about that? It just mentions the analogy git commit -a /svn
> commit (so the first step you mention) but not the second (svn commit
> is similar to git push also)? Personaly, I think this could help a lot
> newbies like me ;-)

I see that it may be a source for confusion if you look at it from the
team workflow POV, you can even say that 'git push' is analogue of 'svn
commit'. But it is a general principle of Git that all commands except
specifically designed to propagation changes ('fetch', 'push', 'pull'
and 'remote') to work locally. So, it is not only that all commits are
created locally but also branches, tags, etc. And, though, your repo may
be visible to other directly, but it is more commonly that you have to
push your changes to some bare repository on the server where it can be
seen by other developers.

So, I am not sure how better to state that in "Git - SVN Crash Course",
and what is the right place for that. Maybe, a few words should be added
to the section titled "Things You Should Know", but I am not sure about
wording. Your suggestions are welcome.

> 
> Second, you said
> > So, your normally should never push to the branch that is currerently checked out. (New versions of Git will warn you about that).
> 
> Is there a way to avoid that? Manually, do I just need on post A
> (against which it was pushed from clone B) to use:
> git-reset --hard HEAD

Normally, you should push to a bare repository, so it not an issue. Yet,
there are some situations when it can happen. For instance, you have two
computers on which you work and you want to push your work from one them
to another directly without using any bare repo. In this case, you can
use 'git reset --hard HEAD' after push (and it can be done automatically
by hooks) but you should be *sure* that uncommitted changes in that
working directory, otherwise they will be lost. So, I really don't think
it is a good idea to do automatically. There are a few alternatives
though. Instead of pushing to the checkout branch, you can push to a new
branch (See refspec for details). There is also Johannes Schindelin's
patch called "Add a few more values for receive.denyCurrentBranch",
which adds the 'updateInstead' value. It may be want you want, but it is
not included to the official Git, because there very few users who want
to this feature.

Do you really foresee a setup where you will push to a non-bare repo
quite often?


Dmitry
