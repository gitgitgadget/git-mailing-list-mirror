From: Maik Beckmann <maikbeckmann@gmx.de>
Subject: gitk: possible bug in diffcmd
Date: Sat, 5 Jan 2008 09:41:35 +0000 (UTC)
Message-ID: <loom.20080105T093532-817@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 10:45:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB5b4-0003rF-AZ
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 10:45:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbYAEJpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 04:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752911AbYAEJpI
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 04:45:08 -0500
Received: from main.gmane.org ([80.91.229.2]:50274 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090AbYAEJpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 04:45:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JB5aQ-00038f-IB
	for git@vger.kernel.org; Sat, 05 Jan 2008 09:45:02 +0000
Received: from port-83-236-53-99.dynamic.qsc.de ([83.236.53.99])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 09:45:02 +0000
Received: from maikbeckmann by port-83-236-53-99.dynamic.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 09:45:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.236.53.99 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.1.11) Gecko/20071204 BonEcho/2.0.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69660>

Hello.  

I'm using git-1.5.3.7 on linux.  

When I try get use "Make Patch" from by the context menu and click on "Generate"
an error popup appears which states: 
  "Error creating patch: illegal use of | or &|"
I tracked the problem down to line 5064 in gitk, which belongs to diffcmd: 
  set cmd [concat | git diff-tree -r $flags $ids]  
This line produces something like 
  | git diff-tree -r -p 5441937e2... 7394db226...  
As you see there is a leading pipe symbol which caused the error message.  
Is there some special shell to use with gitk?? Or is it just a BUG?

If I remove the | after concat everything works smooth.

Thanks in advance,

 -- Maik
