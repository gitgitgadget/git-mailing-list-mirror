From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] status: add new tests for status during rebase -i
Date: Thu, 04 Jun 2015 10:11:25 +0200
Message-ID: <vpq6173zydu.fsf@anie.imag.fr>
References: <1433368825-24617-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	<1433368825-24617-4-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
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
X-From: git-owner@vger.kernel.org Thu Jun 04 10:11:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0QFW-00037M-R5
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jun 2015 10:11:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbFDILb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2015 04:11:31 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46894 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbbFDIL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 04:11:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t548BOjc026216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jun 2015 10:11:24 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t548BPoX022569;
	Thu, 4 Jun 2015 10:11:25 +0200
In-Reply-To: <1433368825-24617-4-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Thu, 4 Jun 2015
 00:00:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 04 Jun 2015 10:11:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t548BOjc026216
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434010285.20162@XG5iE4Yx86SVNOiQhOry3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270756>

I'd swap 3/4 and 4/4 so that we see the impact of your code on these ne=
w
tests. I won't insist on that though.

Please help reviewers by explaining in the commit message why these
tests are needed (what was not covered properly by existing tests?)

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> +test_expect_success 'status: two commands done, two remainings' '
> +	FAKE_LINES=3D"1 exec_exit_15 2 3" &&
> +	export FAKE_LINES &&
> +	test_when_finished "git rebase --abort" &&
> +	ONTO=3D$(git rev-parse --short HEAD~3) &&
> +	COMMIT4=3D$(git rev-parse HEAD) &&
> +	COMMIT3=3D$(git rev-parse HEAD^) &&
> +	COMMIT2=3D$(git rev-parse HEAD^^) &&
> +	(git rebase -i HEAD~3 || true)&&

Space before &&

(same on second test)

> +       cat >expected <<EOF &&

Indent with spaces.

I did not do a thourough review, but this version looks much, much nice=
r
than the previous one (see how PATCH 1/4 and PATCH 2/4 are nice now?).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
