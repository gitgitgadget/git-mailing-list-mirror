From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: RPMs for latest release
Date: Fri, 3 Aug 2007 14:36:09 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708031433080.8184@woody.linux-foundation.org>
References: <46B38125.9060805@centurytel.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: rdavid274 <rdavid274@centurytel.net>
X-From: git-owner@vger.kernel.org Fri Aug 03 23:36:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH4oq-0007L2-52
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 23:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763021AbXHCVgU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762453AbXHCVgU
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 17:36:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49794 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762834AbXHCVgT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 17:36:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l73LaE7D029969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Aug 2007 14:36:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l73La9Mt028928;
	Fri, 3 Aug 2007 14:36:09 -0700
In-Reply-To: <46B38125.9060805@centurytel.net>
X-Spam-Status: No, hits=-2.715 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54764>



On Fri, 3 Aug 2007, rdavid274 wrote:
>
> Downloaded the 10 rpms necessary for a complete install however, there is NO
> single rpm that is independent of the other rpms.
> 
> Every rpm that I have downloaded depends on at 1 other rpm to have been
> already installed.
> 
> So, how does a newbie deal with this issue?

You should be able to do

	rpm -Uvh <list-all-rpms-here>

and be all good.

In other words, if you have dependencies, you need to resolve all the 
dependencies in one go by listing the packages together.

Of course, you could also just force rpm to ignore dependencies (the 
"--nodeps" flag, iirc), but that's usually a bad idea - it just means that 
you will be all the more likely to have a non-working setup because you 
forgot some package or other, and since you told rpm to ignore it, it 
won't tell you.

That said, most rpm distros tend to make things much easier for you by 
letting you just run "yum", which will do all of this for you, and then 
you can generally just do

	yum install git

and it will download all packages and install them by dependencies.

			Linus
