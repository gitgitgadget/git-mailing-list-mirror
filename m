From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-{fetch,peek-remote} handling of --upload-pack
Date: Sat, 21 Jan 2006 19:41:34 -0800
Message-ID: <7vlkx9gc9d.fsf@assigned-by-dhcp.cox.net>
References: <E1F019M-0003Cf-Ln@heater.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 04:41:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0W6x-0003uk-1o
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 04:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWAVDlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 22:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWAVDlg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 22:41:36 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:51957 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932223AbWAVDlf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 22:41:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122033854.YNHG17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 22:38:54 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <E1F019M-0003Cf-Ln@heater.watson.ibm.com> (Michal Ostrowski's
	message of "Fri, 20 Jan 2006 13:38:16 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15043>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> git-peek-remote needs to handle a -u|--upload-pack parameter just like
> git-fetch (and git-fetch has to pass it on to git-peek-remote).
>
> (This is actually a follow-up to my previous git-fetch patch.)

Thanks.

Everything else looks good, but I have one question.  What is
this hunk about?

> diff --git a/git-ls-remote.sh b/git-ls-remote.sh
> index f699268..64f37af 100755
> --- a/git-ls-remote.sh
> +++ b/git-ls-remote.sh
>...
> @@ -34,7 +41,7 @@ case ",$heads,$tags," in
>  esac
>  
>  . git-parse-remote
> -peek_repo="$(get_remote_url "$@")"
> +peek_repo="$(get_remote_url $*)"
>  shift
>  
>  tmp=.ls-remote-$$
