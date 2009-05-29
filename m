From: doki_pen <doki_pen@doki-pen.org>
Subject: Re: git-svn fetch
Date: Fri, 29 May 2009 16:31:07 -0400
Message-ID: <4A20460B.8030709@doki-pen.org>
References: <gvots5$uob$1@ger.gmane.org> <4A20090F.3070608@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 29 22:33:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA8lT-0001JF-GR
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 22:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755838AbZE2UbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 16:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753704AbZE2UbF
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 16:31:05 -0400
Received: from doki-pen.org ([74.207.224.154]:40667 "EHLO doki-pen.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755092AbZE2UbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 16:31:04 -0400
Received: from [192.168.32.173] (unknown [209.190.172.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by doki-pen.org (Postfix) with ESMTPSA id 256035558D;
	Fri, 29 May 2009 16:30:12 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090511)
In-Reply-To: <4A20090F.3070608@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120313>

Michael J Gruber wrote:
> Doki Pen venit, vidit, dixit 29.05.2009 17:09:
>   
[snip]
>> The problem I'm experiencing is that everytime a new branch is added, 
>> git svn fetch seems to download the entire history all the way from r1. 
[snip]
>
> AFAIK git-svn has to go back in order to search for possible earlier
> history of $newbranch. For git-svn, the following two scenarios are
> basically equivalent:
>
> - a new branch is added to the svn repo
> - you change your git-svn config so that a new branch becomes
> "interesting" (which had been skipped before)
>
> git-svn treats them the same way ("a branch we don't know about yet"),
> because it can't really (reliably) distinguish between them.
>   

Turns out that in their infinite wisdom, the repo gods laid out the 
structure like this:

/trunk
  /Source
     [THECODE]
  /SomethingElse
  /SomeOtherStuff
/branches
  /BRANCH-1
     [THECODE]
  /...

The problem was I had trunk set to /trunk and not /trunk/Source.  This 
was a bad mistake.  Since I have fixed it git-svn is quite a bit faster!

TY
