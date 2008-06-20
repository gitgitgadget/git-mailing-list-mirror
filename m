From: Ingo Molnar <mingo@elte.hu>
Subject: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 10:20:34 +0200
Message-ID: <20080620082034.GA24913@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 10:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9bsQ-0007QH-Hj
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 10:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970AbYFTIUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 04:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYFTIUs
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 04:20:48 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47602 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804AbYFTIUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 04:20:46 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1K9brJ-0003Ny-28
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 10:20:45 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id E9CBB3E21DD; Fri, 20 Jun 2008 10:20:36 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85606>


A couple of stupid Git questions (using git-1.5.4.3-2.fc8).

Sometimes i want to see the reverse diff of a particular commit.

If i want to see the normal diff i do:

   git-log -1 -p 7def2be1

But generating the reverse diff does not work:

   git-log --reverse -1 -p 7def2be1

Because the '--reverse' here is the ordering of the revlist, not the 
direction of the patch itself. And that's OK, albeit slightly 
unintuitive.

So instead i do:

   git-diff --reverse 7def2be1..7def2be1^

I've got two observations / potential suggestions:

1) the SHA1 is duplicated above, is there a way to avoid it? Initially i 
   tried the obvious extension:

      git-diff --reverse 7def2be1..^

   But Git didnt recognize that as a valid commit range.

2) is there a way to pass something like --reversediff to git-log?

   [ time passes as i read the manpage - the final thing i do when
     every other measure fails ;-) ]

   Ah, there's "git-log -R" that would achieve this. 

   The situation still feels a tiny bit inconsistent to me, and that's 
   why my attempt to figure it out intuitively based on my existing 
   practices failed:

    a) -R is not recognized by git-diff (so i cannot just standardize 
       myself on -R and have to waste neurons on remembering the 
       distinction ;-)

    b) --reverse has different meaning in git-log and git-diff.

Perhaps one solution would be if -R was recognized by git-diff as the 
meaning of --reverse is an ABI. The extension to the sha1 range 
specifier would be nice as well, it feels intuitive to me.

Hm?

	Ingo
