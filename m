From: Seth Falcon <sethfalcon@gmail.com>
Subject: git svn fetch spewing warnings
Date: Mon, 26 Mar 2007 10:02:50 -0700
Message-ID: <m28xdkvsxx.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 19:03:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsaz-00007i-Hd
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbXCZRCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbXCZRCw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:02:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:45496 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbXCZRCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:02:51 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1652812uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:02:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=dAWy3/Fr7fjBKsgr7x9ZY5WjeN4K7mP7gwXMTfYS/bUS2t6FQBnqQQ4Rzn1DhOLAGiuXdQHo7js2mhvFBbAilJA05QmH/qP+QeK87ppDlrmrPvaH8bdGybSZpZ/ihX+yieJWQMtmz+mWd3iQXv+yAUpi1C9hEraoI2wrMkCkwwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:from:date:message-id:user-agent:mime-version:content-type;
        b=VLDirQ6wRgBZhQtJk46aOZq9CtLshfSJI+3fSgZJJ/wYdxKWueF8afRfo8fJvhxTQKC0mKPgywsjpQjPVFMKLlu1Mz7Gnmh1UIyXqZ7NNroEIfEBmNu8DSFVzpTemC++sMpFtCPIL0PDDZQS3emdaC/rTmRjzuQwBWqWLEaGwZU=
Received: by 10.114.110.1 with SMTP id i1mr2712292wac.1174928568487;
        Mon, 26 Mar 2007 10:02:48 -0700 (PDT)
Received: from ziti.fhcrc.org ( [140.107.181.196])
        by mx.google.com with ESMTP id q18sm881064pog.2007.03.26.10.02.48;
        Mon, 26 Mar 2007 10:02:48 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43159>

Hi,

I'm using git 1.5.1.rc1.13.g0872 and I just tried the following to
create a new git-svn tracked repository.

I did:


    git svn init $URL
    git svn fetch 
    # I also tried git svn fetch --no-follow-parent

The command eventually completed and left me with a working
repository, but in the process I had screenfuls of warning messages
like this:

W: Ignoring error from SVN, path probably does not exist: (175002): RA layer request failed: REPORT request failed on '/bioconductor/!svn/bc/12000': REPORT of '/bioconductor/!svn/bc/12000': Could not read chunk size: Secure connection truncated (https://hedgehog.fhcrc.org)
W: Ignoring error from SVN, path probably does not exist: (175002): RA layer request failed: REPORT request failed on '/bioconductor/!svn/bc/12100': REPORT of '/bioconductor/!svn/bc/12100': Could not read chunk size: Secure connection truncated (https://hedgehog.fhcrc.org)
W: Ignoring error from SVN, path probably does not exist: (175002): RA layer request failed: REPORT request failed on '/bioconductor/!svn/bc/12200': REPORT of '/bioconductor/!svn/bc/12200': Could not read chunk size: Secure connection truncated (https://hedgehog.fhcrc.org)

I haven't seen them before, but...

  1. I haven't initialized a new repository in this way for awhile and
     git-svn has been updated

  2. The subversion server I'm talking to was recently upgraded to
     1.4.2

Thanks,

+ seth
-- 
Seth Falcon | Computational Biology | Fred Hutchinson Cancer Research Center
http://bioconductor.org
