From: Andreas Ericsson <ae@op5.se>
Subject: Re: gitweb: View graphes & get tar
Date: Thu, 09 Feb 2006 13:11:04 +0100
Message-ID: <43EB3158.8070003@op5.se>
References: <4fb292fa0602081534x7f6e74c1veb8c4ea7ad5a83cc@mail.gmail.com>	 <200602090003.35354.alan@chandlerfamily.org.uk> <4fb292fa0602090312k1607e42fu88e03b788d339390@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Feb 09 13:11:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Ado-0007ql-Nm
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 13:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422897AbWBIMLG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 07:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbWBIMLG
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 07:11:06 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:34726 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1422897AbWBIMLF
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 07:11:05 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6473E6BD19
	for <git@vger.kernel.org>; Thu,  9 Feb 2006 13:11:04 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <4fb292fa0602090312k1607e42fu88e03b788d339390@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15810>

Bertrand Jacquin wrote:
> On 2/9/06, Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> 
>>On Wednesday 08 February 2006 23:34, Bertrand Jacquin wrote:
>>
>>
>>I have it set up so that when I push a tag into my public git repositories,
>>that a post-update hook creates a tarball of the site and puts it into the
>>download directory.
>>
>>The hook is of the following form
>>
>>#!/bin/sh
>>#
>># This script is used to create a tarball of the project and place it into the
>>"files"
>># directory of the web site whenever a release is tagged in the repository
>>#
>>PROJECT=akcmoney
>># this should look at each positional parameter
>>for ref ; do
>>#if its a tag then create a tarball
>>        if [ "${ref:0:10}" == "refs/tags/" ] ; then
>>                git-tar-tree ${ref:10} $PROJECT | gzip -9
>>
>>>/var/www/chandlerfamily/files/$PROJECT/$PROJECT-${ref:10}.tar.gz
>>
>>        fi
>>done
> 
> 
> That's ok, but with that I couldn't get a tar for _not_ the current
> tree. If i want to get a tar tree for 2 months old in not master
> branch, I can't with that. The idea here is the create the tar on the
> fly, on the user demand.


This should be really trivial to implement, although I seriously doubt 
its usefulness, not to mention that for large projects it would be 
painfully slow. The only valid reason someone has to get a tar-ball of a 
random development point is to debug it, and for that they should check 
out the whole repo anyways, which will enable them to use the excellent 
bisect tool.


> And also, I use http push so hooks can't be used :/
> 

I suffer for you.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
