From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: Re: [patch] Import "git-forest" into contrib/
Date: Wed, 19 Mar 2008 23:23:55 +0100 (CET)
Message-ID: <alpine.LNX.1.00.0803192301330.25695@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.00.0803181924560.8851@fbirervta.pbzchgretzou.qr> <20080319211140.GK2663@genesis.frugalware.org> <alpine.LNX.1.00.0803192222350.25695@fbirervta.pbzchgretzou.qr> <7v4pb22xgc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:26:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6jY-0003wj-Tu
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935447AbYCSWYA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2008 18:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940892AbYCSWX6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:23:58 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:48218 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbYCSWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:23:56 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 15EFF18030642; Wed, 19 Mar 2008 23:23:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 0A1BF1C00E290;
	Wed, 19 Mar 2008 23:23:55 +0100 (CET)
In-Reply-To: <7v4pb22xgc.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77572>


On Mar 19 2008 14:52, Junio C Hamano wrote:
>
> git also expects the kernel style e-mails, and it is _NOT_ "dump outp=
ut
> from 'git show' in the message, commit/Author:/Date: headers and mess=
age
> indented by 4-spaces" format.

Actually, it's `git log -1 -p` that I used. PINE traditionally
trashes the direct mbox output of git, i.e. Message-ID is rewritten
by PINE again when using Continue Postponed, but apparently only on
non-PINE messages to begin with. I just recently switched to alpine,
maybe it's better there.

> As to the contents, I did not understand this part.
>
> +Notes on interpretation:
> +
> +'=E2=95=AC' (or variants thereof, like =E2=95=AA) is meant to be a "=
path bridge", i.e.
> +traversal is only "allowed" horizontal OR vertical direction.
> +
> +Branching:
> +C D E F G
> +=E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=E2=95=
=90=E2=95=9D  A->{C,E,F,G} and B->D.
> +A B
>
> So the horizontal line bridge goes over the vertical road between B a=
nd D
> and these two will not get connection to anything else.  That part I
> understand.
>
> (1) Why then is that horizontal bridge connected to E, F and G?  Do
>     pluses and inverted Ts have different meaning?  What about the
>     sideway T between A and C?

> Did you mean "Connection with three legs (T, inverted T, sideways T) =
mean
> all sides are connected, connection with four legs (+) mean horizonta=
l and
> vertical are independent and disconnected"?

Yes. Would

#       Connections with four "legs" ('=E2=95=AC' or variants thereof, =
like
#       '=E2=95=AA') are=20
#       meant to be interpreted as being connected only in the
#       horizontal and=20
#       vertical direction, NOT around-the-corner.=20
#=20
#       Connections with three or less "legs" ('=E2=95=A0', '=E2=95=A9'=
, '=E2=95=A6', etc.)
#       imply=20
#       a connection to all connected directions.

work as help text?

> (2) If you want to express D is merge between A and B, and C, E, F, G=
 are
>     independent children of A, how would you write it?

A..G in the above are actually placeholders for more wood
instead of placeholders for commits.

So (one possible) answer to your question=C2=A0=E2=80=94 since you can =
only
be referring to commits :-)=C2=A0=E2=80=94 would be:


=E2=95=93=E2=94=80[master]=E2=94=80=E2=94=80[G]=E2=94=80=E2=94=80sm7
=E2=95=91 =E2=95=93=E2=94=80[F]=E2=94=80=E2=94=80sm6
=E2=95=91 =E2=95=91 =E2=95=93=E2=94=80[E]=E2=94=80=E2=94=80sm5
=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=93=E2=94=80[C]=E2=94=80=E2=94=80sm=
4
=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=91 =E2=95=93=E2=94=80[D]=E2=94=80=E2=
=94=80something3
=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=91 =E2=95=A0=E2=95=90=E2=95=97=20
=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=91 =E2=95=9F=E2=94=80=E2=95=91=E2=94=
=80[B]=E2=94=80=E2=94=80something2
=E2=95=A0=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=E2=95=90=
=E2=95=AC=E2=95=90=E2=95=9D=20
=E2=95=9F=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=95=91=E2=94=80[A]=E2=94=80=E2=94=80something1
=E2=95=A0=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=9D=20
=E2=95=99 Initial

depending on the order you committed (or flags like
--date-order/--topo-order).

If one commit is added to D, the picture shifts a bit:

=E2=95=93=E2=94=80[master]=E2=94=80=E2=94=80c8
=E2=95=91 =E2=95=93=E2=94=80[G]=E2=94=80=E2=94=80sm7
=E2=95=91 =E2=95=91 =E2=95=93=E2=94=80[F]=E2=94=80=E2=94=80sm6
=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=93=E2=94=80[E]=E2=94=80=E2=94=80sm=
5
=E2=95=91 =E2=95=91 =E2=95=91 =E2=95=91 =E2=95=93=E2=94=80[C]=E2=94=80=E2=
=94=80sm4
=E2=95=9F=E2=94=80=E2=95=91=E2=94=80=E2=95=91=E2=94=80=E2=95=91=E2=94=80=
=E2=95=91=E2=94=80[D]=E2=94=80=E2=94=80something3
=E2=95=A0=E2=95=90=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=E2=95=AC=E2=95=90=
=E2=95=AC=E2=95=90=E2=95=97=20
=E2=95=9F=E2=94=80=E2=95=91=E2=94=80=E2=95=91=E2=94=80=E2=95=91=E2=94=80=
=E2=95=91=E2=94=80=E2=95=91=E2=94=80[B]=E2=94=80=E2=94=80something2
=E2=95=91 =E2=95=A0=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=E2=95=90=E2=95=A9=
=E2=95=90=E2=95=9D=20
=E2=95=91 =E2=95=9F=E2=94=80[A]=E2=94=80=E2=94=80something1
=E2=95=A0=E2=95=90=E2=95=9D=20
=E2=95=99 Initial
