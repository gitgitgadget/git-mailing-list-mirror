From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git
Date: Mon, 20 Feb 2006 09:34:21 +0100
Message-ID: <43F97F0D.9080500@op5.se>
References: <7v3bieea32.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 09:34:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB6V0-00051J-Ig
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 09:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWBTIeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 03:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWBTIeX
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 03:34:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:46523 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932298AbWBTIeX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 03:34:23 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E33ED6BD05; Mon, 20 Feb 2006 09:34:21 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3bieea32.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16470>

Junio C Hamano wrote:
> The updated pack-object series is now in "next" branch, and
> seems to be cooking nicely.  The "reuse from existing pack"
> change seems to be a huge win and I haven't found problems in
> there.
> 

Wonderful news. I'll cherry-pick them and do some further testing.

> There now is further performance improvements for git-send-pack
> to avoid sending a huge blob or tree object in its full
> representation when we know the other end has a suitable object
> to use as the base; instead we can just send it out deltified.
> The other end would expand it to a loose object and this would
> not make abit of difference in the resulting repository -- only
> the bandwidth requirement reduction is visible [*1*].
> 

How likely is this to increase the CPU-power needed on the server-side? 
If there is a blob on the server-side, but far from the deltified object 
I suppose we have to look at each commit, perhaps only to discover that 
the client doesn't have them and we need to construct the blob anyways.

> 
> After a bit more testing, we might want to make --thin transfer
> the default (even without an option to turn it off -- I just do
> not see a point not to use it if it is bug-free).
> 

If the answer to my question above is "minimal to none", I agree most 
vehemently. ;)

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
