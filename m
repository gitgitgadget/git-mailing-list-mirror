From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Make git-prune submodule aware (and fix a SEGFAULT in the 
 process)
Date: Fri, 17 Aug 2007 11:14:44 +0200
Organization: eudaptics software gmbh
Message-ID: <46C56704.6D917A53@eudaptics.com>
References: <200707021356.58553.andyparkins@gmail.com> <200708170939.47214.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 11:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILxuH-0005Z3-Nu
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 11:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758236AbXHQJOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 05:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755580AbXHQJOK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 05:14:10 -0400
Received: from main.gmane.org ([80.91.229.2]:60685 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757856AbXHQJOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 05:14:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ILxu5-00030E-HU
	for git@vger.kernel.org; Fri, 17 Aug 2007 11:14:01 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 11:14:01 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 17 Aug 2007 11:14:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56055>

Andy Parkins wrote:
> Could any of the guru's give me a guide to upload-pack.c?  I assume the
> problem is going to be the same as it was for git-prune, the hash for the
> gitlink object in the tree is being assumed to be an object in the ODB;
> which isn't the case with gitlink entries.  Where would that be happening
> in git-upload-pack?  The fix is going to be..
> 
>  if( S_ISGITLINK(mode))
>       continue;
> 
> But I've got no idea where to put it :-)

Most likely in list-objects.c:traverse_commit_list(), which is called
from somewhere in upload-pack.c.

-- Hannes
