From: Andreas Ericsson <ae@op5.se>
Subject: Re: Safe way to remove .temp objects?
Date: Thu, 26 Jan 2006 12:18:09 +0100
Message-ID: <43D8AFF1.2080106@op5.se>
References: <20060126093507.GA5118@harddisk-recovery.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 12:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F258q-0000Br-Kd
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 12:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWAZLSM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 06:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWAZLSM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 06:18:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:62902 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932289AbWAZLSK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 06:18:10 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 8A0016BCFF; Thu, 26 Jan 2006 12:18:09 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060126093507.GA5118@harddisk-recovery.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15158>

Erik Mouw wrote:
> Hi,
> 
> After a git repack, git count-objects reports there are still 20
> objects in the repository. It looks like those are temp objects:
> 
>   erik@arthur:~/git/linux-2.6 > ls .git/objects/??/
>   .git/objects/14/:
>   d6545767f5103b5ef4702bc8fffa18dbe32ce1.temp
> 
>   .git/objects/1a/:
>   d37b580be4215f1b0927b7560f5e8b8d1bc0fa.temp
> 
>   [...]
> 
> Is there a git command to remove those objects in a safe way, or can I
> just rm them without "harming" git??
> 
> 

	$ git prune-packed

When you repack, you can run

	$ git repack -d

to remove loose objects when you're done packing.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
