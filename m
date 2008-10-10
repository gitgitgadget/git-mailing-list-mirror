From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: tip tree clone fail
Date: Fri, 10 Oct 2008 10:56:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0810101046260.3271@apollo>
References: <48EEA714.4010205@cn.fujitsu.com> <20081010072951.GB16016@elte.hu> <20081010083720.GA32069@elte.hu> <alpine.LFD.2.00.0810101040200.3271@apollo> <48EF14FC.1000801@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>,
	FNST-Lai Jiangshan <laijs@cn.fujitsu.com>,
	FJ-KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Wang Chen <wangchen@cn.fujitsu.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 11:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoDtQ-0000pr-3G
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 11:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755748AbYJJJBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbYJJJBX
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 05:01:23 -0400
Received: from www.tglx.de ([62.245.132.106]:33277 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbYJJJBW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 05:01:22 -0400
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id m9A8uk3W024109
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Oct 2008 10:56:47 +0200
In-Reply-To: <48EF14FC.1000801@cn.fujitsu.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Virus-Scanned: ClamAV 0.93.2/8404/Fri Oct 10 03:44:04 2008 on www.tglx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.4 required=5.0 tests=ALL_TRUSTED,AWL
	autolearn=failed version=3.2.4
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on www.tglx.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97917>

On Fri, 10 Oct 2008, Wang Chen wrote:
> Thomas Gleixner said the following on 2008-10-10 16:40:
> > On Fri, 10 Oct 2008, Ingo Molnar wrote:
> > 
> >> Cc:-ed Thomas too - Thomas just ran a clean git clone and that succeeded 
> >> for him, both over the http and over the git protocols.
> > 
> > No, I did ssh and git. Will start a http one now.
> 
> OK. I will wait.
> Thanks, Thomas :)

git clone http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git 

fails here as well. 

Getting pack 7c461fa5d92f9e047ae07b70eb30828a63a803f5
 which contains 874e848aefc2d5952b00593c9fd23d748259eec7
walk 874e848aefc2d5952b00593c9fd23d748259eec7
Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting pack list for http://www.kernel.org/home/ftp/pub/scm/linux/kernel/git/sfr/linux-next.git/
error: Unable to find 85ba94ba0592296053f7f2846812173424afe1cb under http://www.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-tip.git
Cannot obtain needed object 85ba94ba0592296053f7f2846812173424afe1cb
while processing commit 874e848aefc2d5952b00593c9fd23d748259eec7.
fatal: Fetch failed.

The needed object 85ba94ba0592296053f7f2846812173424afe1cb is a commit
in linus tree.

So http transport is wreckaged. (git version 1.6.0.1 here, Wang is using
1.5.3.x)

Junio, can you please have a look ? I know it's http again, but we can
not sanitze the corporate firewall folks by any means.

Thanks,

	tglx
