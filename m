From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict   resolution.
Date: Tue, 12 Aug 2008 09:02:05 +0200
Message-ID: <48A1356D.6020200@viscovery.net>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org> <alpine.DEB.1.00.0808111218160.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811104006.GH32184@machine.or.cz> <alpine.DEB.1.00.0808111328590.24820@pacific.mpi-cbg.de.mpi-cbg.de> <48A0274D.8090504@viscovery.net> <alpine.DEB.1.00.0808111748220.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Abhijit Menon-Sen <ams@toroid.org>,
	git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 12 09:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSnuU-0004cw-Jm
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 09:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbYHLHCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 03:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbYHLHCM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 03:02:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:63453 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbYHLHCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 03:02:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KSntN-0000lj-S6; Tue, 12 Aug 2008 09:02:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7EA3AAFCC; Tue, 12 Aug 2008 09:02:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0808111748220.24820@pacific.mpi-cbg.de.mpi-cbg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92074>

Johannes Schindelin schrieb:
> On Mon, 11 Aug 2008, Johannes Sixt wrote:
>> If the reversal is part of a topic branch that you rebase at least once, 
>> then you want to have the resolutions recorded, don't you?
> 
> That is not the revert we are talking about.  The revert we are talking 
> about is a literal "git revert <commit>".  Not a replay of a commit (that 
> might have been a revert originally).

You are right. My example misses the point.

Another example is when you have to repeat the revert, say, you find out
you did it on the wrong branch. When you repeat the 'git revert' on the
correct branch, you want to have the resolutions replayed.

> I am a little worried that these reverts (being negative changes) could 
> interfer with the common operation: positive changes.  Although I haven't 
> been able to come up with a scenario where the recorded revert would 
> actively be wrong in a subsequent rebase/cherry-pick.

I think that your worries are not justified.  A 'git revert' is not a
"negative" change; it a change like any other. 'git revert' is just a
short hand for a more sequence of diff+apply+commit.

-- Hannes
