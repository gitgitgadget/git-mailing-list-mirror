From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: Recent gits corrupts repository
Date: Thu, 27 Oct 2011 09:30:59 +0200
Message-ID: <CAA787rmRqacu62O0Mzo4QYT=7FeB92QPvFUCuSBJ5__KMw92pA@mail.gmail.com>
References: <CAA787rnrG-mLRpq_a3xbbUyYuHz1kfdOzMqHQpxhBwc0rjt3Ww@mail.gmail.com>
	<vpqk47qc40s.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 27 09:31:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJKQg-0005Uo-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 09:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934Ab1J0HbC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Oct 2011 03:31:02 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46157 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779Ab1J0HbB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2011 03:31:01 -0400
Received: by qabj40 with SMTP id j40so2258344qab.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vONKLbdI8RxBFP4KJaisHJGDWe/NH4b5xQ+LcnP5cHo=;
        b=dPBOo6kEhz+Ajxeep6+0/z1tGUGNf6lX1ooKOZNXpmOxFEIsUls31fXj+rnQXO3UTn
         WA7sdHrY6+PfKZ4xTMw9RAMxTVDmpTN2Bq7mJfe2SGiXdep2EJjwrF3zT3sfD05KOgQs
         1dJM40SxbdDUO4Ao8/q4GiFPckk150ta//lGU=
Received: by 10.68.34.226 with SMTP id c2mr71844807pbj.99.1319700659750; Thu,
 27 Oct 2011 00:30:59 -0700 (PDT)
Received: by 10.142.135.5 with HTTP; Thu, 27 Oct 2011 00:30:59 -0700 (PDT)
In-Reply-To: <vpqk47qc40s.fsf@bauges.imag.fr>
X-Google-Sender-Auth: qmtxvNmIxA2YK32A-vLb84o-04E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184287>

On 27 October 2011 09:00, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> w=
rote:
> =C3=98yvind A. Holm <sunny@sunbase.org> writes:
> >   $ git status
> >   git: malloc.c:3096: sYSMALLOc: Assertion `(old_top =3D=3D (((mbin=
ptr)
> > (((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (stru=
ct
> > malloc_chunk, fd)))) && old_size =3D=3D 0) || ((unsigned long) (old=
_size)
> > >=3D (unsigned long)((((__builtin_offsetof (struct malloc_chunk,
> > fd_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t=
)))
> > - 1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end &
> > pagemask) =3D=3D 0)' failed.
> >   Aborted
>
> This looks very much like
>
>  http://thread.gmane.org/gmane.comp.version-control.git/184094
>
> for which a patch is pending in "next":
>
>  8f41c07 read-cache.c: fix index memory allocation

Argh, that was some wasted hours, should have searched the mailing list
first. But hey, I'm not complaining. :) Glad there's a fix coming up. I
cherry-picked 8f41c07, and it seems to work nicely. Thanks.

Regards,
=C3=98yvind
