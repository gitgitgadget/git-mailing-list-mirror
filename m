From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a
 commit
Date: Tue, 23 Jun 2015 21:18:17 +0200 (CEST)
Message-ID: <392249968.731834.1435087097209.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com> <1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr> <vpq1th2p7ka.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 23 21:16:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7TgL-000726-56
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 21:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbbFWTQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 15:16:25 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:51507 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754461AbbFWTQX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 15:16:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5549C370B;
	Tue, 23 Jun 2015 21:16:21 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pandNS7_fvbv; Tue, 23 Jun 2015 21:16:21 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3F486205B;
	Tue, 23 Jun 2015 21:16:21 +0200 (CEST)
In-Reply-To: <vpq1th2p7ka.fsf@anie.imag.fr>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: o6EFnOFOMRYxCHzZ+9sQTJsJjjTZ3A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272483>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr> write=
s:
>=20
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> >> > +test_rebase_end () {
> >> > +       test_when_finished "git checkout master &&
> >> > +       git branch -D $1 &&
> >> > +       test_might_fail git rebase --abort" &&
> >> > +       git checkout -b $1 master
> >> > +}
> >>
> >> The way this is indented makes it difficult to see that lines 2 an=
d 3
> >> are continuations of 1. Perhaps format it like this instead?
> >>
> >>     test_rebase_end () {
> >>         test_when_finished "git checkout master &&
> >>             git branch -D $1 &&
> >>             test_might_fail git rebase --abort" &&
> >>         git checkout -b $1 master
> >>     }
> >
> > I completely agree with you, moreover it was indented like this bef=
ore.
> > I'll change it in my local version for now.
>=20
> Perhaps to avoid confusion, stg like:
>=20
>         test_when_finished "
>                 ... &&
>                 ...
>         " &&
>         git checkout
>=20
> (the closing " alone on its line)

I think that the indentation on its own is enough to avoid confusion
> test_rebase_end () {
> 	test_when_finished "git checkout master &&
> 		git branch -D $1 &&
> 		test_might_fail git rebase --abort" &&
> 	git checkout -b $1 master
> }
but your idea is fine as well, so I'm ok with either way.

Thanks,
R=C3=A9mi
