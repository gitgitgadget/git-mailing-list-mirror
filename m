From: Junio C Hamano <junkio@cox.net>
Subject: Re: fatal: git-write-tree: not able to write tree
Date: Fri, 28 Apr 2006 01:32:59 -0700
Message-ID: <7vd5f2drr8.fsf@assigned-by-dhcp.cox.net>
References: <200604280430.33100.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 10:33:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZOPS-00053y-Aj
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 10:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWD1IdB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 04:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030372AbWD1IdB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 04:33:01 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:49816 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030370AbWD1IdA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 04:33:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060428083300.NFNZ4388.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Apr 2006 04:33:00 -0400
To: Len Brown <len.brown@intel.com>
In-Reply-To: <200604280430.33100.len.brown@intel.com> (Len Brown's message of
	"Fri, 28 Apr 2006 04:30:33 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19270>

Len Brown <len.brown@intel.com> writes:

> I'm trying to  use git-am to apply a patch series in a mailbox.
>
> The first patch has a conflict, which I edit to fix, and and then invoke
> git am --3way --interactive --signoff --utf8 --resolved
>
> but it bails out with this:
>
> drivers/acpi/thermal.c: unmerged (4829f067a3e7acfbeed8b230caac00b1ed4b8554)
> drivers/acpi/thermal.c: unmerged (528d198c28512af1627cce481575f37a599c0fe8)
> drivers/acpi/thermal.c: unmerged (db3bef1a3e51801128e7553f3e546c8272cc9ee1)
> fatal: git-write-tree: not able to write tree
>
> I've tried various incantations of git reset on the theory that there is some 
> old state hanging around someplace, but have not been able to check in this 
> file.
>
> clues?

Please say "--resolved" after you have actually resolved them,
eh, meaning, (1) edit the working tree file into a desired
shape, and (2) git-update-index drivers/acpi/thermal.c.

I've considered making --resolved to do update-index for all
paths that are unmerged in the index, but that risks going
forward by mistake when you still have other paths to resolve,
so...
