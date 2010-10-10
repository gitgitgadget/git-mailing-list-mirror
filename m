From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 12:46:47 +0800
Message-ID: <AANLkTi=3BG0PScgp5X+y2-U1FqC6aoOrw_pyLU7cEzME@mail.gmail.com>
References: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Akira Kitada <akitada@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 06:51:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4nso-0003Rc-S3
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 06:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782Ab0JJEqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 00:46:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49844 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0JJEqt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Oct 2010 00:46:49 -0400
Received: by ewy20 with SMTP id 20so188773ewy.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=itL5B48fYEZKVwuOFfs/C1lbx8aNq0uWQYw0A26/LKY=;
        b=G2Lic2F8FkpSqo2ahWUepF60Iol1MrIifx5hYnWRKujyrYIXoCwE6x/vQBbPhlM08H
         hNQ69S4ldpvHMT0zxLc6S6sO12fAvyhuu4qBBSUryGSbYCBuZ039KyQ+Mak4rJEommTj
         B3nngFzkkDDGZh/EMZcfOyWhpEEfVohP3Z9GA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IzLJStH/mLRmtgaYlsV5x6ZGh3SE+PH8wupiUnuiJKt0T4qH4Wv4J1d3wTsyoj60ET
         E63Y/lOTedIfxLWjU5T+HAHH7FnAmb5Uoo+os3tG+m90UYIknTMihHhsUQLMDv79mn/W
         DOGq0t+dIx31SK4J6chyjKHXojJlY6GtOJfoQ=
Received: by 10.213.3.16 with SMTP id 16mr2499430ebl.55.1286686007884; Sat, 09
 Oct 2010 21:46:47 -0700 (PDT)
Received: by 10.213.33.197 with HTTP; Sat, 9 Oct 2010 21:46:47 -0700 (PDT)
In-Reply-To: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158641>

On Sun, Oct 10, 2010 at 10:52 AM, Akira Kitada <akitada@gmail.com> wrot=
e:
> Hello,
>
> I'm hitting the following errors during Git 1.7.3.1 build on FreeBSD =
4.
> I didn't see this problem when I built 1.7.0.1 so I should be
> introduced in the recent versions.
> Is there any reports regarding this?
>
> Thank you
>
> $ ./configure && gmake -j 1 V=3D1
> ...
> rm -f git-add--interactive git-add--interactive+ && \
> =A0 =A0 =A0 =A0INSTLIBDIR=3D`MAKEFLAGS=3D gmake -C perl -s --no-print=
-directory instlibdir` && \
> =A0 =A0 =A0 =A0sed -e '1{' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0s|#!.*perl|#!/usr/bin/perl=
|' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0h' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0s=3D.*=3Duse lib (split(/:=
/, $ENV{GITPERLLIB} || "'"$INSTLIBDIR"'"));=3D' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0H' \
> =A0 =A0 =A0 =A0 =A0 =A0-e ' =A0 =A0 =A0 =A0x' \
> =A0 =A0 =A0 =A0 =A0 =A0-e '}' \
> =A0 =A0 =A0 =A0 =A0 =A0-e 's/@@GIT_VERSION@@/1.7.3.1/g' \
> =A0 =A0 =A0 =A0 =A0 =A0git-add--interactive.perl >git-add--interactiv=
e+ && \
> =A0 =A0 =A0 =A0chmod +x git-add--interactive+ && \
> =A0 =A0 =A0 =A0mv git-add--interactive+ git-add--interactive
> 'INSTALLSITEMAN3DIR' is not a known MakeMaker parameter name.
> 'INSTALL_BASE' is not a known MakeMaker parameter name.
> Writing perl.mak for Git
> 'INSTALLSITEMAN3DIR' is not a known MakeMaker parameter name.
> 'INSTALL_BASE' is not a known MakeMaker parameter name.

This looks like a problem with Perl. What version do you have?

You can check that with cpan - type "m ExtUtils::MakeMaker", and look
at the INST_VERSION line.

--=20
Cheers,
Ray Chuan
