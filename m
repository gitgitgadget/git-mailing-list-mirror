From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem with Linus's git repository?
Date: Fri, 29 Jun 2007 15:00:09 +0200
Message-ID: <46850259.8030708@op5.se>
References: <f5r8q5$pbr$1@sea.gmane.org> <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>     <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>   <alpine.LFD.0.98.0706270932040.8675@woody.linux-foundation.org>   <Pine.LNX.4.64.0706280632540.5321@x2.ybpnyarg> <alpine.LFD.0.98.0706280840570.8675@woody.linux-foundation.org> <Pine.LNX.4.64.0706290537130.7055@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Fri Jun 29 15:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4GPQ-0007gQ-NR
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 15:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763610AbXF2NVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 09:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761717AbXF2NVI
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 09:21:08 -0400
Received: from mail.op5.se ([193.201.96.131]:54153 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761430AbXF2NVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 09:21:07 -0400
X-Greylist: delayed 1253 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2007 09:21:07 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1099C194368;
	Fri, 29 Jun 2007 15:00:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mFeIVuPytN0D; Fri, 29 Jun 2007 15:00:10 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.138])
	by mail.op5.se (Postfix) with ESMTP id 81746194357;
	Fri, 29 Jun 2007 15:00:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <Pine.LNX.4.64.0706290537130.7055@x2.ybpnyarg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51175>

walt wrote:
> 
> On Thu, 28 Jun 2007, Linus Torvalds wrote:
> 
>> On Thu, 28 Jun 2007, walt wrote:
>>> No, every morning I pull from you and Junio and Petr Baudis using cg-update,
> 
> 
>> Oh, don't use "cg-update", or just fix it to do "git pull".
> 
> I'm happy to stick with using git.  From reading the latest Docs, it seems
> that git-pull -v will do what I need (I think).
> 
> That's what I did just now to update from you and Junio, and the output
> seemed exactly appropriate -- ended with a fast-forward and no errors
> for either one.
> 
> However, a git-fsck turned up four dangling commits for Junio, and 42
> danglers for you, including a mix of blobs, trees, and commits.
> 

You will see dangling commits, blobs and trees from Junio because he rewinds
his 'pu' branch.

I'm not sure why you see any from Linus, as I'm not aware of any rewinding
in the official kernel tree (unless you're talking about some other repo,
in which case I'm clueless).

> Will a simple git-prune bring me correctly up to date, or am I missing
> some steps?
> 

You're already up to date. The dangling commits do not hurt your repo
in any way. Nor do they hurt the performance of any of the tools you
normally use. fsck suffers a bit from them, because it has to care
about them, but the normal DAG-traversing tools will never even
see them.

git prune would remove them and save you a tiny bit of diskspace.
Next time you pull from Junio, you'll most likely get orphaned commits
again though, meaning blobs, trees and commits will end up dangling once
more. It's perfectly normal and nothing to worry about.

For repo maintenance, I run "git gc" once a month on my local copies.
More to let my laptop do something while I'm fiddling with receipts and
stuff than for any real need (the idea of idle computers offend me for
some reason).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
