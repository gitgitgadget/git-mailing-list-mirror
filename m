From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH v2] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 17:39:44 +0200
Message-ID: <vpqpp5k1zjz.fsf@anie.imag.fr>
References: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 17:39:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxzuT-00027v-Je
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 17:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbbE1Pju convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 11:39:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:32869 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbbE1Pjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 11:39:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SFdgCd002406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 17:39:42 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SFdiqn013988;
	Thu, 28 May 2015 17:39:44 +0200
In-Reply-To: <1432822837-10320-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Thu, 28 May 2015
 16:20:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 17:39:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SFdgCd002406
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433432383.31407@+5lE4bIAi6mKcE54FIb+cQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270154>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> It is an almost empty code sent to validate the global architecture o=
f
> this command.  It is written in C because git status is already in C
> and it seems that it is the current tendency to port shell code to
> C. Moreover will likely use code from wt_status to implement this
> functionnality. The command calls a helper from a shell script, as it
> is made in bisect (bisect--helper.c).

I think this paragraph makes sense in the commit message. My previous
remark was about the wording, not about the relevance of the arguments.

> +static const char * const git_rebase_status_helper_usage[] =3D {
> +	N_("git rebase--status--helper"),
> +	NULL
> +};
> +
> +int cmd_rebase_status__helper(int argc, const char **argv, const cha=
r *prefix)
> +{
> +	struct option options[] =3D {
> +	=09
> +	};

You need to tell parse_options when the array is over (that's C ...) =3D=
>
OPT_END().

> +	argc =3D parse_options(argc, argv, prefix, options,
> +			     git_rebase_status_helper_usage, 0);

Actually, you don't need option-parsing at all since you don't pass
arguments to the helper, but why not have this in case we need it later=
=2E

No need to resend now, you'll send a new version when you have somethin=
g
to build on top (or if someone has more important remarks).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
