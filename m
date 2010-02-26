From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn detects some merges incorrectly from svn:mergeinfo
Date: Fri, 26 Feb 2010 01:50:14 -0800
Message-ID: <20100226095014.GB22579@dcvr.yhbt.net>
References: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Tuomas Suutari <tuomas.suutari@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	josh robb <josh_robb@fastmail.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 10:50:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkwq2-0001ff-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 10:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935805Ab0BZJuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 04:50:18 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:41024 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935804Ab0BZJuP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 04:50:15 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8158D1F488;
	Fri, 26 Feb 2010 09:50:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1266825442-32107-1-git-send-email-tuomas.suutari@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141119>

Tuomas Suutari <tuomas.suutari@gmail.com> wrote:
> Hi,
> 
> Now that git-svn detects merges from svn:mergeinfo, I thought it's
> time to re-import some of my SVN repos with git-svn. Detecting of the
> merges worked mostly well, but when inspecting the imported history
> with gitk, I found some incorrectly detected merges.
> 
> This patch series adds a test case and a fix for the case.
> 
> I was a bit uncertain if the fix should go to parents_exclude function
> or to "cater for merges which merge commits from multiple branches"
> section of find_extra_svn_parents function. I chose the latter and at
> least it does the trick.

Thanks Tuomas and Sam+Thomas for the feedback.

I've pushed this series out to git://git.bogomips.org/git-svn along with
Josh's speedup.

Tuomas Suutari (3):
      t9151: Fix a few commits in the SVN dump
      t9151: Add two new svn:mergeinfo test cases
      git-svn: Fix discarding of extra parents from svn:mergeinfo

josh robb (1):
      git svn: delay importing SVN::Base until it is needed

-- 
Eric Wong
