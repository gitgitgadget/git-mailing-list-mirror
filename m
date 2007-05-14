From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: git log and merge commits
Date: Mon, 14 May 2007 20:01:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0705141959110.23495@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0705141803590.11269@pademelon.sonytel.be>
 <alpine.LFD.0.98.0705141045180.6739@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 14 20:02:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnery-0003OQ-Nk
	for gcvg-git@gmane.org; Mon, 14 May 2007 20:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbXENSBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 14:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757022AbXENSBt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 14:01:49 -0400
Received: from vervifontaine.sonytel.be ([80.88.33.193]:47518 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756922AbXENSBs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 14:01:48 -0400
Received: from pademelon.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 680D058AD0;
	Mon, 14 May 2007 20:01:47 +0200 (MEST)
In-Reply-To: <alpine.LFD.0.98.0705141045180.6739@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47280>

On Mon, 14 May 2007, Linus Torvalds wrote:
> On Mon, 14 May 2007, Geert Uytterhoeven wrote:
> > I noticed `git log -p' doesn't show the changes introduced by merge commits.
> > This is true for plain `git log -p' and for `git log -p <filename>'.
> 
> The default diff output format is silent about merges, because merges can 
> be shown multiple different ways, and you have to tell git which format 
> you want.

IC.

> "git show" defaults to using "--cc", which is usually what you want. But 
> it can be a fairly expensive operation, so "git log" defaults to not 
> showing the merges at all.
> 
> The alternative format is just plain "-c", which shows a combined merge 
> (ie it effectively shows the diff from *both* parents for any file with 
> content merging). It gets really really large, really easily, which is why 
> "--cc" is often more interesting (since it shows what looks like just the 
> potential conflicts!)

Yes, --cc (as pointed out by Jakub, too), and -c both show the merge change.

In my case a file was modified by a merge, but semantically that change didn't
belong to the merge. I saw during `git pull' that the file got modified, but I
couldn't find the actual change with `git log -p'...

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
