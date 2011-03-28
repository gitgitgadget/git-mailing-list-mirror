From: Patrick Doyle <wpdster@gmail.com>
Subject: How to tell what paths changed in a merge?
Date: Mon, 28 Mar 2011 15:48:01 -0400
Message-ID: <AANLkTi=DOf0beuts8TO0c5JJtDtjNAcQ_4hcKNkZoXjM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:48:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4IQP-00028l-MR
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 21:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263Ab1C1TsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 15:48:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45994 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932264Ab1C1TsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 15:48:22 -0400
Received: by fxm17 with SMTP id 17so2953065fxm.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 12:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=iD/oA/NugPnzSUnYgIjTD2MN8HIg7Av8V9tpFGUefeU=;
        b=CL89sATVHmvD8gKSc2AGKsnvPl+azD4UwwmTj8rLR9I4+zmCACq4DLMH+LvR3/ZOLA
         4CQNeoKCCeQNlweLbeMyDAsVUKl7ASGw1Noj9Dbd1vCM1v1snKcLJZTv6dgODujtrBqw
         zLhK0EC2JffYlczhVlG8ZqIJJ4iv4Hj5eFH8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=ptbtSriyhEEiUeqJ0ZNzrFiu0sMqMg540aVXozBuTgpsplV80DzNFuVW96IN6cYOxk
         rdvLeZ4OI3ajqL4aS8gCO71DjzEmCbxz4mMWByiDfiB2p3cKR9Fa4PVtyfXvCLOggXdt
         vXNItEvrfPrGY70s9UTkJUn9qFAVnHyogfbUI=
Received: by 10.223.126.140 with SMTP id c12mr4930038fas.31.1301341701157;
 Mon, 28 Mar 2011 12:48:21 -0700 (PDT)
Received: by 10.223.116.20 with HTTP; Mon, 28 Mar 2011 12:48:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170181>

I have a situation where somebody got confused while trying to
commit/push/pull from the repository and some changes to some files
got lost.

How can I tell which files got selected in a merge?

I have a log file such as shown below (produced by "git log
--full-history --name-status --parents --dense")

I know that commit 693a2 had the correct files, but 1e5e6 does not.
(It has an older version of the file).

So far, I've noticed  one file that has gone bad in this process, and
I'm worried that there may be others, so I would like to figure out
exactly what got changed how at each step of the process.

But I can't figure out how to tell git-log to tell me which files it
kept when merges occurred.

Any thoughts/tips/advice?

Thanks...

--wpd

commit 1e5e614e9d27902af6e1edb6ddbbca224acf3de2
693a25dc0dadfcc13786051fed9d066dac4e088c
6b1747651d06b69f96337633e785808422ed1754
Merge: 693a25d 6b17476
Author: Shawn Kelly <skkelly@mit.edu>
Date:   Fri Mar 25 14:39:01 2011 -0400

    Merge branch 'master' of skkbri2:bri2

commit 693a25dc0dadfcc13786051fed9d066dac4e088c
8da5a19daa298f87307d168c82b8b023bfe2ac58
63252fcde7ee61c06e65cd8036cec8e73d529f1c
Merge: 8da5a19 63252fc
Author: Shawn Kelly <skkelly@mit.edu>
Date:   Fri Mar 25 14:36:02 2011 -0400

    layout merge

commit 6b1747651d06b69f96337633e785808422ed1754
63252fcde7ee61c06e65cd8036cec8e73d529f1c
Author: Shawn Kelly <skkelly@mit.edu>
Date:   Wed Mar 23 19:12:27 2011 -0400

    acwtgtvss1a

A       oalib/bri2/acwtgtvss1a/constraint/hierDesign.oa
A       oalib/bri2/acwtgtvss1a/constraint/master.tag
A       oalib/bri2/acwtgtvss1a/constraint/prop.cfg
A       oalib/bri2/acwtgtvss1a/layout/layout.oa
A       oalib/bri2/acwtgtvss1a/layout/master.tag
A       oalib/bri2/acwtgtvss1a/symbol/master.tag
A       oalib/bri2/acwtgtvss1a/symbol/symbol.oa

commit 63252fcde7ee61c06e65cd8036cec8e73d529f1c
dbe78c36bd1440ad537c8e55c915cb30073cbf54
18245190b4ae4c21a301d58a02d7c1d969a7700b
Merge: dbe78c3 1824519
Author: Shawn Kelly <skkelly@mit.edu>
Date:   Wed Mar 23 18:59:33 2011 -0400

    Merge branch 'master' of wfebri2:bri2

commit 8da5a19daa298f87307d168c82b8b023bfe2ac58
25316a8ef872508934a68916c27bc1e17dcdbe0e
Author: Shawn Kelly <skkelly@mit.edu>
Date:   Wed Mar 23 18:57:06 2011 -0400
