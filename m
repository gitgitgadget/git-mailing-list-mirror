From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 08/10] Drop unused end parameters in hunk parsing
	code
Date: Mon, 16 Mar 2009 13:39:35 -0700
Message-ID: <20090316203935.GT22920@spearce.org>
References: <1237234483-3405-1-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-2-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-3-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-4-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-5-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-6-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-7-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-8-git-send-email-robin.rosenberg@dewire.com> <1237234483-3405-9-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spearce@sparce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:41:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjJcT-0008V6-5d
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 21:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648AbZCPUji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 16:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757637AbZCPUji
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 16:39:38 -0400
Received: from george.spearce.org ([209.20.77.23]:40627 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbZCPUjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 16:39:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EBBE138215; Mon, 16 Mar 2009 20:39:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1237234483-3405-9-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113378>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Is this safe, or should they actually be used?

Yea, these are safe to remove.  At worst we move one line beyond
the end marker given to us by the user in Patch.parse() and then
abort the parse loop when we find ptr >= end.  We should also never
exceed the byte[] length; the ParseUtils methods we use do their
own array bound checks internally.

>  .../org/spearce/jgit/patch/CombinedHunkHeader.java |    2 +-
>  .../src/org/spearce/jgit/patch/HunkHeader.java     |    2 +-
>  .../src/org/spearce/jgit/patch/Patch.java          |    8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)

-- 
Shawn.
