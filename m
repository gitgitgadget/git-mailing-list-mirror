From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Merge conflicts as .rej .orig files
Date: Fri, 19 Aug 2005 09:27:56 +0100
Message-ID: <tnxmznepbzn.fsf@arm.com>
References: <46a038f9050818200625d64a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 19 10:32:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E62FP-0004O8-5W
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 10:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVHSI2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 04:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVHSI2n
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 04:28:43 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:16631 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932452AbVHSI2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 04:28:43 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7J8RZOU004046;
	Fri, 19 Aug 2005 09:27:35 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA09939;
	Fri, 19 Aug 2005 09:28:30 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 19 Aug 2005 09:28:29 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f9050818200625d64a12@mail.gmail.com> (Martin Langhoff's
 message of "Fri, 19 Aug 2005 15:06:14 +1200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 19 Aug 2005 08:28:29.0052 (UTC) FILETIME=[F9F4E3C0:01C5A497]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> After using arch for a while, I've gotten used to getting .rej and
> .orig files instead of big ugly conflict markers inside the file.
> Emacs has a nice 'diff' mode that is a boon when dealing with
> conflicts this way.
>
> Is there a way to convince cogito/git to leave reject files around?
> What utility is git using to do the merges? Or at least: where should
> I look?

You could have a look at StGIT as well. The tool you use for merges is
configurable via the stgitrc file (diff3 is used by default, which
leaves markers in the file). StGIT also leaves the 3 files involved in
the tree-way merge as <file>.{older,local,remote} for further
inspection.

If you prefer other tool than diff3, you can define it in the stgitrc
file. Two examples are given for emacs and xxdiff. You could also
write a small script which invokes diff3 by default and, if it fails,
run the emacs ediff-merge-files-with-ancestor function.

-- 
Catalin
