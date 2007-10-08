From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Trying to use git-filter-branch to compress history by removing
   large, obsolete binary files
Date: Mon, 08 Oct 2007 08:22:42 +0200
Message-ID: <4709CCB2.4000202@viscovery.net>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <Pine.LNX.4.64.0710080018270.4174@racer.site> <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com> <Pine.LNX.4.64.0710080028301.4174@racer.site> <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com> <Pine.LNX.4.64.0710080129480.4174@racer.site> <20071008010033.GA25654@fieldses.org> <Pine.LNX.4.64.0710080204140.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 08:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iem12-0004sI-6l
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 08:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbXJHGWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 02:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXJHGWr
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 02:22:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24628 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbXJHGWq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 02:22:46 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iem0j-0005So-Fc; Mon, 08 Oct 2007 08:22:37 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7455554D; Mon,  8 Oct 2007 08:22:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0710080204140.4174@racer.site>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60294>

Johannes Schindelin schrieb:
> The rationale was this: filter-branch recently learnt how to rewrite many 
> branches, and it might be tedious to find out which ones.  But then, there 
> is git log --no-walk --all, so maybe I really should get rid of 
> refs/original/*?
> 
> I'd like to have some comments from the heavier filter-branch users on 
> that...

IMHO, a backup of the original refs is needed. However, it may be wise to 
store them in the refs/heads namespace so that 'git branch -d' can delete 
them and 'git branch -m' can move them back if something went wrong.

-- Hannes
