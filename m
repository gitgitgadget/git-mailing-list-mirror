From: Dennis Huynh <dennis@brainstorm-digital.com>
Subject: Re: problems installing git docs and gitweb on centos 5.5
Date: Thu, 30 Sep 2010 10:22:49 -0400
Message-ID: <4CA49D39.1020403@brainstorm-digital.com>
References: <4CA3EFE6.2010306@brainstorm-digital.com> <20100930024059.GA2373@burratino> <4CA41FCC.8050704@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 30 16:23:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1K2T-0000Rm-G7
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 16:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756564Ab0I3OW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 10:22:56 -0400
Received: from omr16.networksolutionsemail.com ([205.178.146.66]:41094 "EHLO
	omr16.networksolutionsemail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756482Ab0I3OW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 10:22:56 -0400
Received: from cm-omr10 (mail.networksolutionsemail.com [205.178.149.5] (may be forged))
	by omr16.networksolutionsemail.com (8.13.6/8.13.6) with ESMTP id o8UEMnwZ021007
	for <git@vger.kernel.org>; Thu, 30 Sep 2010 10:22:53 -0400
Authentication-Results: cm-omr10 smtp.user=dennis@brainstorm-digital.com; auth=pass (CRAM-MD5)
X-Authenticated-UID: dennis@brainstorm-digital.com
Received: from [38.117.157.152] ([38.117.157.152:34683] helo=[192.168.1.119])
	by cm-omr10 (envelope-from <dennis@brainstorm-digital.com>)
	(ecelerity 2.2.2.41 r(31179/31189)) with ESMTPA
	id FC/B9-30857-93D94AC4; Thu, 30 Sep 2010 10:22:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4CA41FCC.8050704@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157671>

Alright, I'm going with the Fedora EPEL repositories.  But last I 
checked the latest version available via that method was 1.5.x.  Since 
this is a server, I preferred to use the latest and greatest so to last 
in the long run from any major patches or cover any major upgrades, but 
if that's the version that's preferred, who am I to argue.  One problem 
I recall in yum'ing the install for git however was the man pages 
weren't installed either.  I could be wrong however.  I'll keep you guys 
up to date.  Wish me luck!  Thanks for all your help and the timely 
responses.

Also, is there how-tos you'd suggest I use in setting up the git/gitweb 
combo with the yum install?  I noticed yum installs files in different 
locations then the source does.  Thanks again!


On 9/30/10 1:27 AM, J.H. wrote:
> On 09/29/2010 07:40 PM, Jonathan Nieder wrote:
>    
>> (-cc: security@centos)
>>
>> Hi Dennis,
>>
>> Dennis Huynh wrote:
>>
>>      
>>> Am I the only one having issues installing git docs?
>>>        
>> Here's my advice:
>>
>>   1. Breathe in, breathe out.
>>   2. Look at the INSTALL file, section beginning "To build and install
>>      documentation suite".  Among other things, it describes how to
>>      retrieve pre-formatted documentation from the git.git repository
>>      itself.  So you can try:
>>
>> 	git clone git://git2.kernel.org/pub/scm/git/git.git
>>      
> For the love of monkeys do *NOT* point people at specific git machines
> like that.  Use git://git.kernel.org/pub/scm/git/git.git using a
> specific machine causes a giant amount of headaches for me and
> completely ruins any attempt at load balancing I might be able to
> accomplish.
>
> Couple that with the fact it will steer people to the wrong server if
> they aren't in North America, it's just not a good idea.  Period.
>
>    
>> 	cd git
>> 	make quick-install-doc
>>
>>      after installing git, which should be relatively painless.
>>   3. Look at gitweb/INSTALL.  The moment something seems unclear, note
>>      that, so we can come up with a patch to make it clearer for the
>>      next person.
>>      
> As an overall note, git and gitweb, including my caching version of
> gitweb are available in Fedora EPEL as rpm packages.  These are official
> packages for Redhat / CentOS / Distro based on those things.  You
> shouldn't need to compile your own really.
>
> Unless you need the latest and greatest I would try those.  If you
> really need the latest you might be better off grabbing the latest
> .src.rpm from here:
>
> http://www.kernel.org/pub/software/scm/git/RPMS/SRPMS/
>
> http://www.kernel.org/pub/software/scm/git/RPMS/SRPMS/git-1.7.3.1-1.fc11.src.rpm
>
> and doing an rpmbuild --rebuild git-1.7.3.1-1.fc11.src.rpm on it and
> installing the rpm that it builds.
>
> I'm not saying doing it completely from source is bad, but deviating
> from what your distro uses / provides can cause other headaches and
> maintenance issues down the line.
>
> Bonus to going the RPM rebuild route is that it will tell you what your
> missing to do the rebuild with.
>
> - John 'Warthog9' Hawley
>
>
>    
