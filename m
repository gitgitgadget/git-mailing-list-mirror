From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] import memmem() with linear complexity from Gnulib
Date: Sat, 28 Feb 2009 23:44:01 +0100
Message-ID: <20090228224401.GA27262@glandium.org>
References: <cover.1235629933.git.gitster@pobox.com> <cd73512d11e63554396983ed4e9556b2d18b3e4a.1235629933.git.gitster@pobox.com> <49A88FA7.1020402@lsrfire.ath.cx> <7vy6vrgxnn.fsf@gitster.siamese.dyndns.org> <7v8wnrgkjw.fsf@gitster.siamese.dyndns.org> <49A937B8.1030205@lsrfire.ath.cx> <7vmyc6foj3.fsf@gitster.siamese.dyndns.org> <1235848615.7043.30.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Feb 28 23:46:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdXwW-0002YQ-Lr
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 23:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbZB1WoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 17:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbZB1WoL
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 17:44:11 -0500
Received: from vuizook.err.no ([85.19.221.46]:39233 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487AbZB1WoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 17:44:09 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LdXuS-0006yl-N7; Sat, 28 Feb 2009 23:43:56 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LdXub-0007H0-65; Sat, 28 Feb 2009 23:44:01 +0100
Content-Disposition: inline
In-Reply-To: <1235848615.7043.30.camel@ubuntu.ubuntu-domain>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111798>

On Sat, Feb 28, 2009 at 08:16:55PM +0100, Ren=E9 Scharfe wrote:
> Gnulib and glibc have gained a memmem() implementation using the Two-=
Way
> algorithm, which needs constant space and linear time.  Import it to
> compat/ in order to replace the simple quadratic implementation there=
=2E
>=20
> memmem.c and str-two-way.h are copied verbatim from the repository at
> git://git.savannah.gnu.org/gnulib.git, with the following changes to
> memmem.c to make it fit into git's build environment:
>=20
> 	21,23c21
> 	< #ifndef _LIBC
> 	< # include <config.h>
> 	< #endif
> 	---
> 	> #include "../git-compat-util.h"
> 	40c38
> 	< memmem (const void *haystack_start, size_t haystack_len,
> 	---
> 	> gitmemmem(const void *haystack_start, size_t haystack_len,
>=20
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  Makefile             |    1 +
>  compat/memmem.c      |  103 +++++++++----
>  compat/str-two-way.h |  429 ++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 504 insertions(+), 29 deletions(-)

Seeing how much memmem is being used in the codebase, is it really wort=
h?

Mike
