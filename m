From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH av/i18n 2/2] Make git-sh-i18n executable
Date: Sun, 25 Jul 2010 10:19:34 +0000
Message-ID: <AANLkTimpqw2RirLPDJkAhQIql793nwC9pc0HctIcxKKj@mail.gmail.com>
References: <ba054975988a4a799bcd81a74acd865815ae9bf5.1280051448.git.trast@student.ethz.ch>
	<d890d9ba7d967e6a191cb47194379d8f9ca5cd0d.1280051448.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jul 25 12:19:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcyJB-0000vh-QW
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 12:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab0GYKTg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 06:19:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44877 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab0GYKTf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jul 2010 06:19:35 -0400
Received: by iwn7 with SMTP id 7so1809011iwn.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 03:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zRpm2kDuZ5ccz49H8rbTI2e5nIFn1nj1o4a+VL+CM60=;
        b=gmquyhkcJuRp5QluxgTRVfBtMDUxSuCRYt31zXMe8NapN1AlN+WJ/KiBsKlq/QkTi1
         mlDEMa9Cbpi4qF7yhbiI6ZbHZDh22gXEgSvmMh+CmCqlulMAqTa0gqYydad70Jlo2Tfs
         3Cfex4y22oJeAjQojHd3bQ1t4g+Og19w/Ees4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GEazNazCdkE9Nz2JbCKnqscxsKav8qNOzWmTowFkJzFrgilvji1jwzl0tbh/EiodJQ
         ixeq/dHVIBseVG3FMJ2VQWUBKd4ixiPllRi3LMBG5z1SMyE7maRgVP2JuE3oi4ypmqYU
         wPjJzWIkOhEvaLh8hYRxTU0+cCMLgipNczCqo=
Received: by 10.231.171.7 with SMTP id f7mr6736589ibz.72.1280053174878; Sun, 
	25 Jul 2010 03:19:34 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sun, 25 Jul 2010 03:19:34 -0700 (PDT)
In-Reply-To: <d890d9ba7d967e6a191cb47194379d8f9ca5cd0d.1280051448.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151721>

On Sun, Jul 25, 2010 at 09:50, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> git-sh-i18n was not picked up by the valgrind wrapper code because
> that tests for the executable bit. =C2=A0Since there does not seem to=
 be a
> particular reason why it needs to be non-executable, and this is the
> path of least special-casing to fix --valgrind testing, just make it
> executable.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> =C2=A00 files changed, 0 insertions(+), 0 deletions(-)
> =C2=A0mode change 100644 =3D> 100755 git-sh-i18n.sh
>
> diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
> old mode 100644
> new mode 100755
> --

Why is it including git-sh-i18n.sh? It should only be using the
generated SCRIPT_LIB git-sh-i18n file.

On my system the executable bit of git-sh-i18n.sh has no effect on the
generated git-sh-i18n file:

    $ rm git-sh-i18n; chmod +x git-sh-i18n.sh ; make ; ls -l git-sh-i18=
n*
        GEN git-sh-i18n
        SUBDIR git-gui
        SUBDIR gitk-git
    make[1]: Nothing to be done for `all'.
        SUBDIR perl
        SUBDIR git_remote_helpers
        SUBDIR templates
    -rw-r--r-- 1 avar avar 1965 2010-07-25 10:15 git-sh-i18n
    -rwxr-xr-x 1 avar avar 1955 2010-07-25 10:08 git-sh-i18n.sh

And this still leaves git-sh-setup without an executable bit, why
doesn't that fail under valgrind while git-sh-i18n apparently does?
Maybe something to do with it being included as
<<. "$GIT_EXEC_PATH"/git-sh-i18n>> instead of as <<. git-sh-setup>> ?
