From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.1 (a.k.a. quilt for git)
Date: Tue, 28 Jun 2005 11:03:12 +0100
Message-ID: <tnxwtoeiysf.fsf@arm.com>
References: <tnxy899zzu7.fsf@arm.com> <20050623175848.1cf41a52.pj@sgi.com>
	<tnxd5qc6s5o.fsf@arm.com> <20050624034743.6c3bdae4.pj@sgi.com>
	<tnxhdfo56yd.fsf@arm.com> <20050624045627.6e9cbaff.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 11:59:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnCrU-0001PA-Ql
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 11:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVF1KFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 06:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbVF1KFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 06:05:25 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:7332 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S261169AbVF1KFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2005 06:05:18 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j5SA4f6i010058;
	Tue, 28 Jun 2005 11:04:41 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA06169;
	Tue, 28 Jun 2005 11:05:08 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 28 Jun 2005 11:03:27 +0100
To: Paul Jackson <pj@sgi.com>
In-Reply-To: <20050624045627.6e9cbaff.pj@sgi.com> (Paul Jackson's message of
 "Fri, 24 Jun 2005 04:56:27 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 28 Jun 2005 10:03:27.0923 (UTC) FILETIME=[A1449830:01C57BC8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>> there is no way to modify the log history.
>
> Aha.  If that means what I think it does, then I suspect I will remain
> with quilt.  The per-patch comment is often about the last thing that
> I put in the patch.

OK, you convinced me :-). I will upload a new StGIT version tonight. I
removed the 'commit' command completely. To add changes into the
repository, you would use the 'refresh' command. There is only one git
commit object for each patch and they can be seen with tools like
cg-log on top of the stack base (i.e. the HEAD of the pulled tree).

There is no per-patch history anymore. The patch diff and information
(description, author name etc.) are indefinitely changeable via the
'refresh' command but only one commit with the latest information is
seen in the tree log for each patch.

To pull new changes from the master repository:

   stg pop -a
   cg-udpate (or whatever people use to pull and merge)
   stg push -a

The 'push' command re-bases all the commits corresponding to the StGIT
patches.

Does this make it closer to quilt in functionality?

-- 
Catalin
