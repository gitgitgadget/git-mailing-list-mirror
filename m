From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH RFC] Add a config verbose option fetch and push
Date: Sat, 22 May 2010 12:44:31 +0200
Message-ID: <201005221244.32213.trast@student.ethz.ch>
References: <4bf6b6f5.dd79dc0a.5533.2acd@mx.google.com> <AANLkTil-PDpdkcJaJn2FUrJrSIJ6lP0OcvY5l7HRorsa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>,
	<git@vger.kernel.org>,
	Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 12:45:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFmCX-0000sY-Se
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 12:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab0EVKpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 May 2010 06:45:00 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:56800 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054Ab0EVKo7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 06:44:59 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 22 May
 2010 12:44:57 +0200
Received: from thomas.localnet (129.132.211.235) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sat, 22 May
 2010 12:44:35 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTil-PDpdkcJaJn2FUrJrSIJ6lP0OcvY5l7HRorsa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147512>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> Since Peter Kjellerstedt wanted --ff-only, and you want --verbose. I
> wonder whether a better solution wouldn't be to farm this
> functionality out to the config parser.
[...]
>     [fetch "option"]
>         verbose =3D 1
>=20
> Is there any reason not to add such a general facility?

That would completely ruin the scriptability of almost all commands.
Imagine the user added the following options as default:

  add --edit
  checkout --patch
  cherry-pick --no-commit
  commit --amend
  pull --rebase

I'm sure you can find one option that changes the command in something
completely different *for every command*.

In fact even pull --ff-only has the same problem since it will refuse
the merge in cases where an unmodified pull would go through.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
