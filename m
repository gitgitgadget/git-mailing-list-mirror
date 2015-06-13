From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFCv5 3/3] git rebase -i: add static check for commands
 and SHA-1
Date: Sun, 14 Jun 2015 01:17:05 +0200 (CEST)
Message-ID: <775816946.447663.1434237425837.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1433931035-20011-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1433931035-20011-3-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <vpq8ubrtws0.fsf@anie.imag.fr> <58099623.334723.1433951804504.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpqa8w71r80.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 14 01:16:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3uf2-0002BE-Lr
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 01:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbbFMXQH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Jun 2015 19:16:07 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40884 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751179AbbFMXQF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 19:16:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 105A6365E;
	Sun, 14 Jun 2015 01:16:03 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHLSHuJRgMl9; Sun, 14 Jun 2015 01:16:02 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id E5F92365D;
	Sun, 14 Jun 2015 01:16:02 +0200 (CEST)
In-Reply-To: <vpqa8w71r80.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: add static check for commands and SHA-1
Thread-Index: OSNfJ/1dJCXjq16V8DJmn/kYG1I9VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271601>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> write=
s:
>=20
> > It is mainly because here the SHA-1 is a long one (40 chars)
>=20
> OK, but then the minimum would be to add a comment saying that.
>=20
> Now, this makes me wonder why you are doing the check after the sha1
> expansion and not before. Also, when running `git bisect --edit-todo`=
, I
> do get the short sha1. So, there's a piece of code doing what you wan=
t
> somewhere already. You may want to use it.

Originally I did the whole checking after the expansion because I
though that it was a better idea to avoid doing it myself (Comparing
the whole SHA-1 instead of partial ones to find missing ones made more
sense for me since otherwise I would have to check if one is the
prefix of the other or expand to the same size before comparing).

However I agree that adding a comment would make things clearer. Will
probably do that.

Thank you,
R=C3=A9mi
