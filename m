From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCH v2] shell: Rewrite documentation and improve error message
Date: Mon, 23 Aug 2010 13:42:12 -0400
Message-ID: <AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
	<AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
	<20100822080359.GB15561@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 19:42:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onb2M-0004Y6-3v
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 19:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab0HWRmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 13:42:17 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:45473 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753130Ab0HWRmP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 13:42:15 -0400
X-AuditID: 12074422-b7bbfae000005e9b-07-4c72b2f01fb0
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Brightmail Gateway) with SMTP id 8E.C9.24219.0F2B27C4; Mon, 23 Aug 2010 13:42:08 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o7NHgEnk016427
	for <git@vger.kernel.org>; Mon, 23 Aug 2010 13:42:14 -0400
Received: from mail-gy0-f174.google.com (mail-gy0-f174.google.com [209.85.160.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7NHgCjO021735
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 23 Aug 2010 13:42:13 -0400 (EDT)
Received: by gyd8 with SMTP id 8so2206734gyd.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 10:42:12 -0700 (PDT)
Received: by 10.150.139.11 with SMTP id m11mr3898779ybd.16.1282585332402; Mon,
 23 Aug 2010 10:42:12 -0700 (PDT)
Received: by 10.231.154.212 with HTTP; Mon, 23 Aug 2010 10:42:12 -0700 (PDT)
In-Reply-To: <20100822080359.GB15561@kytes>
X-Brightmail-Tracker: AAAAAhWs/CYVrch4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154240>

> -COMMAND_DIR is the path 'git-shell-commands' in the user's home
> -directory. The user must have read and execute permissions to the
> -directory for it to be useful.
> +COMMAND_DIR is the path "$HOME/git-shell-commands". The user must ha=
ve
> +read and execute permissions to the directory in order to execute th=
e
> +programs in it. The programs are executed with a cwd of $HOME, and
> +<argument> is passed to them as a command-line argument.
Sorry, I guess I wasn't clear enough with what I meant here.  The
<argument> is actually parsed as a command-line string (so split on
spaces respecting quotes), not just passed as a raw command-line
argument.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (access(COMMAND_DIR, R_OK | X_OK) =3D=
=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Inteactive git she=
ll is not enabled.\n"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hint: " COMMAN=
D_DIR " should exist "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Interactive git sh=
ell is not enabled.\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "hint: ~/$COMMA=
ND_DIR should exist "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"and have read=
 and execute access.");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0run_shell();
Whoops, I'm not sure why I put a $ here.  "hint: ~/" COMMAND_DIR "
should exist " is definitely what you want.

Other than that, looks fine to me.
