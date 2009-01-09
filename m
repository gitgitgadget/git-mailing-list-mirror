From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 09 Jan 2009 11:09:08 +0100
Message-ID: <49672244.80200@viscovery.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090109083836.GB21389@coredump.intra.peff.net> <20090109092250.GA1809@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLEKI-0007vG-BC
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 11:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754423AbZAIKJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 05:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884AbZAIKJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:09:26 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:12404 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751713AbZAIKJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 05:09:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LLEIq-0006xY-N1; Fri, 09 Jan 2009 11:09:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 071884FB; Fri,  9 Jan 2009 11:09:19 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090109092250.GA1809@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104997>

Jeff King schrieb:
> Below is a patch that uses the three-process mechanism, and it fixes the
> problem. _But_ it is not satisfactory for inclusion, because it won't
> work on MINGW32. Since it is actually splitting git into two processes
> (one to monitor the pager and one to actually run git), it uses fork.

We have start_async()/finish_async() to replace a fork() of the sort that
we have here.

> IOW, I think
> the breakage you are seeing has always been broken on MINGW32.

Indeed. Hitting Ctrl-C while the pager was open has messed up the console
since day 1.

-- Hannes
