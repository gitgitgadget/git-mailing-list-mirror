From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 0/5] Return of 'quickfetch' version 3
Date: Sun, 11 Nov 2007 02:29:13 -0500
Message-ID: <20071111072913.GX14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 08:29:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir7GC-0003EU-E7
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 08:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbXKKH3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 02:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXKKH3T
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 02:29:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41436 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbXKKH3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 02:29:19 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ir7Fs-0000z5-Jv; Sun, 11 Nov 2007 02:29:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 781E120FBAE; Sun, 11 Nov 2007 02:29:14 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64414>

OK, attempt #3.  Much shorter series as I've taken out the (messy)
object memory management change.  Its now unrelated to this series
and may return in the near future.

 1) Fix memory leak in traverse_commit_list

The memory leak we talked about in traverse_commit_list.  Its still
valid for pack-objects but is unnecessary for fetch.

 2) git-fetch: Always fetch tags if the object they reference exists

I think I figured out why I said "random behavior" earlier.
Please see the commit message for an updated description.

 3) run-command: Support sending stderr to /dev/null
 4) rev-list: Introduce --quiet to avoid /dev/null redirects
 5) git-fetch: avoid local fetching from alternate (again)

Pretty much the original quickfetch series, but updated with list
comments and moved to builtin-fetch where it works for all types
of transports and not just the native git one.

-- 
Shawn.
