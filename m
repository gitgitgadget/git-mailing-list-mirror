From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] push: mention "git pull" in error message for non-fast forwards
Date: Mon, 02 Aug 2010 21:52:16 +0200
Message-ID: <vpqfwywdc7j.fsf@bauges.imag.fr>
References: <1280756564-3932-1-git-send-email-Matthieu.Moy@imag.fr>
	<20100802191211.GA2180@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:53:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og14c-0002dK-9d
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab0HBTxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 15:53:17 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40665 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495Ab0HBTxQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 15:53:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o72JoF5G014405
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Aug 2010 21:50:15 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Og13Z-000229-5c; Mon, 02 Aug 2010 21:52:17 +0200
In-Reply-To: <20100802191211.GA2180@burratino> (Jonathan Nieder's message of "Mon\, 2 Aug 2010 14\:12\:49 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 02 Aug 2010 21:50:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o72JoF5G014405
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281383417.18503@DGdutSRbjA9dW2ES5T6p0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152445>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This reminds me: sometimes people blindly =E2=80=9Cgit pull=E2=80=9D =
a rebased history
> just to avoid a non-fast-forward push, and it irks me to no end.  So =
if
> I were running the world, the output would be:
>
>  error: rejected non-fast-forward push to '<url>'
>  hint: To prevent you from losing history, non-fast-forward updates a=
re
>  hint: rejected by default.
>  hint: See the 'Note about fast-forwards' section of 'git push --help=
'
>  hint: for details.

If you were running the world, you'd still need to add stg like

   YES, I DO MEAN IT, RTFM BEFORE ANYTHING ELSE, AND DON'T COMPLAIN
   BEFORE YOU REACH THE END OF THE MANPAGE.

or so, at least if your friends look like my students ;-)

> and the relevant section of the manual would explain that
>
>  1. if upstream is ahead of you, you may want to "git pull"
>
> but
>
>  2. if upstream rebased, you may want to "git pull --rebase", and
>     yell at upstream a little while at it.
>
> and
>
>  3. if the history you are pushing to is both (1) known to be unstabl=
e
>     and (2) wrong, you can override it with
>     "git push <remote> +<refspec>".  Be sure to make sure the
>     =E2=80=9C[receive] denyNonFastForwards=E2=80=9D setting is unset =
correctly in this
>     case.

It's not that far from what the manpage says indeed (it talks about
--force instead of +<refspec>, and mentions both pull and pull
--rebase). But when the user reached the point where (s)he's wiling to
read the doc and finds it interesting, then (s)he'll also read about
advice.pushNonFastForward and get rid of the whole (now useless)
message ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
