From: Steve Folly <steve@spfweb.co.uk>
Subject: Re: git stash pop not reapplying deletions
Date: Mon, 15 Feb 2010 14:32:44 +0000 (UTC)
Message-ID: <loom.20100215T152932-38@post.gmane.org>
References: <loom.20100214T200110-615@post.gmane.org> <201002142308.01704.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 15 15:33:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh20k-0003zp-M8
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 15:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755594Ab0BOOdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 09:33:13 -0500
Received: from lo.gmane.org ([80.91.229.12]:46701 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755349Ab0BOOdM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 09:33:12 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nh20Z-0003qv-PQ
	for git@vger.kernel.org; Mon, 15 Feb 2010 15:33:07 +0100
Received: from 82.152.64.57 ([82.152.64.57])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:33:07 +0100
Received: from steve by 82.152.64.57 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:33:07 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.152.64.57 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_2; en-gb) AppleWebKit/531.21.8 (KHTML, like Gecko) Version/4.0.4 Safari/531.21.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140012>

Thomas Rast <trast <at> student.ethz.ch> writes:

> 
> On Sunday 14 February 2010 20:45:03 Steve Folly wrote:
> > 
> > I'm not sure if I've found a bug in 'git stash' or if I'm using 
> > it the wrong way? (This is with git 1.6.6):
> > 
> [eliding a lot everywhere to make it clearer]
> > $ git status   # correctly shows renames
> > #	renamed:    dira/a -> dirb/a
> > #	renamed:    dira/b -> dirb/b
> > #	renamed:    dira/c -> dirb/c
> > $ git stash
> > $ git stash pop
> > # Changes to be committed:
> > #	new file:   dirb/a
> > #	new file:   dirb/b
> > #	new file:   dirb/c
> > # Changed but not updated:
> > #	deleted:    dira/a
> > #	deleted:    dira/b
> > #	deleted:    dira/c
> 
> The problem is that you aren't using --index, but still expecting it
> to restore your index.  If you change it to 'git stash pop --index',
> everything will work as expected.

OK, yep - got it. Thanks.
 
> Yes, it does stage new files, but that is only to help you: otherwise
> you could forget them before committing.
> 

But that's even more confusing - not using --index only 
restores *some* of the index. To be honest, 
that's not really helping - I still have to stage deletions 
manually.

If not using --index isn't supposed to restore the index, 
then surely it shouldn't be staging the new files?


Cheers
Steve
