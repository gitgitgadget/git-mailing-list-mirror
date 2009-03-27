From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: patch series starting with [JGIT PATCH 1/5] Remove dead/unused
	reset method from CountingOutputStream
Date: Fri, 27 Mar 2009 07:51:00 -0700
Message-ID: <20090327145100.GM23521@spearce.org>
References: <1238030515-31768-1-git-send-email-spearce@spearce.org> <200903270911.54571.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Daniel Cheng <j16sdiz+freenet@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 15:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnDQH-0006lu-GG
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 15:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbZC0OvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 10:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZC0OvE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 10:51:04 -0400
Received: from george.spearce.org ([209.20.77.23]:45512 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbZC0OvD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 10:51:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 748D938211; Fri, 27 Mar 2009 14:51:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200903270911.54571.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114901>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> 
> More related, I also noted that the git:// ssh or file: clone calculates the CRC's separately
> and wasn't subject to this bug.

clone (or fetch) is going through IndexPack, which has its own logic
to tear apart a pack file and build up the table of contents of
that pack in the most efficient method possible.  Its an entirely
different code base than writing a pack, because its going the
other direction.  :-)

The new test case at least validates that both IndexPack and
PackWriter produce the same information in the .idx file.

-- 
Shawn.
