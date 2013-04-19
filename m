From: Jed Brown <jed@59A2.org>
Subject: Find/prune local branches after upstream branch is deleted?
Date: Fri, 19 Apr 2013 12:11:38 -0500
Message-ID: <87ehe64f91.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:11:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTEqr-0004Lx-4i
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab3DSRLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:11:43 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:32832 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab3DSRLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:11:41 -0400
Received: by mail-ia0-f178.google.com with SMTP id j38so319061iad.9
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:subject:user-agent:date:message-id
         :mime-version:content-type;
        bh=3k1KQFrNS9ztVgedVjv40viYPbtySKIq4rG81cvtK6k=;
        b=i1n+SUl/z8XZUMKh+XEuqrLEDEf4MDDwBlUMh8MEZKYdOfkr3njTQcKaOKE11Mb3wC
         F7gcqlEknpndiTz7dDZVcwPijpt+evkQ1sVcltnr+LyHBWOiwtXqHtQ+8CYU7xuv8J2n
         tvCp59ZQOJT+RO5Hy+WQSrkeIgdTcwerL8szOL718FuAdb9QM/uLxzIAAHeNyZQhg+1e
         Fdrh7rTHG8DLtBQm4dZeoK2dPwMNCiJjGXlWalqo1rlGlXJaauMpKGwb02VEIZufrnhp
         iXf/WTEX7+MQSEYKFEPiAuHMMUc6CpLSASxZzDXFyjxwuWftYrP7j+4FCWhouB58rogy
         38tg==
X-Received: by 10.50.61.142 with SMTP id p14mr9650481igr.31.1366391500868;
        Fri, 19 Apr 2013 10:11:40 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPSA id qn10sm3588086igc.6.2013.04.19.10.11.39
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Apr 2013 10:11:40 -0700 (PDT)
User-Agent: Notmuch/0.15.2+78~g5404ac5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221780>

Consider this workflow:

$ git checkout -b my/branch
hack, commit, ...
$ git push -u origin my/branch

The branch gets reviewed, merged, and eventually deleted upstream.  The
remote tracking branch gets pruned via 'git fetch --prune' or 'git
remote prune', but that leaves my local branch with an upstream that has
been deleted.  Is there a good way to discover this so I can prune my
local branches?

$ git branch -vv
  my/branch        6d32ec0 [origin/my/branch] The commit message

I can script it, but this seems like a pretty common thing.
