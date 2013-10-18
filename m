From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Fri, 18 Oct 2013 18:54:47 -0400
Message-ID: <201310182254.r9IMslOr003223@freeze.ariadne.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley>
	<xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com>
	<3401D1F36F134CDDB0881B196F79CB3A@PhilipOakley> <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com>
Cc: philipoakley@iee.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 00:54:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXIwY-0004kq-TI
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 00:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757472Ab3JRWyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 18:54:51 -0400
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:60023
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757376Ab3JRWyu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 18:54:50 -0400
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id emKW1m00227AodY59mupAN; Fri, 18 Oct 2013 22:54:49 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id emup1m00D1KKtkw3fmupBv; Fri, 18 Oct 2013 22:54:49 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9IMsm9x003224;
	Fri, 18 Oct 2013 18:54:48 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9IMslOr003223;
	Fri, 18 Oct 2013 18:54:47 -0400
In-reply-to: <xmqqr4bjy63y.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1382136889;
	bh=lziYOQBobz8qEJBpUDOg7c9AodT2tHnxNGNDW2Qd0Hc=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=MVmcMWF3/SDYvf70LQAsLzjPJGev1UFCVNoWt5sU82Pf3pT8qmOlzVkjHfD+ML8q5
	 KpBh8LlJub+zPi6m+oNuyLdyH+b2MdPL/grjdmtXrVRqZlGJLCWYE78BbtOv5fqLv3
	 2Bv3Jvqbuk+RkMV2KfsQ7C6qrmnPFaDr6dqBW3H8Okog4K6ACaRK7w1hPE2XFBLC2S
	 J78ZIFuOtWAun52dMYzZnvI3ZOvJrPyjTzlx/sriubiO36EZ3gj3qXIluWA5D4TIbX
	 tpZgow8P99XtLJiuBKrXlbyVsA/A0qacvIBVP3inCDL/ezjeqKmyUDpb+3rR83O9iH
	 SkY5O7Y1BkjxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236377>

> From: Junio C Hamano <gitster@pobox.com>

> It was unclear to me which part of our documentation needs updating
> and how, and that was (and still is) what I was primarily interested
> in finding out.

It seems to me that what is missing is a description of the
circumstances under which Git can be run.  With Subversion (the only
other source control system I know in detail), the working tree that
is operated on is at and below the cwd, and the working tree always
points to the repository.  (A subdirectory of a working tree is also a
valid working tree.)

With Git, it seems that the basic usage is that Git searches upward
from the cwd to find the top of the work tree, which is distinguished
by having a .git subdirectory.  The rules when the worktree is
detached are more complicated, and don't seem to be written in any
single place.

Dale
