From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Thu, 17 Nov 2005 11:36:47 +0100
Message-ID: <cda58cb80511170236p4a7e2baay@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ech8M-0004CR-SL
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 11:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbVKQKgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 05:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbVKQKgs
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 05:36:48 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:11111 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbVKQKgr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 05:36:47 -0500
Received: by zproxy.gmail.com with SMTP id 18so1959672nzp
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 02:36:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8JwGHWhkjM/E21G9L+VrYj9cGGdiqIjcpPWhIUaok0NamOIsEKjCLJlfamtDdIUOSao0OESULVco36cbd6VW926FruG7zDmp6zLfWXqQSYWORXXbM/jmlnUHU9yA17G+eJtothJLta4yJRpVSAC8CzgCw1ERA2WIYteNCvxiBM=
Received: by 10.36.132.11 with SMTP id f11mr7280556nzd;
        Thu, 17 Nov 2005 02:36:47 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Thu, 17 Nov 2005 02:36:47 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12095>

Hi Linus

2005/11/16, Linus Torvalds <torvalds@osdl.org>:
>
>
> First off, "rsync://" will never do what you want. It uses rsync
> (surprised surprise) to grab the objects, so since it has no clue what the
> objects are, it has no choice but to just grab them all.
>

yes that was a bad example, actually I've tried several protocol
including git protocol.

> The fact that _some_ of the linux-mips repositories are based on mine
> makes me suspect that all their 2.6-based ones are rooted like mine is,
> but that may or may not be true.
>

hmm, don't think "linux mips" repository is rooted like yours. It
seems that it has been imported from mips cvs repository which
contains linux-mips history since 1995.

> Just try your above command line with "git://" instead.
>
> (NOTE! Doing a full clone like the above is pretty expensive with git for
> the server side, so it might take a while before it starts feeding you
> stuff if it is under heavy load)
>

well I've already tried that but have renounced after waiting more
than 4 hours ! I don't know if the server was under heavy load or if
git protocol needs a lots of resources but it seems useless to setup a
git dameon on it...

> If you want to get rid of other branches, do:

Sorry, I forget to tell that I have already tried what you suggested
at first (except that I did not do a 'git repack -a -d') but it didn't
work out (and that the reason why I tried the "kill father object"
thing). Since I forgot the repack thing, I retried again, and it did
last more than 4 hours to cpmplete all git commands. After that I run
gitk --all to check that all old branch's objects have been removed
but I can see all of them.

I plan to take look at git code to understand how object removal is
done, but until this do you have any ideas why this fails ?

Thanks
--
               Franck
