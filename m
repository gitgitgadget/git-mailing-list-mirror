From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [StGit] How do I get colored diff output?
Date: Fri, 31 Aug 2007 16:14:49 +0100
Message-ID: <tnxveavviqe.fsf@arm.com>
References: <20070830123222.GG5050@xp.machine.xx> <tnx3ay1w40p.fsf@arm.com>
	<fb6sst$6rt$2@sea.gmane.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 17:15:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR8DR-0005Lx-MV
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 17:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504AbXHaPOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 11:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757486AbXHaPOz
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 11:14:55 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:43212 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757471AbXHaPOy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 11:14:54 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id l7VFEpbI027993;
	Fri, 31 Aug 2007 16:14:51 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 31 Aug 2007 16:14:50 +0100
In-Reply-To: <fb6sst$6rt$2@sea.gmane.org> (Jakub Narebski's message of "Thu,
 30 Aug 2007 18:57:04 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 31 Aug 2007 15:14:50.0900 (UTC) FILETIME=[AD2E2540:01C7EBE1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57171>

Jakub Narebski <jnareb@gmail.com> wrote:
> Catalin Marinas wrote:
>
>> I now tried the example stgit.pager option and it looks bad indeed. In
>> the meantime, there is a diffcol.sh script in the contrib directory, I
>> use this instead and it looks much nicer.
>
> That means it should be not removed even though git-diff learned
> --color...

It looks nicer than "filterdiff | colordiff" (and probably pretty
similar to the git-diff --color output).

It shouldn't be removed yet because there is no support in StGIT to
pass these options automatically. Since StGIT uses git-diff-tree/index
directly, always passing the --color option to these tools is not
feasible as they cannot detect whether the output is tty or file. This
functionality is currently handled by the pydoc.pager function.

Using git-diff would require a bit of work as well since StGIT first
captures the output and displays it afterwards via pydoc.pager. We
might change this at some point since GIT now has proper support for
PAGER.

-- 
Catalin
