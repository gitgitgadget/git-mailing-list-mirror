From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of
 @{-1}
Date: Wed, 6 Apr 2016 22:05:19 +0200 (CEST)
Message-ID: <980248197.3116219.1459973119988.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com> <972993506.2587877.1459438308676.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CAJPOeMeqMpy8wmZ3jMfw_XLAS2WbPOtJF8_Rd_sPGQNeCNyFnw@mail.gmail.com> <1048705176.2897167.1459806794368.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CAJPOeMeAQVR9ZvEC+r24P-RZq46iAeVx3CrLNbGXBGE8jw-iUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: elena petrashen <elena.petrashen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 22:01:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1antdu-0002Sc-0x
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 22:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbcDFUB2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 16:01:28 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:49288 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753115AbcDFUB1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Apr 2016 16:01:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1A17C217F;
	Wed,  6 Apr 2016 22:01:23 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcdMOZDspdHp; Wed,  6 Apr 2016 22:01:23 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 044B2217D;
	Wed,  6 Apr 2016 22:01:23 +0200 (CEST)
In-Reply-To: <CAJPOeMeAQVR9ZvEC+r24P-RZq46iAeVx3CrLNbGXBGE8jw-iUA@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: branch -D: allow - as abbreviation of @{-1}
Thread-Index: QxXVrS2OHsaGFzyELE+5KKD/YEF42w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290865>

elena petrashen <elena.petrashen@gmail.com> wrote:
> On Tue, Apr 5, 2016 at 12:53 AM, Remi Galan Alfonso
> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> > elena petrashen <elena.petrashen@gmail.com> wrote:
> >> On Thu, Mar 31, 2016 at 6:31 PM, Remi Galan Alfonso
> >> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> >> > Elena Petrashen <elena.petrashen@gmail.com> wrote:
> >> >> +void delete_branch_advice(const char *name, const char *ref)
> >> >> +{
> >> >> +        const char fmt[] =3D
> >> >> +        "\nNote: to restore the deleted branch:\n\ngit branch =
%s %s\n";
> >> >
> >> > Shouldn't that be marked for translation, like is done with the =
other
> >> > strings?
> >> >
> >> > Thanks,
> >> > R=C3=A9mi
> >>
> >> Thank you for letting me know about that! Could you please
> >> help me out and explain how do I mark it for translation? I tried
> >> to do it the same way as with the other strings but evidently
> >> didn't quite succeed.
> >
> > I am not sure.
> > I tried to grep similar cases, it seems that you can do the followi=
ng:
> >
> >         const char fmt[] =3D N_("\nNote: to restore [...] \ngit bra=
nch %s %s\n");
> >         fprintf(stderr, _(fmt), name, ref);
> >
> > Some similar example in builtin/add.c:
> >
> >         static const char ignore_error[] =3D
> >         N_("The following paths are ignored by one of your .gitigno=
re files:\n");
> >         [...]
> >                         fprintf(stderr, _(ignore_error));
> >
> > Or you can define fmt as a 'const char *' and in that case do the
> > following:
> >
> >         const char *fmt =3D _("\nNote: to restore [...] \n git bran=
ch %s %s\n");
> >         fprintf(stderr, fmt, name, ref);
> >
> >
> > In builtin/am.c:
> >                 const char *invalid_line =3D _("Malformed input lin=
e: '%s'.");
> >         [...]
> >                                 ret =3D error(invalid_line, sb.buf)=
;
> >
> > I don't know which one is the best way to go though.
> >
> > Thanks,
> > R=C3=A9mi
>=20
> Thank you! I'm a bit confused though as the previous implemented advi=
ce function
> in advice.c (the one I used for reference) doesn't seem to employ thi=
s... does
> this mean it's also not marked for translation?
>=20
> void detach_advice(const char *new_name)
> {
> const char fmt[] =3D
> "Note: checking out '%s'.\n\n"
> "You are in 'detached HEAD' state. <.........>Example:\n\n"
> "  git checkout -b <new-branch-name>\n\n";
>=20
> fprintf(stderr, fmt, new_name);
> }

It doesn't seem so, at least it doesn't translate:

# $ LANG=3Dfr_FR.UTF-8 git checkout 9494c39
# Note: checking out '9494c39'.
#=20
# You are in 'detached HEAD' state. You can look around, make experimen=
tal
# changes and commit them, and you can discard any commits you make in =
this
# state without impacting any branches by performing another checkout.
#=20
# If you want to create a new branch to retain commits you create, you =
may
# do so (now or later) by using -b with the checkout command again. Exa=
mple:
#=20
#   git checkout -b <new-branch-name>
#=20
# HEAD est maintenant sur 9494c39... Sync with Git 2.8.1
Only the last line is translated.

Blame traces it back to commit 2857093b that was in 2012 so obviously
the lack of translation isn't due to the message being recent.

Thanks,
R=C3=A9mi
