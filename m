From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: remove useless assignment
Date: Wed, 28 Mar 2012 16:22:33 -0400
Message-ID: <20120328202233.GB29315@sigill.intra.peff.net>
References: <4F73721D.4010808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Mar 28 22:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCzOD-0000fu-1z
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 22:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab2C1UWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 16:22:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36336
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758331Ab2C1UWf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 16:22:35 -0400
Received: (qmail 21363 invoked by uid 107); 28 Mar 2012 20:22:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 16:22:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 16:22:33 -0400
Content-Disposition: inline
In-Reply-To: <4F73721D.4010808@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194187>

On Wed, Mar 28, 2012 at 10:18:37PM +0200, Ren=C3=A9 Scharfe wrote:

> v1.7.9-8-g270a344 (config: stop using config_exclusive_filename) repl=
aced
> config_exclusive_filename with given_config_file.  In one case this
> resulted in a self-assignment, which is reported by clang as a warnin=
g.
> Remove the useless code.
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  builtin/config.c |    2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/builtin/config.c b/builtin/config.c
> index d41a9bf..33c8820 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -397,8 +397,6 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
>  				xstrdup(prefix_filename(prefix,
>  							strlen(prefix),
>  							given_config_file));
> -		else
> -			given_config_file =3D given_config_file;
>  	}

Thanks. I remember refactoring that part of the conditional several
times while figuring out the right ordering of my refactoring patches,
but obviously I missed removing the stale code on the final
pass-through.

Acked-by: Jeff King <peff@peff.net>

-Peff
