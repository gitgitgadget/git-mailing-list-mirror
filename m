From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Random Git Issues/Wishlist
Date: Mon, 24 Jul 2006 11:19:01 +0100
Message-ID: <tnxirln5mqy.fsf@arm.com>
References: <20060722195502.GS13776@pasky.or.cz>
	<20060723042725.GA12306@spearce.org>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 24 12:19:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4xX0-0006tf-1Q
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 12:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWGXKTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 06:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGXKTL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 06:19:11 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:37523 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932096AbWGXKTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jul 2006 06:19:11 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.255.63])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id k6OAJ3Gf010797;
	Mon, 24 Jul 2006 11:19:03 +0100 (BST)
Received: from localhost.localdomain ([10.1.255.211]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0);
	 Mon, 24 Jul 2006 11:19:03 +0100
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060723042725.GA12306@spearce.org> (Shawn Pearce's message of
 "Sun, 23 Jul 2006 00:27:25 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 24 Jul 2006 10:19:03.0006 (UTC) FILETIME=[96232FE0:01C6AF0A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24137>

Shawn Pearce <spearce@spearce.org> wrote:
> Petr Baudis <pasky@suse.cz> wrote:
>>   (viii) Patches versioning in StGit - many people I've told about StGit
>> complained that it doesn't version patches (and possibly moved to mq?).
>> We should have some scheme for doing meta-history (especially
>> interesting when/if we aim to make altering history easy).
>
> Doesn't StGit now have a single ref for every patch commit?

Yes, it does and the history is lost.

> What about turning on reflog support on those refs and reading the
> reflog for the ``history'' of that patch?  Granted the reflog isn't
> prune proof but it is a history of that ref's values over time.

That's a good idea indeed (I haven't noticed this feature). Anyway, I
don't see any problem with not being prune-safe. I wouldn't want to
preserve the refresh history of a patch forever. If I have a stable
series I want to keep, I either clone it or simply tag it.

I think that people willing to keep the patch history for a number of
years (and be prune-safe) should use topic branches rather than
StGIT. Patches are meant to be more lightweight than topic branches
and might have a shorter life-time. There were some people at the OLS
BOF session even mentioning that they don't care about long-term
history.

The StGIT feature wish-list after the OLS is:

- patch history (I'll probably use reflogs as you suggested)
- configurable pull command (currently uses git-pull only)
- commit directly to a patch which is not top
- patch synchronisation between between branches (as some people,
  including me have the same patches based on different branches and
  they have scripts for moving the changes in one to the others)
- document the workflow on the StGIT wiki
- maybe a separate undo command rather than passing a --undo option to
  push and refresh

-- 
Catalin
