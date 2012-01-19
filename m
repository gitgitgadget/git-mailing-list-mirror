From: Jehan Bing <jehan@orb.com>
Subject: Re: Rebase and incrementing version numbers
Date: Thu, 19 Jan 2012 13:07:29 -0800
Message-ID: <4F188611.20205@orb.com>
References: <CADo4Y9jGYJasDL9m7_50aOTrOyoezdyg=vcsZhQ87Qk-1XfTUQ@mail.gmail.com> <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Nahas <mike.nahas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 22:07:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnzCy-00027Y-5v
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 22:07:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933057Ab2ASVHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 16:07:39 -0500
Received: from lo.gmane.org ([80.91.229.12]:59440 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932818Ab2ASVHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 16:07:38 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RnzCr-00024J-5A
	for git@vger.kernel.org; Thu, 19 Jan 2012 22:07:37 +0100
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 22:07:37 +0100
Received: from jehan by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 22:07:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <CADo4Y9iKvoXhKg5pEAB+cbA7Rkfa=nF4TLu0xgcS3dnkNi_n4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188836>

On 2012-01-19 09:20, Michael Nahas wrote:
> The problem I'm running into is that whenever I change a file in a
> directory, I have to bump up the version number in the configuration
> file.  The larger version value in the config file causes my changes
> to be loaded over the old ones.
>
> Most of my commits are edits to a file like "foo.js" and an increment
> to the version number in "config".  Ideally, each of my features
> should live in a single commit and I should be able to make a sequence
> of them, each time incrementing the version number in config.
>
> The problem I'm running into starts with me editing version=100.  I
> create new commits where I set the version to 101, 102, 103, 104.
> When I go to push ("git svn dcommit"), my coworkers have incremented
> the version to 103.  So, I rebase my changes, and get conflicts every
> time because of the version number!
>
> Is there a good way to avoid these conflicts?  Is there a hook I can
> write?  Is there a change to this process that would work smoother
> with Git and its distributed development?  It's okay if the version
> number skips numbers (e.g., jumps from 100 to 104), as long as it
> increases.

Maybe you can do something with "git rerere" 
(http://progit.org/2010/03/08/rerere.html). It supposed to automatically 
resolve known conflicts.

I've never used myself, I just know it exists, so I don't know it's 
usable in your case. But possibly you would pre-fill the rerere cache 
(assuming that the format is simple enough) then just run rebase.

	Jehan
