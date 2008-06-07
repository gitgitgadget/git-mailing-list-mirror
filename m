From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] 0003 This patch is to allow 12 different OS's to compile
 and run git.
Date: Fri, 06 Jun 2008 19:12:32 -0700
Message-ID: <7vzlpyouwf.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0806061330180.18454@xenau.zenez.com>
 <87bq2ez72u.fsf@jeremyms.com>
 <Pine.LNX.4.64.0806061359080.18454@xenau.zenez.com>
 <7vmylyrwkg.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0806061718420.18454@xenau.zenez.com>
 <Pine.LNX.4.64.0806061822220.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806062043350.19665@iabervon.org>
 <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Harning <harningt@gmail.com>,
	Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 04:14:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4nwW-0000AL-9M
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 04:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYFGCM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 22:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbYFGCMy
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 22:12:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbYFGCMu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 22:12:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 65BED36D0;
	Fri,  6 Jun 2008 22:12:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 37D9636CE; Fri,  6 Jun 2008 22:12:39 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0806061922290.18454@xenau.zenez.com> (Boyd Lynn
 Gerber's message of "Fri, 6 Jun 2008 19:25:11 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 38EF743C-3437-11DD-9BFA-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84166>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> On Fri, 6 Jun 2008, Daniel Barkalow wrote:
>
>> On Fri, 6 Jun 2008, Boyd Lynn Gerber wrote:
>> 
>> > From db0574a7f89bb90b6ce02cd44053f8cec2c454cc
>> > 
>> > This patch has patches to
>> > 
>> > Makefile
>> > git-compat-util.h
>> > progress.c
>> > 
>> > This patch allows some older OS's, SCO OpenServer 5.0.X, SCO UnixWare 7.1.4,
>> > and OpenServer 6.0.X to build and run git.  Applied suggestions from list.
>> > 
>> >         Developer's Certificate of Origin 1.1
>> > 
>> >         By making a contribution to this project, I certify that:
>> > 
>> >         (a) The contribution was created in whole or in part by me and I
>> >             have the right to submit it under the open source license
>> >             indicated in the file; or
>> > 
>> >         (b) The contribution is based upon previous work that, to the best
>> >             of my knowledge, is covered under an appropriate open source
>> >             license and I have the right under that license to submit that
>> >             work with modifications, whether created in whole or in part
>> >             by me, under the same open source license (unless I am
>> >             permitted to submit under a different license), as indicated
>> >             in the file; or
>> > 
>> >         (c) The contribution was provided directly to me by some other
>> >             person who certified (a), (b) or (c) and I have not modified
>> >             it.
>> > 
>> >         (d) I understand and agree that this project and the contribution
>> >             are public and that a record of the contribution (including all
>> >             personal information I submit with it, including my sign-off) is
>> >             maintained indefinitely and may be redistributed consistent with
>> >             this project or the open source license(s) involved.
>> > 
>> > Signed-off-by: Boyd Lynn Gerber <gerberb@zenez.com>
>> > 
>> > --
>> > Boyd Gerber <gerberb@zenez.com>
>> > ZENEZ   1042 East Fort Union #135, Midvale Utah  84047
>
> OK made changes you recommended.

I guess the patch text itself seems to be getting reasonable, and perhaps
the next few rounds would be to fix the commit log message ;-)

> diff --git a/Makefile b/Makefile
> index cce5a6e..000bf1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -165,6 +165,11 @@ uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
>  # CFLAGS and LDFLAGS are for the users to override from the command line.
>  
>  CFLAGS = -g -O2 -Wall
> +ifeq ($(uname_S),SCO_SV)
> +	ifeq ($(uname_R),3.2)
> +		CFLAGS = -O2
> +	endif
> +endif

What makes SCO_SV so special that this platform specific tweak does not
live in "Platform specific tweaks" section like others?

CFLAGS is for the user to oerride from the command line, and I do not very
much like any tweaks in Makefile.  I'd suggest dropping this hunk.

> @@ -564,6 +569,42 @@ endif
>  ifeq ($(uname_S),GNU/kFreeBSD)
>  	NO_STRLCPY = YesPlease
>  endif
> +ifeq ($(uname_S),UnixWare)
> +	CC=cc

s/=/ = /; you have similar one elsewhere.

> +	NEEDS_SOCKET = YesPlease
> +	NEEDS_NSL = YesPlease
> +	NEEDS_SSL_WITH_CRYPTO = YesPlease
> +	NEEDS_LIBICONV = YesPlease
> +	SHELL_PATH = /usr/local/bin/bash
> +	NO_IPV6 = YesPlease
> +	NO_HSTRERROR = YesPlease
> +	BASIC_CFLAGS +=  -Kalloca -Kthread

I am only guessing what -Kalloca is, but is it for alloca(3), and if so do
you still need it?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 01c4045..b3cd7b3 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -39,7 +39,12 @@
>  /* Approximation of the length of the decimal representation of this type. */
>  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
>  
> -#if !defined(__APPLE__) && !defined(__FreeBSD__)
> +/* Added for __USLC__ for any Novell devrived Compiler and Some Sys V 
> +   Added _M_UNIX for any XENIX/SCO UNIX/OpenServer less than or equal
> +   OpenServer 5.0.7  This is do avoided compiler hell like the other
> +   OS's __APPLE__ and __FreeBSD__ */

We generally do not do changelog inside the code comment.

> +#if !defined(__APPLE__) && !defined(__FreeBSD__)  && !defined(__USLC__) && !de
> +fined(_M_UNIX)

Linewrapped patch?  It is very curious that you have + in front of "fined(_M_UNIX)".
