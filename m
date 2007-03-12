From: "A.J. Rossini" <blindglobe@gmail.com>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Mon, 12 Mar 2007 09:08:46 +0100
Message-ID: <1abe3fa90703120108x3fbc5b49k17ee6d00ff5fb79@mail.gmail.com>
References: <20070311043250.GA21331@moooo.ath.cx>
	 <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0703111326170.9690@woody.linux-foundation.org>
	 <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 09:08:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQfaO-0001UP-DW
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 09:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbXCLIIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 04:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965316AbXCLIIt
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 04:08:49 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:26684 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965263AbXCLIIr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 04:08:47 -0400
Received: by an-out-0708.google.com with SMTP id b33so1346588ana
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 01:08:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zcqdf9qRrR/FQIQhEs6FoQMcnMwmh9aI8nGKHvpFC42LTdCBv7L5RycsDmsogN/r3aVuSiCKH+F2nXRZ822Fjzz61ymh/ZnPPP05Gi1lt8pPk32YNCdX+UU+zhKOW5Z5P3YNmCFQEIPLPB0mH8ZZkyzCePNQwKmzuWZ7iQ3GCrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TG0M7y+Ko503jyqsPlhnLFtFYwZFa1bDmvIwvUp3rWqC0D9wusDPKPSqJX8nvhBYRWSA1gRSg9uyOX/+6Mxnu36TS6K/rjxyOSA+tQ+UoOjAac5N6dKUWDV03cmgYqbqfo46NVQDO9ZRfzs84pyi4MjXu2hYLeg+6J/GwVFrJf8=
Received: by 10.114.75.1 with SMTP id x1mr1139235waa.1173686926882;
        Mon, 12 Mar 2007 01:08:46 -0700 (PDT)
Received: by 10.115.47.9 with HTTP; Mon, 12 Mar 2007 01:08:46 -0700 (PDT)
In-Reply-To: <7vodmzv6dq.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42013>

On 3/11/07, Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > So let's say that you have a git repository for tracking all that. The
> > "working tree" for that git repository would be your home directory.
> >
> > Now, imagine that you *also* want to track something else in git, that you
> > *also* have in your home directory. Say your ".bashrc" files etc. They
> > have nothing to do with your music tracking setup, so you don't want to
> > track it in the same git repository, and you want to have a totally
> > different .git/index file for those. But again, the *working*tree* is
> > actually your home directory.
>
> That is a good example usage schenario; we would need to think
> about what to do with .gitignore (and .gitattributes if we will
> have that in-tree), though.

Modulo problems like above, isn't this just a solid solution to the
modules problem?   (not only directory-level modules, but intertwined
(in the sense of repositories) files within a directory).

And wouldn't the cheap hack just to be to have a pecking order for
determining attributes?  (i.e. a master file with metadata which is
owned by the working directory, not the repository, to decide which
repository to look at for which files).

Ouch, but Junio's right, it's still painful, ugly and problematic.

best,
-tony

blindglobe@gmail.com
Muttenz, Switzerland.
"Commit early,commit often, and commit in a repository from which we
can easily roll-back your mistakes" (AJR, 4Jan05).
