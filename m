From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] prevent checkout from creating branches that start with
 a   dash
Date: Wed, 02 Jul 2008 17:38:05 +0200
Message-ID: <486BA0DD.5030608@viscovery.net>
References: <20080702150128.GH26300@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 17:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE4QG-0002SJ-LR
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 17:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753649AbYGBPiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 11:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753129AbYGBPiK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 11:38:10 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5639 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbYGBPiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 11:38:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KE4PF-0005mV-QF; Wed, 02 Jul 2008 17:38:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8E3C24FB; Wed,  2 Jul 2008 17:38:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080702150128.GH26300@jukie.net>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87152>

Bart Trojanowski schrieb:
> It was previously possible to create a -f branch with git-checkout, which
> could not be used or deleted.
> 
>         $ git checkout -b -f master
>         Switched to a new branch "-f"

"-f" *is* a valid branch name and can be used and deleted:

$ git checkout -b -f next
Switched to a new branch "-f"
$ git checkout next
Switched to branch "next"
Your branch is ahead of the tracked remote branch 'origin/next' by 2 commits.
$ git checkout -- -f
Switched to branch "-f"
$ git checkout next
Switched to branch "next"
Your branch is ahead of the tracked remote branch 'origin/next' by 2 commits.
$ git branch -d -- -f
Deleted branch -f.

-- Hannes
