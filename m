From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 6 May 2012 23:09:49 +0200
Message-ID: <CAMP44s2ubKqDeYz9r+FM+bn88uZBpNtyU94_79q0af9MZeuG9A@mail.gmail.com>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
	<201205061221.29592.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 23:09:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR8iJ-0005Dc-AH
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 23:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab2EFVJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 17:09:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65129 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab2EFVJu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 17:09:50 -0400
Received: by eaaq12 with SMTP id q12so1230153eaa.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 14:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=okXpbWBmWZ6z/zi5Xp5Dk728rZCOIUWrWIuXsaG5EnE=;
        b=OHa75myFJ8h3WZ+BCt4KkKy1JCpgaEMESt1gp8Bn0DNASkTwBMp88PSysOaWXsp6wC
         tCgBoRvfwlAtg7yBlr9Nwm3eySRtFswiAKE+g4PmF75FX+xumQckjhMzR2rF6yZKGR+W
         H1hF0bHSPXC60y8qOsCw6EMpmtC3j4TC2ll3+Qpezj+CFJSReeJ7hrGOogYr18IYIOdV
         yYH0p+iUy1SW5jFT4VNq6zbpuxx7iaUtam5ZULOe7Y8kN2FGQopyLCzeLwLvMW764vKV
         XuxjktkOiJj747INHewRRWbgz9XUq5TBctwRCwbhtvwHb5Z2ZFB6f8oKn7zE3vv3CsFU
         zcHw==
Received: by 10.14.96.129 with SMTP id r1mr2280599eef.86.1336338589136; Sun,
 06 May 2012 14:09:49 -0700 (PDT)
Received: by 10.213.103.18 with HTTP; Sun, 6 May 2012 14:09:49 -0700 (PDT)
In-Reply-To: <201205061221.29592.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197213>

On Sun, May 6, 2012 at 12:21 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:

> Anyway another issue to resolve is '--cached' and '--index' command l=
ine
> options, as described in gitcli(7) manpage:
>
> =C2=A0Many commands that can work on files in the working tree
> =C2=A0and/or in the index can take `--cached` and/or `--index`
> =C2=A0options. =C2=A0Sometimes people incorrectly think that, because
> =C2=A0the index was originally called cache, these two are
> =C2=A0synonyms. =C2=A0They are *not* -- these two options mean very
> =C2=A0different things.
>
> =C2=A0 * The `--cached` option is used to ask a command that
> =C2=A0 =C2=A0 usually works on files in the working tree to *only* wo=
rk
> =C2=A0 =C2=A0 with the index. =C2=A0For example, `git grep`, when use=
d
> =C2=A0 =C2=A0 without a commit to specify from which commit to look f=
or
> =C2=A0 =C2=A0 strings in, usually works on files in the working tree,
> =C2=A0 =C2=A0 but with the `--cached` option, it looks for strings in
> =C2=A0 =C2=A0 the index.
>
> =C2=A0 * The `--index` option is used to ask a command that
> =C2=A0 =C2=A0 usually works on files in the working tree to *also*
> =C2=A0 =C2=A0 affect the index. =C2=A0For example, `git stash apply` =
usually
> =C2=A0 =C2=A0 merges changes recorded in a stash to the working tree,
> =C2=A0 =C2=A0 but with the `--index` option, it also merges changes t=
o
> =C2=A0 =C2=A0 the index as well.
>
> You can use '--staged' in place of '--cached', but what about '--inde=
x'?
> How do you replace it?

=46rom past discussions it was suggested to use --staged-only for
--cached, and --staged for --index in commands that need this
distinction. Alternatively it could be --cached -> --staged, --index
-> --stage-and-wd, or something like that.

Cheers.

--=20
=46elipe Contreras
