From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How can I remove a remote branch from local repo that is removed
   at the server side
Date: Tue, 12 May 2009 09:32:15 +0200
Message-ID: <4A0925FF.5030307@viscovery.net>
References: <4A091DB3.4070509@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Tue May 12 09:32:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3mTT-0004h0-BY
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 09:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379AbZELHcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 03:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756250AbZELHcS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 03:32:18 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:27905 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499AbZELHcS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 03:32:18 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M3mTI-0004wP-Aw; Tue, 12 May 2009 09:32:16 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1149EFF4E; Tue, 12 May 2009 09:32:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A091DB3.4070509@ubicom.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118877>

Yakup Akbay schrieb:
> Hi,
> 
> consider the following situation:
> 
>    adg@adghp:~/myrepo$ git branch -a
>    * master
>      origin/HEAD
>      origin/master
>      origin/work
> 
> I want to remove origin/work from my local repository which is no more
> existing at the origin. git fetch (or pull) does not help either.
> However, it disappears when I remove the following line in
> .git/packed-refs file:
> 
>    021a032317425b136b5430c7dead94328996b9d0 refs/remotes/origin/work
> 
> Is there command line version to do it?

Two options:

  git branch -D -r origin/work
  git remote prune origin

The second removes *all* of origin's tracking branches that are not in the
remote anymore. Use it only if you are sure you want that to happen.

-- Hannes
