From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git rebase +
Date: Thu, 13 Oct 2011 15:21:37 +0200
Message-ID: <4E96E5E1.7010103@viscovery.net>
References: <loom.20111013T134405-495@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Piatyszek <ediap@wp.pl>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:21:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELEM-0003Xv-EP
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755118Ab1JMNVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:21:40 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:9589 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab1JMNVi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:21:38 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RELE9-0008S1-Km; Thu, 13 Oct 2011 15:21:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 643471660F;
	Thu, 13 Oct 2011 15:21:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <loom.20111013T134405-495@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183481>

Am 10/13/2011 13:48, schrieb Adam Piatyszek:
> In the middle of "git rebase --continue" process I hit Ctrl+C today to break
> this operation. When I tried to replay the same command it errors out with the 
> following problem:
> /project/dfttools/libexec/git-core/git-rebase--interactive: line 650: 
> /home/ediap/project.git/.git/rebase-merge/author-script: No such file or 
> directory
> 
> Is this an expected behavior?

Hitting Ctrl-C during git-rebase results undefined behavior. git-rebase is
a shell script and was never designed to operate in any form of atomicity.

You should have let it run until it stopped. Then you could have said 'git
rebase --abort' (if it didn't complete) or 'git reset --hard ORIG_HEAD'
(if it completed).

-- Hannes
