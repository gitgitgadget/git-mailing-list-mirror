From: david@lang.hm
Subject: Re: post-receive hook
Date: Fri, 30 May 2008 02:43:04 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0805300242460.4014@asgard.lang.hm>
References: <alpine.DEB.1.10.0805300108140.4014@asgard.lang.hm> <200805301106.33992.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 30 11:44:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K219U-0007mh-Ub
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 11:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbYE3JnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 05:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbYE3JnI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 05:43:08 -0400
Received: from mail.lang.hm ([64.81.33.126]:44525 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750764AbYE3JnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 05:43:07 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m4U9gurP020299;
	Fri, 30 May 2008 02:42:56 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <200805301106.33992.johan@herland.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83280>

On Fri, 30 May 2008, Johan Herland wrote:

> On Friday 30 May 2008, david@lang.hm wrote:
>> I'm trying to setup a post-receive hook to do a checkout -f when I push to
>> a public repo (it's a web based tool and I want the executables to be
>> updated with a push)
>>
>> unfortunantly if I just add git checkout -f to the post-receive hooks it
>> checks the files out in the .git directory.
>>
>> if I do a cd .. ; git checkout -f I get an error message complaining that
>> it's not in a git repository, but if I manually cd to that directory and
>> do a checkout it works.
>>
>> what am I missing here?
>
> I'm guessing that the post-receive hook is invoked with "GIT_DIR=.", which goes bad the moment you chdir anywhere. I have this in my own update hook script:
>
> if [ "$GIT_DIR" = "." ]; then
> 	GIT_DIR=`pwd`
> fi
>
> If you do this before the "cd .. ; git checkout -f", you might have better luck.

thanks, that solved the problem.

David Lang
