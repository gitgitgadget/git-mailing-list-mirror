From: Marc Mutz <marc@kdab.net>
Subject: rebaseing topic branch which has merges from master
Date: Tue, 14 Apr 2009 17:03:50 +0200
Message-ID: <gs28e1$ktn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 14 18:02:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltl5c-0003Li-7h
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 18:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbZDNQAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 12:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757454AbZDNQAI
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 12:00:08 -0400
Received: from main.gmane.org ([80.91.229.2]:53351 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757380AbZDNQAG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 12:00:06 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ltl3L-0004TW-01
	for git@vger.kernel.org; Tue, 14 Apr 2009 16:00:03 +0000
Received: from dialbs-213-023-007-034.static.arcor-ip.net ([213.23.7.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 16:00:02 +0000
Received: from marc by dialbs-213-023-007-034.static.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 16:00:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialbs-213-023-007-034.static.arcor-ip.net
User-Agent: KNode/0.10.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116543>

Hi,

I'd like to achieve the following:

---(BP)--- ....---(M1)---     ...    ---(M2)---   .... master
     \              \                     \
      \              \                     \
      (T1)---(T2)---(T3)---(T4)---(T5)---(T6)--- .... topic
 
 
                                   ||
                                   ||
                                   VV
 
 
---(BP)---....---(M1)---     ...    ---(M2)---   .... master
                   \                     \_____________
                    \                                  \
                   (T1)---(T2)---(T3)---(T4)---(T5)---(T6)--- .... topic

However, when I run
  git checkout topic
  git rebase M1
I get a conflict somewhere around a merge commit down the road, and when I
gitk to check where I am, I see master commits (M2, M2^) that have changed
their (sha1) name. That shouldn't happen, afaiu git, so what's wrong? Is
this simply not supported? Can I flatten the merge commits somehow before
rebasing?

Thanks,
Marc
