From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: tr/xdiff-fast-hash generates warnings and breaks tests
Date: Thu, 17 May 2012 11:33:27 +0200
Message-ID: <CAA787r=aMJCQvxtMZaYUHJsTkxs-mUYBYroArvVN=E=_EGKDDQ@mail.gmail.com>
References: <CAA787r=WCJXeDipiVL37oMgji=ncoPyXXVOcCyYbSC6iCcTi1g@mail.gmail.com>
	<4FB4A4B9.3080009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 17 11:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUx5R-0006x5-RP
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 11:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab2EQJd3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 May 2012 05:33:29 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49198 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab2EQJd2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 May 2012 05:33:28 -0400
Received: by pbbrp8 with SMTP id rp8so2308610pbb.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QqM260E350V5Tq4m7+E+Wlbrrh0/r1Oqz7bLsyZG3Bw=;
        b=Lyso7+B1Sl8O81jXFw7nJfOJ/aZG4pKKnivb7cSWy5WZDf9gRXdVM6eU6lZeJnuv/Q
         fopUB14G9dYiaZFC2qQgojq2YK/aNaiKvs0Lgs4Knx40/H4WylIY75rXM1FnsVIWuN+5
         iq9F40QcAbJwl9ibEN/JL2v6VoY/Z9ICA/pSbXfCouMn9so9ISfnUU5JLke1U9wettzs
         36jhNng6XKOD450AcYt0p3zCkWOXCNj2V4Z3hAnYxJrWoM/3bMu1+mMLSfRXbX14bVYK
         vGkRv78pbbu9EGhoPIe4P0lalAVQu2XmtSfyd3Zl6vNZPuVsZ4SxrmFaoTcWVCJnXgxB
         D7ow==
Received: by 10.68.221.39 with SMTP id qb7mr25735403pbc.120.1337247207758;
 Thu, 17 May 2012 02:33:27 -0700 (PDT)
Received: by 10.68.26.98 with HTTP; Thu, 17 May 2012 02:33:27 -0700 (PDT)
In-Reply-To: <4FB4A4B9.3080009@lsrfire.ath.cx>
X-Google-Sender-Auth: tPbe8Wr2PyVOx3xqKbZz6JdIdiM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197914>

On 17 May 2012 09:11, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> w=
rote:
> Am 17.05.2012 01:31, schrieb =C3=98yvind A. Holm:
> > On Debian GNU/Linux 6.0.5 (squeeze), the two commits on the
> > tr/xdiff-fast-hash branch introduces compiler warnings and breaks
> > t/t0020-crlf.sh and maybe later tests:
>
> What does the following short C program report when run (e.g. put it
> in a file named s.c, then run "gcc -o s s.c" and "./s")?
>
> =C2=A0#include <stdio.h>
> =C2=A0int main(int argc, const char **argv) {
> =C2=A0 =C2=A0printf("%u %u %u\n", sizeof(int), sizeof(long), sizeof(v=
oid *));
> =C2=A0 =C2=A0return 0;
> =C2=A0}

The result is "4 4 4".

> I suspect you run a 32-bit userland on a 64-bit kernel.

Yes, it looks like that to me, too. FYI, this isn't my computer, but a
login shell at a webhosting provider, so I don't know the exact details
about the installation.

Cheers,
=C3=98yvind
