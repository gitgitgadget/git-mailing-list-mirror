From: Andy Parkins <andyparkins@gmail.com>
Subject: Something wrong with next in main git repository?
Date: Fri, 7 Mar 2008 11:29:21 +0000
Message-ID: <200803071129.21551.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 12:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXamC-0006jC-8O
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 12:30:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161AbYCGL32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 06:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758035AbYCGL32
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 06:29:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:40406 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757856AbYCGL31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 06:29:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so4299239ugc.16
        for <git@vger.kernel.org>; Fri, 07 Mar 2008 03:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        bh=1+E2RbshXdW4C0fnTid9HejjX39Pk3MGu6MMepvKKDo=;
        b=DxwGHlCZqcs3JNRTgtSbD6pkFfPbDxjuKSeVmIDlj14X6XQZOn//7cvhrDIjV3px84LU6oxFQRSwLcyzDbtaembdZ32g697wwT25eTUeXxivGo7goPuxuM4ZbRNB14xv4640/IkXybGBk9AFW6MGhzzeiBOAS1XCX0FKf4Wlf34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=HYyqbJMK5kUoHMpl58apN4B5u9Bm0uUPhclgfkZd4mxxXWG7ojbdaD15eL/FFzadXMAd/04jX0XQczn8R2kufyObWJ4NT6Hznc8pcRuiLBNismmuqfUwMmA2m1IMyzHJivC4UbUPuqcYvwqeMg6ZE97ZC9b3J8EVVu1vUzGcB4g=
Received: by 10.78.137.7 with SMTP id k7mr3212588hud.68.1204889365724;
        Fri, 07 Mar 2008 03:29:25 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id z40sm1935365ikz.4.2008.03.07.03.29.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Mar 2008 03:29:24 -0800 (PST)
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76476>

Hello,

I've been keeping up with development only intermittently lately, and just got 
a warning from git fetch (in my git directory) that the update to my 'next' 
tracking branch was rejected as not being a fast forward.

I renamed my current up/next to up/oldnext and fetched the latest next, so I 
had up/oldnext and up/next to compare.  I'm probably concerned over nothing, 
but I can't find any mention of a rewind of next in the mailing list.

As far as I can tell a whole series of merges has just vanished.  For 
information:

 $ git rev-parse up/next up/oldnext
 0bdd7328c801101d752d0dfc9976a50651738897
 38fd5a1b23780381c3b6987c730f5ea3d8e1fc7f

 $ git merge-base up/next up/oldnext
 ef5b9d6e2286630bf8afb5bdf1c6e3356f3d50c7

Apart from all the merges that have vanished, some revisions have vanished too 
(vanished in the sense, they aren't on the branch any more).  i.e.

 $ git log --no-merges --pretty=oneline up/next..up/oldnext
 33369889 Revert "Support builtin aliases"
 3a569a00 Revert "parse_commit_buffer: don't parse invalid commits"
 1b1b2346 parse_commit_buffer: don't parse invalid commits
 f0a31f58 Avoid redundant declaration of missing_target()
  ... etc ...
 0edad442 adjust_shared_perm: chmod() only when needed.
 69a47520 Revert "pack-objects: use of version 3 delta is now optional."
 394737eb pack-objects: use of version 3 delta is now optional.

Have all these commits gone missing?  I'm certain that someone other than me 
would have noticed this sort of loss, so is it something I've done wrong or 
misunderstood?



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
