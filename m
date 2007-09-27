From: Adam Roben <aroben@apple.com>
Subject: Re: Equivalent of `svn switch` for git-svn?
Date: Thu, 27 Sep 2007 09:39:27 -0700
Message-ID: <46FBDCBF.7060909@apple.com>
References: <46FB5086.7070408@apple.com> <20070927100607.GC10289@artemis.corp> <Pine.LNX.4.64.0709271253040.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 27 18:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IawOl-0000KX-DW
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 18:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbXI0Qj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 12:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753147AbXI0Qj2
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 12:39:28 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:51221 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061AbXI0Qj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 12:39:27 -0400
Received: from relay12.apple.com (relay12.apple.com [17.128.113.53])
	by mail-out3.apple.com (Postfix) with ESMTP id 49BCF12C97DE;
	Thu, 27 Sep 2007 09:39:27 -0700 (PDT)
Received: from relay12.apple.com (unknown [127.0.0.1])
	by relay12.apple.com (Symantec Mail Security) with ESMTP id 328982807C;
	Thu, 27 Sep 2007 09:39:27 -0700 (PDT)
X-AuditID: 11807135-a56febb000006e40-a7-46fbdcbf8c06
Received: from [17.203.12.236] (aroben.apple.com [17.203.12.236])
	by relay12.apple.com (Apple SCV relay) with ESMTP id 12DDC2804E;
	Thu, 27 Sep 2007 09:39:27 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0709271253040.28395@racer.site>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59303>


Johannes Schindelin wrote:
> Hi,
>
> On Thu, 27 Sep 2007, Pierre Habouzit wrote:
>
>   
>> On Thu, Sep 27, 2007 at 06:41:10AM +0000, Adam Roben wrote:
>>     
>>> Hi all-
>>>   I've recently been informed that the Subversion server I and several 
>>> others have been tracking with git-svn will be switching from using the 
>>> svn+ssh scheme to the http scheme. To handle this, users of svn will be 
>>> running `svn switch` to move their working copies to the new repository 
>>> URL. Is there some way to do the same for git-svn? I suspect the biggest 
>>> complication will come from the git-svn-id: lines in the commit logs, 
>>> since changing that line would require changing the commit hash as well.
>>>       
>>   edit your .git/config, in the section [svn-remote "svn"], change url =
>>     
>
> Or use git-config:
>
> 	git config svn-remote.svn.url <url>
>
> Or make it a global alias:
>
> 	git config --global alias svn-switch 'config svn-remote.svn.url'
>
> so that you can say
>
> 	git svn-switch <url>
>   
Will doing this then change all the git-svn-id: lines in the commit logs 
for those imported revisions? I'm asking because my understanding is 
that git-svn uses those git-svn-id: lines to determine which branch 
you're on, and if the URLs are now all out of date won't it then think 
it can't determine the correct branch?

Thanks for the suggestions so far.

-Adam
