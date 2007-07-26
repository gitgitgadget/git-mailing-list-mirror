From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 26 Jul 2007 09:32:22 +0200
Organization: eudaptics software gmbh
Message-ID: <46A84E06.2ED4CFBC@eudaptics.com>
References: <Pine.LNX.4.64.0707260630570.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 09:32:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxpk-0001b8-Ch
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755677AbXGZHcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755289AbXGZHcY
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:32:24 -0400
Received: from main.gmane.org ([80.91.229.2]:56004 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755508AbXGZHcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:32:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDxpY-0007cr-7Q
	for git@vger.kernel.org; Thu, 26 Jul 2007 09:32:16 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 09:32:16 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 09:32:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53801>

Johannes Schindelin wrote:
> 
> When you select the context menu item "Split Hunk" in the diff area,
> git-gui will now split the current hunk so that a new hunk starts at
> the current position.
> 
> For this to work, apply has to be called with --unidiff-zero, since
> the new hunks can start or stop with a "-" or "+" line.

For chrissake, NO!

I tried this already, and it immediately corrupted my data.

The problem case is when the hunk you want to apply is not the first one
and the first one does not add and remove the same number of lines. In
this case, all that git-apply can do is to rely on line numbers. But
they are WRONG and apply the patch at the WRONG spot.

First, I didn't believe Linus when he preached that --unidiff-zero is
bad; it took only a day to become a follower. ;)

-- Hannes
