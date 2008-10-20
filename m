From: Johan Herland <johan@herland.net>
Subject: Re: Archiving tags/branches?
Date: Mon, 20 Oct 2008 09:53:45 +0200
Message-ID: <200810200953.45339.johan@herland.net>
References: <48F93F52.4070506@pcharlan.com>
 <200810181532.59883.johan@herland.net> <48FC26DA.10508@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Pete Harlan <pgit@pcharlan.com>,
	SZEDER =?iso-8859-1?q?G=E1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 20 18:52:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Krpbp-0007PV-AV
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 09:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbYJTHyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 03:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbYJTHyH
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 03:54:07 -0400
Received: from smtp.getmail.no ([84.208.20.33]:36614 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752165AbYJTHyG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 03:54:06 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K910020L1Y45V00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 20 Oct 2008 09:54:04 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K91000AX1XL7WC0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 20 Oct 2008 09:53:45 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K91001681XL6G10@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 20 Oct 2008 09:53:45 +0200 (CEST)
In-reply-to: <48FC26DA.10508@pcharlan.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98679>

On Monday 20 October 2008, Pete Harlan wrote:
> Johan Herland wrote:
> > BTW, the best way IMHO to archive old refs is to clone your repo (with
> > all tags/branches) to a backup disk, and then regularly push (git push
> > --all && git push --tags) your new tags/branches to this backup. You
> > are now free to delete these tags/branches from your work repo (they
> > will not be deleted from the backup unless you use "git push
> > --mirror"). And if you ever need to retrieve an old tag/branch, it's
> > just a matter of pulling it from the backup repo. Nice, clean,
> > flexible, and requires no changes to git.
> >
> >
> > Have fun! :)
> >
> > ...Johan
>
> Hi,
>
> Thank you; that indeed seems to work and solves the problem of managing
> refs/archived-tags manually.
>
> Using a secondary repo solely to overcome a flat tag/branch namespace
> feels hackish.  Perhaps git will benefit someday from work in this area,
> but until I come up with a patch your suggestion should work fine.  Just
> knowing I didn't overlook an existing feature helps a lot.

>From reading your other emails, I get the feeling that I'm in a similar 
situation at $dayjob (i.e. converting ~9 years of development history from 
CVS to Git). We have literally tens of thousands of tags (mostly build and 
release tags) in some of our repos, and keeping all these tags in our daily 
work repos is simply unwieldy and impractical. We therefore plan to have 
official reps which only contain the most important tags, and 
have "archive" repos in a different location that contain all the other 
tags.

You seem to want to keep all your tags in the work repo, but in a 
separate/hidden namespace, so that they don't clutter the default tag 
listings. IMHO, once you get into thousands of tags, cloning and other 
operations where all refs are synchronized become annoyingly slow (although 
things are certainly somewhat better in v1.6). At that point, my only 
advice is to keep the lesser-used tags in separate repos, and pull each ref 
into your work repos on-demand, especially when most of these tags will 
probably never be referenced.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
