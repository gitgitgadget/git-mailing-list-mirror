From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Fix git.7 dependencies.
Date: Fri, 19 Jan 2007 11:20:25 -0800
Message-ID: <7vbqkuhlhi.fsf@assigned-by-dhcp.cox.net>
References: <873b67735m.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 19 20:20:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zHq-0004fv-HY
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbXASTU1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 14:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbXASTU1
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:20:27 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:65312 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932856AbXASTU1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 14:20:27 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119192026.IKCU20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:20:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D7Lj1W00h1kojtg0000000; Fri, 19 Jan 2007 14:20:44 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <873b67735m.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Fri, 19
	Jan 2007 10:54:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37193>

Santi B=E9jar <sbejar@gmail.com> writes:

> Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
> ---
>  Documentation/Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

Thanks.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 96755ad..c258d09 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -78,10 +78,10 @@ cmds_txt =3D cmds-ancillaryinterrogators.txt \
>  	cmds-plumbingmanipulators.txt \
>  	cmds-synchingrepositories.txt
> =20
> -$(cmds_txt): cmd-list.perl $(MAN1_TXT) $(MAN7_TXT)
> +$(cmds_txt): cmd-list.perl $(MAN1_TXT)
>  	perl ./cmd-list.perl

I think this is correct, as mine creates a circular dependency
between git.txt -> cmds-*.txt -> git.txt.

> -git.7 git.html: git.txt core-intro.txt
> +git.7 git.html: git.txt core-intro.txt $(cmds_txt)

I do not think this is needed; doesn't doc.dep catch cmds_txt as
well?
