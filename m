From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 1/2] submodule-config: keep shallow recommendation
 around
Date: Thu, 26 May 2016 11:02:52 +0200 (CEST)
Message-ID: <2022441346.44059.1464253372857.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160526000633.27223-1-sbeller@google.com> <20160526000633.27223-2-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 10:52:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5r1y-0003JU-NT
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 10:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbcEZIwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 04:52:34 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:40199 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751100AbcEZIwd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 04:52:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 5FBD720F4;
	Thu, 26 May 2016 10:52:29 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lQceYVneJx5B; Thu, 26 May 2016 10:52:29 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4908320F0;
	Thu, 26 May 2016 10:52:29 +0200 (CEST)
In-Reply-To: <20160526000633.27223-2-sbeller@google.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: submodule-config: keep shallow recommendation around
Thread-Index: VBieT1Fm6QhY76cnRuG7KF6MGhPFgw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295638>

Hi Stefan,

Stefan Beller <sbeller@google.com> writes:
> [...]
> @ -353,6 +354,15 @@ static int parse_config(const char *var, const ch=
ar *value, void *data)
>                  else if (parse_submodule_update_strategy(value,
>                           &submodule->update_strategy) < 0)
>                                  die(_("invalid value for %s"), var);
> +        } else if (!strcmp(item.buf, "shallow")) {
> +                if (!me->overwrite &&
> +                         submodule->recommend_shallow !=3D -1)

Nit: You seems to be able to keep the whole condition on the same line:

		if (!me->overwrite && submodule->recommend_shallow !=3D -1)

If you want to keep it in two line, you might want to align it:
		if (!me->overwrite &&
		    submodule->recommend_shallow !=3D -1)

Thanks,
R=C3=A9mi
