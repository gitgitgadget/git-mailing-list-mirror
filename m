From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merge-Recursive Improvements
Date: Wed, 13 Feb 2008 08:39:43 +0100
Message-ID: <47B29EBF.7060607@viscovery.net>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Voltage Spike <voltspike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 08:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPCES-0002nD-Og
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 08:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbYBMHjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 02:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbYBMHjr
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 02:39:47 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10118 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbYBMHjq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 02:39:46 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JPCD9-0006p0-RL; Wed, 13 Feb 2008 08:39:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 03D4E69F; Wed, 13 Feb 2008 08:39:44 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73746>

Voltage Spike schrieb:
> Third, git doesn't appear to have any sense of context when performing a
> merge. Another contrived example which wouldn't be flagged as a merge
> conflict:
> 
>   ptr = malloc(len); // Added in HEAD.
>   init();            // Included in merge-base.
>   ptr = malloc(len); // Added in "merge".

You seem to say that you want this to result in a merge conflict.

I'm opposed to this: It means that you would mark a conflict if there is a
single unchanged line between the two changes that come from the merged
branches. So far it has happened for me much more frequently that such
merges were correct, and I should not be bothered with conflict markers. I
conciously prefer to pay the price that such a merge is incorrect on occasion.

You also need to draw a border line: a single unchanged line between the
changes? Or better also conflict at 2 lines? Or 3?

-- Hannes
