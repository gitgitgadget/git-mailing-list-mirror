From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUGS] test failure in t4014-format-patch.sh with master
Date: Thu, 17 Apr 2008 17:34:21 +0200
Message-ID: <20080417153421.GA13117@atjola.homenet>
References: <87od88eslq.dlv@maison.homelinux.org> <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 17 18:02:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmW8m-0007tE-UT
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 17:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933127AbYDQPe0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Apr 2008 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbYDQPe0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 11:34:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:34039 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932753AbYDQPeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 11:34:25 -0400
Received: (qmail invoked by alias); 17 Apr 2008 15:34:23 -0000
Received: from i577AFE10.versanet.de (EHLO atjola.local) [87.122.254.16]
  by mail.gmx.net (mp011) with SMTP; 17 Apr 2008 17:34:23 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+PxnEOKjGPPv0GBHzMcT6hJi+MTS/ATV83yozukU
	zjR9G6rUc7Vnsl
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804170806430.2879@woody.linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79798>

On 2008.04.17 08:11:52 -0700, Linus Torvalds wrote:
>=20
>=20
> On Thu, 17 Apr 2008, Remi Vanicat wrote:
> >=20
> > While trying to wrote a test for git, I discover that there is a te=
st
> > failure in master on my computer:
>=20
> Hmm. Doesn't fail for me.
>=20
> > $ ./t4014-format-patch.sh
> > [....]
> > * FAIL 8: replay did not screw up the log message
> >=20
> >  git cat-file commit rebuild-1 | grep "^Side .* with .* backslash-n=
"
> >=20
> > It seem that now, somewhere a \n has been interpreted as a newline.
>=20
> I wonder if it is some shell-specific variable expansion issue. What'=
s=20
> your /bin/sh? (I assume, from your email address, that you're using=20
> Debian, and I thought Debian used bash, but maybe that's not true).
>=20
> What does
>=20
> 	a=3D"hello\nhi"
> 	echo $a
>=20
> result in?

Debian has its own dash which is supposed to be a lightweight
alternative to bash and "for checking POSIX compliance of scripts"
(quote from the packages description). I don't happen to know off-hand
whether POSIX says that echo should default to -e, but dash seems to do
that:

$ dash
$ a=3D"hello\nhi"
$ echo $a
hello
hi

Bj=F6rn
