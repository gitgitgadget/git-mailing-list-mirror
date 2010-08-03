From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC/PATCH] git-compat-util.h: Don't define NORETURN under 
	__clang__
Date: Tue, 3 Aug 2010 21:10:34 +0000
Message-ID: <AANLkTinNkLNGjFrfmo5za_D10AkcMEMzA8yppA+H+YMe@mail.gmail.com>
References: <1280840883-24540-1-git-send-email-avarab@gmail.com>
	<vpq62zr24zw.fsf@bauges.imag.fr>
	<vpqvd7rzsfa.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 03 23:10:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgOkz-00006V-SL
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 23:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061Ab0HCVKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 17:10:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45391 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755695Ab0HCVKg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 17:10:36 -0400
Received: by ywh1 with SMTP id 1so1718670ywh.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=792NEFYQm9xkwT+CmqdllBC9WjlxJQfOMuN6F8uCbVE=;
        b=MuEO1NPsXWBwIP0h00PIfOn6Cerirw6oQ9jxjOJ1O9puQOpI1+KSXIw3EYYoLcd82T
         AN7iz8qnWWwTNV3RDSK5EyAnn+JpQIY3egWRR/s6gIR6mIDkzX+uW+s+nPSR+y2bZr4I
         gS2NYB+njTQp3db8OIBGqHA5aIJdkFPcIgRhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gjbTTYhfVDHxdYpDs4sEgPeZarKrT+l4pSGdm9Uq/v2U65orXoXvPbG0us8AIdDHFd
         i+PMkjLLPRUhlMiHMI9zpW/3qd66sLoG5qHdABGc7Sd1GYgV+SNUgFAGnBP5XG26QVpY
         IBrt1YDznkj2gBDpKo8WkmXmduos+US5qS89w=
Received: by 10.101.185.6 with SMTP id m6mr9019861anp.22.1280869834588; Tue, 
	03 Aug 2010 14:10:34 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 3 Aug 2010 14:10:34 -0700 (PDT)
In-Reply-To: <vpqvd7rzsfa.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152540>

Thanks everyone. I should have tested a later version of clang before
I sent the patch. It might still be worthwhile to munge the flags for
old clangs so that git doesn't error out on it, but if 1.0 doesn't
make it into some major OS release and gcc remains the default it's
not much of an issue.

On Tue, Aug 3, 2010 at 14:23, Matthieu Moy <Matthieu.Moy@grenoble-inp.f=
r> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> (other than that, it's cool to see someone testing another
>> compiler ;-) )
>
> BTW, the only warnings remaining with -Wall with my clang are:
>
> imap-send.c:548:27: warning: data argument not used by format string =
[-Wformat-extra-args]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 cmd->tag, cmd->cmd, cmd->cb.dlen);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^

I didn't look into that one. It'd be usefu to check out if the format
string is really incomplete there, or if clang is just failing it its
analysis.

That's some hairy code, in any case.

> imap-send.c:1089:41: warning: conversion specifies type 'unsigned sho=
rt' but the argument has type 'int' [-Wformat]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(ports=
tr, sizeof(portstr), "%hu", srvc->port);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0~~^ =C2=A0 ~~~~~~~~~~
> 2 diagnostics generated.

Looks like that needs a cast.
