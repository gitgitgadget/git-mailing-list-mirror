From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: [BUG] git checkout <branch> allowed with uncommitted changes
Date: Thu, 13 Oct 2011 18:32:28 +0200
Message-ID: <4E97129C.3090609@ira.uka.de>
References: <loom.20111013T094053-111@post.gmane.org>  <CACsJy8Dzy5-kOZAjwdx=ooUdnN0L2F3EiNQ7b==3AGQZYjEUXQ@mail.gmail.com>  <20111013145924.2113c142@ashu.dyn.rarus.ru>  <loom.20111013T130924-792@post.gmane.org> <4E96D819.20905@op5.se>  <loom.20111013T152144-60@post.gmane.org> <1318517194.4646.30.camel@centaur.lab.cmartin.tk> <loom.20111013T171530-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: arQon <arqon@gmx.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 18:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REOCa-0001TQ-9C
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 18:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130Ab1JMQcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 12:32:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57899 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751086Ab1JMQcG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 12:32:06 -0400
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1REOCM-0007mr-UB; Thu, 13 Oct 2011 18:32:04 +0200
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1REOCM-0002fL-ML; Thu, 13 Oct 2011 18:31:58 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.22) Gecko/20110907 SUSE/3.1.14 Thunderbird/3.1.14
In-Reply-To: <loom.20111013T171530-970@post.gmane.org>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1318523524.259577000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183496>

On 13.10.2011 17:53, arQon wrote:
>> git st
> # On branch foo
> # Changes not staged for commit:
> #   (use "git add<file>..." to update what will be committed)
> #   (use "git checkout --<file>..." to discard changes in working directory)
> #
> #       modified:   file1.txt
> #
> no changes added to commit (use "git add" and/or "git commit -a")
>
> What makes this really interesting though is this: I tried to switch to
> master to see if that gave the same warning, and NOW, I get the correct
> error.
>
>> git co master
> error: Your local changes to the following files would be overwritten by
> checkout:
>          file1.txt
> Please, commit your changes or stash them before you can switch branches.
> Aborting

At the end of your example (in a previous email) you were on branch 
master, now in the beginning you are on foo. So you at least changed 
branch again inbetween. maybe you also committed something? Check out 
git log or gitk

I tried your example and I can checkout master and foo again and again 
and I never see the error message.

> Lucky you. :P  The most likely reason for me is, I'm working on something
> and I get interrupted and have to switch. Since the code may well not even
> compile at this point, the last thing I want to do is commit it. git's
> ability for that commit to be local is half the reason I'm trying to switch
> to it. (I'm not particularly keen on having to commit broken code to even a
> local repo, but that's still a hell of a lot better than having it pushed
> upstream as well).

As Alexey already said, just commit and later amend. Or stash. Git 
encourages you to commit small changes you can put a name to. You never 
should delay a commit because it produces unworkable code. Instead have 
a master branch (or branches) that always compiles and branches for the 
unfinished stuff. Then it won't matter if some branch is only half working.
