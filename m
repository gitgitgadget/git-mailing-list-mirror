From: Andreas Ericsson <ae@op5.se>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 21:18:06 +0100
Message-ID: <437B93FE.9000108@op5.se>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net> <437B8CEC.8040002@mc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 21:21:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTjS-0002DB-MY
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 21:18:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVKPUSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 15:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVKPUSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 15:18:09 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:5074 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S932587AbVKPUSI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 15:18:08 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id BE66B6BCBE; Wed, 16 Nov 2005 21:18:06 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Andrew Wozniak <awozniak@mc.com>
In-Reply-To: <437B8CEC.8040002@mc.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12050>

Andrew Wozniak wrote:
> Yes, that suggestion worked - it is similar to other code fragments and 
> ifdefs within the same file.
> 
> Unfortunately, now there are other failures:
> 
> gcc -o http-push.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' 
> http-push.c
> http-push.c: In function `start_mkcol':
> http-push.c:479: `CURLOPT_HTTPGET' undeclared (first use in this function)
> 

....

> I grep'd for these defines and they are nowhere to be found!  Is some 
> other package needed to resolve these undefines on my RH7.2 build host?
> 

curl and curl-devel. Or you can build with

	make NO_CURL=YesPlease

which just means you won't have http and https transports available. 
This shouldn't be much of a problem on a server though.

> I'm really surprised that the unmodified tarball source fails to build. 
> Just curious, is the git project rebuilt on a "nightly" basis to verify 
> recent patches?
> 

I have no idea, but since it's a developer tool in pre-1.0 I think the 
general consensus is that user-friendliness in the build-process comes 
somewhere between "not so important" and "what? users? oh, those living 
in the *other* land!"

Perhaps you should try the RPM's at 
http://www.kernel.org/pub/software/scm/git-core/ ?

If nothing else it will tell you what other packages you need.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
