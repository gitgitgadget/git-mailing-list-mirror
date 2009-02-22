From: Ingo Molnar <mingo@elte.hu>
Subject: git-grep: small suggestion, -w flag
Date: Sun, 22 Feb 2009 11:34:48 +0100
Message-ID: <20090222103448.GA32119@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 11:37:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbBi9-0007ia-6C
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 11:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbZBVKe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 05:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbZBVKe7
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 05:34:59 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45437 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234AbZBVKe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 05:34:58 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1LbBff-0004fL-Mo
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Sun, 22 Feb 2009 11:34:57 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 2373D3E2132; Sun, 22 Feb 2009 11:34:48 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx2: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110994>

Here's a stupid little git-grep suggestion.

I recently transitioned from the use of egrep to git-grep, and i 
like it very much (it nicely excludes build related files, 
etc.), but there's one small detail: the lack of the -w flag.

It's equivalent to this pattern:

   git grep '\<tick_length\>'

And it's the most common grep flag i (and i suspect many others) 
use, in addition to the (already supported) -l flag.

When grepping for symbols in a large repository (such as the 
Linux kernel) -w is very common and very useful - there's many 
similar symbols, variants of each other. I use it when seeing a 
symbol in an oops, etc.

While i realize that git-grep does not want to be a full grep 
replacement, there's a real usability difference between having 
to type:

   git grep '\<schedule\>'
   git grep -w schedule

(especially since backslash is a seldom used key during a normal 
workflow, so accessing it is often a small mental hickup.)

	Ingo
