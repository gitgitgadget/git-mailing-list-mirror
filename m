From: John Ellson <ellson@research.att.com>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 14 Jan 2006 15:25:09 -0500
Message-ID: <43C95E25.3070006@research.att.com>
References: <dp3qpb$7uk$1@sea.gmane.org>	<7voe2prniw.fsf@assigned-by-dhcp.cox.net>	<43C91B25.9030707@research.att.com> <7v1wzaliv0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jan 14 21:25:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Exrxr-000415-91
	for gcvg-git@gmane.org; Sat, 14 Jan 2006 21:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWANUZT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jan 2006 15:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWANUZT
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jan 2006 15:25:19 -0500
Received: from [192.20.225.110] ([192.20.225.110]:31169 "EHLO
	mail-white.research.att.com") by vger.kernel.org with ESMTP
	id S1751079AbWANUZS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2006 15:25:18 -0500
Received: from [135.207.24.103] (ellson.research.att.com [135.207.24.103])
	by bigmail.research.att.com (8.13.3+Sun/8.11.6) with ESMTP id k0EKUPnw007736;
	Sat, 14 Jan 2006 15:30:28 -0500 (EST)
User-Agent: Thunderbird 1.5 (X11/20060112)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wzaliv0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14678>

Junio C Hamano wrote:
> John Ellson <ellson@research.att.com> writes:
>   
> I consider leaving the interim version unbuildable for binary packaging
> consider a feature.
>   
Not a very helpful feature IMO.    Who is protected by this?
> If you want to build your own version, I think you could locally
> tag that head and build, like:
>
> 	$ git tag -a "John's GIT 1.1.2+frotz patch" v1.1.2.John0114
> 	$ make rpmbuild
>
> Of course you can keep a patch with the sed -e 's/-/_/' in
> GIT-VERSION-GEN as Linus suggested in your development branch.
>   
Thats basically all I'm looking for.   I agree that is only necessary to 
fix the "make rpm" target.
Further changes are not strictly necessary.   I don't understand why it 
would only be useful to me?

> I am not yet convinced being able to build a random
> unidentifiable binary package is a good thing, and "the number
> of minutes/seconds monotonicity" would not work in multiple
> branches case (i.e. still leaves the result unordered).
>   
Since disparate branches are intrinsically unordered I was suggesting 
that the
hash field would be used to ensure uniqueness only.   The timestamp 
field is only for ordering within a branch.

So if someone builds rpms from two different branches, they might still 
have to force the particular
selection they want with "rpm -Uvh --oldpackage ...", but I think this 
is the best that can be done
in the absence of any intrinsic ordering.

Anyway, this is above and beyond doing something with sed to fix the '-' 
issue.

John
>
>
>   
