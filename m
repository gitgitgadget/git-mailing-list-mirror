From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [1.8.0] Tracking empty directories
Date: Thu, 03 Feb 2011 12:07:53 +0100
Organization: Bertin Technologies
Message-ID: <20110203120753.6636d0cd@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 03 12:22:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkxGE-0002XZ-V4
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 12:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab1BCLVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 06:21:50 -0500
Received: from blois.bertin.fr ([195.68.26.9]:41781 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756200Ab1BCLVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 06:21:50 -0500
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id D4927542B0
	for <git@vger.kernel.org>; Thu,  3 Feb 2011 12:21:46 +0100 (CET)
Received: from YPORT1 (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id B1BD2542A1
	for <git@vger.kernel.org>; Thu,  3 Feb 2011 12:21:46 +0100 (CET)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0LG1006MXGWAIZ00@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 03 Feb 2011 12:21:46 +0100 (CET)
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8200-6.5.0.1024-17932.006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165967>

Jonathan wrote:
>What might make git nice as an interoperability tool is that it tracks
>the _relevant_ information for the history of a software project.
>Example of what is not relevant information and why that matters:
>
> http://thread.gmane.org/gmane.comp.version-control.git/53494

Hell, that message seems to even suggest a potential solution:
use .gitattributes for tracking empty dirs.  That way a post-change
"git checkout-index" could find the info (from .gitattribute in the index)
without confusing any pre-change tool.

For ease of use, some porcelain could possibly be taught to add empty
directories into $GIT_DIR/.gitattribute (as well as checking whether an
empty-dir entry has turned useless because it now has content, and any
other administrative stuff we could want).


But that idea is linked to another issue, which could be the subject
of a 1.8 proposal of its own: the handling of .gitattribute, for which
only the checked-out version is taken into account:

http://marc.info/?l=git&m=126458888515166

-- 
Yann Dirson - Bertin Technologies
