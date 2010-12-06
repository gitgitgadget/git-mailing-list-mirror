From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] describe: 
 =?utf-8?q?Don=E2=80=99t_look_up_commits_with?= --exact-match
Date: Mon, 6 Dec 2010 11:53:59 +0100
Message-ID: <201012061153.59635.trast@student.ethz.ch>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Anders Kaseorg <andersk@ksplice.com>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>,
	SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 11:54:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPYhu-00031Y-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 11:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab0LFKyD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 05:54:03 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:45857 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab0LFKyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 05:54:01 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 6 Dec
 2010 11:53:41 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Mon, 6 Dec
 2010 11:54:00 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <20101206073214.GA3745@burratino>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162991>

Jonathan Nieder wrote:
> Anders Kaseorg wrote:
> > On Fri, 3 Dec 2010, Jonathan Nieder wrote:
>=20
> >> Instead of looking up the commit to be matched exactly in the comm=
its
> >> hash table, this makes a linear search.
> [...]
> > I don=E2=80=99t think it=E2=80=99s ever a problem: in my repository=
 with 1800 tags on a=20
> > warm cache, that loop accounts for about 0.1% of even the fastest=20
> > non-exact-match query (a commit right after a tag).
>=20
> Thanks for checking.  Makes sense.

Apart from measuring: for_each_ref *loads* the tags in a linear scan,
so another linear scan doesn't add to the runtime w.r.t. number of
tags.  It only hurts if you also describe many refs in one go.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
