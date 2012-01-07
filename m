From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: How to deal with historic tar-balls
Date: Sat, 7 Jan 2012 02:50:13 +0100
Message-ID: <87lipk46y2.fsf@thomas.inf.ethz.ch>
References: <4EFF5CDA.5050809@gmail.com> <4F05C0E2.4050101@gmail.com>
	<4F079BA1.3060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, <git@vger.kernel.org>
To: nn6eumtr <nn6eumtr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 02:50:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjLQP-00034J-Rg
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 02:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759323Ab2AGBuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 20:50:19 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:3553 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759239Ab2AGBuS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 20:50:18 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sat, 7 Jan
 2012 02:50:11 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Sat, 7 Jan
 2012 02:50:14 +0100
In-Reply-To: <4F079BA1.3060907@gmail.com> (nn6eumtr@gmail.com's message of
	"Fri, 06 Jan 2012 20:10:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188060>

nn6eumtr <nn6eumtr@gmail.com> writes:

> Thanks for the response, there is lots of good information there.
>
> One clarification - can you track renames in git? I tried using git mv
> but from the status output it looks like it deleted the old file  and
> added the new file. I was expecting it to record some sort of
> indicator of the name change, instead it looks like a short-cut for
> delete & add, the docs aren't clear if that is the case.

Git only stores snapshots; so for an ordinary (non-merge, non-root)
commit, you have the "before" (parent) and "after" (commit's) snapshot.
Everything is generated on the fly from that, including diffs, heuristic
rename detection, pickaxe, ...

To apply rename detection when diffing (e.g. in diff, log, show,
format-patch), use the -M flag.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
