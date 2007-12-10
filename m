From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How-to combine several separate git repos?
Date: Mon, 10 Dec 2007 08:52:31 +0100
Message-ID: <20071210075231.GA2984@steel.home>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home> <475C3E25.30704@saville.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 08:53:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1dRj-0000Wr-4t
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 08:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbXLJHwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 02:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbXLJHwh
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 02:52:37 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:9511 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbXLJHwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 02:52:37 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTj/u1c=
Received: from tigra.home (Fcade.f.strato-dslnet.de [195.4.202.222])
	by post.webmailer.de (mrclete mo49) (RZmta 14.5)
	with ESMTP id Y03a3ejBA3pAzA ; Mon, 10 Dec 2007 08:52:34 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D2901277AE;
	Mon, 10 Dec 2007 08:52:33 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 94A7E56D22; Mon, 10 Dec 2007 08:52:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <475C3E25.30704@saville.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67691>

Wink Saville, Sun, Dec 09, 2007 20:12:37 +0100:
>> You can merge them, for example:
>>
>>     $ cd project1
>>     $ git merge project2/master
>>   
> Starting over (restoring the original from a tar backup)
> this didn't work I get:
>
> wink@ic2d1:$ cd StateMachine
> wink@ic2d1:$ git merge ../test2/master
> ../test2/master - not something we can merge

This is *not* what I suggested. It should be:

    $ git config ... (as suggested before)
    $ git fetch test2
    $ git merge test2/master

Here test2/master - is *NOT* a path. It is the name of the branch
where the local repository stores reference to the commit
corresponding to the master of remote repo (that is: the "master"
branch of "test2", as seen from the repository where you do the
merge).

> So the first suggestion works, but I don't want them as
> separate branches as I want to work on the simultaneously
> and they'll share common code.

Sound like the secode (merge) approach

> Another option I was thinking would work for me would be to use
> submodules. But I'm not sure submodules are ready for
> neophytes and maybe it doesn't do what I want?

They are ready for some (dunno if they'd like to be called neophytes).
I just don't think you need them (keywords on your explanations being
"share common code", understanding them as "the modules use the common
code simultaneously").
