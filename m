From: worley@alum.mit.edu (Dale R. Worley)
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Fri, 18 Oct 2013 18:25:04 -0400
Message-ID: <201310182225.r9IMP4i3002659@freeze.ariadne.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<201310171909.r9HJ9mxd007908@freeze.ariadne.com> <xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 00:32:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXIag-0008A8-01
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 00:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757428Ab3JRWcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 18:32:14 -0400
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:38866
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757418Ab3JRWcN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Oct 2013 18:32:13 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Oct 2013 18:32:13 EDT
Received: from omta19.westchester.pa.mail.comcast.net ([76.96.62.98])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id eati1m00627AodY5CmR5z7; Fri, 18 Oct 2013 22:25:05 +0000
Received: from freeze.ariadne.com ([24.34.72.61])
	by omta19.westchester.pa.mail.comcast.net with comcast
	id emR51m00Y1KKtkw3fmR5qz; Fri, 18 Oct 2013 22:25:05 +0000
Received: from freeze.ariadne.com (freeze.ariadne.com [127.0.0.1])
	by freeze.ariadne.com (8.14.5/8.14.5) with ESMTP id r9IMP4RD002660;
	Fri, 18 Oct 2013 18:25:05 -0400
Received: (from worley@localhost)
	by freeze.ariadne.com (8.14.5/8.14.5/Submit) id r9IMP4i3002659;
	Fri, 18 Oct 2013 18:25:04 -0400
In-reply-to: <xmqq4n8fzmmj.fsf@gitster.dls.corp.google.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1382135105;
	bh=2+VyDswbYm34JYRBdTfn0yJLQbxMiiFigKdetj9dehk=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=MB0RVEOEOaejEB8CU5jC8uHNOMK8U7bHkBw8ENkVetJKIhCknazBS1RZ0Vzqkq9qv
	 r5B9EbCO9ks0q4Z/nfMD6lVAObdmyipbRINrDx51QlAHEAGJS8ND4JsYulcTH0UmK2
	 1zFsL37MQfMR7ZYw1XAdGZ+hQD60y2fAB7FkHC/iA/csw39caYcQ5nTUokqFIJkYYd
	 FKtHbR0IOdplswtqQZYJoFw4eXMJlFzBtAgIBXWZgNQ3ufMI8M1mxoMNYOOsKAf4ek
	 1RtVIIa+OcfyunHHtC2cooUDvDA/8Ym770Kha3ps3NOGprp+lDkzrM5+IgylwZd7NF
	 NT0n2FlwUeXHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236374>

> From: Junio C Hamano <gitster@pobox.com>

> 	Side note: without GIT_WORK_TREE environment (or
> 	core.worktree), there is no way to tell where the top level
> 	is, so you were limited to always be at the top level of
> 	your working tree if you used GIT_DIR to refer to a
> 	repository that is not embedded in your working tree.  There
> 	were some changes in this area, but I do not recall the
> 	details offhand.

That's not true.  The core.worktree config variable tells the top of
the worktree, so once you've located the repository, you know where
the worktree is.

Indeed, it's not clear why GIT_WORK_TREE exists, as that allows the
user to set GIT_WORK_TREE inconsistently with core.worktree.  (What
happens if you do that?)

Dale
