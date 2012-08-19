From: Robert Luberda <robert@debian.org>
Subject: Re: [PATCH/RFC] git svn: don't introduce new paragraph for git-svn-id
Date: Sun, 19 Aug 2012 23:46:57 +0200
Organization: Debian
Message-ID: <50315ED1.6080803@debian.org>
References: <1343856197-6393-1-git-send-email-robert@debian.org> <20120801214318.GA10384@dcvr.yhbt.net> <5019AD3A.8030609@debian.org> <20120801230118.GA15479@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 00:45:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3EEu-0007mZ-40
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 00:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab2HSWoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 18:44:16 -0400
Received: from master.debian.org ([70.103.162.29]:34405 "EHLO
	master.debian.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab2HSWoO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 18:44:14 -0400
Received: from localhost ([127.0.0.1] helo=vox.robbo.home)
	by master.debian.org with esmtp (Exim 4.72)
	(envelope-from <robert@debian.org>)
	id 1T3EE9-0006fX-Ka; Sun, 19 Aug 2012 22:44:13 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by vox.robbo.home (Postfix) with ESMTP id 1E84EE312E;
	Sun, 19 Aug 2012 23:46:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.6esrpre) Gecko/20120817 Icedove/10.0.6
In-Reply-To: <20120801230118.GA15479@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203739>

Eric Wong wrote:

Hi,
>> I don't think it will be hard to make it configurable. I can try to make
>> such a change, do you have any preferences about the option and
>> configuration key names?
> 
> No preference off the top of my head.  As long as it makes sense to
> enough people here and is consistent in style with existing options in
> git.

I have been quite a busy recently, so it took me longer that I thought.

It was quite hard for me to think some sensible option name, and finally
have chosen --trim-svn-log (svn.trimsvnlog as config key name). Please
let me know if such name is ok for you. If not, I'll try to find a
different one (but as I wrote I'm not really good at giving names to
options/functions/variables, etc. :()

I considered making the option a default one for new git svn clones, so
that existing repositories would use the older approach, but I gave up
the idea, and implemented the simpler solution, in which the option must
be given explicitly if one needs the new behavior. If making it a
default for new clones would make sense for you, I can try to implement
this as well.

For consistency, the `--add-author-from' option was modified not to add
an extra new line before 'From: ' line when the newly introduced option
is in effect.

I'm sending a new patch in next e-mail, could you please look at it and
share any comments you might have? One thing I was not sure about is the
requirement, introduced in the change, of having a whitespace character
after a colon in pseudo-header lines
(e.g. `From:somebody <somebody@somewhere.com>' won't be considered as a
pseudo-header) - is this consistent with a way git handles
headers/pseudo-headers?

Best regards,
robert
