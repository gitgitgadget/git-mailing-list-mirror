From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix minor memory leak in get_tree_entry()
Date: Sun, 14 Feb 2010 23:43:49 -0500
Message-ID: <20100215044349.GB3336@coredump.intra.peff.net>
References: <4B77C8DE.5070503@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 15 05:43:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgsoI-00020b-6p
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 05:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939Ab0BOEnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Feb 2010 23:43:45 -0500
Received: from peff.net ([208.65.91.99]:56154 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147Ab0BOEnp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 23:43:45 -0500
Received: (qmail 13142 invoked by uid 107); 15 Feb 2010 04:43:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 23:43:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 23:43:49 -0500
Content-Disposition: inline
In-Reply-To: <4B77C8DE.5070503@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139969>

On Sun, Feb 14, 2010 at 10:56:46AM +0100, Ren=C3=A9 Scharfe wrote:

> diff --git a/tree-walk.c b/tree-walk.c
> index 08796c2..67a9a0c 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -441,6 +441,7 @@ int get_tree_entry(const unsigned char *tree_sha1=
, const char *name, unsigned ch
> =20
>  	if (name[0] =3D=3D '\0') {
>  		hashcpy(sha1, root);
> +		free(tree);
>  		return 0;
>  	}

Oops. Good catch.

Acked-by: Jeff King <peff@peff.net>

-Peff
