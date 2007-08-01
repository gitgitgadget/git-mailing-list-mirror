From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: dangling blob which is not dangling at all
Date: Wed, 01 Aug 2007 11:13:27 +0200
Message-ID: <46B04EB7.80006@dawes.za.net>
References: <20070801013450.GA16498@raptus.dandreoli.com> <alpine.LFD.0.999.0707311914570.4161@woody.linux-foundation.org> <20070801063209.GA13511@raptus.dandreoli.com> <7vhcnjbtpt.fsf@assigned-by-dhcp.cox.net> <20070801074237.GA14790@raptus.dandreoli.com> <46B045D3.4070208@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Domenico Andreoli <cavokz@gmail.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 11:14:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGAHo-0005KF-Ud
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 11:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759329AbXHAJOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758831AbXHAJOE
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 05:14:04 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:59616 "EHLO
	spunkymail-a9.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753193AbXHAJOB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 05:14:01 -0400
Received: from [192.168.201.102] (dsl-146-24-241.telkomadsl.co.za [165.146.24.241])
	by spunkymail-a9.g.dreamhost.com (Postfix) with ESMTP id 4565520874;
	Wed,  1 Aug 2007 02:13:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.5 (Windows/20070716)
In-Reply-To: <46B045D3.4070208@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54421>

Steven Grimm wrote:
> Domenico Andreoli wrote:
>> What is this reflog thing and why is required?
>>   
> 
> It is a log of where each ref pointed at any given time. Or rather, a 
> log of changes to refs, with timestamps. It is not *required* per se 
> (you can turn it off and almost all of git will continue to work as 
> before) but it's handy in that you can say stuff like
> 
> git checkout -b newbranch master@"{4 days ago}"
> 
> and git will give you a new branch pointing at the rev that master 
> pointed to 4 days ago, even if it's a rev that is no longer reachable 
> from any of the existing heads (e.g., because you did a "git rebase" and 
> the rev in question was replaced by a new one.) Obviously as soon as you 
> do a "git gc" you will lose the ability to go back to unreachable revs 
> using the reflog.
> 

Not strictly true. "git gc" does take the reflogs into account when 
determining reachability, but it also prunes the reflogs periodically to 
prevent them from growing without bound (and preventing pruning of 
otherwise unreachable objects).

 From the git-gc manpage:

CONFIGURATION
  The optional configuration variable gc.reflogExpire can be set to
  indicate how long historical entries within each branch's reflog should
  remain available in this repository. The setting is expressed as a
  length of time, for example 90 days or 3 months. It defaults to 90
  days.

Regards,

Rogan
