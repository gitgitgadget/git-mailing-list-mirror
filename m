From: Adrian Bunk <bunk@stusta.de>
Subject: git-apply{,mbox,patch} should default to --unidiff-zero
Date: Fri, 6 Jul 2007 01:22:10 +0200
Message-ID: <20070705232210.GR3492@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 01:21:53 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6adw-0002Vv-4y
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 01:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760271AbXGEXVo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 19:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759811AbXGEXVn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 19:21:43 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52114 "EHLO
	mailhub.stusta.mhn.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758694AbXGEXVm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 19:21:42 -0400
Received: from r063144.stusta.swh.mhn.de (r063144.stusta.swh.mhn.de [10.150.63.144])
	by mailhub.stusta.mhn.de (Postfix) with ESMTP id DBDF8181C28
	for <git@vger.kernel.org>; Fri,  6 Jul 2007 01:22:54 +0200 (CEST)
Received: by r063144.stusta.swh.mhn.de (Postfix, from userid 1000)
	id 47C185EE61A; Fri,  6 Jul 2007 01:22:10 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51704>

I just ran into the following issue:

I sent someone a patch that purposefully contained a chunk without 
context, and git-apply of the recipient refused to apply it without
an explicit --unidiff-zero.

git-apply{,mbox,patch} should default to doing --unidiff-zero:
Generating a patch without context is something I have to do explicitely 
by giving "diff" an option or by manually editing the patch. I know 
about the dangers of having no context, but there are use cases where
I know that replacing and/or deleting one or more lines is safe even 
without context and where I want to avoid context e.g. for avoiding to 
clash with other patches.

Example use case:
Look at the file Documentation/feature-removal-schedule.txt in the Linux 
kernel. If I want to send someone two independent patches removing 
adjanced entries in this file, the patches can be applied in any order 
exactly as long as this chunk does not contain any context. Removing an 
entry from this file is obviously safe even without any context.

TIA
Adrian

BTW: Please Cc me on replies.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
