From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git rebase --continue with goofy error
Date: Thu, 04 Dec 2008 17:32:57 +0100
Message-ID: <49380639.3010508@drmicha.warpmail.net>
References: <5AC243B6-F048-4286-80E1-1D0E695792B9@illumaware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adrian Klingel <Adrian.Klingel@illumaware.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 17:34:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8H9m-0002Zf-Pg
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 17:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbYLDQdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 11:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYLDQdF
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 11:33:05 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59323 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751969AbYLDQdE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2008 11:33:04 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 836E41CCC5A;
	Thu,  4 Dec 2008 11:33:01 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 04 Dec 2008 11:33:01 -0500
X-Sasl-enc: fALSBFh7f3nQJWBp98bOfm0+T4O5YfcxxvImbofZuoZ4 1228408381
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CD61513E0F;
	Thu,  4 Dec 2008 11:33:00 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <5AC243B6-F048-4286-80E1-1D0E695792B9@illumaware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102348>

Adrian Klingel venit, vidit, dixit 04.12.2008 15:55:
> I am trying so, so hard to rebase a branch with updates made in master:
> 
> *********
> git rebase master
> *********
> 
> I get about 20 conflicts back, which I fix and do:
> 
> *********
> git add *
> *********
> 
> There were also many, many error messages after the rebase command, eg:
> 
> *********
> error: test/unit/missing_year_test.rb: already exists in index
> error: test/unit/axle_test.rb: already exists in index
> error: test/unit/body_style_test.rb: already exists in index
> error: test/unit/brake_test.rb: already exists in index
> error: test/unit/category_test.rb: already exists in index
> error: test/unit/comment_test.rb: already exists in index
> error: test/unit/company_comment_test.rb: does not exist in index
> error: test/unit/country_test.rb: already exists in index
> *********
> 
> 
> but I ignore that error, because I have no idea what it means.  If I  

Not a good general approach. If there are errors to begin with there is
no reason to expect success later on.

Here, I assume you are starting from a dirty working tree. What did git
status say before the rebase?

> were to guess, I'd say it's trying to copy files from master to my  
> current branch.  Of course.
> 
> So now I have added my conflict fixes, per the message:
> 
> *********
> Failed to merge in the changes.
> Patch failed at 0002.
> 
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To restore the original branch and stop rebasing run "git rebase -- 
> abort".
> *********

What command triggered that message? It's certainly not saying that you
have added your conflict fixes, as you seem to think.

> 
> So I decide to continue:
> 
> *********
> git rebase --continue
> *********
> 
> 
> And I get the following:
> 
> *********
> mymac:/Library/mydir/code/myapp me$ git rebase --continue
> Unknown option: 1
> Usage: head [-options] <url>...
>      -m <method>   use method for the request (default is 'HEAD')
>      -f            make request even if head believes method is illegal
>      -b <base>     Use the specified URL as base
>      -t <timeout>  Set timeout value
>      -i <time>     Set the If-Modified-Since header on the request
>      -c <conttype> use this content-type for POST, PUT, CHECKIN
>      -a            Use text mode for content I/O
>      -p <proxyurl> use this as a proxy
>      -P            don't load proxy settings from environment
>      -H <header>   send this HTTP header (you can specify several)
> 
>      -u            Display method and URL before any response
>      -U            Display request headers (implies -u)
>      -s            Display response status code
>      -S            Display response status chain
>      -e            Display response headers
>      -d            Do not display content
>      -o <format>   Process HTML content in various ways
> 
>      -v            Show program version
>      -h            Print this message
> 
>      -x            Extra debugging output
> Applying
> You still have unmerged paths in your index
> did you forget to use 'git add'?
> 
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --skip".
> To restore the original branch and stop rebasing run "git rebase -- 
> abort".
> 
> *********
> 
> 
> A google search of "git" and "Unknown option: 1" yields zero  
> results. 

As the "Usage: head..." tells us, the message comes from the command
"head", not from git. (head is used by git-rebase -i)

> Notice I did not commit the adds.  I didn't think it made  
> sense to do that, since I imagine that is what the rebase is doing  
> anyway?
> 
> This is on git version 1.5.5.3.
> 
> Should I upgrade git?  Will that break any repos that I have?

Yes! No!

Cheers,
Michael
