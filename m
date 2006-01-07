From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] rpmbuild doesn't like '-' in version strings
Date: Sat, 07 Jan 2006 01:04:51 +0100
Message-ID: <43BF05A3.8060407@op5.se>
References: <dp3qpb$7uk$1@sea.gmane.org> <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 07 01:04:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev1Zo-000696-As
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 01:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbWAGAEx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965363AbWAGAEx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 19:04:53 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:9198 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S965364AbWAGAEx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jan 2006 19:04:53 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 382986BCBE
	for <git@vger.kernel.org>; Sat,  7 Jan 2006 01:04:52 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7voe2prniw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14230>

Junio C Hamano wrote:
> John Ellson <ellson@research.att.com> writes:
> 
> 
>>Suggested fix:  Use '_' instead of '-'
> 
> 
> I wonder if the right fix is to change the git-describe output
> before the current output becomes too widespread.


I don't think there's any major risk of the current output being very 
widespread. It's not very useful for scripting.


>  To really
> fix this problem, I think the rpm target of the main Makefile
> needs to be modified to include something monotonicly increasing
> (e.g. number of seconds since the base commit encoded in base26,
> or something silly like that)


Why not keep it super-simple and just print the number of commits since 
whatever tag is found? It only counts commits on the current branch, so 
a merge shows up as a single commit. That should more or less be ok 
though and goes well with the topic branch model.


>  If I cut a binary package out of my
> master and then one of my topic branches, it is very likely they
> will get confused time ordering when they happen to find the
> same base revision.


I suppose this could happen when counting commits as well. People who 
build packages from different branches should be shot on sight though, 
so I wouldn't worry about it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
