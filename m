From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Split a subversion repo into several git repos
Date: Fri, 12 Oct 2007 15:23:44 +0100
Message-ID: <1B9700E6-5DFB-443D-9465-30E0DCAD0619@steelskies.com>
References: <op.tz09zaizjwclfx@ichi> <27DDC599-C7A0-4660-B5C6-7DFCEB137C14@steelskies.com> <470E9858.5050904@vilain.net> <op.tz28hnd2jwclfx@ichi>
Mime-Version: 1.0 (Apple Message framework v907)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eivind LM <eivliste@online.no>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgLQp-0005ro-7U
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 16:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbXJLOXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 10:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbXJLOXv
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 10:23:51 -0400
Received: from juliet.asmallorange.com ([207.210.105.70]:43377 "EHLO
	juliet.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbXJLOXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 10:23:51 -0400
Received: from gir.office.bestbefore.tv ([89.105.122.147]:57478)
	by juliet.asmallorange.com with esmtpa (Exim 4.68)
	(envelope-from <maillist@steelskies.com>)
	id 1IgLQa-0006Nm-Lv; Fri, 12 Oct 2007 10:23:49 -0400
In-Reply-To: <op.tz28hnd2jwclfx@ichi>
X-Mailer: Apple Mail (2.907)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - juliet.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60692>

On 12 Oct 2007, at 15:14, Eivind LM wrote:

> On Thu, 11 Oct 2007 23:40:40 +0200, Sam Vilain <sam@vilain.net> wrote:
>
>> Jonathan del Strother wrote:
>>>> For example, I want to convert one subversion repository which
>>>> contains the folders:
>>>> trunk/projectA
>>>> trunk/projectB
>>>>
>>>> into two git repositories:
>>>> projectA.git
>>>> projectB.git
>>>
>>> I have a slightly different layout to you -
>>>
>>> projectA/trunk
>>> projectA/branches
>>> projectA/tags
>>> projectB/trunk
>>> projectB/branches
>>> projectB/tags
>>> etc
>>>
>>> - but I've been creating separate git repos from that with (for
>>> example) :
>>>
>>> git-svn init -t tags -b branches -T trunk http://svn.host.com/projectA
>>> git-svn fetch
>>>
>>>
>>> Or will git-svn not work with your sort of layout?
>>
>> It does work.  Use:
>>
>> git-svn init -t projectA/tags -b projectA/branches \
>>   -T trunk/projectA http://svn.host.com/
>> git fetch
>
> With my paths this translates into
>
>  $ git-svn init -b eivindlm/branches \
>                 -t eivindlm/tags \
>                 -T eivindlm/trunk/src/probesimulator \
>                 file:///svn-repo/
> , which prints the happy message:
>  Initialized empty Git repository in .git/
>
> The next command is unfortunately not as happy:
>  $ git fetch
>  fatal: 'origin': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly
>  Cannot get the repository state from origin


I believe you actually wanted "git-svn fetch" here
