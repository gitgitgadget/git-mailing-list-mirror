From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git gui create desktop icon currently does not work
Date: Tue, 23 Feb 2010 23:54:40 +0100
Message-ID: <cb7bb73a1002231454j4720b28ei20c10de37e929fde@mail.gmail.com>
References: <20100223224955.GB11271@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysGit Mailinglist <msysgit@googlegroups.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 23:55:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk3ew-0003LT-0v
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 23:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab0BWWzH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 17:55:07 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:44540 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab0BWWzF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 17:55:05 -0500
Received: by ewy20 with SMTP id 20so513081ewy.1
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 14:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gP9oR/9jI+e8WN7zH5NGl0leCBxWGARmNUrS6dKRxp0=;
        b=F38QJG89JoIjNhgXqhcXynqoqlX22gxZkqGyJd/efh9G6fc24eVUj2wRTpg2EbsV5y
         +dwLPmxvpVTmZqgLeFvSqiPhxxTMD69dBzW2CxFd7nvRfDSVHqxQhu5CYJObBRio2A5c
         DzkfqV2qfcoQ1wQmZEcL9aFmz/rc+G7/s6H2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OgjyfvMmfruxRjffAenUQyo9USceOF6h4OsKLcKSmZXWK0yphZBco0R1azypgksFH1
         ZIwNnH/jCCyh6n18/cA0zDRn4UwyctiOyvf88jO5hZKHIZrapT7EyyCe3TMQUHdQuqNS
         D37Z1st+cov2QyLN/ObBl2KFejUeGnguF9Y9M=
Received: by 10.213.97.17 with SMTP id j17mr242439ebn.24.1266965700205; Tue, 
	23 Feb 2010 14:55:00 -0800 (PST)
In-Reply-To: <20100223224955.GB11271@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140862>

On Tue, Feb 23, 2010 at 11:49 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote=
:
> Hi,
>
> I have a patch (further down) to this issue but I only tested this on
> Windows 7 and my virtual machine (XP) did not like it for some reason=
 (it
> created the shortcut but the shortcut did not work). If anyone else c=
an
> confirm that this patch actually works we can include it.
>
> Commit 3748b0 git-gui: update shortcut tools to use _gitworktree
> from Guiseppe does break the creation of Desktop shortcuts on Windows=
=2E
>
> I do not know whether this has worked with any tcl interpreter as it
> attempts to execute $_gitworktree as a command.
>
> Here is my fix:
>
> From 5c22c39d530ffb308826629d974048d30cd32e53 Mon Sep 17 00:00:00 200=
1
> From: Heiko Voigt <hvoigt@hvoigt.net>
> Date: Tue, 23 Feb 2010 10:40:14 +0100
> Subject: [PATCH 1/2] git-gui: fix usage of _gitworktree when creating=
 shortcut for windows
>
> Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> ---
> =A0git-gui/lib/shortcut.tcl | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui/lib/shortcut.tcl b/git-gui/lib/shortcut.tcl
> index 79c1888..8cad0e2 100644
> --- a/git-gui/lib/shortcut.tcl
> +++ b/git-gui/lib/shortcut.tcl
> @@ -16,7 +16,7 @@ proc do_windows_shortcut {} {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0[info nameofexecutable] \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0[file normalize $::argv0] \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0] \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [file normalize [$_gitworktree]]
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 [file normalize $_gitworktree]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} err]} {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0error_popup [strcat [m=
c "Cannot write shortcut:"] "\n\n$err"]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}

Ouch. Yes, I think your patch is obviously correct.

(I'll go sit in a corner with my 'TCL Dunce' cap on for a while ...)

--=20
Giuseppe "Oblomov" Bilotta
