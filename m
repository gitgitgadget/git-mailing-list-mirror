From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a
 commit
Date: Tue, 23 Jun 2015 21:01:19 +0200 (CEST)
Message-ID: <1637608183.731706.1435086079947.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:59:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7TQ2-00059z-1p
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933516AbbFWS7e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 14:59:34 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:51335 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932130AbbFWS70 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 14:59:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 55C8B292F;
	Tue, 23 Jun 2015 20:59:24 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bm-o+Dw-T27L; Tue, 23 Jun 2015 20:59:24 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 17C85292E;
	Tue, 23 Jun 2015 20:59:24 +0200 (CEST)
In-Reply-To: <CAPig+cT+idnGkR0V-UfwbHwvjd_U=zbjHx+so7Jz+4o1XU5eHw@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: U5KmGaUOiFq7i279P2QxOFTSwIBW9w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272480>

Eric Sunshine <sunshine@sunshineco.com> writes:
> > +test_rebase_end () {
> > +       test_when_finished "git checkout master &&
> > +       git branch -D $1 &&
> > +       test_might_fail git rebase --abort" &&
> > +       git checkout -b $1 master
> > +}
>=20
> The way this is indented makes it difficult to see that lines 2 and 3
> are continuations of 1. Perhaps format it like this instead?
>=20
>     test_rebase_end () {
>         test_when_finished "git checkout master &&
>             git branch -D $1 &&
>             test_might_fail git rebase --abort" &&
>         git checkout -b $1 master
>     }

I completely agree with you, moreover it was indented like this before.
I'll change it in my local version for now.

Ironically, it was modified after the following:

Galan R=C3=A9mi <remi.galan-alfonso@ensimag.grenoble-inp.fr> writes:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > > +test_expect_success 'rebase -i respects rebase.missingCommitsChe=
ck=3Dignore' '
> > > +       test_config rebase.missingCommitsCheck ignore &&
> > > +       test_when_finished "git checkout master &&
> > > +               git branch -D tmp2" &&
> >
> > Strange indentation.
>=20
> Considering that 'git branch -D tmp2' is a part of test_when_finished=
,
> I wasn't sure of how it was supposed to be indented, so I did it this
> way to show that it was still within test_when_finished and not a
> separate command.
> >         test_when_finished "git checkout master &&
> >         git branch -D tmp2" &&
> Doesn't seem as clear, especially if you quickly read the lines.
>=20
> For now, I have removed the tab.

:p

Thanks,
R=C3=A9mi
