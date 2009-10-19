From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push: remove incomplete options list from help text
Date: Sun, 18 Oct 2009 20:13:03 -0700
Message-ID: <7vpr8kcc00.fsf@alter.siamese.dyndns.org>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
 <4ADB4AE8.5070007@hartwork.org>
 <20091018235240.GU6115@genesis.frugalware.org>
 <20091019115412.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 05:14:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzihZ-0001BB-G8
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 05:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755819AbZJSDNP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 23:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755794AbZJSDNP
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 23:13:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765AbZJSDNO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 23:13:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B14A7CC0E;
	Sun, 18 Oct 2009 23:13:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Pu1HdP/lDt+x
	ro6diu2QGqUwk9U=; b=l/tni+YmD1P5a5brqEFlMYeCSMWXHT9wXDUpBUpbmVkn
	Ox7zigZCmApbDsoPsycRRKiOty263s1qs2agqczdhExME3JOc/QUL+Lzj4e1FT0S
	9Y4AcrqZFtFwM1CZSj9S2HCOZaIpdiqV3+re1/9dUQepz8dX/3z7fSW9laZ6dhc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wevxnp
	46TfDt2umbGN0JTplbQXsb5ePP0K622diIXCucbt2+gGJSuAkSWcmthRPoVNNSKY
	dmCVXf3wocpma/8rsIM852pPO/YJ1IbowvrLa/dYsQ6ovsF7sws7KxlJt5CPMGhE
	BduHSdGR8CKyhHyVgPuolCyrljRnp6wGx7hdU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 34C787CC04;
	Sun, 18 Oct 2009 23:13:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 30BF97CC03; Sun, 18 Oct 2009
 23:13:04 -0400 (EDT)
In-Reply-To: <20091019115412.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon\, 19 Oct 2009 11\:54\:12 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55987250-BC5D-11DE-9414-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130642>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> 'git push -h' shows usage text with incomplete list of options and th=
en
> has a separate list of options that are supported. Imitate the way ot=
her
> commands (I looked at 'git diff' for an example) show their options.
>
> Signed-off-by: =E3=81=97=E3=82=89=E3=81=84=E3=81=97 =E3=81=AA=E3=81=AA=
=E3=81=93 <nanako3@lavabit.com>
> ---
> ...
> diff --git a/builtin-push.c b/builtin-push.c
> index 3cb1ee4..6686b79 100644
> --- a/builtin-push.c
> +++ b/builtin-push.c
> @@ -10,7 +10,7 @@
>  #include "parse-options.h"
> =20
>  static const char * const push_usage[] =3D {
> -	"git push [--all | --mirror] [-n | --dry-run] [--porcelain] [--tags=
] [--receive-pack=3D<git-receive-pack>] [--repo=3D<repository>] [-f | -=
-force] [-v] [<repository> <refspec>...]",
> +	"git push <options> [<repository> <refspec>...]",
>  	NULL,
>  };
> =20
> --=20
> 1.6.5.rc1.18.g53a9a

Sounds like a sane thing to do, but I am sort of surprised that you are
still on 1.6.5-rc1 ;-)

How does this interact with one of the "unapplied patch" you reminded m=
e
of, namely, this one:

    From:	Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
    Subject: [PATCH] push: fix usage: --tags is incompatible with --all=
 and --mirror
    Date:	Thu, 15 Oct 2009 18:39:05 +0200
    Message-ID: <4AD75029.1010109@gmail.com>

        Correct the usage text to make it clear that --tags cannot
        be combined with --all or --mirror.

The option description that comes from parse-options may need to be
updated as well, no?

>     -q, --quiet           be quiet
>     -v, --verbose         be verbose
>     --repo <repository>   repository
>     --all                 push all refs
>     --mirror              mirror all refs
>     --tags                push tags
>     -n, --dry-run         dry run
>     --porcelain           machine-readable output
>     -f, --force           force updates
>     --thin                use thin pack
>     --receive-pack <receive-pack>
>                           receive pack program
>     --exec <receive-pack>
>                           receive pack program
