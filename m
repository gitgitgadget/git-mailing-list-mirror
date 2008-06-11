From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-daemon on Windows?
Date: Wed, 11 Jun 2008 15:54:02 +0200
Message-ID: <484FD8FA.3060003@viscovery.net>
References: <63c5d3820806110551y69e895eeg4fde4bfdaf22bbf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Hoffman <chris.c.hoffman@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 16:01:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6Qo6-0002Zp-Mj
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 15:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbYFKNyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 09:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbYFKNyH
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 09:54:07 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38959 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbYFKNyG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 09:54:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K6Qm3-00074o-2J; Wed, 11 Jun 2008 15:54:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9A2216B7; Wed, 11 Jun 2008 15:54:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <63c5d3820806110551y69e895eeg4fde4bfdaf22bbf2@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84610>

Chris Hoffman schrieb:
> Is there a distribution of the git server for Windows, or am I totally
> missing the point of git?  Will a simple file share work, or do I have
> to worry about file locking and such (e.g., two people try to commit
> at the same time).

You are missing *some* point of git: Usually, everyone has his own
repository, hence, commits that happen concurrently won't be a problem.

But you must exchange your work, and for this it is common that everyone
in addition has a publically accessible (bare) repository. These you can
place on a normal file share. I do this all the time.

You *can* choose to have only a single (bare) repository that everyone
uses to exchange work. But then you do have to worry about concurrent
*pushes* that get in the way of each other. You have this problem no
matter which form of server you chose (file share, ssh, git daemon,
WebDAV). If you go this route, you need a policy how people publish their
work (eg. branch namespaces). msysgit and 4msysgit do it this way.

-- Hannes
