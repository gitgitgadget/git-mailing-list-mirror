From: Joe Zim <contact@joezimjs.com>
Subject: Re: Broken Repo
Date: Mon, 07 May 2012 13:12:40 -0500
Message-ID: <4FA81098.3000208@joezimjs.com>
References: <4FA74355.3020704@joezimjs.com> <20120507074917.GE18812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 07 20:35:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRSmX-0001BR-4n
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757296Ab2EGSfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 14:35:15 -0400
Received: from gateway16.websitewelcome.com ([69.56.162.7]:56531 "EHLO
	gateway16.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757183Ab2EGSfO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 14:35:14 -0400
X-Greylist: delayed 1348 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 May 2012 14:35:13 EDT
Received: by gateway16.websitewelcome.com (Postfix, from userid 5007)
	id 7D8015122BAE0; Mon,  7 May 2012 13:12:43 -0500 (CDT)
Received: from matiz.websitewelcome.com (matiz.websitewelcome.com [174.120.137.194])
	by gateway16.websitewelcome.com (Postfix) with ESMTP id 02FEC5122B96C
	for <git@vger.kernel.org>; Mon,  7 May 2012 13:12:43 -0500 (CDT)
Received: from [66.189.143.116] (port=56069 helo=[192.168.1.101])
	by matiz.websitewelcome.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.77)
	(envelope-from <contact@joezimjs.com>)
	id 1SRSQM-0001cK-Fo; Mon, 07 May 2012 13:12:42 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <20120507074917.GE18812@sigill.intra.peff.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - matiz.websitewelcome.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - joezimjs.com
X-BWhitelist: no
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.101]) [66.189.143.116]:56069
X-Source-Auth: contact+joezimjs.com
X-Email-Count: 3
X-Source-Cap: am9lemltanM7c21zaXRlczttYXRpei53ZWJzaXRld2VsY29tZS5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197293>

Thanks for the reply guys. It's fixed now.

On 5/7/2012 2:49 AM, Jeff King wrote:
> On Sun, May 06, 2012 at 10:36:53PM -0500, Joe Zim wrote:
>
>> Hi, I'm new here. I'm using Github right now. I have a repository
>> there and a local copy on my Windows 7 PC. I made a change, committed
>> it, then attempted to push it. I got a strange error that I can't
>> remember. Anyway, after several attempts I decided to just delete the
>> local repository, restore it from github and try again later. I
>> realize now that there were other ways this should have been handled,
>> but right now it doesn't matter. I can't figure out how to restore a
>> copy from Github and make this renewed repo the master branch. Can
>> anyone give me a detailed, step by step answer please?
> I don't quite understand your question. You deleted the original
> repository, which I assume means you removed the whole working tree. So
> can you not "git clone" the original repository again and redo your
> work?
>
> Or did you remove only the ".git" directory, leaving your modified
> working tree in place? If that is the case, you probably want:
>
>    # turn your directory back into a git repository
>    cd $your_project
>    git init
>
>    # fetch the existing work again
>    git remote add origin $your_remote_url
>    git fetch
>
>    # now tell git that we are basing our branch on the upstream master.
>    # We must make sure not to use "--hard" here, because that would
>    # overwrite the working tree.
>    git reset origin/master
>
> At this point you should be able to use "git status" to see your
> changes, and commit as normal. You might also want to run:
>
>    git branch --set-upstream master origin/master
>
> to make "git pull" work without any arguments. This setup is done
> automatically by "git clone", but not by the manual init+fetch we did
> above.
>
> -Peff
