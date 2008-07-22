From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix update-index --refresh for submodules if stat(2)
 returns st_size 0
Date: Tue, 22 Jul 2008 18:59:47 +0200
Message-ID: <48861203.80106@viscovery.net>
References: <20080721173511.GB5387@steel.home> <4885897C.8010401@viscovery.net> <20080722164604.GA3766@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 19:00:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLLEJ-0006hI-9E
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 19:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbYGVQ7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbYGVQ7v
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:59:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33236 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYGVQ7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:59:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLLDH-0004nR-N8; Tue, 22 Jul 2008 18:59:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 72F986D9; Tue, 22 Jul 2008 18:59:47 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080722164604.GA3766@blimp.local>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89501>

Alex Riesen schrieb:
> Johannes Sixt, Tue, Jul 22, 2008 09:17:16 +0200:
>> Alex Riesen schrieb:
>>> +	if ((changed & DATA_CHANGED) && (ce->ce_size != 0 || S_ISGITLINK(ce->ce_mode)))
>> Does this mean that ce->ce_size is non-zero for gitlinks, at least on
>> Unix?
> 
> It is non-zero for directories (which is what gitlinks are in working
> directories) on UNIX operating systems I met.
> 
>> Is this value useful in anyway?
> 
> Sometimes it is (the size a directory takes on storage)

Sure; but is ce->ce_size of gitlinks useful?

-- Hannes
