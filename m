From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [completion] Request: Include remote heads as push targets
Date: Thu, 21 Oct 2010 12:03:05 -0400
Message-ID: <4CC06439.8040003@xiplink.com>
References: <4CC05E4B.1010106@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:03:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8xc3-00055t-9L
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943Ab0JUQD0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 12:03:26 -0400
Received: from smtp142.iad.emailsrvr.com ([207.97.245.142]:38629 "EHLO
	smtp142.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab0JUQD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:03:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp44.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 79C10128563;
	Thu, 21 Oct 2010 12:03:25 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp44.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 4D7DA128500;
	Thu, 21 Oct 2010 12:03:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100922 Thunderbird/3.1.4
In-Reply-To: <4CC05E4B.1010106@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159518>

On 10-10-21 11:37 AM, Marc Branchaud wrote:
> Hi Shawn,
> 
> I find myself wishing that completion would support the following:
> 
> 	git push origin HEAD:<tab>
> 
> The options presented at this point should include all the origin/* heads,
> without the "origin/" prefix.  Right now (git 1.7.3.1) completion only lets
> me choose from local refs.

Hmmm, perhaps this is really a bug.

When I double-tab, the remote branch name I want is in the list of
possibilities.  But when I try to complete by typing a couple of leading
characters then hitting <tab> again, I don't get that name.  Instead I get a
tag that starts with the same letters.

More concretely:

$ echo $BASH_VERSION
4.1.5(1)-release

$ git branch -a
  bar
  baz
* master
  remotes/origin/HEAD -> origin/master
  remotes/origin/battle
  remotes/origin/battle.hardened
  remotes/origin/master

$ git tag
bassinet

$ git push origin HEAD:<tab><tab>
battle            battle.hardened   HEAD              master

$ git push origin HEAD:ba<tab><tab>
bar        bassinet   baz

Wacky!

		M.
