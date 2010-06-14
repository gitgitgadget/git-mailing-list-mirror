From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/2] Add infrastructure for translating Git with gettext
Date: Mon, 14 Jun 2010 23:56:46 +0200
Message-ID: <201006142356.46780.trast@student.ethz.ch>
References: <1275846453-3805-1-git-send-email-avarab@gmail.com> <1275846453-3805-2-git-send-email-avarab@gmail.com> <AANLkTikuSTKbPkTrRtw4fvNUxlh32uhTlbq0g-q35dng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 23:56:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOHeI-0005z8-7Y
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 23:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab0FNV4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 17:56:51 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:16706 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756810Ab0FNV4t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jun 2010 17:56:49 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 23:56:47 +0200
Received: from thomas.localnet (84.74.100.241) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 14 Jun
 2010 23:56:47 +0200
User-Agent: KMail/1.13.3 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.3; x86_64; ; )
In-Reply-To: <AANLkTikuSTKbPkTrRtw4fvNUxlh32uhTlbq0g-q35dng@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149139>

=C6var Arnfj=F6r=F0 Bjarmason wrote:
> It turns out that this doesn't actually work, and I can't find a
> workaround. In Bash and Solaris's /bin/sh this executes until "dies
> here". The problem is that I can't use the subshell trick, since the
> gettext.sh inclusion has to be done in the current shell (I checked,
> tests will fail).
>=20
>     #!/bin/sh
>     (. does-not-exist.sh)
>     echo "A subshell made it! ret =3D $?"
>     . does-not-exist.sh
>   # dies here
>     echo "A real shell made it! ret =3D $?"
>=20
> Is there some clever shellscript trick that I'm missing, or will I
> have to resort to modifying the file at `make' time for this to work
> everywhere?

Works for me in bash (4.0.35), but fails the way you say in dash (if
only I could figure out the option that tells me the version!).

This works however:

  type does-not-exist.sh 2>/dev/null && . does-not-exist.sh

I suspect it only works if the script is executable, as otherwise type
would not find it (but . would).  But at least on my system, it is.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
