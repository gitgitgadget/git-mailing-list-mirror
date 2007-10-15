From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] Fixing path quoting in git-rebase
Date: Mon, 15 Oct 2007 15:39:30 +0200
Message-ID: <47136D92.8060104@viscovery.net>
References: <4711486B.1050301@op5.se> <11924540292687-git-send-email-maillist@steelskies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Jonathan del Strother <jon.delStrother@bestbefore.tv>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 15:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQAh-00022x-7b
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 15:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758886AbXJONjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 09:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759083AbXJONjk
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 09:39:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8098 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756984AbXJONjj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 09:39:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhQAH-0004j0-5k; Mon, 15 Oct 2007 15:39:26 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C815769F; Mon, 15 Oct 2007 15:39:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11924540292687-git-send-email-maillist@steelskies.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60995>

Jonathan del Strother schrieb:
> -	eval GITHEAD_$hd='"$(cat $dotest/onto_name)"'
> +	eval GITHEAD_$hd='"$(cat \"$dotest/onto_name\")"'

I believe this is not correct. It should be this way:

	eval GITHEAD_$hd='$(cat "$dotest/onto_name")'

You can test it with a conflicting git-rebase -m. It only affects what the 
conflict markers look like. The test suite does not test it.

The rest looks good.

-- Hannes
