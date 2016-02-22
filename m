From: Kevin Daudt <me@ikke.info>
Subject: Re: Question about pull-requests
Date: Mon, 22 Feb 2016 17:37:31 +0100
Message-ID: <20160222163731.GA4154@ikke.info>
References: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nagaraj Mandya <nmandya@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 17:46:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXtcV-0003V0-9X
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 17:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbcBVQp4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 11:45:56 -0500
Received: from ikke.info ([178.21.113.177]:35948 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbcBVQpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 11:45:55 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Feb 2016 11:45:55 EST
Received: by vps892.directvps.nl (Postfix, from userid 1008)
	id D94D3440082; Mon, 22 Feb 2016 17:37:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOh0v-WW=hOXw=uTdzkd3afzXCguBHWdaDShwKE3QKqUCOBTzg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286934>

On Mon, Feb 22, 2016 at 05:24:15PM +0530, Nagaraj Mandya wrote:
> Hello,
>   In our GIT repository, all users are restricted from merging to
> master without a pull request. This works well and all developers are
> raising pull requests and merging. However, if there is a merge
> conflict during the merge, we have a problem.
> 
>   We follow the instructions provided by Bitbucket and the final step
> is to push the merged code to master to the "origin" repository.
> However, that steps always fails with the error that pushes can only
> be made with pull requests.
> 
>   How do we work around this problem? We want all pushes to happen
> through merge requests but still allow pull requests with merge
> conflicts to get pushed. Thanks.

The usual way to solve this is to rebase those commits of the pull
requests on the updated master. That allows the one who makes the pull
request to solve the issues, and then push the branch again (adding
--force-with-lease because you've rewritten history). 

This should update the pull request, but now it should be able to be
merged without conflicts.

That way, you are not required to merge locally into master and push
that.

The merge local option will only work if at least someone has rights to
push to master, but that is a bitbucket question, not a git question.
