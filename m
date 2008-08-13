From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Show of hands, how many set USE_NSEC
Date: Wed, 13 Aug 2008 22:01:26 +0200
Message-ID: <200808132201.26868.robin.rosenberg.lists@dewire.com>
References: <20080808163455.GE9152@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 22:44:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTNCJ-0004Bz-Jd
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 22:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbYHMUmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 16:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYHMUmy
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 16:42:54 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:35092 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbYHMUmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 16:42:53 -0400
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 89AE437F40; Wed, 13 Aug 2008 22:42:51 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 772EC37F37; Wed, 13 Aug 2008 22:42:51 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 5F38E37E42;
	Wed, 13 Aug 2008 22:42:51 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080808163455.GE9152@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92269>

fredagen den 8 augusti 2008 18.34.55 skrev Shawn O. Pearce:
> How many users really build their Git with USE_NSEC=1?
> 
> I'm suspecting a status issue in jgit caused by jgit honoring a
> millisecond resolution on file modification timestamps, and the
> underlying filesystem supporting at least a 1/2 second (or finer)
> granularity, but C Git was built without USE_NSEC so it only honors
> 1 second granularity.
> 
> This can cause jgit to think a file is locally modified as the
> mtime has data in the tv_nsec field, but C Git set that to 0 in
> the index as USE_NSEC wasn't enabled at build time.
When jgit finds an index entry with zero nsec it ignores the subsecond
portion of the file timestamp when comparing.

-- robin
