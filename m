From: Anton Tropashko <atropashko@yahoo.com>
Subject: Re: Errors cloning large repo
Date: Mon, 12 Mar 2007 10:39:44 -0700 (PDT)
Message-ID: <315943.12751.qm@web52606.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 18:40:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQoVg-00077M-GN
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 18:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbXCLRkJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 13:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbXCLRkI
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 13:40:08 -0400
Received: from web52606.mail.yahoo.com ([206.190.48.209]:39421 "HELO
	web52606.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751998AbXCLRkH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2007 13:40:07 -0400
Received: (qmail 13160 invoked by uid 60001); 12 Mar 2007 17:39:44 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=USqg4E52XcLsSj8KAamZN2QXzILnRx86lRdu1UJE/Bd4Jwqeg+fgO09ds3GGkSuTOyRMUds2QhWLSJm3myLcV2yLQvarC6Jg5M52IK6x/kNKd94rBlbuBXMUYQ0emj5m41+BJ9JPmvmAmq4n5E8sVObzZoFa0AtMijh+WHEtWUc=;
X-YMail-OSG: AINC5AEVM1mBWn06LV8HXymKYH3sguGjVHxTLCGTNU4tM0oucEEK3klYjjIwXOLFAhZQfx87d.w396pA1vj7WyFC_M0LP8XdZsD41pXE6lw6opdR2PxTmqqqnmif5VST3LiRrr9IPW8Rn2iYMgVo02SV
Received: from [129.188.69.145] by web52606.mail.yahoo.com via HTTP; Mon, 12 Mar 2007 10:39:44 PDT
X-Mailer: YahooMailRC/471 YahooMailWebService/0.6.132.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42047>

> For example, if "du -sh" says 8.5GB, it doesn't necessarily mean that 
> there really is 8.5GB of data there.

> Its very likely this did fit in just under 4 GiB of packed data,
> but as you said, without O_LARGEFILE we can't work with it.

.git is 3.5GB according to du -H :)

> As Linus said earlier in this thread; Nico and I are working on
> pushing out the packfile limits, just not fast enough for some users
> needs apparently (sorry about that!).  Troy's patch was rejected

No problem.
You're providing things to work around faster than I can process them :-)

> So the "git repack" actually worked for you? It really shouldn't have 
> worked.

It did not complain. I did not check the exit status but there were no so
much as a single warning message:
index file has overflown the kernel will panic shortly. please stand by...

> Is the server side perhaps 64-bit? If so, the limit ends up being 4GB 
> instead of 2GB, and your 8.5GB project may actually fit.

both server and client are 32 bit.

> If so, we can trivially fix it with the current index file even for a 
> 32-bit machine. The reason we limit pack-files to 2GB on 32-bit machines 

Unfortunately the server machine is managed by IT. I can't install whatever
I want. The client is not and it's against the IT policy to have rogue linux boxes
on the net ;)

> So, wouldn't the correct fix be to automatically split a pack
> file in two pieces when it would become larger than 2 GB?

Just curious why won't you use something like 
PostgreSQL for data storage at this point, but, then
I know nothing about git internals :)

Anyhow, I have a patch to apply now and a bash script to hone my
bashing skills on. If you have anything else for me to test just shoot me
an e-mail.

I'm glad I can keep you all busy.






 
____________________________________________________________________________________
Expecting? Get great news right away with email Auto-Check. 
Try the Yahoo! Mail Beta.
http://advision.webevents.yahoo.com/mailbeta/newmail_tools.html 
