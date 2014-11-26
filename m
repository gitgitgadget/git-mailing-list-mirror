From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t7503: use write_script to generate hook scripts
Date: Tue, 25 Nov 2014 23:51:27 -0500
Message-ID: <20141126045127.GC15252@peff.net>
References: <cover.1416955873.git.oystwa@gmail.com>
 <78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 05:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtUZh-0007Td-Si
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 05:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbaKZEv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 23:51:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:45109 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752055AbaKZEv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 23:51:28 -0500
Received: (qmail 26535 invoked by uid 102); 26 Nov 2014 04:51:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 22:51:28 -0600
Received: (qmail 4201 invoked by uid 107); 26 Nov 2014 04:51:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 23:51:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 23:51:27 -0500
Content-Disposition: inline
In-Reply-To: <78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260270>

On Tue, Nov 25, 2014 at 11:51:28PM +0100, =C3=98ystein Walle wrote:

> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>  t/t7503-pre-commit-hook.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index 984889b..99ed967 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -24,8 +24,7 @@ test_expect_success '--no-verify with no hook' '
>  HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
>  HOOK=3D"$HOOKDIR/pre-commit"
>  mkdir -p "$HOOKDIR"
> -cat > "$HOOK" <<EOF
> -#!/bin/sh
> +write_script "$HOOK" <<EOF

While you are touching this line, please make it "<<\EOF". It does not
matter for these simple cases, but as a style, we try to avoid
interpolation unless it is necessary.

-Peff
