From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: rebase -p loses amended changes
Date: Sat, 31 Mar 2012 00:49:55 +0200
Message-ID: <87ty15vh4c.fsf@thomas.inf.ethz.ch>
References: <CADb3U=4DNt7Jnzq4eW-K+W1_sEfMgL6MxqY6qmPaJZagiFdmmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: J Robert Ray <jrobertray@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:50:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDke6-0002qv-Ct
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935115Ab2C3WuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:50:04 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:58720 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935006Ab2C3Wt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 18:49:59 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Sat, 31 Mar
 2012 00:49:55 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sat, 31 Mar
 2012 00:49:56 +0200
In-Reply-To: <CADb3U=4DNt7Jnzq4eW-K+W1_sEfMgL6MxqY6qmPaJZagiFdmmg@mail.gmail.com>
	(J. Robert Ray's message of "Fri, 30 Mar 2012 14:31:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194421>

J Robert Ray <jrobertray@gmail.com> writes:

> If a merge is amended to add changes to a file unaffected by the
> merge, these changes are lost after a rebase. Attached is a script to
> demonstrate the problem.

> 4. Merge (--no-ff) "mod-a" onto master.
>
> 5. Amend the merge with a modification to a.

> 7. Rebase -p master onto "master-copy."
>
> Notice the change to "a" from step #5 is now gone. "a" reverts to the
> pre-amended version after step #4.

That's pretty much expected. rebase -p attempts to (conflicts will
happen again) replay the merge.  I don't think anybody's come up with a
clear idea of how to apply the conflicted or evil parts of the merge
mechanically.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
