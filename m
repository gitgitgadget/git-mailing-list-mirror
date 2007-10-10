From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] exec_git_cmd: fix executing commands if path contains
 spaces
Date: Wed, 10 Oct 2007 08:16:56 +0200
Message-ID: <470C6E58.3080208@viscovery.net>
References: <470BB44B.3030500@viscovery.net> <11919659771056-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Oct 10 08:17:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfUsr-0004tI-Mc
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 08:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbXJJGQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 02:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752313AbXJJGQ7
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 02:16:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:17745 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbXJJGQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 02:16:58 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IfUsD-0004fx-HP; Wed, 10 Oct 2007 08:16:49 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4EB1B6B7; Wed, 10 Oct 2007 08:16:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <11919659771056-git-send-email-prohaska@zib.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60466>

Steffen Prohaska schrieb:
> Ok, this is what I created from the quick-fix. It works for
> me in msysgit. 
> 
> Should the patch be polished that it can be applied to git.git
> or will we only apply it to 4msysgit?

I'll apply it to mingw.git, and as long as you don't rebase or pull from 
there, you'd also have to apply it to 4msysgit.

git.git is a no-go at this time - compat/mingw.c doesn't exist, yet.

> If it should be polished, what would be the right way?
> ifdef in exec_cmd.c?

This area needs more polishing, and it will be among the *last* mingw 
patches that flow upstream.

BTW, I think the fix is incomplete anyway: We quote only argv[0], but 
actually all of argv should be quoted. Will test.

-- Hannes
