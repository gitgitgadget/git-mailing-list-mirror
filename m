From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: git-ls-files --added?
Date: Mon, 25 May 2009 11:31:42 +0400
Message-ID: <85647ef50905250031m375a14d9y252444a8bdc250b5@mail.gmail.com>
References: <2cfc40320905240054j2c08da8bt4df95c6f1bc9e254@mail.gmail.com>
	 <m3fxeudhho.fsf@localhost.localdomain>
	 <2cfc40320905240212jc111b1xfeb39b1851c606d3@mail.gmail.com>
	 <7vmy921i3j.fsf@alter.siamese.dyndns.org>
	 <7vws85y9n7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 25 09:34:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8Uh6-0002Wu-8H
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 09:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbZEYHbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 03:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753707AbZEYHbn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 03:31:43 -0400
Received: from mail-fx0-f168.google.com ([209.85.220.168]:49380 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbZEYHbl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 03:31:41 -0400
Received: by fxm12 with SMTP id 12so1125507fxm.37
        for <git@vger.kernel.org>; Mon, 25 May 2009 00:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2aa1rY7d5ffwuqiN4YWp+pvBMnHIb1AEsw6vjKDIcOY=;
        b=E1aXpPJ/197pEGVQJHoCnZOJnEHUtBoK1WaArsaHoM5aGf6+sGksGeS45BZQevQS7H
         9MXO56CJPqY5ruJMspGM+EzjsK9uP6+lbroC9DiV1zuqVCqCWhVde+6gpvuGXbbx0AXl
         Qru82k81Abib7Tz0atWB+0Gu1/cebV7VqQRNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Us2cWkktLUXdzv8wcyIGReQuBRfxwxxp7LYYyYLjvcyQW/3Tqx/v4VMDfD9ayTvGeP
         JfZjTmnPP1/cQQErvrD7MW9dneMnC2DNtLiEkyoBDWZP0yf/lSp0bAignKmCqwjJ35hV
         yzfMBsQLbm7of9Bq6dAFEMm6KntDj+0RAJxdE=
Received: by 10.204.69.133 with SMTP id z5mr6646539bki.163.1243236702186; Mon, 
	25 May 2009 00:31:42 -0700 (PDT)
In-Reply-To: <7vws85y9n7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119892>

On Mon, May 25, 2009 at 10:33 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jon Seymour <jon.seymour@gmail.com> writes:
>> ...
>>> I am still interested in the rationale for git-ls-files not support=
ing
>>> such an option directly, since git-diff still seems a little indire=
ct.
>>
>> Partly historical, but more fundamental reason is because ls-files
>> plumbing is about the index.
>> ...
>> Added is _not_ about comparision between the index and the work tree=
=2E =A0It
>> is between the HEAD commit and the index, and it does not belong to
>> ls-files plumbing.
>
> Having said all that, I think you might be interested in pursuing
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/97830/focus=
=3D99134
>
> Also, the following thread may serve as a food for thought; it shows =
that
> there is real need for some concise, easy to parse output for people =
who
> want their own Porcelain.
>
> =A0http://thread.gmane.org/gmane.comp.version-control.git/106122/focu=
s=3D108110
>
> In short, ls-files and diff-index _can_ give you what you want, but o=
ften
> people would want information from both, consolidated.

I'm one of those people :) Writing git support for IDEs is quite
tricky at times, and status check was one of quite unpleasant
experiences.

BTW git-diff won't work in situation when the directory was just
initialized and there were no commit. In that case added file =3D stage=
d
file and it is possible to use git-ls-files.

Constantine
