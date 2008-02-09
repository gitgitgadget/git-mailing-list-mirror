From: Jan Holesovsky <kendy@suse.cz>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sat, 9 Feb 2008 15:25:35 +0100
Message-ID: <200802091525.36284.kendy@suse.cz>
References: <200802081828.43849.kendy@suse.cz> <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 15:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNqej-0004DE-PG
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 15:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbYBIOZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 09:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbYBIOZj
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 09:25:39 -0500
Received: from styx.suse.cz ([82.119.242.94]:37159 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752415AbYBIOZi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 09:25:38 -0500
Received: from ben.suse.cz (ben.suse.cz [10.20.1.143])
	by mail.suse.cz (Postfix) with ESMTP id 36114628091;
	Sat,  9 Feb 2008 15:25:37 +0100 (CET)
User-Agent: KMail/1.9.1
In-Reply-To: <alpine.LFD.1.00.0802081250240.2732@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73231>

Hi Nicolas,

On Friday 08 February 2008 19:03, Nicolas Pitre wrote:

> > I've provided a git import of OOo with the entire history; the problem is
> > that the pack has 2.5G, so it's not too convenient to download for casual
> > developers that just want to try it.
>
> How did you repack your repository?
>
> We know that current defaults are not suitable for large projects.  For
> example, the gcc git repository shrinked from 1.5GB pack down to 230MB
> after some tuning.

After the suggestions in this thread I tried to experiment with the --window 
and --depth options of git-repack, and indeed, there are still reserves.

So far I'm at 2G (saved 500M), unfortunately the aggressive values like 
--window=250 --depth=250 that someone mentioned here cause out-of-memory on a 
machine with 8G :-(  If there's anybody brave enough here to try as well, I'd 
be grateful.  Maybe it would be also interesting to _exactly_ locate what 
causes the oom, and eg. exclude the object from the pack if possible.

The tree is available here:

git clone git://o3-build.services.openoffice.org/git/ooo.git
git clone http://o3-build.services.openoffice.org/~svn/ooo.git (the same over 
http://)

Thank you in advance!

Regards,
Jan
