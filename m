From: Chris Webb <chris@arachsys.com>
Subject: Re: [PATCH] rebase -i: handle fixup of root commit correctly
Date: Tue, 31 Jul 2012 13:48:25 +0100
Message-ID: <20120731124824.GC14028@arachsys.com>
References: <20120724121703.GG26014@arachsys.com>
 <5017A1E4.1070800@kdbg.org>
 <20120731111938.GD19416@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 14:48:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwBsJ-0007gn-16
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 14:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753999Ab2GaMsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 08:48:32 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:54076 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab2GaMsb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 08:48:31 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SwBsE-0000aa-3c; Tue, 31 Jul 2012 13:48:30 +0100
Content-Disposition: inline
In-Reply-To: <20120731111938.GD19416@arachsys.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202650>

Chris Webb <chris@arachsys.com> writes:

> If we have a conflict in the middle of a chain of fixup/squashes, as far as
> I can see, we have a HEAD with all the previous successful fixups applied,
> conflict markers for the current failed pick, and when the conflict has been
> resolved, git rebase --continue will commit --amend the resolution and
> continue? Isn't that the correct behaviour here?

As an explicit test, I've just tried a chain of four squashed commits, each
of which deliberately resulted in a conflict to manually resolve. For each
squash, I was left with conflict markers on top of what had already been
squashed in the expected way, and when I continued after resolving these,
the resolution was 'commit --amend'ed in the expected way, with the same
behaviour and resulting commit at the end of the rebase -i as I get with a
copy of git without this patch.

Cheers,

Chris.
