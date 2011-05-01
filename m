From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [msysGit] Strange cherry-picking issue with 1.7.5.msysgit.1.1.g05d0e
Date: Sun, 1 May 2011 12:02:03 +0200
Message-ID: <BANLkTik1eYsz2eBkkUGM1XRVTOg8XEXnRQ@mail.gmail.com>
References: <ipj5k5$j04$1@dough.gmane.org>
	<alpine.DEB.1.00.1105011138020.13761@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 01 12:02:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGTTf-0000hc-KV
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 12:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1EAKCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2011 06:02:07 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:64233 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab1EAKCE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2011 06:02:04 -0400
Received: by qwk3 with SMTP id 3so2257411qwk.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V2sZ/8MSi9bl9vwwdvFBalNG3oLc4pUqaOsJOpzzArE=;
        b=BzgaJi74lNvEPUvAJb3m8uhd3X42QlGERUg8ZxvjkN6cSQdhUziEbtEh8aQJxTFuIL
         b1+jvi3ZdW1w9CWIKJf4dQY3ZX9q2qQ3M21DvZWz+n2b7cQmBgxzlIe4mL95d6xKzjIq
         qh5O4aMaegQruhC+4kSnrV70u2BmivSd4JX+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UPR0u2wMP2vciEE3UcSidFt9J3/U2UAE2mlQhe0f6mcdHZBhRo2eAzpja3MHax01EW
         IKdeCVtFMDXuHvtUJX+g0w3G5xLlI/hKfWqx20ZqEnQYVfgkJe3HqBMgiDdmJl+wwSLa
         ufSt6b1uJC/hg3ki8oorV4+ubN4i6Wr8aesL8=
Received: by 10.229.27.65 with SMTP id h1mr5061355qcc.216.1304244123616; Sun,
 01 May 2011 03:02:03 -0700 (PDT)
Received: by 10.229.62.222 with HTTP; Sun, 1 May 2011 03:02:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1105011138020.13761@bonsai2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172537>

On Sun, May 1, 2011 at 11:45, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> # Untracked files:
>> # =C2=A0 (use "git add <file>..." to include in what will be committ=
ed)
>> #
>> # =C2=A0 =C2=A0 =C2=A0 share/InnoSetup/ISCmplr.dll~5946786... Call B=
indImage on installer for all the exe and dll files
>
> This looks like some problem trying to check out that file from anoth=
er
> branch. Since you say that this problem does not occur when starting =
from
> the 1.7.4 tag, and you updated ISCmplr.dll 6 days after that, I could
> imagine that something locks the .dll. After all, the current 'mob' i=
s
> still based off of 1.7.4 not off of the current 'devel'.
>
> There should not have been a problem, though, as the .dll has not cha=
nged
> between the merge base and 5946786...

You're right, I had Inno Setup running in the background, probably
locking the ISCmplr.dll. But even after closing Inno Setup and making
sure ISCmplr.dll is not locked anymore, the above cherry-pick fails.

However, if I pass --strategy=3Dresolve, it works with 1.7.5. But as yo=
u
already mentioned, I'd not expect the cherry-pick to touch ISCmplr.dll
in any case ... no what does that tell me, is it a regression in
1.7.5, or a new "feature"?

--=20
Sebastian Schuberth
