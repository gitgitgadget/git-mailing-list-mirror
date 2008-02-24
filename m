From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Instituting feature and infrastructure enhancement proposal
 window?
Date: Sun, 24 Feb 2008 12:42:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802241226340.21332@woody.linux-foundation.org>
References: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 21:43:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTNhK-0001l0-10
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 21:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbYBXUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbYBXUnH
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 15:43:07 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:43715 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752480AbYBXUnG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Feb 2008 15:43:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1OKgmGl021550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 24 Feb 2008 12:42:49 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1OKglKG030535;
	Sun, 24 Feb 2008 12:42:48 -0800
In-Reply-To: <7v8x1ataiu.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.078 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74958>



On Sun, 24 Feb 2008, Junio C Hamano wrote:
>
> The important dates in the above would be (in parentheses are my
> straw-mans):

On the merge window issue: I can heartily recommend it, but for the kernel 
we have noticed:

 - people get really antsy it the releases are more than two months apart. 
   Quite frankly, six weeks would be better, but it's just not realistic.

 - the kernel has to have a long stabilization phase, and I largely blame 
   the fact that we have so much different hardware (and driver and arch 
   changes are generally much more than 50% of all changes anyway). So we 
   arguably need wider testing than projects that are more "repeatable" on 
   a smaller set of machines.

So I think the merge window has worked out beautifully, but in a perfect 
world, I'd make the window be roughly half the time of the release (rather 
than about 20% as it is for the kernel), and aiming for a six-week release 
timing. And I think both of those should be reasonably easy to hit within 
the git development model.

So I would basically cut you target timeframes into half (except for the 
first -rc release - there's no point in making that less than a week). 
Three months is just going to make people who miss the release window 
antsy. It's what the kernel has in practice, and I would *not* advocate it 
as ideal - I actually aim for 2 months and we then invariably slip a bit..

So I'd suggest:
 - first -rc in 1 week
 - window closes in 3 weeks
 - next release in 6 weeks
 - rinse and repeat

and if you worry that there won't be enough changes to merit a release, 
trust me, that's the *good* schenario. Nobody will ever mind releases that 
aren't disruptive, and you'll have an easy case with making them too. 
There really are no downsides to having an easy release cycle with not a 
lot of big changes. I _wish_ I had more of those.

And on exactly that note:

>  * diff --dirstat (Linus)

I actually actively use this (not just for -rc releases, but I find it 
nice to do occasionally in other cases too), so it would be really nice if 
at least the initial version got merged soon. Even if it gets the binary 
case wrong, and even if the statistics would arguably be better based on 
"damage" instead of just number of lines.

Of course, I have it in my tree regardless, but especially with me then 
publicising the feature in my -rc releases (another one coming up today), 
I'd hope that you'd merge it so that others can use it too.. If this was 
at the end of a merge window, I'd hate to have to wait 1.5 months for the 
next one to open.

			Linus
