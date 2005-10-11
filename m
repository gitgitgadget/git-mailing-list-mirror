From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] First cut of a Cygwin package creation target.
Date: Tue, 11 Oct 2005 15:48:51 -0700
Message-ID: <7vd5mbsm98.fsf@assigned-by-dhcp.cox.net>
References: <23711.145.36.10.111.1129040793.squirrel@www.dspsrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:49:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPSvc-0000iY-Qy
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 00:49:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbVJKWs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 18:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVJKWs6
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 18:48:58 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61163 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751235AbVJKWs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 18:48:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011224830.WAZP24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 18:48:30 -0400
To: timo@dspsrv.com
In-Reply-To: <23711.145.36.10.111.1129040793.squirrel@www.dspsrv.com> (Tim
	O. Callaghan's message of "Tue, 11 Oct 2005 15:26:33 +0100 (IST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9989>

"Tim O Callaghan" <timo@dspsrv.com> writes:

> applies-to: 2bab3caf63fc29f249c792289365abaf1cfa071b
> ba3be06048f361afc80baae30b00dd6e022386d0
> diff --git a/Makefile b/Makefile
> old mode 100644
> new mode 100755

Is the mode change relevant to cygwin port?

> index c31af7b..1a227ed
> --- a/Makefile
> +++ b/Makefile
> @@ -441,6 +441,26 @@ deb: dist
>         dpkg-source -b $(GIT_TARNAME)
>         cd $(GIT_TARNAME) && fakeroot debian/rules binary
>
> +unexport prefix
> +export prefix=/
> +export DESTDIR=/tmp/cygwin/usr
> +cygwinpackage: all
> ...

Are these environment-mucking supposed to be only effective
while you are running cygwinpackage target, or are you breaking
everybody else?  I cannot offhand tell because your patch does
not apply for me to try it out, after your MUA munged it.
