From: Andreas Ericsson <ae@op5.se>
Subject: Re: Do most people feel tracking branches useful?
Date: Wed, 29 Oct 2008 10:48:22 +0100
Message-ID: <49083166.7090804@op5.se>
References: <49082514.9050405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 29 10:49:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv7gL-0000l8-Lv
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 10:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYJ2Js1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 05:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbYJ2Js1
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 05:48:27 -0400
Received: from mail.op5.se ([193.201.96.20]:43916 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbYJ2Js1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 05:48:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 577DB1B80070;
	Wed, 29 Oct 2008 10:42:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKisIL363mR5; Wed, 29 Oct 2008 10:42:49 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 181EB1B80048;
	Wed, 29 Oct 2008 10:42:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <49082514.9050405@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99354>

Liu Yubao wrote:
> Hi,
> 
> I often feel tracking branches are useless to me, because there are remote
> branches and I work on my private branch in most time.
> 
>    repos
>      |
>      |-- my               (private branch, do my dirty work)
>      |-- master           (tracking branch)
>      |-- origin/master    (remote branch)
> 
> To avoid conflict when execute `git pull` and make the history linear, I work
> on branch "my" instead of "master". Here is my work flow:
> 

Use "git fetch" instead of "git pull" and you won't need the 'my' branch.
If you use "git pull --rebase" you won't need to bother at all.

> 1) use `git fetch` or `git remote update` to synchronize branch "origin/master"
> with branch "master" in remote repository;
> 2) create a new private branch to polish my commits and rebase it against
> "origin/master";
> 3) at last push this new branch to the remote repository or ask the upstream
> developer to fetch it(no `git pull` because we want history as linear as possible).
> 
> I don't want to bother with the tracking branch "master", it's identical
> with "origin/master".

Not unless you "git pull" when there's only fast-forward changes.

>  Because `git checkout -b xxx <remote_branch>`
> will create a tracking branch "xxx" by default, so my question is:
> do most people feel tracking branches useful?
> 

I use them all the time. They're immensely useful to me.

I can't understand why you're working so hard for a linear history, but perhaps
that's just an effect of only having leaf developers. I also can't understand
why you'd want to sync with upstream at all if you're just working on a single
feature/bugfix at the time, since you'd probably be better off by just completing
that single feature in your own time and doing "git pull --rebase && git push"
when you're done.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
