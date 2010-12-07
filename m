From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] describe: =?utf-8?B?RG9u4oCZ?=
	=?utf-8?Q?t?= look up commits with --exact-match
Date: Tue, 7 Dec 2010 10:58:18 +0100
Message-ID: <20101207095818.GB1867@neumann>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
	<20101203084348.GD18202@burratino>
	<alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
	<20101206073214.GA3745@burratino>
	<alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 10:59:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPuK9-00006c-R6
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 10:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab0LGJ67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 04:58:59 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:60096 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab0LGJ66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 04:58:58 -0500
Received: from localhost6.localdomain6 (p5B13086E.dip0.t-ipconnect.de [91.19.8.110])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0LgcCX-1Ocry21WkP-00nbxK; Tue, 07 Dec 2010 10:58:19 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:3jzaq8A04JDf+JM8WO1o9mRsBeFeGh0bWGXb2VVa3+Q
 kjOJgqBDgTnVyxkuYC1okU12boYGRzPVtcoOMl7BY+QCkK/iue
 Px0E+i8DtAgcoFh3XKJXZz8C9tIqOjtiQ5WdCN8IRUzIfLD4Gf
 ORZqF0lI/dzVS/rM8im79P2iTD8EG3T8D4t4mQ9DF4T/7quA0v
 33Zl0qdRipv9Xo71sRHHA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163074>

Hi,

On Mon, Dec 06, 2010 at 12:28:59PM -0500, Anders Kaseorg wrote:
> This makes =E2=80=98git describe --exact-match HEAD=E2=80=99 about 15=
 times faster on
> a cold cache (2.3s instead of 35s) in a linux-2.6 repository with man=
y
> packed tags.  That=E2=80=99s a huge win for the interactivity of the =
__git_ps1
> shell prompt helper.

I wanted to give it a try to see the performance improvements in the
bash prompt for myself, but couldn't get to it so far.  However,
glancing through the logic finding out the current branch in
__git_ps1, it seems that git describe is only run when git
symbolic-ref HEAD failed, i.e. when on a detached head.  So the
performance improvement in the shell prompt is only there when on a
detached head (and with lots of tags), right?  If so, then I'd like to
have "when on a detached head" appended to the commit message.


Best,
G=C3=A1bor
