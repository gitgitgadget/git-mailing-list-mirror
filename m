From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: BUG: git pull --rebase on detatched head prints a lot of usage warnings
Date: Fri, 3 Dec 2010 19:38:54 +0100
Message-ID: <AANLkTimyCG6zVhc4znWPWwipd0bn-YT2FrOT=T0AgHNW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 19:39:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POaXc-0003Xi-Kd
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 19:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab0LCSj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 13:39:27 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37854 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0LCSj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 13:39:26 -0500
Received: by yxt3 with SMTP id 3so4450346yxt.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 10:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=1BEtDbyBkRhwXvy+DnSp6zHUwAp1kjPpjeUaaxtuE5I=;
        b=LcRAe2YGSUHkUj64KEEx7Nh0KviejLg+itHr7B0H7Jq9KvZqy1fkM/bocFSau+24ix
         WvrU1e82ioVSzAihb1fa06A8bpTGJrGWpfoXH4Kkq2EUNtTuMFn0lxdkY9SopWh6aSXh
         Xlz/WShZC73++YvJco9lMdZcP8CkVEv/EwubU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=iC1hdAOYRw1bjU0G/nUCrp8ZOP5GzR5Cr8ZlaV12XRoQ9RFTwSaywaCBhO1EonKR95
         1D5eODTnz1volGgUbMOMZlMRLqnz+jLGq6L8SJJFQa+N6L0dV1+2H7mwZ/swxu+OgA40
         QaGbJ2pWXACE2nWJnR6sufA46RmfAQglY2ofg=
Received: by 10.151.47.3 with SMTP id z3mr4250810ybj.131.1291401565695; Fri,
 03 Dec 2010 10:39:25 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Fri, 3 Dec 2010 10:38:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162823>

Heya,

sverre@laptop-sverre:~/code/Melange
$ git pull --rebase
usage: git merge-base [-a|--all] [--octopus] <commit> <commit>...
   or: git merge-base --independent <commit>...

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others

usage: git merge-base [-a|--all] [--octopus] <commit> <commit>...
   or: git merge-base --independent <commit>...

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others

usage: git merge-base [-a|--all] [--octopus] <commit> <commit>...
   or: git merge-base --independent <commit>...

    -a, --all             output all common ancestors
    --octopus             find ancestors for a single n-way merge
    --independent         list revs not reachable from others


[... many more snipped ...]

You are not currently on a branch, so I cannot use any
'branch.<branchname>.merge' in your configuration file.
Please specify which remote branch you want to use on the command
line and try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details.


There are 127 helpful messages in total.

Output with GIT_TRACE set:

trace: exec: 'git-pull' '--rebase'
trace: run_command: 'git-pull' '--rebase'
trace: built-in: git 'rev-parse' '--git-dir'
trace: built-in: git 'rev-parse' '--is-inside-work-tree'
trace: built-in: git 'rev-parse' '--show-toplevel'
trace: built-in: git 'ls-files' '-u'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'config' '--bool' 'branch..rebase'
trace: built-in: git 'rev-parse' '-q' '--verify' 'HEAD'
trace: built-in: git 'rev-parse' '--verify' 'HEAD'
trace: built-in: git 'update-index' '-q' '--ignore-submodules' '--refresh'
trace: built-in: git 'diff-files' '--quiet' '--ignore-submodules'
trace: built-in: git 'diff-index' '--cached' '--quiet'
'--ignore-submodules' 'HEAD' '--'
trace: built-in: git 'rev-parse' '-q' '--git-dir'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'config' '--get' 'branch..remote'
trace: built-in: git 'symbolic-ref' '-q' 'HEAD'
trace: built-in: git 'for-each-ref' '--format=%(upstream)'
trace: built-in: git 'rev-parse' '-q' '--verify' 'refs/remotes/origin/tip'
trace: built-in: git 'rev-list' '-g' 'refs/remotes/origin/tip'
trace: built-in: git 'merge-base' '927b640697cf707a8d3d26b39c926be052c3aa7c'
trace: built-in: git 'merge-base' '8281385d7b5132a51ae1f3ad515f0220478c7f40'

Tested on current next.

-- 
Cheers,

Sverre Rabbelier
