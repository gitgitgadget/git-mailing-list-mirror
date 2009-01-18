From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Sun, 18 Jan 2009 18:06:37 +0300
Organization: St.Petersburg State University
Message-ID: <20090118150637.GC27522@roro3.zxlink>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru> <20090108195356.GA14644@lapse.rw.madduck.net> <20090108201614.GA4185@roro3> <20090108211149.GA19983@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:07:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZEa-0000O3-Td
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929AbZARPFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762093AbZARPFV
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:05:21 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:2582 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761739AbZARPFU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:05:20 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id C085617B663; Sun, 18 Jan 2009 18:05:18 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LOZET-0007ZT-EH; Sun, 18 Jan 2009 18:06:37 +0300
Content-Disposition: inline
In-Reply-To: <20090108211149.GA19983@roro3>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106209>

On Fri, Jan 09, 2009 at 12:11:49AM +0300, Kirill Smelkov wrote:
> I'm sorry, but I've found a mistake in my code for case:
> 
> diff --git a/tg-patch.sh b/tg-patch.sh
> index db1ad09..d701c54 100644
> --- a/tg-patch.sh
> +++ b/tg-patch.sh
> @@ -17,8 +17,8 @@ while [ -n "$1" ]; do
>         case "$arg" in
>         -i)
>                 topic='(i)'
> -               diff_opts="$diff_opts --cached";;
> -               diff_committed_only=;
> +               diff_opts="$diff_opts --cached";
> +               diff_committed_only=;;
>         -w)
>                 topic='(w)'
>                 diff_committed_only=;;
> 
> 
> So here is corrected patch:
> 
> 
> From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
> To: Petr Baudis <pasky@suse.cz>
> Cc: martin f krafft <madduck@madduck.net>
> Cc: Git Mailing List <git@vger.kernel.org>
> Subject: [PATCH (topgit)] tg-patch: add support for generating patches against worktree and index
> 
> This implements `tg patch -i` and `tg patch -w` to see current patch as
> generated against not-yet-committed index and worktree.
> 
> 
> NOTE: unfortunately `git cat-file blob <file>` does not provide an option
> to cat file from worktree (only from an object or from index), so I had to
> unroll my own `cat file topic:file` with special support for '(i)' and
> '(w)' topics.
> 
> Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

[...]

Petr, Martin,

What's the state of this patch?

I don't understand why this gets ignored. Maybe I do something wrong?
...


Thanks,
Kirill
