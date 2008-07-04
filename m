From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Cherry picking instead of merges.
Date: Fri, 04 Jul 2008 08:36:34 +0200
Message-ID: <486DC4F2.70608@viscovery.net>
References: <20080703182650.GA11166@old.davidb.org> <alpine.LFD.1.10.0807031403380.2815@woody.linux-foundation.org> <20080703223949.GA23092@old.davidb.org> <20080704001003.GA19053@atjola.homenet> <20080704044032.GA4445@old.davidb.org> <alpine.LFD.1.10.0807032221190.2815@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-1?Q?Bj=F6r?= =?ISO-8859-1?Q?n_Steinbrink?= 
	<B.Steinbrink@gmx.de>, git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 08:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEevK-0000A4-Ot
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 08:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbYGDGgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 02:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954AbYGDGgl
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 02:36:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42198 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbYGDGgk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 02:36:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KEeuJ-0006pG-CV; Fri, 04 Jul 2008 08:36:36 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E08586D9; Fri,  4 Jul 2008 08:36:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LFD.1.10.0807032221190.2815@woody.linux-foundation.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87363>

Linus Torvalds schrieb:
> IOW, let's say that you really do bisect things down to a merge and cannot 
> see what the fault in that merge is, you can literally do
> 
> 	# create a test-branch with the 'remote' side of the merge
> 	git checkout -b test-branch merge^2
> 
> 	# rebase that remote side on top of the local side
> 	git rebase merge^
> 
> and now you've linearized the merge temporarily just to be able to bisect 
> in that temporary branch what the bad interaction is. But once you've 
> bisected it, the temporary branch is again just junk - there's no real 
> value in saving it, because once you know _why_ the bug happened, you're 
> just better off going back to the original history and just fixing it (and 
> documenting the bug through the fix, rather than by addign extra-ugly 
> history).

FWIW, the same thing in different words is written in section

"Why bisecting merge commits can be harder than bisecting linear history"

of Documentation/user-manual.txt.

-- Hannes
