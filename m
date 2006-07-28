From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: ssh-pull.o depends on ssh-fetch.c
Date: Fri, 28 Jul 2006 11:14:07 -0700
Message-ID: <7vslkllhqo.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607281117240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 28 20:14:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Wr2-0006Od-VY
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 20:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbWG1SOL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 14:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030301AbWG1SOL
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 14:14:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:915 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030250AbWG1SOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 14:14:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060728181407.HECR22733.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Jul 2006 14:14:07 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607281117240.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 28 Jul 2006 11:17:46 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24398>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  Makefile |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 636679f..e8037ad 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -661,6 +661,7 @@ git-%$X: %.o $(GITLIBS)
>  	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(LIB_FILE) $(SIMPLE_LIB)
>  
> +ssh-pull.o: ssh-fetch.c
>  git-local-fetch$X: fetch.o
>  git-ssh-fetch$X: rsh.o fetch.o
>  git-ssh-upload$X: rsh.o

My personal preference would be to deprecate these commit
walkers ;-) but in any case we would also need to make
ssh-push.o depend on ssh-upload.c for the same logic.
