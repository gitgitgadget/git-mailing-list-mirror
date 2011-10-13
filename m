From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 18:08:12 +0200
Message-ID: <4E970CEC.3000509@ira.uka.de>
References: <loom.20111013T094053-111@post.gmane.org> <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com> <20111013145924.2113c142@ashu.dyn.rarus.ru> <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se> <loom.20111013T152144-60@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 18:07:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RENp4-0002iv-Cc
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 18:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab1JMQHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 12:07:50 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:46655 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750873Ab1JMQHt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 12:07:49 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1RENot-0004vR-3z; Thu, 13 Oct 2011 18:07:48 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1RENos-0006ed-W6; Thu, 13 Oct 2011 18:07:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <loom.20111013T152144-60@post.gmane.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1318522068.274619000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183493>

On 13.10.2011 15:58, arQon wrote:
> Andreas Ericsson<ae<at>  op5.se>  writes:
>> there's no reason to refuse the branch change.
>> Partly because nothing will be lost
>
> Actually, this isn't true either, because of the second bug: doing a revert
> in branchA causes the changes in branchB to be lost. This can't possibly be
> the intended behavior: again, it completely violates the integrity of branches
> by allowing changes on one branch to impact a different branch.

I assume you mean revert through 'git checkout' and not through 'git 
revert'. Git uses a different philosphy. It works best with small 
commits and commits done often. It assumes that when you switch 
branches, you don't switch your brain as well and still know for what 
purpose you changed tr_font.cpp (and even if you forget you always can 
check with git diff).
It also reminds you that tr_font.cpp is changed when you switch branches 
(remember the "M tr_font.cpp" printed when you switched to another branch).
It assumes that when you use 'git checkout --' to wipe out changed files 
without committing them anywhere(!) that you have thought about it the 
same way you have thought about before deleting or overwriting any file 
in the file system. The same way you have thought about before deleting 
or overwriting an uncommitted file in svn.

What you term integrity of the branch is a model you made of the 
workings of svn that you now try to pin onto a different model.
