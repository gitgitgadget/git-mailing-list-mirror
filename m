From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] rebase: Squelch the "fatal: Not an error." message
Date: Thu, 25 Mar 2010 14:24:44 -0700
Message-ID: <AB91AF2A-E6ED-4C4F-8B99-4A9CFA591C29@sb.org>
References: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 22:24:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuuXr-00026T-OB
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 22:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab0CYVYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 17:24:45 -0400
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:51470 "EHLO
	randymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752323Ab0CYVYo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 17:24:44 -0400
X-Greylist: delayed 163296 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Mar 2010 17:24:44 EDT
Received: from [192.168.1.17] (173-13-153-133-sfba.hfc.comcastbusiness.net [173.13.153.133])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id 1516E109E89
	for <git@vger.kernel.org>; Thu, 25 Mar 2010 14:24:44 -0700 (PDT)
In-Reply-To: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143198>

Aww crud, I just realized I titled this patch wrong. It was supposed to be

rebase: Squelch the "fatal: Not a range." error

Should I send out a new patch?

-Kevin Ballard

On Mar 23, 2010, at 5:03 PM, Kevin Ballard wrote:

> When `git rebase --onto newbase upstream` is executed with
> upstream being equal to the current commit, `git rebase` will
> call `git format-patch` with "upstream..upstream" as the commits
> to generate patches for. This causes a spurious error message to
> be thrown which should be squelched.
> 
> Signed-off-by: Kevin Ballard <kevin@sb.org>
> ---
> This patch was inspired by a common error encountered when using `git pull --rebase`, particularly in the case where there are no local commits that need rebasing and the fetched head was a force-pushed history modification (e.g. from git filter-branch). The error itself is actually caused by running `git rebase --onto newbase upstream` where upstream is the same commit as HEAD. This causes `git format-patch` to be called with "upstream..upstream" as the range and it complains. My solution was to squelch all errors from `git format-patch`, though I am unsure if the "fatal: Not a range." error is the only error that can be raised in this situation.
> 
> git-rebase.sh |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> <0001-rebase-Squelch-the-fatal-Not-an-error.-message.patch>
