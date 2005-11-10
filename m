From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 1/2] git-clone: Keep remote names when cloning unless
 explicitly told not to.
Date: Thu, 10 Nov 2005 18:49:12 +0100
Message-ID: <43738818.4010906@op5.se>
References: <20051110115808.418125BF88@nox.op5.se> <7vd5l81l15.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 18:51:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaGY1-0006iD-JC
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 18:49:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVKJRtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 12:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVKJRtO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 12:49:14 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:2974 "EHLO smtp-gw1.op5.se")
	by vger.kernel.org with ESMTP id S1751189AbVKJRtO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 12:49:14 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id BA1666BCFF
	for <git@vger.kernel.org>; Thu, 10 Nov 2005 18:49:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
In-Reply-To: <7vd5l81l15.fsf@assigned-by-dhcp.cox.net>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11495>

Junio C Hamano wrote:
> exon@op5.se (Andreas Ericsson) writes:
> 
>>+# Try using "humanish" part of source repo if user didn't specify one
>>+[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's#/*\.git$##' -e 's#.*[/:]##')
> 
> 
> Micronit; if I version control contents of my home directory on
> host.xz [*1*] under git, I would say host.xz:.git/ when cloning
> it, wouldn't I?
> 

Gah. Does anyone do that?

Anyways,
	sed -e 's#:*/*\.git$##' -e 's#.*[/:]##'
would turn that into "host.xz", so that should work real nice like, I 
suppose.

> Maybe we would want to check if the resulting $dir makes sense
> after this step.
> 

Perhaps, but this would lead to mkdir complaining about the empty 
directory name, so it's no worse than the current code. The sane user 
then looks at the help output and determines that he needs to specify a 
target directory.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
