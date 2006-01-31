From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Bottlenecks in git merge
Date: Tue, 31 Jan 2006 22:33:14 +0100
Message-ID: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jan 31 22:55:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F43Ti-0001nR-49
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 22:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbWAaVzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWAaVzz
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 16:55:55 -0500
Received: from ebar091.ebar.dtu.dk ([192.38.93.106]:46465 "HELO
	ebar091.ebar.dtu.dk") by vger.kernel.org with SMTP id S1751553AbWAaVzz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 16:55:55 -0500
Received: (qmail 32319 invoked by uid 5842); 31 Jan 2006 21:33:14 -0000
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15353>

Hello, 

In connection with Ian Molton's question about merge have I played a
little with 'git merge' on the kernel sources.  What I find is that a
merge can take quite some time, but I'm not sure where that time exactly
goes to.  Here are the times I got:

Recursive (default):  4m22.282s
Resolve (-s resolve): 3m23.548s


What is taking so long?

Regards,

Peter


==============================>8==================
#!/bin/sh
#  Run from linux-2.6

change_readme() {
	sed -i "s/are much better/are better/" README
}

git checkout -f master
git branch -d test
git checkout -b test v2.6.12
change_readme
git commit -a -m "Work, work, work"
time git merge $STRATEGY "Merging happily." HEAD v2.6.15
