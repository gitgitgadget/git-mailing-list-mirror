From: Bill Lear <rael@zopyra.com>
Subject: Re: Using the --track option when creating a branch
Date: Thu, 30 Oct 2008 06:04:54 -0600
Message-ID: <18697.41702.241183.408377@lisa.zopyra.com>
References: <18696.32778.842933.486171@lisa.zopyra.com>
	<1225343538.10803.9.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 13:06:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvWI9-0004RD-3I
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 13:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403AbYJ3MFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 08:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbYJ3MFH
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 08:05:07 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60635 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752803AbYJ3MFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 08:05:06 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m9UC4wb27839;
	Thu, 30 Oct 2008 06:04:58 -0600
In-Reply-To: <1225343538.10803.9.camel@maia.lan>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99462>

On Wednesday, October 29, 2008 at 22:12:18 (-0700) Sam Vilain writes:
>On Wed, 2008-10-29 at 09:23 -0600, Bill Lear wrote:
>> We use git in a way that makes it desirable for us to only push/pull
>> to the same remote branch.  So, if I'm in branch X, I want 'git push'
>> to push to origin/X, and 'git pull' to fetch into origin/X and then
>> merge into X from origin/X.
>> 
>> In other words, we want git push/pull to behave in branches other than
>> master the same way it does when in master.
>> 
>> I have discovered the '--track' option when creating a local branch,
>> and this appears to me to be the thing that gives us the desired
>> behavior.
>
>As things currently stand this is not achievable behaviour.  The
>behaviour of 'git push' is to push all matching refs.  If you are lucky
>this is what you intended, but it also pushes any changes to *other*
>branches that you have made.
>
>I have tabled a change proposal to make it work as you suggest in a
>separate thread.

Ok, now I'm confused.  The ONLY thing I want to prevent is the
"crossing of streams" issue.  If I am on branch X and issue 'git
push', I want X, and ONLY X, to be pushed to the remote repository's X
branch --- I don't care if other branches are pushed to their
respective remote branches, as long as they don't get merged to X.

So, are you saying that Santi was incorrect, and that in fact
the push will result in a merge of the branches?


Bill
