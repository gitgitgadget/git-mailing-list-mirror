From: Sandy Carter <sandy.carter@savoirfairelinux.com>
Subject: Re: [PATCH] i18n: proposed command missing leading dash
Date: Fri, 28 Feb 2014 19:36:16 -0500 (EST)
Message-ID: <1960754503.587182.1393634176189.JavaMail.root@mail>
References: <xmqq38j2u84r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jn avila <jn.avila@free.fr>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 01:36:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJXuk-00007z-Jp
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 01:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbaCAAgV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 19:36:21 -0500
Received: from mail.savoirfairelinux.com ([209.172.62.77]:55613 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbaCAAgT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 19:36:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4F28B10D75AD;
	Fri, 28 Feb 2014 19:36:18 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkUzxmLWwXIL; Fri, 28 Feb 2014 19:36:16 -0500 (EST)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [192.168.52.6])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DE92C10D75AC;
	Fri, 28 Feb 2014 19:36:16 -0500 (EST)
In-Reply-To: <xmqq38j2u84r.fsf@gitster.dls.corp.google.com>
X-Mailer: Zimbra 7.1.4_GA_2555 (ZimbraWebClient - GC33 (Linux)/7.1.4_GA_2555)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243033>

Should I also update the relevant git.pot and *.po sections?

----- Original Message -----
=46rom: "Junio C Hamano" <gitster@pobox.com>
To: "Jonathan Nieder" <jrnieder@gmail.com>
Cc: "Sandy Carter" <sandy.carter@savoirfairelinux.com>, git@vger.kernel=
=2Eorg, "jn avila" <jn.avila@free.fr>, "Carlos Mart=C3=ADn Nieto" <cmn@=
elego.de>
Sent: Friday, February 28, 2014 6:31:32 PM
Subject: Re: [PATCH] i18n: proposed command missing leading dash

Jonathan Nieder <jrnieder@gmail.com> writes:

> To make life saner for translators, this should be either
> untranslatable or a single multi-line string, I suspect:
>
> diff --git i/builtin/branch.c w/builtin/branch.c
> index b4d7716..972040c 100644
> --- i/builtin/branch.c
> +++ w/builtin/branch.c
> @@ -1022,11 +1022,13 @@ int cmd_branch(int argc, const char **argv, c=
onst char *prefix)
>  		 */
>  		if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERRIDE &&
>  		    !branch_existed && remote_tracking) {
> -			fprintf(stderr, _("\nIf you wanted to make '%s' track '%s', do th=
is:\n\n"), head, branch->name);
> -			fprintf(stderr, _("    git branch -d %s\n"), branch->name);
> -			fprintf(stderr, _("    git branch --set-upstream-to %s\n"), branc=
h->name);
> +			fprintf(stderr, "\n");
> +			fprintf(stderr, _("If you wanted to make '%s' track '%s', do this=
:\n\n"
> +					  "    git branch -d %s\n"
> +					  "    git branch --set-upstream-to %s"),
> +					head, branch->name, branch->name, branch->name);
> +			fprintf(stderr, "\n");
>  		}
> -
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
> =20
> What do you think?

Yes, I think it is sensible to make sure that the command examples
are not corrupted by the _() process.
