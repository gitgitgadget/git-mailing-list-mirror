From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Conditionally define _GNU_SOURCE in mailinfo.c
Date: Sun, 30 Apr 2006 14:51:52 -0700
Message-ID: <7vodyiybnr.fsf@assigned-by-dhcp.cox.net>
References: <20060430181931.GE6626@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 23:51:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaJpd-0006tP-4R
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 23:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWD3Vvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 17:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWD3Vvy
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 17:51:54 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42434 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751227AbWD3Vvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 17:51:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430215153.XDRH27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 17:51:53 -0400
To: "Art Haas" <ahaas@airmail.net>
In-Reply-To: <20060430181931.GE6626@artsapartment.org> (Art Haas's message of
	"Sun, 30 Apr 2006 13:19:31 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19359>

"Art Haas" <ahaas@airmail.net> writes:

> Place the '#define _GNU_SOURCE' within an #ifndef/#endif block testing
> if '_GNU_SOURCE' is already defined.
>
> d3932a8fca2faac8ed14bfd0e65c1f0135dc1d4b
> diff --git a/mailinfo.c b/mailinfo.c
> index b276519..4b99ccf 100644
> --- a/mailinfo.c
> +++ b/mailinfo.c
> @@ -2,7 +2,9 @@
>   * Another stupid program, this one parsing the headers of an
>   * email to figure out authorship and subject
>   */
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif

Hmph....  I understand that this makes any difference only if
you use -D_GNU_SOURCE in CFLAGS, which implies there are _other_
things you need to have "#define _GNU_SOURCE" to compile for
your setup.  I wonder what it is...
