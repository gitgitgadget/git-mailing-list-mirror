From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What did I just fetch?
Date: Wed, 31 Jan 2007 14:15:49 +0100
Organization: At home
Message-ID: <epq4nl$ui7$1@sea.gmane.org>
References: <17856.37307.324767.617892@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 14:15:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCFIb-0003tE-LR
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 14:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933246AbXAaNOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 08:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933273AbXAaNOu
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 08:14:50 -0500
Received: from main.gmane.org ([80.91.229.2]:45236 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933246AbXAaNOr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 08:14:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCFIO-0007he-59
	for git@vger.kernel.org; Wed, 31 Jan 2007 14:14:40 +0100
Received: from host-81-190-29-4.torun.mm.pl ([81.190.29.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 14:14:40 +0100
Received: from jnareb by host-81-190-29-4.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 14:14:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-29-4.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38248>

Bill Lear wrote:

> When updating in cvs, I get a list of files changed by the update.
> 
> How can I do this in git when fetching into a bare repo?
> 
> % GIT_DIR=. git fetch git://source/project
> remote: Generating pack...
> remote: Done counting 18 objects.
> remote: Result has 10 objects.
> remote: Deltifying 10 objects.
> remote:  100% (10/10) done
> Unpacking 10 objects
> remote: Total 10, written 10 (delta 6), reused 7 (delta 3)
>  100% (10/10) done
You should have also something like below:
* refs/remotes/origin/master: fast forward to branch 'master' of git://source/project
  old..new: 1732a1f..73a2acc

> So, I'd like to see the files, perhaps the differences, etc.

 $ git diff --summary 1732a1f..73a2acc
 $ git diff --summary ORIG_HEAD..HEAD

Or, if you want to see the log instead:

 $ git log 1732a1f..73a2acc
 $ git log origin/master

By the way, you get summary automatically when doing pull, on merge
(but not on fast-forward, I think).
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
