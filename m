From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: How to figure out what 'git push' would do?
Date: Sun, 5 Aug 2007 21:56:37 +0200
Message-ID: <515E28B6-85AF-4379-870A-CFECF19B74DE@zib.de>
References: <267CDD46-549B-4BFE-B993-80CD1CFE75D8@zib.de> <20070805173340.GA3159@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 21:56:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHmCl-0000AE-V2
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 21:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbXHETzr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 15:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754017AbXHETzr
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 15:55:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:51289 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbXHETzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 15:55:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l75JtjCM013127;
	Sun, 5 Aug 2007 21:55:45 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10786.pool.einsundeins.de [77.177.7.134])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l75JtiOC017550
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 5 Aug 2007 21:55:44 +0200 (MEST)
In-Reply-To: <20070805173340.GA3159@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55065>


On Aug 5, 2007, at 7:33 PM, Alex Riesen wrote:

> Steffen Prohaska, Sun, Aug 05, 2007 13:37:34 +0200:
>> How can I check what a 'git push' would do, without
>> actually doing it?
>>
>> Is there something like 'git push --dry-run', similar
>> to 'rsync --dry-run'?
>
> No. It is often safe to just do git-push, unless you have naive
> developers doing pull every time some ref in your shared repo changes
> *and* expecting the result to compile (typical for CVS way of work).
> git-push will not overwrite anything, it always only forwards history.
>
> For the case you really want to know what the changes on remote repo
> will be it is possible to fetch them into the local repo first and
> compare with what you will push:
>
>     $ git fetch git://remote/path/REPO master:refs/remotes/REPO/master
>     $ gitk local..REPO/master
>
> It gives you all possible information, which may be worth that bit of
> work. Or, if you have all the remote configuration ready, it can be
> just:
>
>     $ git fetch
>     $ gitk local..REPO/master
>

That applies only for a single branch. If I prepared a couple of
branches for pushing and somehow want to double check what I prepared,
'git push --dry-run' would be quite handy. I know how to handle the
situation and could write a custom script that does all necessary
checks. But I haven't found an out-of-the-box solution for double
checking right before 'git push'

	Steffen
