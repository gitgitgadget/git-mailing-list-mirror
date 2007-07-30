From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 0/4] Add guards to guilt
Date: Sun, 29 Jul 2007 23:54:43 -0400
Message-ID: <20070730035443.GC22017@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 05:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFMLT-0007iL-SF
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 05:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933615AbXG3Dy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 23:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933509AbXG3Dy4
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 23:54:56 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45541 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758817AbXG3Dyz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 23:54:55 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6U3shwd026045;
	Sun, 29 Jul 2007 23:54:43 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6U3shil026043;
	Sun, 29 Jul 2007 23:54:43 -0400
Content-Disposition: inline
In-Reply-To: <118569541814-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54178>

On Sun, Jul 29, 2007 at 12:50:14AM -0700, Eric Lesh wrote:
> 
> This series adds Mercurial Queues-like guards to guilt.  It allows you
> to assign guards to related patches in the series file to selectively
> push patches.

Neat. I actually never looked into guards, but you forced me to :) Very
interesting concept. I think it would be worth it having such functionality
in guilt.

I know I've been bad about forcing even myself to write new regression
tests. Your patches modify things significantly enough, that I'd like to see
some regression tests cases to make sure that user's data is not eaten
(e.g., a bug in the guard setting code could blow away the series file =>
very bad).

> This introduces the command `get_guarded_series`, which just lists
> patches that are to be applied based on the guards.  It also makes
>         eidx=`wc -l < $applied`
> inaccurate if you're using it as an index into get_series.

The index-based patch finding is a bit nasty anyway.

> If you change guards on a patch or select a different guard while
> patches are applied, some commands might get confused. guilt pop -a will fix
> everything though.  Usually, it's best to pop -a before fiddling with
> guards anyway.

Is this a problem with other projects' implementations of guards as well?
Perhaps printing a warning if a new guard is set when there are applied
patches would be in order?

> This is an RFC, but I have tested it and things seem to be working
> well.

Great!

I'm going to reply to each of the patches separately with any comments.

Josef 'Jeff' Sipek.

-- 
Penguin : Linux version 2.4.20-46.9.legacysmp on an i386 machine (2778.72 BogoMips).
