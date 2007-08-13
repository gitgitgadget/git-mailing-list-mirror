From: "David Tweed" <david.tweed@gmail.com>
Subject: gitk performance questions/issues
Date: Mon, 13 Aug 2007 10:48:54 +0100
Message-ID: <e1dab3980708130248g1cbab0cej18e260c8bfa2b315@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 11:49:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKWXv-0003wq-Nb
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 11:49:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S969736AbXHMJtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 05:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S971095AbXHMJs7
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 05:48:59 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:56324 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S971390AbXHMJs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 05:48:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1159189wxd
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 02:48:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i6HG+jRWppPS716ANCVPEImG5dYvpM7sRrLS8HQNPOvsAEhvhRy4ITzZLYNwBgJ4vT2PpxrM3E8+vjSFl+gp2FxkLk1PIit0Zk24FSbyNpbbL/yPn8cTyDf0bzIqoQhCYq4kgvNB6JxN6t2Cs8bSYpzoLrzxlDzL6ibG6TzdNZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WpcS/iNOuXQF83z8VORbvILpnLeorYxdggH5Z3CS3TK9zg0/nOeXpwWn76uFkaZfMfVjnLKSipuBlmzuz9lXfi5TrgxkYWQW9RHP/0MWyP1Tpf9Eys/zIneMRkxzCmnj2JcFfuw085rABSY+woFbg7P+5Vkijb1Hu8Oh/ygDjds=
Received: by 10.70.37.12 with SMTP id k12mr9246259wxk.1186998534750;
        Mon, 13 Aug 2007 02:48:54 -0700 (PDT)
Received: by 10.70.26.12 with HTTP; Mon, 13 Aug 2007 02:48:54 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55755>

Since the gitk is being discussed, I'd like to see if I'm
understanding correctly and hitting problems or just
not doing things correctly. (This is using a
self-compiled "git version 1.5.2.2".)

[Caveat: this is on a repository that is evolves using
my own scripts which mimic the git shell scripts in
calling the low-level programs. I'm 99.999% sure it's
generating a fully valid repo, but I might be missing
something. Actual generating script is at
http://www.personal.rdg.ac.uk/~sis05dst/chronoversion.htm
]

1.  With gitk --all -n 256 on my repo it consistently
takes 12s for the window to appear and 21s for the
"I'm working" cursor to change to a normal cursor.
This is on a dual Xeon machine, /proc/cpuinfo
excerpt

model name      :   Intel(R) Xeon(TM) CPU 3.00GHz
stepping        : 3
cpu MHz         : 2992.496
cache size      : 2048 KB

running x86-64 Fedora 7, packed repo has a 12M
.git dir. Is this the expected start-up time for such a
configuration? The output of
time git-rev-list --parents --topo-order --all>/dev/null
is

real    0m0.048s
user    0m0.044s
sys     0m0.005s

2. Startup time isn't an excessive problem. However,
I often don't seem to be getting the "diff with parent"
being displayed once I click on the another commit. If
I click on several in sequence I get the error
message

"error getting diffs: couldn't fork child process: not enough memory"

The diffs are relatively small (consecutive commits
are generated hourly automatically) and a command
line git-diff generates them instantly.

3. Is "gitk --all -n 256" the best way to say "show me
relatively recent stuff" or should I be using different
options for limiting things?

Many thanks for any insight,

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"we had no idea that when we added templates we were adding a Turing-
complete compile-time language." -- C++ standardisation committee
