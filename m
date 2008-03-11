From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Is a given file known to git?
Date: Tue, 11 Mar 2008 08:38:36 +0100
Message-ID: <47D636FC.2060203@viscovery.net>
References: <47D6317D.7030700@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYz5L-0006Xe-I5
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYCKHik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbYCKHik
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:38:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36097 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbYCKHij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:38:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JYz3Z-0006iX-PR; Tue, 11 Mar 2008 08:37:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 97ED56EF; Tue, 11 Mar 2008 08:38:36 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47D6317D.7030700@melosgmbh.de>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76807>

Christoph Duelli schrieb:
> Given a repository and a path p to a file in it:
> Is it possible (how?) to detect (in a bash script) if the file pointed
> to by p is "known" to git?
> Something along the line:
> if `git knows p?
> then
> ...
> fi

For simplicity, I'll assume with "known to git" you mean whether the
current branch's tip has some content at the given path. Then you could write:

	if git rev-parse HEAD:"$p" >/dev/null 2>&1
	then
		# git knows about $p
	else
		# git does not know about $p
	fi

-- Hannes
