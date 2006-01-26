From: Junio C Hamano <junkio@cox.net>
Subject: Re: Safe way to remove .temp objects?
Date: Thu, 26 Jan 2006 04:24:06 -0800
Message-ID: <7v1wyvfa8p.fsf@assigned-by-dhcp.cox.net>
References: <20060126093507.GA5118@harddisk-recovery.nl>
	<43D8AFF1.2080106@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Erik Mouw <erik@harddisk-recovery.com>
X-From: git-owner@vger.kernel.org Thu Jan 26 13:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F26Ae-00051m-16
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 13:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWAZMYJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 07:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWAZMYJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 07:24:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50942 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932304AbWAZMYI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 07:24:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126122201.TPKG17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 07:22:01 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43D8AFF1.2080106@op5.se> (Andreas Ericsson's message of "Thu, 26
	Jan 2006 12:18:09 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15164>

Andreas Ericsson <ae@op5.se> writes:

> Erik Mouw wrote:
>> Hi,
>> After a git repack, git count-objects reports there are still 20
>> objects in the repository. It looks like those are temp objects:
>>   erik@arthur:~/git/linux-2.6 > ls .git/objects/??/
>>   .git/objects/14/:
>>   d6545767f5103b5ef4702bc8fffa18dbe32ce1.temp
>>   .git/objects/1a/:
>>   d37b580be4215f1b0927b7560f5e8b8d1bc0fa.temp
>>   [...]
>> Is there a git command to remove those objects in a safe way, or can
>> I
>> just rm them without "harming" git??
>>
>
> 	$ git prune-packed
>
> When you repack, you can run
>
> 	$ git repack -d
>
> to remove loose objects when you're done packing.

What is being asked is not about loose objects but droppings
commit walkers make when interrupted.

I think *.temp files are garbage and you can safely remove
them.  They are not even correct objects.
