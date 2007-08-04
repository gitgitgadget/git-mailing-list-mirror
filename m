From: David Kastrup <dak@gnu.org>
Subject: Re: Terminology question about remote branches.
Date: Sat, 04 Aug 2007 16:25:41 +0200
Message-ID: <85y7grfkbe.fsf@lola.goethe.zz>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz>
	<8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	<85k5sbh129.fsf@lola.goethe.zz>
	<8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com>
	<854pjfgzit.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:25:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKZf-0002V8-Nh
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761915AbXHDOZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760415AbXHDOZo
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:25:44 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:38750 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759767AbXHDOZo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 10:25:44 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 2E52E27ED9;
	Sat,  4 Aug 2007 16:25:43 +0200 (CEST)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 1E90528EE1B;
	Sat,  4 Aug 2007 16:25:43 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-037.pools.arcor-ip.net [84.61.10.37])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id D93668C465;
	Sat,  4 Aug 2007 16:25:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 037941C4F932; Sat,  4 Aug 2007 16:25:41 +0200 (CEST)
In-Reply-To: <854pjfgzit.fsf@lola.goethe.zz> (David Kastrup's message of "Sat\, 04 Aug 2007 16\:11\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3854/Sat Aug  4 06:49:48 2007 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54856>

David Kastrup <dak@gnu.org> writes:

> "Lars Hjemli" <hjemli@gmail.com> writes:
>
>>> > Was this helpful?
>>
>> Talking to myself: obviously not
>
> Disagree.  "Does this answer all questions and makes git's behavior
> perfectly transparent" -- no.  But let's not confuse "magical" with
> "helpful" here.

Ok, let's have another go.  Maybe I have understood more as compared
with last time.

git-branch/git-commit -b creates and manages local branches, nothing
else.  Local branches' defining feature is that they have a branch
head I can move around myself.

Then there are non-local branches.  Their defining feature is that
they have no locally moving branch head and _must_ track a remote
branch.

But local branches _also_ can track the progress/head of a remote
branch.  Since they have a locally moving branch head, this will often
lead to merge conflicts which must be resolved.

So this is more or less what I understand now.  There really is no
difference between "tracking" and "following" as I thought previously.
It is just that a local branch which happens to track a remote branch
is basically a remote tracking branch with a head of its own.

Which means it can get merge conflicts.  Can we get merge conflicts
with a remote tracking branch, too?  Namely when the remote branch
messed with its history, rebased/reverted stuff?

So that the real difference between a local and a remote tracking
branch is not that the latter tracks a remote branch (the former can
do that as well), but that the latter has no local branch head and
that saves us a lot (but not necessary all) merge conflicts?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
