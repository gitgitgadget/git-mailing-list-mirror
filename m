From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] git stash: Avoid data loss when saving a stash
Date: Sun, 30 Jun 2013 15:20:17 +0200
Message-ID: <20130630132017.GQ12252@machine.or.cz>
References: <7vhaghnct4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 30 15:20:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtHYY-0000M8-AZ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 15:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3F3NUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 09:20:24 -0400
Received: from pasky.or.cz ([84.242.80.195]:43701 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab3F3NUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 09:20:23 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0114E1700058; Sun, 30 Jun 2013 15:20:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vhaghnct4.fsf@alter.siamese.dyndns.org>
 <7vbo6qni1d.fsf@alter.siamese.dyndns.org>
 <7vobaqnkq3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229278>

  Hi!

On Fri, Jun 28, 2013 at 11:39:16AM -0700, Junio C Hamano wrote:
> Thanks.  I'll queue it with a pair of fix-up commits on top, so that
> they can later be squashed in.
> 
> The result of squashing the fix-ups would look like this.

  Thanks! I agree with all of your changes.

> -- >8 --
> From: Petr Baudis <pasky@ucw.cz>
> Date: Fri, 28 Jun 2013 17:05:32 +0200
> Subject: [PATCH] git stash: avoid data loss when "git stash save" kills a directory

  Hmm, it's a pity that the note that `git reset --hard` itself should
perhaps also abort in that case got lost. I don't insist on mentioning
it in the commit message, though.


On Fri, Jun 28, 2013 at 02:30:15PM -0700, Junio C Hamano wrote:
> -- >8 --
> Subject: treat_directory(): do not declare submodules in index to be untracked

  Oh, you are truly awesome! I admit that properly reviewing this patch
is a little out of my depth right now as I'm not familiar with this
infrastructure. I'd just like to note...

>  	case index_gitdir:
>  		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>  			return path_none;
> -		return path_untracked;
> +		return path_none;

...that the if-test can be removed now as both branches are the same.

				Petr "Pasky" Baudis
