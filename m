From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Provide configurable UI font for gitk
Date: Sun, 02 Apr 2006 03:57:20 -0700
Message-ID: <7vodzkkzxr.fsf@assigned-by-dhcp.cox.net>
References: <1143969814.2303.71.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Apr 02 12:57:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQ0Gq-0003LS-RR
	for gcvg-git@gmane.org; Sun, 02 Apr 2006 12:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWDBK5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Apr 2006 06:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbWDBK5W
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Apr 2006 06:57:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61132 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932317AbWDBK5V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Apr 2006 06:57:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060402105721.RVUX17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Apr 2006 06:57:21 -0400
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1143969814.2303.71.camel@neko.keithp.com> (Keith Packard's
	message of "Sun, 02 Apr 2006 01:23:34 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18265>

Keith Packard <keithp@keithp.com> writes:

> This makes the font used in the UI elements of gitk configurable in the
> same way the other fonts are. The default fonts used in the Xft build of
> tk8.5 are particularily horrific, making this change more important
> there.
>
> Signed-off-by: Keith Packard <keithp@neko.keithp.com>

Thanks for the patch.  I haven't run it, but a quick eyeballing
suggests what you did is sane.  However,..

>  proc makewindow {rargs} {
> -    global canv canv2 canv3 linespc charspc ctext cflist textfont
> +    global canv canv2 canv3 linespc charspc ctext cflist textfont
> mainfont uifont

Your MUA seems to be line-wrapping the patch here and there...

> @@ -345,16 +345,20 @@ proc makewindow {rargs} {
>  
>      menu .bar
>      .bar add cascade -label "File" -menu .bar.file
> +    .bar configure -font $uifont
>      menu .bar.file
>      .bar.file add command -label "Update" -command [list updatecommits
> $rargs]
>      .bar.file add command -label "Reread references" -command
> rereadrefs
>...

so the patch does not apply X-<.

Also, I prefer changes to gitk to be fed via Paul Mackerras
tree.  If you send changes to gitk to me, I will forward patches
with my Acked-by: to him and wait for him to bounce the change
back to me through his tree, so it is not a big deal for me, and
the changes will _not_ be lost anyway, but I'd still appreciate
gitk patches to be sent to Paul first if possible.
