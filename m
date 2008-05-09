From: Kevin Ballard <kevin@sb.org>
Subject: Re: git pull/merge master on other branch
Date: Fri, 9 May 2008 12:16:04 -0500
Message-ID: <8C649BDA-41CA-4105-86C5-103B4A8BEEC1@sb.org>
References: <g00nb3$dlm$1@ger.gmane.org> <200805090824.12772.johan@herland.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:17:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuWDL-0003g6-Hp
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 19:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbYEIRQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 13:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbYEIRQI
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 13:16:08 -0400
Received: from sd-green-bigip-74.dreamhost.com ([208.97.132.74]:53072 "EHLO
	randymail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753629AbYEIRQH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2008 13:16:07 -0400
Received: from [192.168.1.106] (ip68-1-99-99.pn.at.cox.net [68.1.99.99])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a3.g.dreamhost.com (Postfix) with ESMTP id F1746185D64;
	Fri,  9 May 2008 10:16:05 -0700 (PDT)
In-Reply-To: <200805090824.12772.johan@herland.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81624>

On May 9, 2008, at 1:24 AM, Johan Herland wrote:

> On Friday 09 May 2008, SungHyun Nam wrote:
>> Hello,
>>
>> If I am on a branch (reguarly rebased), I don't want to switch to
>> master branch, but merge origin into master.
>> If I switch to master and pull and switch to branch, I have to
>> rebuild almost of sources.
>>
>> How I can pull origin into master without switching to master
>> branch?
>
> You can't; merging requires use of the working tree (to resolve  
> conflicts).
>
> However, what you can do is make a local clone of your project (cheap,
> because it just hardlinks files from the original repo), and  
> checkout the
> master branch in the clone, perform the merge (after having set up  
> the same
> origin and retrieved its contents), and then fetch (or push) the  
> result back
> into the original repo (remember: "fetch" instead of "pull", since the
> latter will initiate a merge with your current branch).


If you know the pull will just be a fast-foward, then you can do  
something like

   git fetch origin && git update-ref master origin/master

-Kevin Ballard

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
