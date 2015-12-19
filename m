From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: git leaves behind .git/COMMIT_EDITMSG non-shared in --shared non-bare repo
Date: Sat, 19 Dec 2015 13:40:04 +0100
Message-ID: <1450528804-669-1-git-send-email-szeder@ira.uka.de>
References: <alpine.DEB.2.20.1512191137450.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Yaroslav Halchenko <yoh@onerussian.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 19 13:41:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAGpd-00010G-4U
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 13:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027AbbLSMlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Dec 2015 07:41:14 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:42743 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932933AbbLSMlN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Dec 2015 07:41:13 -0500
Received: from x590d6c76.dyn.telefonica.de ([89.13.108.118] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1aAGot-0006ZV-MI; Sat, 19 Dec 2015 13:41:08 +0100
X-Mailer: git-send-email 2.7.0.rc0.37.g77d69b9
In-Reply-To: <alpine.DEB.2.20.1512191137450.6483@virtualbox>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1450528868.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282745>

> On Fri, 18 Dec 2015, Yaroslav Halchenko wrote:
>=20
> > Not sure for what batch operations that file is actually useful,
>=20
> None. This file is written when you commit interactively. It is delet=
ed
> afterwards, unless aborted in a fatal manner.

Is it?  I have a COMMIT_EDITMSG lying around in just about every git
repository I have and couldn't find any unlink() in builtin/commit.c
or elsewhere that would remove it.  In fact, not deleting it seems to
be the desired bahavior, because many tests in t7502-commit.sh depend
on this file still being present after a successful 'git commit'.

G=C3=A1bor
