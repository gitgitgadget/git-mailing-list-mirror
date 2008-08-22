From: Paolo Bonzini <bonzini@gnu.org>
Subject: [bug] git `next' does not do trivial merges
Date: Fri, 22 Aug 2008 08:36:39 +0200
Message-ID: <g8lmpn$jvk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 08:38:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWQHq-000821-W1
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 08:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759138AbYHVGgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 02:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759198AbYHVGgw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 02:36:52 -0400
Received: from main.gmane.org ([80.91.229.2]:57219 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759138AbYHVGgv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 02:36:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KWQGM-0003Xu-NE
	for git@vger.kernel.org; Fri, 22 Aug 2008 06:36:46 +0000
Received: from 213-140-22-65.fastres.net ([213.140.22.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 06:36:46 +0000
Received: from bonzini by 213-140-22-65.fastres.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 06:36:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 213-140-22-65.fastres.net
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93260>

I had already posted this bug report yesterday but it was hidden in a 
cover letter at 
http://permalink.gmane.org/gmane.comp.version-control.git/93143 -- so 
I'll copy the relevant info here:

> 	The included testcases demonstrate that trivial merges are
> 	currently broken.  The failing test is:
> 
> 	  git init
> 	  echo a > a
> 	  git add a
> 	  git commit -ma 
> 	  git checkout -b branch
> 	  echo b > b
> 	  git add b
> 	  git commit -mb
> 	  git checkout master
> 	  git merge --no-ff -s resolve branch
> 
> 	Running this in 1.5.5 shows: 
> 
> 	  Trying really trivial in-index merge...
> 	  Wonderful.
> 	  In-index merge
> 
> 	while `next' gives
> 
> 	  Trying really trivial in-index merge...
> 	  error: Untracked working tree file 'a' would be overwritten by merge.
> 	  Nope.
> 	  Trying simple merge.
> 	  Merge made by resolve.

Paolo
