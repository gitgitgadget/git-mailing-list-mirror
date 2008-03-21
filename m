From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Path filtered history not maximally simplified
Date: Fri, 21 Mar 2008 14:49:09 +0100
Message-ID: <47E3BCD5.2070405@viscovery.net>
References: <47E3AE38.5060405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 14:49:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jchd4-0002Wf-7o
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 14:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbYCUNtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 09:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbYCUNtM
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 09:49:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17614 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbYCUNtL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 09:49:11 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JchbX-0003YM-7x
	for git@vger.kernel.org; Fri, 21 Mar 2008 14:48:19 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 275F0AFCC
	for <git@vger.kernel.org>; Fri, 21 Mar 2008 14:49:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47E3AE38.5060405@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77738>

Johannes Sixt schrieb:
> While investigating a path-filtered history in gitk, I noticed a layout
> like this:
> 
>      --A---------M--4--N
>         \       /     /
>          1--2--3-----5
> 
> There are no commits displayed on the upper line between A and M.
> Shouldn't this have been simplified to:
> 
>                   4--N
>                  /  /
>      --A--1--2--3--5

Ok, it turns out that M is an evil merge, i.e. the file in M is different
from both A and 3, but in such a way that it does not show up in a diff
--cc that has only 3 lines of context. In particular, one of the commits
1, 2, 3 added a single line at an isolated spot in the file, and I undid
that addition in the merge commit M.

Sorry for the noise.

-- Hannes

(So, *that's* why they are called "evil"!)
