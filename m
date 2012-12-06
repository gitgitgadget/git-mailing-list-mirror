From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Thu, 6 Dec 2012 12:51:45 +0100 (CET)
Message-ID: <954603524.19440856.1354794705772.JavaMail.root@dewire.com>
References: <50C04255.8050209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 12:52:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgZzn-0002el-9H
	for gcvg-git-2@plane.gmane.org; Thu, 06 Dec 2012 12:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423347Ab2LFLvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2012 06:51:47 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:60386 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423208Ab2LFLvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2012 06:51:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 900B2825F7;
	Thu,  6 Dec 2012 12:51:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S9bmuGM-v8Pp; Thu,  6 Dec 2012 12:51:45 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id D3B5C825AD;
	Thu,  6 Dec 2012 12:51:45 +0100 (CET)
In-Reply-To: <50C04255.8050209@viscovery.net>
X-Originating-IP: [194.68.56.41]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Win)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211165>



----- Ursprungligt meddelande -----
> Am 12/5/2012 23:46, schrieb Robin Rosenberg:
> > - git status - when do we report a diff.
> > 	- After checkout we should probably not
> 
> Are you saying that it should be ignored that the index records a
> symbolic
> link, but the worktree contains a regular file and that the regular
> file
> does not even contain the value of the symbolic link (like it would
> in the
> core.symlinks=false case)?

Well we should have some notion of clean state. That could be handled
in more than one way. We could just ignore it, or compare the copy with
the content of the link target. The first is good enough for a proof-of
concept, but perhaps not as a solution since we don't have good other
means to check that the copy is stale.

-- robin
