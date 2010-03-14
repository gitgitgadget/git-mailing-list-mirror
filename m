From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Master:809780b failing t9151-svn-mergeinfo.sh
Date: Sun, 14 Mar 2010 19:09:53 -0400
Message-ID: <4B9D6CC1.6020307@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 15 00:10:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nqwwi-0001Hv-0y
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 00:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757806Ab0CNXKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 19:10:03 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:56354 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab0CNXKA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 19:10:00 -0400
Received: by gxk27 with SMTP id 27so132785gxk.1
        for <git@vger.kernel.org>; Sun, 14 Mar 2010 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=aQxc/KU0umZv8KXkkgICLNFqhdJAOQ6St5xvCaupZEo=;
        b=eTlxl5dD51rN7Zz4i+i7l70DD54M+MmEOfOm1dArQVSSr2lN6bFX+eG2oMqsKgEbkN
         NeN5awhfdazlWEmWWy7OCGrch4eFbAWnc5lCxZynzMUKUpFFdZQqepmEwT73TndiHkaK
         Yws4MAQ/W4QUlrSSncAEKuv8hg7lgu2g78wyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        b=wP/NdDYWlZqDE7f+NVRbCxKY3uY8Wmv5PZtm8HgHEgOsHTaVHBhwNN+AwuaM7FwD5A
         X3t9PSoBAkGWWkfs1gIxZrqjqBYgMUrHXkp/kldkGkrqPvU7EIpdmYH80OzP0SZ8IQgy
         ovxbfFI+5KJs9GPcRqzfW6uJq3yu/c2DsVujg=
Received: by 10.100.18.11 with SMTP id 11mr6183169anr.154.1268608200057;
        Sun, 14 Mar 2010 16:10:00 -0700 (PDT)
Received: from [10.0.0.6] (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 13sm2474338gxk.8.2010.03.14.16.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Mar 2010 16:09:59 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142161>

[I've been away from computers for 10 days and I'm 611 messages behind 
so if this is old news please ignore the noise.]

Master 809780 is failing test 1 of t9151-svn-mergeinfo.sh with the 
following information:

*** t9151-svn-mergeinfo.sh ***
* FAIL 1: load svn dump

                 svnadmin load -q '/home/internet/GIT/git/t/trash 
directory.t9151-svn-mergeinfo/svnrepo'           < 
'/home/internet/GIT/git/t/t9151/svn-mergeinfo.dump' &&
                 git svn init --minimize-url -R svnmerge           -T 
trunk -b branches 'file:///home/internet/GIT/git/t/trash 
directory.t9151-svn-mergeinfo/svnrepo' &&
                 git svn fetch --all

*   ok 2: all svn merges became git merge commits
*   ok 3: cherry picks did not become git merge commits
*   ok 4: svn non-merge merge commits did not become git merge commits
*   ok 5: commit made to merged branch is reachable from the merge
*   ok 6: merging two branches in one commit is detected correctly
*   still broken 7: everything got merged in the end
* still have 1 known breakage(s)
* failed 1 among remaining 6 test(s)
make[2]: *** [t9151-svn-mergeinfo.sh] Error 1
make[2]: Leaving directory `/home/internet/GIT/git/t'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/internet/GIT/git/t'
make: *** [test] Error 2


This is on a 64 bit (mostly) Debian Squeeze system. The last working 
master before I left was 6d84bcb.
