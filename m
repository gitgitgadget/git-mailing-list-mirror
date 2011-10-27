From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Recent gits corrupts repository
Date: Thu, 27 Oct 2011 09:00:51 +0200
Message-ID: <vpqk47qc40s.fsf@bauges.imag.fr>
References: <CAA787rnrG-mLRpq_a3xbbUyYuHz1kfdOzMqHQpxhBwc0rjt3Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-1?Q?=D8yvind?= A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Thu Oct 27 09:01:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJJxZ-0003qN-A8
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 09:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab1J0HAz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 03:00:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37372 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab1J0HAz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 03:00:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9R6v6dc011864
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Oct 2011 08:57:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RJJxL-0004Z2-ET; Thu, 27 Oct 2011 09:00:51 +0200
In-Reply-To: <CAA787rnrG-mLRpq_a3xbbUyYuHz1kfdOzMqHQpxhBwc0rjt3Ww@mail.gmail.com>
	(=?iso-8859-1?Q?=22=D8yvind?= A. Holm"'s message of "Thu, 27 Oct 2011
 08:50:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Oct 2011 08:57:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9R6v6dc011864
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1320303427.47014@K/g8W79rpz8jbY9slLI3RA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184286>

=D8yvind A. Holm <sunny@sunbase.org> writes:

>   $ git status
>   git: malloc.c:3096: sYSMALLOc: Assertion `(old_top =3D=3D (((mbinpt=
r)
> (((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struct
> malloc_chunk, fd)))) && old_size =3D=3D 0) || ((unsigned long) (old_s=
ize)
>>=3D (unsigned long)((((__builtin_offsetof (struct malloc_chunk,
> fd_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t))=
)
> - 1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end &
> pagemask) =3D=3D 0)' failed.
>   Aborted

This looks very much like

  http://thread.gmane.org/gmane.comp.version-control.git/184094

for which a patch is pending in "next":

  8f41c07 read-cache.c: fix index memory allocation

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
