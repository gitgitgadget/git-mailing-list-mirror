From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 0/2] StGit patch series import
Date: Mon, 25 May 2009 01:03:38 +0200
Message-ID: <cb7bb73a0905241603r4949abb5g1a9e861aba40c6fe@mail.gmail.com>
References: <1243149558-17160-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7voctirzu6.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241443m6b5d6ba4vab438c856e47a947@mail.gmail.com>
	 <7vfxeurwh0.fsf@alter.siamese.dyndns.org>
	 <cb7bb73a0905241518l43048416i34cb905c143c63e0@mail.gmail.com>
	 <fabb9a1e0905241528r7b5102b0w5d064727125654d@mail.gmail.com>
	 <cb7bb73a0905241553i2cf2c246ycd0b5466e60c8de8@mail.gmail.com>
	 <fabb9a1e0905241557l403037f6p7c1df1f587cb9cf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 01:04:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8MkD-0003Ba-G9
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 01:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753995AbZEXXDk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 May 2009 19:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753768AbZEXXDj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 May 2009 19:03:39 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:55789 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZEXXDi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 May 2009 19:03:38 -0400
Received: by fxm12 with SMTP id 12so983944fxm.37
        for <git@vger.kernel.org>; Sun, 24 May 2009 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2S/B0QCEO21h/Fs8zqKXQaYbv7PNMl8Cb5Xu2625z0A=;
        b=ItlPMvTc4koap7O82p3rtBsjZIzB0NBg3szrUwaaSZeamKAEUUMsGxQApXX8u4Wh6e
         nWHb1rxVNr9A+3fGlTEN4LcvBPF0q1tW40Y2SFK+fzgO3MJjJl9NdY+0LjVWY+Lk1A8t
         bOyVKrISujPH8hh1M1ic0Q1wg9MgUHlp+k5AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bTzpLbt3Drj+G5cYvFEZAMhLHGREAYGVDb5lkFtZR4wRrvZDxYX0TRjiSeMd2ec5ZJ
         ZFUObLONrnv++DqWMdF3i1Tm98TqgR81GkahrQPbH7ikP/LbaF+ySQCa1Xn/JpZiGNCj
         DNH/CxZmz9Itog2zS6oZdIoj/eS1ZpY7AgJVM=
Received: by 10.204.63.209 with SMTP id c17mr6274630bki.47.1243206219009; Sun, 
	24 May 2009 16:03:39 -0700 (PDT)
In-Reply-To: <fabb9a1e0905241557l403037f6p7c1df1f587cb9cf7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119874>

On Mon, May 25, 2009 at 12:57 AM, Sverre Rabbelier <srabbelier@gmail.co=
m> wrote:
> Heya,
>
> On Mon, May 25, 2009 at 00:53, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> This is an interesting solution. And git-am could call git-munge
>> automatically before feeding the patches to mailinfo, replacing
>> =A0git mailinfo $keep $utf8 "$dotest/msg" "$dotest/patch" \
>> =A0 =A0 =A0<"$dotest/$msgnum" >"$dotest/info"
>> with
>> =A0git munge "$dotest/$msgnum" | git mailinfo etc
>
> I was thinking the other way around, so that 'git am' doesn't need to
> be modified.
>
> Behind the scenes, git munge "$dotest/$msgnum" does something like:
> 1. munge the file so that it's in the appropriate format
> 2. dispatch to 'git am' with the munged file
> 3. profit

But then the name munge would not be descriptive of what the command
does. If git am is to be left untouched, I would rather then have
something like git import-patches that accepts patches in 'any'
format, expanding StGIT series into the respective patches and
transforming everything into mbox format, invoking am on the final
result. But I see no particular reason why git-am shouldn't be able to
handle all this by itself


--=20
Giuseppe "Oblomov" Bilotta
