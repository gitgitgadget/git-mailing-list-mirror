From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 08:44:07 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804170841270.2879@woody.linux-foundation.org>
References: <87od88eslq.dlv@maison.homelinux.org> <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org> <20080417153421.GA13117@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 17 17:57:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmWJh-0002LL-GU
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 17:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbYDQPpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 11:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbYDQPpn
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 11:45:43 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46929 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754739AbYDQPpm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 11:45:42 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HFi82O003693
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Apr 2008 08:44:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HFi7JM015563;
	Thu, 17 Apr 2008 08:44:07 -0700
In-Reply-To: <20080417153421.GA13117@atjola.homenet>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.977 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79796>



On Thu, 17 Apr 2008, Bj=F6rn Steinbrink wrote:
>=20
> Debian has its own dash which is supposed to be a lightweight
> alternative to bash and "for checking POSIX compliance of scripts"
> (quote from the packages description). I don't happen to know off-han=
d
> whether POSIX says that echo should default to -e, but dash seems to =
do
> that:
>=20
> $ dash
> $ a=3D"hello\nhi"
> $ echo $a
> hello
> hi

Ahh. So that "echo" should just be replaced with a 'printf "%s\n"'=20
instead?=20

We have a _lot_ of "echo"s though. I suspect the only ones we'd ever ca=
tch=20
are the ones explicitly tested for. I suspect that the dash echo is jus=
t=20
broken.

		Linus
