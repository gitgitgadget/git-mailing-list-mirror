From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] fetch: add configuration for making --all default
Date: Fri, 17 Jul 2015 17:02:46 +0200 (CEST)
Message-ID: <1674906250.515624.1437145366822.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1437139899-6210-1-git-send-email-oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 16:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG76A-0001S4-RM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 16:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370AbbGQO6p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jul 2015 10:58:45 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:50207 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756760AbbGQO6p convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 10:58:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id BACF32109;
	Fri, 17 Jul 2015 16:58:42 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F-CqcUWL4S-Y; Fri, 17 Jul 2015 16:58:42 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id AAA912108;
	Fri, 17 Jul 2015 16:58:42 +0200 (CEST)
In-Reply-To: <1437139899-6210-1-git-send-email-oystwa@gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Win)/8.0.9_GA_6191)
Thread-Topic: fetch: add configuration for making --all default
Thread-Index: 4ikuVYcZLnHMNwHIm25Apac3tXTK9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274074>

Hi,

=C3=98ystein Walle <oystwa@gmail.com> writes:
> +fetch.all::
> +        If true, fetch will automatically behave as if the `--all`
> +        option was given on the command line uness a remote was give=
n. The
> +        default is false.

s/uness/unless

> +test_expect_success 'git fetch (fetch.all =3D true)' '
> +        (git clone one test9 &&
> +         cd test9 &&
> +         git config fetch.all true &&
> +         git remote add one ../one &&
> +         git remote add two ../two &&
> +         git remote add three ../three &&
> +         git fetch &&
> +         git branch -r > output &&

No space after redirection ('>').
It should be:
         git branch -r >output &&

> +test_expect_success 'git fetch one (fetch.all =3D true)' '
> +        (cd test3 &&
> +         git config fetch.all true &&
> +         git fetch three &&
> +         git branch -r > output &&

Same here

> +         test_cmp ../expect output &&
> +         git fetch --no-all &&
> +         git branch -r > output &&

And here.

> +         test_cmp ../expect output)
> +'

Thanks,
R=C3=A9mi
