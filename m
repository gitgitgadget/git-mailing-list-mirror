From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stg pop/push -a nitpick: not handling deleted files
Date: Fri, 15 Sep 2006 22:41:09 +0100
Message-ID: <tnxzmd03j0q.fsf@arm.com>
References: <450AE0AC.7060806@intel.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 23:41:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOLR9-0006Cn-T8
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 23:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWIOVlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWIOVlW
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 17:41:22 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:26868 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932294AbWIOVlV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 17:41:21 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k8FLfFvs003326;
	Fri, 15 Sep 2006 22:41:15 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Fri, 15 Sep 2006 22:41:14 +0100
To: Auke Kok <auke-jan.h.kok@intel.com>
In-Reply-To: <450AE0AC.7060806@intel.com> (Auke Kok's message of "Fri, 15
 Sep 2006 10:19:40 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Sep 2006 21:41:14.0539 (UTC) FILETIME=[AB2037B0:01C6D90F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27102>

Auke Kok <auke-jan.h.kok@intel.com> wrote:
> minor nitpick when working with a patch that deletes a file: stg does
> not handle the 'abandoned' file when popping all patches off -
> essentially it would have to put the file back over an abandoned file.
[...]
> $ stg pop -a
> Popping "all_git_versions.patch" - "all_copyright_update.patch"
> patches...fatal: Untracked working tree file
> 'drivers/net/e1000/LICENSE' would be overwritten by merge.
> stg pop: git-read-tree failed (local changes maybe?)

I don't think it's an StGIT-specific issue, git-read-tree failed to
switch the working tree from one commit to another because a file
would be overwritten. It is probably safer to fail in this situation.

-- 
Catalin
