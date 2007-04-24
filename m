From: Andy Parkins <andyparkins@gmail.com>
Subject: .git grows after git-gc?
Date: Tue, 24 Apr 2007 14:31:32 +0100
Message-ID: <200704241431.33624.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 15:32:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgL85-0007pv-OZ
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 15:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161761AbXDXNcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 09:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161764AbXDXNcL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 09:32:11 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:32737 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161761AbXDXNcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 09:32:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so178573uga
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 06:32:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KZQ+m03/0ugkJv/yb3ZLOG/DNq7J5i396Ypk6zuFcur1YVAcgFkmG+G+n4fVMh76gsF2aN3rHEmEq/UeTNYr0hHmSprhhv9U/SX814V+d1vLfWCvSU9qxVgZuAOe7oVaPsUKcJAclO4q5wzGTbumfM2B0Nhu4rT12fpB/mCgukE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LNllM6ch5MJ6676SiDLPj7XMFjG4fl0SUwAL8LAzZLpxgDal58F4ARtc/du7+LIL3I6PrE5xav67ZQY4lxb7fgmIG+SFVRWO6JkMA1y/mU+JUh1ZFsMN7AlyA9UQhJHuHuI8/NMTtXSffAJ0iWMqF8R1IIaL0OldAWJUVDyXIrE=
Received: by 10.82.116.15 with SMTP id o15mr10899593buc.1177421527359;
        Tue, 24 Apr 2007 06:32:07 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id y34sm6143iky.2007.04.24.06.31.52;
        Tue, 24 Apr 2007 06:32:00 -0700 (PDT)
User-Agent: KMail/1.9.6
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45448>

Hello,

Not important at all, but I was surprised to see this:

$ git fetch \
   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git \
   refs/heads/master:refs/remotes/vendor
remote: Generating pack...
remote: Done counting 194409 objects.
remote: Deltifying 194409 objects.
remote:  100% (194409/194409) done
Indexing 194409 objects.
remote: Total 194409 (delta 147074), reused 179896 (delta 138737)
 100% (194409/194409) done
Resolving 147074 deltas.
 100% (147074/147074) done
* refs/remotes/vendor: storing branch 'master' of 
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.16.y
  commit: 7a715c6

$ du -h .git
95M     .git

$ git-gc --prune
Generating pack...
Done counting 194520 objects.
Deltifying 194520 objects...
 100% (194520/194520) done
Writing 194520 objects...
 100% (194520/194520) done
Total 194520 (delta 147074), reused 194520 (delta 147074)
Pack pack-220cec9989ebd8b75963de71742861c6adbeda7d created.
Removing unused objects 100%...
Done.

$ du -h .git
97M     .git

That's a bit odd isn't it?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
