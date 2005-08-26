From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 19:08:47 +1200
Message-ID: <46a038f90508260008d1013ea@mail.gmail.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	 <46a038f905082518306e9d7d2a@mail.gmail.com>
	 <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	 <46a038f90508252115415acc04@mail.gmail.com>
	 <m17je9tcj0.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 10:31:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8YL7-0007wH-7H
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 09:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbVHZHIy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 03:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVHZHIy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 03:08:54 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:50155 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932540AbVHZHIu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 03:08:50 -0400
Received: by rproxy.gmail.com with SMTP id i8so515454rne
        for <git@vger.kernel.org>; Fri, 26 Aug 2005 00:08:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P9SQsDMalaeo6vtTPc3VjxfJHjUjp6Y+mhdPwxAqUjGk3+xg5mGqsphOyB0ww7fNMNED/krVaYfBqmDJBUaUysehAmLRHkXnGWdXNMwS4V4QkUotkBnk42C8U7AalfNCScxDY741UnYPPbJJ19OPBAKZsz/+W3kG+mPsw9x1/tU=
Received: by 10.38.92.14 with SMTP id p14mr1584405rnb;
        Fri, 26 Aug 2005 00:08:47 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Fri, 26 Aug 2005 00:08:47 -0700 (PDT)
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m17je9tcj0.fsf@ebiederm.dsl.xmission.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7779>

On 8/26/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Thinking about it going from arch to git should be just a matter
> of checking sha1 hashes, possibly back to the beginning of the
> arch tree.

Yup, though actually replaying the tree to compute the hashes is
something I just _won't_ do ;)

> Going from git to arch is the trickier mapping, because you
> need to know the full repo--category--branch--version--patch
> mapping.

My plan doesn't include git->arch support... yet...

> Hmm.  Thinking about arch from a git perspective arch tags every
> commit.  So the really sane thing to do (I think) is to create
> a git tag object for every arch commit.

Now I like that interesting idea. It doesn't solve all my problems,
but is a reasonable mapping point. Will probably do it.

> With patch trading (Martin I think I know what you are refering to)
> arch does seem to have a concept that does not map very well to git,
> and this I think is a failing in git.

I won't get into _that_ flamewar ;)

My plan for merges is to detect when two branches up until what point
branches are fully merged, and mark that in git -- because that is
what git considers a merge. The rest will be known to the importer,
but nothing else.

cheers,


martin
