From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: fatal: index-pack failed
Date: Sun, 02 Oct 2011 15:47:12 +0200
Message-ID: <4E886B60.2000901@dewire.com>
References: <50B87B00-064C-4FCC-B1E8-94A9EB027468@portalify.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matti Linnanvuori <matti.linnanvuori@portalify.com>
X-From: git-owner@vger.kernel.org Sun Oct 02 15:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAMO9-0003KM-Fl
	for gcvg-git-2@lo.gmane.org; Sun, 02 Oct 2011 15:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547Ab1JBNrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Oct 2011 09:47:16 -0400
Received: from mail.dewire.com ([83.140.172.130]:1144 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126Ab1JBNrO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Oct 2011 09:47:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 38D838003A4;
	Sun,  2 Oct 2011 15:47:13 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H0k+6CLwBtm5; Sun,  2 Oct 2011 15:47:12 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id B75F4800394;
	Sun,  2 Oct 2011 15:47:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0) Gecko/20110916 Thunderbird/7.0
In-Reply-To: <50B87B00-064C-4FCC-B1E8-94A9EB027468@portalify.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182600>

Matti Linnanvuori skrev 2011-09-30 10.11:
> Jenkins got an error:
>
> Error performing command: git fetch -t ssh://iac-builder@sorsa.portalify.com/p/git/.git+refs/heads/*:refs/
> Command "git fetch -t ssh://iac-builder@sorsa.portalify.com/p/git/.git+refs/heads/*:refs/remotes/origin/*" returned status code 128: error: refs/remotes/origin/HEAD does not point to a valid object!
> error: refs/remotes/origin/master does not point to a valid object!
> error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
> error: refs/remotes/origin/HEAD does not point to a valid object!
> error: refs/remotes/origin/master does not point to a valid object!
> error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
> error: Could not read 49f273234b582edb44bbdbda29193719e5054cb7
> error: refs/remotes/origin/HEAD does not point to a valid object!
> error: refs/remotes/origin/master does not point to a valid object!
> error: missing object referenced by 'refs/tags/iac-1.4.13'
> error: refs/tags/jenkins-iac-orm-snapshot-889 does not point to a valid object!
> error: Could not read 49f273234b582edb44bbdbda29193719e5054cb7
> fatal: pack has 26 unresolved deltas
> fatal: index-pack failed

I saw this too a couple of weeks ago. I have no idea what caused it. 
After removing all refs from the remote and fetching again everything 
was fine. No system crash was involved.

(fresh) Hypothesis: A fetch updated the refs, but failed to get save the 
actual objects. I think git tries hard to make sure that this cannot happen.

In my case JGit might have been used to perform the fetch that failed. 
Since you say it's Jenkins, I'd guess not, since it uses C Git.

-- robin
