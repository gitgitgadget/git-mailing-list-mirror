From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git Intall problem:  cannot stat `lib/tclIndex'
Date: Mon, 2 Jul 2007 18:30:56 -0400
Message-ID: <20070702223055.GC4495@spearce.org>
References: <594387.97825.qm@web56006.mail.re3.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: free cycle <freecycler23@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 00:31:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5UQK-0001It-L1
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 00:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbXGBWbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 2 Jul 2007 18:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754855AbXGBWbA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 18:31:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53818 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbXGBWa7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 18:30:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I5UPw-0000e7-AY; Mon, 02 Jul 2007 18:30:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E59F20FBAE; Mon,  2 Jul 2007 18:30:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <594387.97825.qm@web56006.mail.re3.yahoo.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51418>

free cycle <freecycler23@yahoo.com> wrote:
>    I=E2=80=99m trying to install git and I have run the following ste=
ps:
>=20
>    make configure
>    ./configure --prefix=3D/p/tools/git
>    make all
>    make install
>=20
>    Everything works OK up until the =E2=80=9Cmake install=E2=80=9D st=
ep at which point I get the following error:
>     =20
>    install -m644 lib/tclIndex '/p/nhm/rtl/tools/git/share//git-gui/li=
b'
>=20
>    install: cannot stat `lib/tclIndex': No such file or directory

Sounds like you are trying to build a version of Git that doesn't
gracefully fallback when tclsh isn't available.  So I'm guessing
you don't have a tclsh in your $PATH, and that is why git-gui could
not create its lib/tclIndex.

Hmmph.  Even as far back as Git 1.5.2 git-gui used a fallback for
its lib/tclIndex when tclsh wasn't available or working properly.
We're currently on 1.5.2.3 (just released).

Please consider upgrading to the latest stable Git (1.5.2.3 or
1.5.2.2 if the .3 isn't available on your mirror of choice yet).

--=20
Shawn.
