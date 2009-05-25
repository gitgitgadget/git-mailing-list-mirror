From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 09:19:30 +0200
Message-ID: <cb7bb73a0905250019y12e3747brff3c0b6a6523c41a@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7voctirzu6.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
	 <7vfxeurwh0.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
	 <fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com>
	 <cb7bb73a0905241553i2cf2c246ycd0b5466e60c8de8@mail.gmail.com>
	 <fabb9a1e0905241557l403037f6p7c1df1f587cb9cf7@mail.gmail.com>
	 <cb7bb73a0905241603r4949abb5g1a9e861aba40c6fe@mail.gmail.com>
	 <7vocthy9df.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 09:19:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8UTO-0005ne-GC
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbZEYHTc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 03:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbZEYHTb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:19:31 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:56420 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZEYHTb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 03:19:31 -0400
Received: by fxm12 with SMTP id 12so1119482fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 00:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7hYfaAx/bcAUZjlZnMyhsUzBKcKeCa0x9DILe82Pm/o=;
        b=b70yU4pWif6zy6Jnynwk16PGba6F2rYQ3pvOVIhFrNeIPy6Ky0BOZ5GyDTbq8jVbjg
         moZEKeHpmdynFR0FEMjA4wl9W7mZCs3vYcwXGsKOhhNwCT5vc5G+WzLx/ki2ZFrDNS0j
         id+jZHY854K7GJHbA/QLh3c9yCjpfga9T8SpE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D1gcNdgnRSjhY3nLuIfsXT4c4iVfxudtZlbGiZYhMWt1yGlYYQVNQSiYr5DJTBS4Di
         YV6P+kYvpNVtT7d/Ut2Vkp0ExNTslliACVzTdI+8LyrmjVi6u2nDLe0mHVK2u75Hmfmq
         i17/MUq5HJTjSDyezT4LEmYbduNP9X8xS12fI=
Received: by 10.204.101.13 with SMTP id a13mr6662311bko.89.1243235970620; Mon, 
	25 May 2009 00:19:30 -0700 (PDT)
In-Reply-To: <7vocthy9df.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119891>

On Mon, May 25, 2009 at 8:39 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> But then the name munge would not be descriptive of what the command
>> does. If git am is to be left untouched, I would rather then have
>> something like git import-patches that accepts patches in 'any'
>> format,...
>
> There is no need to introduce any new program, I think.

I'm not so sure about this, see below.

> Nobody is against your teaching the "git am" callchain to accept thin=
gs
> other than Berkeley mbox. =A0"git am" is "import-patches" in that sen=
se
> already.

I thought as much 8-)

> You can add a conditional (perhaps triggered by a "the patches are in=
 this
> format" command line option) to "git am"

I'd rather have autodetection than command line options, at least as
long as it can be done reliably enough.

> to alter the way it splits the
> input into individual pieces of e-mail, named 0001, 0002, 0003, ..., =
and
> leaves the total number of message in $dotest/last.
> Currently we call "git-mailsplit" to do all of that; your new conditi=
onal
> will take StGIT export, and instead of calling "git-mailsplit", read =
the
> series file and process individual patch files into 0001, 0002,... th=
at
> are in proper mbox format (i.e. you would need to fix the "Subject: "=
 less
> title line when you do this), and leave the total number of patches i=
n
> $dotest/last file.

Hm. It does make sense to have mail conversion at 'mailsplit' time.
The preprocessing would (1) explode any series, if present (2) convert
the patch from whatever format they are in into mbox format (3) put
them in place. (1) is what my git am patch does, so what we need is
essentially (2). For efficiency we could assume that the user does not
pass patches of different formats to us, so we peek at the first patch
and treat all of them as that kind of patch.

I do suspect that patch format conversion _does_ require an additional
program, in the sense that not doing so would make the git-am script
grow, and I'm not sure it would be very efficient. Is core git C+sh
only or can we rely on some Perl stuff? It'd probably be more
appropriate for this kind of job.

> With that change, the main loop that iterates 'while test "$this" -le
> "$last"' does not have to change, right?

Well, my proposed change git-munge | git-mailinfo would not be that
big of a change, but it does make sense to make the conversion early
on, as I mentioned above. It also makes it easier to debug the
conversion, as the result is kept in the dotest directory.

> We could for example add RMAIL format support in the same way.

No idea what that is.

--=20
Giuseppe "Oblomov" Bilotta
