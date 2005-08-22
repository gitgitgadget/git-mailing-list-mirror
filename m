From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Pushing back to shared repo with a different named branch
Date: Mon, 22 Aug 2005 13:59:10 +1200
Message-ID: <46a038f9050821185965869612@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Aug 23 01:05:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7LKh-0000vT-0s
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 01:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVHVXC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 19:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVHVXC5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 19:02:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:32143 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751315AbVHVXCz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 19:02:55 -0400
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.203])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id j7M20Ana000591
	for <git@vger.kernel.org>; Sun, 21 Aug 2005 19:00:11 -0700
Received: by rproxy.gmail.com with SMTP id i8so866021rne
        for <git@vger.kernel.org>; Sun, 21 Aug 2005 18:59:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MlSc3XN5T1dZL6WzRHztzl+S8mcSExPwsAmbdOY5P4hsSJ0zKTGDAo2BWUhwIx0xUFrYh3P5DOO+ST+CR2Er/P85iJF40SREDT2ViNQe47OWP2rDRz5C8NKphxILHu9o2FLM/y6qBQqBpNCPpZrvrynD5R4DdtOJsuZuoQbhmVg=
Received: by 10.38.97.69 with SMTP id u69mr551718rnb;
        Sun, 21 Aug 2005 18:59:10 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Sun, 21 Aug 2005 18:59:10 -0700 (PDT)
To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Following earlier discussions, I've setup a team repo where all
heads/branches are. We have many interrelated branches so it makes
sense to keep it all together. to work, we do single-branch checkouts
using ssh like:

cg-clone locke.catalyst.net.nz:/var/git/moodle.git#mdl-osc-ceed moodle-osc-ceed

now, after a few commits, I'm ready to push back onto the branch.
cg-push won't let me, and I kind of expected that. It says:

$ cg-push origin 
cg-push: pushing to a different head not supported yet

But git isn't playing ball either. What is the right incantation to
tell it to push origin to where it came from.

$ cat .git/branches/origin 
locke.catalyst.net.nz:/var/git/moodle.git#mdl-osc-ceed

git-push-script origin
error: remote ref 'refs/heads/master' is not a strict subset of local
ref 'refs/heads/master'.
error: remote ref 'refs/heads/origin' is not a strict subset of local
ref 'refs/heads/origin'.

I am not using the 'remotes' setup, because I want to avoid too much
setup of each repo/working copy. Is there a simple way of doing this?

cheers,


martin
