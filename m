From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Documentation: update tar.umask default
Date: Tue, 21 Aug 2007 23:15:26 +0200
Organization: glandium.org
Message-ID: <20070821211526.GA12483@glandium.org>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820174142.GA7943@glandium.org> <46CB286C.8000403@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	git discussion list <git@vger.kernel.org>
To: =?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Aug 21 23:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INb5r-00009c-8e
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 23:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbXHUVQs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 17:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758098AbXHUVQs
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 17:16:48 -0400
Received: from vawad.err.no ([85.19.200.177]:42348 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756868AbXHUVQr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2007 17:16:47 -0400
Received: from aputeaux-153-1-97-232.w86-217.abo.wanadoo.fr ([86.217.119.232] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1INb5Z-0002Zv-Uk; Tue, 21 Aug 2007 23:16:39 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1INb4R-0003Fl-Hp; Tue, 21 Aug 2007 23:15:27 +0200
Content-Disposition: inline
In-Reply-To: <46CB286C.8000403@lsrfire.ath.cx>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56331>

On Tue, Aug 21, 2007 at 08:01:16PM +0200, Ren=E9 Scharfe <rene.scharfe@=
lsrfire.ath.cx> wrote:
> As noted by Mike Hommey, the documentation for the config setting tar=
=2Eumask
> is not up-to-date.  Commit f08b3b0e2e9ad87767d80ff03b013c686e08ba4b c=
hanged
> the default from 0 to 2; this patch finally documents it.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
> diff --git a/Documentation/git-archive.txt b/Documentation/git-archiv=
e.txt
> index 4da07c1..9984a11 100644
> --- a/Documentation/git-archive.txt
> +++ b/Documentation/git-archive.txt
> @@ -80,8 +80,8 @@ in the repository configuration as follows :
>          umask =3D 002	;# group friendly
> =20
>  The special umask value "user" indicates that the user's current uma=
sk
> -will be used instead. The default value remains 0, which means world
> -readable/writable files and directories.
> +will be used instead.  The default is 002, which allows reading for =
all
> +and writing for both owner and group.

Actually, I'd say it's not enough ; users may be confused by the
sentence just above:

By default, file and directories modes are set to 0666 or 0777 in tar
archives.

Which is true, but if you are not very familiar with umask, you won't
actually gather from the rest that the modes are not going to be that b=
y
default.

Mike
