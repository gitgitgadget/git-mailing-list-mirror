From: Johan Herland <johan@herland.net>
Subject: Re: Empty directories...
Date: Fri, 20 Jul 2007 14:18:26 +0200
Message-ID: <200707201418.26534.johan@herland.net>
References: <85lkdezi08.fsf@lola.goethe.zz> <200707201220.15114.johan@herland.net> <86tzrzuyyy.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 14:18:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBrRP-0006r9-UR
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 14:18:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbXGTMSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 08:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756504AbXGTMSg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 08:18:36 -0400
Received: from sam.opera.com ([213.236.208.81]:36154 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273AbXGTMSf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 08:18:35 -0400
Received: from pc166.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l6KCIQJc029460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 20 Jul 2007 12:18:31 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <86tzrzuyyy.fsf@lola.quinscape.zz>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3702/Fri Jul 20 09:04:11 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53089>

On Friday 20 July 2007, David Kastrup wrote:
> Johan Herland <johan@herland.net> writes:
> > My point is fundamentally that selectively tracking directories is a
> > more powerful concept than just tracking _all_ directories by
> > default.
> 
> Perhaps you might read up on some of the past discussion before
> beating dead horses.  This has been covered already, and more than
> once.  I never asked for "all directories" to be tracked.  I outlined
> cases where they are tracked and where not, and I tested that the
> mechanisms in "man gitignore" already work _perfectly_ with the
> pattern "." for configuring the _implied_ tracking at directory,
> repository, project, and user preference level.

It seems our discussion is based on so many misunderstandings of each other 
that it's not very useful to reply to specific parts of it.

AFAICS, from a high-level POV, we're pretty much in agreement on the following 
points:

1. Git should be able to track directories.

2. Tracked directories should be kept alive, even if empty.

3. Git must not necessarily track _all_ directories.


Conversely, we seem to disagree on these points:

4. Whether or not git should track directories by default. You say yes, I say 
no.

5. How the tracking of directories should be implemented in git's object 
database. I want to keep the index/tree as-is except for adding directory 
entries (w/mode 040000) for the tracked directories only. You seem to want to 
add directory entries for _all_ directories and then additional "." entries 
for directories you don't want deleted if/when empty.


Am I making sense, or have I misunderstood our misunderstandings?


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
