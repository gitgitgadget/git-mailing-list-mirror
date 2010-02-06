From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Sat, 6 Feb 2010 09:16:56 +0100
Message-ID: <cb7bb73a1002060016p179a3ffdt134897d52f54d41c@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vaavo90ic.fsf@alter.siamese.dyndns.org> <cb7bb73a1002041538m64c6a6b3p5ee8bbaf0d78457@mail.gmail.com> 
	<201002051136.43738.johan@herland.net> <7veikzfysv.fsf@alter.siamese.dyndns.org> 
	<7vsk9fwbzj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 09:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndfus-0000xV-5O
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 09:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391Ab0BFIRS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 03:17:18 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:43357 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0BFIRS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 03:17:18 -0500
Received: by ewy28 with SMTP id 28so808004ewy.28
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 00:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EyAWyl6e/LPFgaT15ghbRHSoJbYkLiaeBPR5yHCrebo=;
        b=uBg/mOTUcY2yiCDMpdia5etoIYsV9wAycVc0XqJZe4nFKU5ea39IOEflTX8EsPaR4y
         Ony641hQn2veionZuBj/sTXry/fYAR9i7BBgbixdrHjoS5zrWesziZ7370eskLfXGMrC
         sV3foUe6hIChaKdj0RqJiuReK7/ciWGeBhAz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=u0MAlHQEM38BOG0nS0mTBFApZIWaBI9Knb7yIkl8s3S0W8Lv8N3EmG2+fkSxnmMecY
         qukETol7e62PS84vqKs1j4Ax/BNXlbiSDgWP/dolbBkHns9mMOXZYr+nIel5hmchS2kD
         CdPoLGZpowvrh2K3/kNLbfNvmFMcBzOZuKUVQ=
Received: by 10.213.1.210 with SMTP id 18mr3245899ebg.18.1265444236164; Sat, 
	06 Feb 2010 00:17:16 -0800 (PST)
In-Reply-To: <7vsk9fwbzj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139149>

On Fri, Feb 5, 2010 at 11:31 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Giuseppe was wondering about multi-line thing, so the illustration sh=
ould
> be adjusted to match the "format-patch" example to show a multi-line =
note,
> I think. =A0Here is what I meant.
>
> Instead of showing:
>
> =A0 =A0$ git log --notes-ref=3Damlog -1 4d0cc22
> =A0 =A0commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
> =A0 =A0Author: Junio C Hamano <gitster@pobox.com>
> =A0 =A0Date: =A0 Thu Feb 4 11:10:44 2010 -0800
>
> =A0 =A0 =A0 =A0fast-import: count --max-pack-size in bytes
>
> =A0 =A0 =A0 =A0Similar in spirit to 07cf0f2 (make --max-pack-size arg=
ument to 'git
> =A0 =A0 =A0 =A0...
>
> =A0 =A0Notes:
> =A0 =A0 =A0 =A0pulled on Fri Feb 5 07:36:12 2010 -0800
> =A0 =A0 =A0 =A0from git://git.bogomips.org/git-svn.git/
> =A0 =A0Notes-amlog:
> =A0 =A0 =A0 =A0<7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
>
> which is what 1.6.6 added, showing it like this:
>
> =A0 =A0$ git log --notes-ref=3Damlog -1 4d0cc22
> =A0 =A0commit 4d0cc2243778b38c3759c6a08f4f1ed64155a070
> =A0 =A0Author: Junio C Hamano <gitster@pobox.com>
> =A0 =A0Date: =A0 Thu Feb 4 11:10:44 2010 -0800
> =A0 =A0Notes: pulled on Fri Feb 5 07:36:12 2010 -0800
> =A0 =A0 from git://git.bogomips.org/git-svn.git/
> =A0 =A0Notes-amlog: <7v4olwbyvf.fsf_-_@alter.siamese.dyndns.org>
>
> =A0 =A0 =A0 =A0fast-import: count --max-pack-size in bytes
>
> =A0 =A0 =A0 =A0Similar in spirit to 07cf0f2 (make --max-pack-size arg=
ument to 'git
> =A0 =A0 =A0 =A0...
>
> might be easier to see. =A0After all, notes are metainformation on co=
mmits,
> and people who are interested will look at the header, and those who =
are
> not will skim over the block of text at the beginning, knowing that i=
s
> where all the metainformation is.
>
> But this is just "might", not "should---I strongly believe".


I'm not convinced. I believe format-patch output should be as close as
possible to RFC2822 compliance, given how it can be used as basis for
actual email.

According to the RFC, lines should be no more than 78 characters and
must be less than 998. The 'one space indent on newline', if I'm not
mistaken, is a way to indicate a _wrapped_ single line header, rather
than a multi-line one.

A scenario such as the following is thus possible: format-patch
creates a single-line header which is longer than 78 characters
(X-Git-Notes-somerefname: 70ish characters line). The patch gets sent
by email, and a properly configured send-email sends the X-Git-Notes*
headers through (BTW, this should probably be added to the
notes/send-email TODO). Some intermediate forwarder or user agent
decides to rewrap the longish line so that it isn't longer than 78
characters. The user saves the raw email and uses git am to apply it
-> oops, the single line note has become a two-liner.

If we use the convention (at least in format-patch, not necessarily in
log) of one header line per notes line we should be more on the safe
side. It would also allow us to keep the headers wrapped at < 78
characters which is nice for legibility on terminals.


--=20
Giuseppe "Oblomov" Bilotta
