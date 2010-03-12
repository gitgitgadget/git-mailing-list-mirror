From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How do you switch branches in a bare repo?
Date: Fri, 12 Mar 2010 07:57:33 +0100
Message-ID: <4B99E5DD.3020005@viscovery.net>
References: <4B99DEA2.6050104@uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adam Nielsen <adam.nielsen@uq.edu.au>
X-From: git-owner@vger.kernel.org Fri Mar 12 07:57:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpyoY-0008VZ-7q
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 07:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab0CLG5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 01:57:38 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:10541 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab0CLG5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 01:57:37 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NpyoQ-0002GC-Fn; Fri, 12 Mar 2010 07:57:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3BE621660F;
	Fri, 12 Mar 2010 07:57:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B99DEA2.6050104@uq.edu.au>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142026>

Adam Nielsen schrieb:
> I want to remove some commits (with git reset) from a bare repo, but
> they're not in the master branch and I can't figure out how to change
> branches:
> 
> $ git checkout newbranch
> fatal: This operation must be run in a work tree
> 
> I've tried running the reset locally and pushing the change (with -f)
> but that doesn't work either, and Google isn't being much help.
> 
> How do you switch between branches in a bare repo?

You don't have to. This should work:

   git push -f . newbranch~2:newbranch

will remove the last two commits at the tip of 'newbranch'.

Of course, you can do the push from any other repository as long as you
are allowed to do non-fast-forward pushes into the bare repository.

-- Hannes
