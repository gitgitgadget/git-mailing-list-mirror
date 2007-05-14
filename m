From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log and merge commits
Date: Mon, 14 May 2007 10:51:34 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705141045180.6739@woody.linux-foundation.org>
References: <Pine.LNX.4.62.0705141803590.11269@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
X-From: git-owner@vger.kernel.org Mon May 14 19:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hneiq-0001CH-Ap
	for gcvg-git@gmane.org; Mon, 14 May 2007 19:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbXENRw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbXENRw2
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 13:52:28 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:34171 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758377AbXENRw1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2007 13:52:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4EHpYa8032588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 May 2007 10:51:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4EHpYO7022287;
	Mon, 14 May 2007 10:51:34 -0700
In-Reply-To: <Pine.LNX.4.62.0705141803590.11269@pademelon.sonytel.be>
X-Spam-Status: No, hits=-2.991 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.178 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47279>



On Mon, 14 May 2007, Geert Uytterhoeven wrote:
> 
> I noticed `git log -p' doesn't show the changes introduced by merge commits.
> This is true for plain `git log -p' and for `git log -p <filename>'.

The default diff output format is silent about merges, because merges can 
be shown multiple different ways, and you have to tell git which format 
you want.

"git show" defaults to using "--cc", which is usually what you want. But 
it can be a fairly expensive operation, so "git log" defaults to not 
showing the merges at all.

The alternative format is just plain "-c", which shows a combined merge 
(ie it effectively shows the diff from *both* parents for any file with 
content merging). It gets really really large, really easily, which is why 
"--cc" is often more interesting (since it shows what looks like just the 
potential conflicts!)

		Linus
