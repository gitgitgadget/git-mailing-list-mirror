From: Russell King <rmk@arm.linux.org.uk>
Subject: git-pasky file mode handling
Date: Sat, 16 Apr 2005 10:45:59 +0100
Message-ID: <20050416104559.A12943@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 16 11:42:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMjoy-0006YI-0y
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 11:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVDPJqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 05:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVDPJqG
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 05:46:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57871 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261655AbVDPJqD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 05:46:03 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DMjsH-0007Nv-0J
	for git@vger.kernel.org; Sat, 16 Apr 2005 10:46:01 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DMjsF-0003sk-Qj
	for git@vger.kernel.org; Sat, 16 Apr 2005 10:45:59 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

It seems that there's something weird going on with the file mode
handling.  Firstly, some files in the git-pasky repository have mode
0664 while others have 0644.

Having pulled from git-pasky a number of times, with Petr's being the
"tracked" repository, I now find that when I do an update-cache --refresh,
it complains that the files need updating, despite show-diff showing no
differences.  Investigating, this appears to be because the file modes
are wrong for a number of the files.  All my files do not have group
write.

I notice in the changelog what appears to be a dependence on the umask.
If this is so, please note that git appears to track the file modes,
and any dependence upon the umask is likely to screw with this tracking.

-- 
Russell King

