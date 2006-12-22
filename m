From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 10:39:30 +0100
Message-ID: <8c5c35580612220139x491dc3ecwf3fc60dda2fa379f@mail.gmail.com>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home>
	 <200612220841.46016.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 22 10:39:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxgsP-0007nj-0z
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 10:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946013AbWLVJji (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 04:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946010AbWLVJji
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 04:39:38 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:31113 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946015AbWLVJjh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 04:39:37 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3379418nfa
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 01:39:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N4kl/YodB670gp6eUHjTKyYiM0nc9JVzgVKSZg7G/jT2HIrRQsgMovpWhzbA6wRz99k4nuv0X4+3YkXStSJRXgUNHHupE7SV5LykCORi+VPgSWE87Jvvj+aYz2usef1TEc/G5PYDtua7Y6ScVlywStIGqCUEyafBfrcAo/xiIj0=
Received: by 10.82.172.15 with SMTP id u15mr536481bue.1166780375752;
        Fri, 22 Dec 2006 01:39:35 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Fri, 22 Dec 2006 01:39:30 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
In-Reply-To: <200612220841.46016.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35156>

On 12/22/06, Andy Parkins <andyparkins@gmail.com> wrote:
> On Thursday 2006 December 21 22:17, Nicolas Pitre wrote:
> > $ git branch -r
> > * master
> >   origin/HEAD
> >   origin/html
> >   origin/maint
> >   origin/man
> >   origin/master
> >   origin/next
> >   origin/pu
> >   origin/todo
>
> I'm trying to track down why "master" is being shown in this case";

This looks very much like "git branch -a".

I've just tried this:

$ git clone git://git2.kernel.org/pub/scm/git/git.git
Initialized empty Git repository in /home/larsh/src/tmp/git/.git/
remote: Generating pack...
remote: Done counting 34527 objects.
remote: Deltifying 34527 objects.
remote:  100% (34527/34527) done
Indexing 34527 objects.
remote: Total 34527, written 34527 (delta 23920), reused 34111 (delta 23623)
 100% (34527/34527) done
Resolving 23920 deltas.
 100% (23920/23920) done
Checking files out...
 100% (748/748) done
$ cd git
$ git branch -r
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo
$ git branch -a
* master
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo
$ cp .git/refs/heads/master .git/refs/remotes/master
$ git branch -r
  master
  origin/HEAD
  origin/html
  origin/maint
  origin/man
  origin/master
  origin/next
  origin/pu
  origin/todo
$ git symbolic-ref HEAD refs/remotes/master
$ git branch -r
fatal: HEAD not found below refs/heads!
$ git --version
git version 1.4.4.2.gee60


-- 
larsh
