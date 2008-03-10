From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Mon, 10 Mar 2008 10:28:53 +0100
Message-ID: <47D4FF55.8020909@viscovery.net>
References: <200803041459.29000.michal.rokos@nextsoft.cz> <47CD78C9.80003@viscovery.net> <200803100959.43611.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <michal.rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Mon Mar 10 10:30:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYeKX-0000Om-1a
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 10:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbYCJJ25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 05:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbYCJJ25
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 05:28:57 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32681 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYCJJ25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 05:28:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JYeIl-0006Mv-Gy; Mon, 10 Mar 2008 10:28:11 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C70CF546; Mon, 10 Mar 2008 10:28:53 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200803100959.43611.michal.rokos@nextsoft.cz>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76709>

Michal Rokos schrieb:
> Hello,
> 
> I've managed to run testcase on
> Tru64 OSF1 <hostname> V5.1 2650 alpha
> and it returns
> case1: 0
> case2: 4
> case3: 5
> case4: 5
> which is sad since our vsnprintf() cannot detect this ill behaviour.

Ugh! We'd need to run the loop until we get a return value that is not
negative and less than the size specified...

-- Hannes
