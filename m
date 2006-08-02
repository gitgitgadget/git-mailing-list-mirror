From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Wed, 2 Aug 2006 02:34:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608020215470.17230@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 02:34:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G84h2-0006rA-Jk
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 02:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWHBAed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 20:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWHBAed
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 20:34:33 -0400
Received: from mail.gmx.net ([213.165.64.21]:17862 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750869AbWHBAec (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 20:34:32 -0400
Received: (qmail invoked by alias); 02 Aug 2006 00:34:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 02 Aug 2006 02:34:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1ws0xb9y.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24617>

Hi,

On Tue, 1 Aug 2006, Junio C Hamano wrote:

>   - Git.pm by Pasky with help from Pavel Roskin and others.
> 
>     I'd like to merge this immediately after 1.4.2, unless there
>     still are concerns about its portability (in which case
>     please help fixing them up before this hits the "master"
>     branch).

Although I am admittedly not a big fan of this dependency (it is one thing 
to depend on perl, but another to depend on compiling C modules for perl), 
I have to say that on all machines I tested, it works fine now. The only 
platform I did not test is IRIX, and I'll do that on Friday.

>   - "merge-recur" by Johannes and Alex with help from others.
> 
>     I still see a few TODO here and there in the code, but it
>     appears that this operates correctly (I've been using this
>     for real work for some time).  Do we have benchmarks?

As for the TODOs: they are strictly non-functional. But I think we can 
squash the remaining three until Monday.

As for benchmarks, Alex has a very nasty test-case, where the Python 
script takes ages: 10 minutes as compared to just over 2 minutes with our 
recursive merge.

Unfortunately, resolve beats that easily with less than 3 seconds ;-)

>    Johannes Schindelin:
>       Add the --color-words option to the diff options family

BTW I realized it is not really colouring words, since I erroneously 
selected word boundaries at whitespace. But if the only reaction to this 
is your "soooooooo strange", I guess you'll drop it...

>       read-tree --rename and merge-rename

Do you have any numbers on that? I could imagine that merge-recursive 
could be rewritten as a shell script using this and git-merge-base...

Ciao,
Dscho
