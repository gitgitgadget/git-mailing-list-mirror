From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat and fstat implementation based on Win32
 API
Date: Tue, 04 Sep 2007 13:28:25 +0200
Message-ID: <46DD4159.9060406@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com> <46DBBC1E.4010407@eudaptics.com> <46DBFA2A.7050003@trolltech.com> <Pine.LNX.4.64.0709031428080.28586@racer.site> <46DC5ED4.8050202@trolltech.com> <46DD0C16.70101@eudaptics.com> <46DD3153.8060805@trolltech.com> <46DD3943.8040403@eudaptics.com> <46DD3FC9.2020706@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 13:28:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISWaH-0003lw-U4
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 13:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbXIDL2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 07:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753010AbXIDL2e
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 07:28:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8816 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbXIDL2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 07:28:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ISWa6-00023n-ML; Tue, 04 Sep 2007 13:28:32 +0200
Received: from [192.168.1.42] (j6t.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3FB326B7; Tue,  4 Sep 2007 13:28:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46DD3FC9.2020706@trolltech.com>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.371, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57553>

Marius Storm-Olsen schrieb:
> Johannes Sixt said the following on 04.09.2007 12:53:
>> Marius Storm-Olsen schrieb:
>>> Johannes Sixt said the following on 04.09.2007 09:41:
>>> http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=f15974add93bdfa92775c77c00e7c65aefd42127 
>>
>>
>> Looks good, although you should now handle INVALID_HANDLE_VALUE at the 
>> beginning of git_fstat() like this:
> 
> Actually, that's already handled.

It's not a big deal: It's an unlikely code path, actually an indication of a 
coding error, so you can leave your version.

>> Ok, I just tested FileTimeToLocalFileTime() in a tight loop, and I can 
>> run it 100,000,000 times per second. So I'm confident that there won't 
>> be any noticable degradation with my proposed change.
> 
> Ok. I haven't done the performance test with Git yet, but we'll see. If 
> it's not noticeable, I'll add it to all the timestamps we have.

Ack.

-- Hannes
