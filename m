From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-archive for files changed in revision range
Date: Wed, 13 Feb 2008 14:43:23 +0100
Message-ID: <47B2F3FB.3020600@viscovery.net>
References: <20080213130304.GA19957@grahamcox.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graham Cox <graham@grahamcox.co.uk>
X-From: git-owner@vger.kernel.org Wed Feb 13 14:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPHu9-0003iQ-3b
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 14:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658AbYBMNn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 08:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753568AbYBMNn1
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 08:43:27 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35919 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359AbYBMNn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 08:43:26 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JPHt4-0000x2-Sh; Wed, 13 Feb 2008 14:42:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4A86B69F; Wed, 13 Feb 2008 14:43:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080213130304.GA19957@grahamcox.co.uk>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73792>

Graham Cox schrieb:
> The command line I used was something like (This is mostly from memory):
> git-archive --format=zip . `git-whatchanged <start>..HEAD --pretty=oneline 
>   | grep '^:' | sed 's/^.*\t//'` > release.zip
> 
> To produce a zip containing all of the modified and added files for the 
> revision range <start>..HEAD.

git diff-tree -r --name-only -z <start> HEAD | \
    xargs -0 git archive --format=zip HEAD > release.zip

-- Hannes
