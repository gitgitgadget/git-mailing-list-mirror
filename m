From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 11:47:43 +0100
Message-ID: <tnx3bo59tm8.fsf@arm.com>
References: <20050916101138.99906352682@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 12:49:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGDlY-0006Zb-RT
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 12:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965293AbVIPKsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 06:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbVIPKsL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 06:48:11 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:36228 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S965293AbVIPKsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 06:48:09 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j8GAlhSV027477;
	Fri, 16 Sep 2005 11:47:43 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch1.emea.arm.com [10.1.255.57])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA07350;
	Fri, 16 Sep 2005 11:47:50 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.140]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 16 Sep 2005 11:47:49 +0100
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050916101138.99906352682@atlas.denx.de> (Wolfgang Denk's
 message of "Fri, 16 Sep 2005 12:11:38 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 16 Sep 2005 10:47:49.0681 (UTC) FILETIME=[14D8A210:01C5BAAC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8675>

Wolfgang Denk <wd@denx.de> wrote:
> -> git-fsck-cache --unreachable $(cat .git/HEAD .git/refs/heads/*)
> unreachable commit 08cf4121ad704faa5ae7c7ae7b3dca4476ef2770
> unreachable tree 29a4c18afd958cc6cee938f0fe7fa59764418097
> unreachable tree 3b722a7278e02b272ddc8aefbc7be22703d8a94f
> unreachable tree 4ebc50d240d99b4236952d13d5044691f9078e3c
> unreachable tree 63af5944e130b449338cc907ee77c51f4a69e339
> unreachable tree 79c9a6bb02a80df15c7d829bdac0901f88c5e301
> unreachable blob 85dcf4b5c4c0f6833cd63fa1d0fd29ef250162af
> unreachable commit c1b779fbce762c970e3ace4332bb6ddc0de65e61
> unreachable blob d70d1d44f12db7b2a3976c2a5313c90568a62c25
> unreachable commit e1bcd2a5d53bceef2679737474487e32d87e7f2c
>
> I have to admit that I don't know what to do next...
>
> a) I understand that these  messages  are  indications  of  problems,
>    right? What can I do to clean this up?
>
> b) Is there any way to find out what I did wrong in the first place?

Did you use StGIT on your tree? StGIT can leave unreachable
objects. Otherwise, git-prune should remove them.

Note that if you use StGIT, git-prune will also remove the commit
objects for the patches which are not pushed onto the stack. I will
add a 'stg prune' commands which takes care of these.

-- 
Catalin
