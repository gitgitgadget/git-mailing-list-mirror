From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git  --  how to revert build to as-originally-cloned?
Date: Thu, 19 May 2011 09:26:45 +1000
Message-ID: <SNT124-W3827431D13C320A4C9BF9DC48F0@phx.gbl>
References: <4DD44DCD.7010508@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <johnlumby@hotmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 19 01:33:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMqEh-0004y7-8U
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 01:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756432Ab1ERXc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 19:32:56 -0400
Received: from snt0-omc1-s9.snt0.hotmail.com ([65.55.90.20]:30914 "EHLO
	snt0-omc1-s9.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756181Ab1ERXcz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 19:32:55 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 May 2011 19:32:55 EDT
Received: from SNT124-W38 ([65.55.90.7]) by snt0-omc1-s9.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 16:26:46 -0700
X-Originating-IP: [27.32.25.138]
Importance: Normal
In-Reply-To: <4DD44DCD.7010508@hotmail.com>
X-OriginalArrivalTime: 18 May 2011 23:26:46.0183 (UTC) FILETIME=[0DCDEB70:01CC15B3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173918>


> Date: Wed, 18 May 2011 18:53:01 -0400
> From: johnlumby@hotmail.com
> To: git@vger.kernel.org
> Subject: git -- how to revert build to as-originally-cloned?
>
> I am stuck trying to revert a private kernel build back to the state in
> which I originally cloned it,
> (after probably doing the wrong thing - as below). Hoping someone
> can advise.
>
> Here's what I did (helpful criticism welcome)
>
> On machine MA in filesystem /a on 13 May
>
> git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next-2.6.git
>
...
>
> I have tried all the commands I can find that claim to do this
> and none of them have done it, e.g. :
> git reset --hard HEAD /* did nothing */
> git reset --hard ORIG_HEAD /* did nothing */
>
> Not only that, but none of the various show , log , status commands
> appear to be aware of the merge at all. There appears to be no record
> of it -
> but the actual files themselves are the updated ones. (diff with /b
> compares equal)
>
> How can I undo it?
>
> Cheers John Lumby





You should now have a merge commit. git log should show the latest 

commit with a message similar to "merge blah".



Normally in order to undo a merge, you would simply do a "git reset

--hard HEAD^". Take note of the carat(is that correct?) character; that 

means the commit BEFORE head.



Can you please post the commit message that you see in the first commit

when doing a git log?

Also, if you just want to go back to a particular branch, you can
specify it to git reset, in the form of "git reset --hard 
origin/master". This will reset (discarding any changes) YOUR branch to
wherever origin/master happens to be, which, from reading your message 
seems to be where you want to go?

Be careful if you have made changes you want to keep, though.




Cheers,

Tim.





() ascii ribbon campaign - against html e-mail

/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  