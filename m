From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git Scaling: What factors most affect Git performance for a large repo?
Date: Fri, 20 Feb 2015 17:38:53 +0100
Message-ID: <vpq38604jxe.fsf@anie.imag.fr>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	<20150220000320.GD5021@vauxhall.crustytoothpaste.net>
	<CAH8BJxEWDb0SDHPS_ZnPzz0QEbryw2GCv2RtJm2u_6rPH566hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOqbU-0004VR-S5
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 17:39:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754953AbbBTQi5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Feb 2015 11:38:57 -0500
Received: from mx2.imag.fr ([129.88.30.17]:56818 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbbBTQi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 11:38:56 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KGcp8q012996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 17:38:51 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KGcroa006062;
	Fri, 20 Feb 2015 17:38:53 +0100
In-Reply-To: <CAH8BJxEWDb0SDHPS_ZnPzz0QEbryw2GCv2RtJm2u_6rPH566hg@mail.gmail.com>
	(Stephen Morton's message of "Fri, 20 Feb 2015 11:06:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 20 Feb 2015 17:38:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KGcp8q012996
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425055132.14373@OHxodlG3lH/r1w5dpa42mw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264172>

Stephen Morton <stephen.c.morton@gmail.com> writes:

> 1. =C6var : I'm a bit concerned by your statement that git rebases ta=
ke
> about 1-2 s per commit. Does that mean that a "git pull --rebase", if
> it is picking up say 120 commits (not at all unrealistic), could
> potentially take 4 minutes to complete? Or have I misinterpreted your
> comment.

=C6var talked about "applied commits" during rebase. When you "git pull
--rebase", you fast-forward the history you just fetched, which is
almost instantaneous, and then you reapply your local history on top of
it.

So, the performance depends on how long your local history is, not on
how many commits you're fetching.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
