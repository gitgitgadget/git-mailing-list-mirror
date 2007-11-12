From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 16:59:11 +0100
Message-ID: <4738784F.7010106@viscovery.net>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:59:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbhG-0007Y3-FU
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbXKLP7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbXKLP7P
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:59:15 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:36184 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495AbXKLP7O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:59:14 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrbgO-0002AS-W8; Mon, 12 Nov 2007 16:58:41 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C7CC554D; Mon, 12 Nov 2007 16:59:11 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64644>

Ping Yin schrieb:
> git status/commit just treats submodules as ordinary files when reporting status
> changes. However, one may also wonder how submodules change (the commits).
> 
> This commit teaches git status/commit to additionally show commit summary of
> user-cared (i.e. checked out) modified submodules since HEAD (or HEAD^ if
> --amend option is on). For submodules deleted or initially added, commit summary
> are not shown.

In general, I like the idea (as I've already pointed out).

But at this time git-commit is about to be made a builtin, and since your 
implementation contains a lot of non-portable constructs ($'', >&) and a new 
dependency on awk (and, hence, has little chances of being accepted), I 
suggest that you stay tuned, and implement this in the forth-coming 
builtin-commit.c.

> A configuration variable 'submodule.status' is used to turn this summary
> behaviour on or off (default off). Also --submodule and --no-submodule options
> are added.

There is already 'status.color', I suggest the configuration to become 
'status.submoduleSummary'.

-- Hannes
