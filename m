From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 20:05:52 +0200
Message-ID: <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
 <4FD89DD6.1070705@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Zbigniew =?utf-8?b?SsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerxB-0001ID-5e
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 20:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab2FMSF5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 14:05:57 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:42350 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754507Ab2FMSF5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 14:05:57 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id 727561A024F;
	Wed, 13 Jun 2012 20:05:53 +0200 (CEST)
Received: from reverse.completel.net (reverse.completel.net [92.103.38.66])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Wed, 13 Jun
 2012 20:05:52 +0200
In-Reply-To: <4FD89DD6.1070705@in.waw.pl>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199914>


Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> a =C3=A9crit=C2=A0=
:

> On 06/12/2012 04:46 PM, Junio C Hamano wrote:
>> I do not think it is worth another round of resend at this point, so
>> please eyeball the version I fixed up and queued in 'pu' when it is
>> pushed out.  I also moved the '-x <cmd>::' option description to
>> where it belongs (iow, not at the very beginning).
>
> Hi,
> I think some small changes are still in order. Please consider
> squashing this in:
>
> -----8<------
> Subject: [PATCH] squash! rebase -i: teach "--exec <cmd>"
>
> In the commit message: s/each runs/each run/
>
> Fixup to the documentation part:
> - Use the phrase "after each commit in the final history" from Junio'=
s
>   commit message to replace "each commit application". The latter is
>   awkward and not really true.


After reading again the sentence, I find that the new expression is =20
more appropriate
when it comes to the "--autosquash" case (here, "in the final history" =
=20
is clearer than
"application"). Thus, the new formulation seems good to me.

> - Reorder paragraphs and reword the one about --interactive.
>   Make the part about two forms of exec less verbose.

Less verbose and avoid some repetitions. But...

> +You may execute several commands by either using one instance of `--=
exec`
> +with several commands:
>  +
> -You can also insert several instances of `--exec`, if you wish to on=
ly
> -have one command per line. For example:
> +	git rebase -i --exec "cmd1 && cmd2 && ..."
>  +
> -	git rebase -i --exec "cmd1" --exec "cmd2" ...
> +or equivalently by giving more than one `--exec`:

=2E..I'm against using "equivalently" as in the first case, all the com=
mands
are on one line, and in the second case, each commands have its line, t=
hus
easier for the user to manipulate them independently.

> - Replace ';' with '&&' in the example. This (a) makes the two
>   examples equivalent, and (b) encourages good practice that we try
>   to follow in git tests to never fail silently. People are likely
>   to copy the example verbatim.

Why not.
