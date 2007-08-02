From: Sam Vilain <sam@vilain.net>
Subject: Re: Why does git-svn dcommit rewrite the log messages?
Date: Thu, 02 Aug 2007 12:44:21 -0700
Message-ID: <46B23415.8030008@vilain.net>
References: <e2a1d0aa0708011419m1f6cb323ge9e93680147a298@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:54:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGjZ6-0007IT-4s
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756349AbXHBWyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755652AbXHBWyj
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:54:39 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:54457 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbXHBWyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:54:39 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id F2D0420C139; Fri,  3 Aug 2007 10:54:36 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id A962721C13E;
	Fri,  3 Aug 2007 10:54:32 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <e2a1d0aa0708011419m1f6cb323ge9e93680147a298@mail.gmail.com>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54635>

Patrick Doyle wrote:
> I see that it appends text to the log messages with the SVN repository
> revision and ID.  Does it do that because:
>
> 1) That's the _only_ way to keep git & svn in sync
> If so, then I guess I'm out of luck.  But it seems (to my
> inexperienced eye) to make branching impossible in git -- as soon as I
> do a "git-svn dcommit", I lose the commit on which my branch was
> originally based.  Or, am I missing something?
>
> 2) That was the simplest way to keep them in sync at the time git-svn
> was written and it hasn't bothered anybody enough to go back and fix
> it.
> If so, I'd be glad to see what I could do to fix it.  I would also
> appreciate any pointers folks might care to give to get me started.
>   

Primarily it's so that the person who pushed via dcommit and people who
sync via git-svn fetch get the same commit ID (assuming they are both
using the same authors map).

It might be possible to store the extra information needed to recreate
exactly the original git commit in SVN revision properties, but this
would need to be implemented once and basically not changed after that.

You can disable this behaviour, but you'll end up with duplicate commits.

Sam.
