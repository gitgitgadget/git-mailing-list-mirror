From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Thu, 24 May 2012 22:47:26 +0200
Message-ID: <20120524204726.GB2052@goldbirke>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ville =?iso-8859-1?Q?Skytt=E4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 22:47:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXewf-0003dB-Aq
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 22:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758593Ab2EXUrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 May 2012 16:47:37 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54229 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab2EXUrg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 16:47:36 -0400
Received: from localhost6.localdomain6 (p5B13046B.dip0.t-ipconnect.de [91.19.4.107])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0LckSJ-1RoBBY3RUF-00jqvE; Thu, 24 May 2012 22:47:28 +0200
Content-Disposition: inline
In-Reply-To: <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:8y0oEAA/a7t7LU7IusIGj2fg/vrFTe5Yp6ncc60r/Wt
 sJeNtfKYTmLz5Lh5VBlb122qhR/MjsQZq6j3THkJo6gNNdAp+K
 IdTVBJdF6uCvL94f09KQTBAfBZ9XRdz81VyioDxZ9/zBdZNjuI
 92Xxc0sEZN4h9kpBUH6PWXo1KCf2jGHGA2IdSSoJj5GoENs3rQ
 Od7ibBz2WdsB/p6kEqMJ0krjHauaS+d/TUv4KE1vPlOKb5SBlG
 v28JbRxLMDUSPXOHrfHnPyDtgnXnFI3b1pLt/OI/GLwnprNhcO
 mVkeB8X7bqXlcPiEEpE6bbspztUPpu5imnFzGzFIjMqee/moqN
 HJac+eHN4B6euPSFx4WI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198424>


Hi,


On Tue, May 22, 2012 at 10:46:40PM +0200, Felipe Contreras wrote:
> bash-completion 1.90 shipped=20

That's still beta, right?  (or the bash-completion website is out of
date...)

> with support to load completions
> dynamically[1], which means the git completion script wouldn't be loa=
ded
> until the user types 'git <tab>'--this creates a problem to people us=
ing
> __git_ps1(); that function won't be available when the shell is first
> created.
>=20
> For now distributions have workarounded this issue by moving the git
> completion to the "compatdir"[2]; this of course is not ideal.
>=20
> The solution, proposed by Kerrick Staley[3], is to split the git scri=
pt
> in two; the part that deals with __git_ps1() in one (i.e.
> git-prompt.sh), and everything else in another (i.e.
> git-completion.bash).

This breaks existing setups, where the user installs
git-completion.bash with 'make install', or where the user sources
git-completion.bash directly from the repository.


Best,
G=E1bor
