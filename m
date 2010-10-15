From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] compat: add memrchr()
Date: Fri, 15 Oct 2010 05:31:41 +0000
Message-ID: <AANLkTinBuAhLLUMLd6ZWtVFWCjnFAxYwVSo1Pkja7bT4@mail.gmail.com>
References: <1287098999-9244-1-git-send-email-ydirson@altern.org>
	<20101015051750.GA21830@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6ctY-000824-K6
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557Ab0JOFbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 01:31:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51906 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab0JOFbm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 01:31:42 -0400
Received: by fxm4 with SMTP id 4so219854fxm.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qz/UWSQULR8VVeH6ElXIf1edTm69bZ9NaxbCK8FF3ZU=;
        b=rgx/qShKKMvUSYgtRF00m49PHQB/7CECmdsovZkBKU5Kbzy0Ut2fBRPseMoVCIwSDY
         68kADXpBjLRO0gFfuKyc8kThETGWA3dprmztAmtW3C/4CmlE94bDnLC0qUqxvj+y3/Su
         UAdvv8xFyJWLLalc2MfLJT0DHbJilZVtM6+F4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sEEbM5gi9FrezQdAyk2cVWGkZoAkz5h60hqXMYCEB8rNVW2yYeY5oGaPhrOcmPIwoL
         RJ2Cy9ziKhSdOcwCQesJXTJdS4Vl+Oig8MZLIlDnVnZ4yNSlH1cbJxf2O4ZsXl6U0ecs
         g9A0LKNqz3Mnv9Lgr6r2d0DBXQhmy3mFTWNf4=
Received: by 10.103.121.16 with SMTP id y16mr71142mum.95.1287120701192; Thu,
 14 Oct 2010 22:31:41 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Thu, 14 Oct 2010 22:31:41 -0700 (PDT)
In-Reply-To: <20101015051750.GA21830@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159096>

On Fri, Oct 15, 2010 at 05:17, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Reimplement another handy convenience function from glibc. =C2=A0memr=
chr()
> searches from the end of a memory area for a particular character. =C2=
=A0It
> is similar to strrchr() but takes a length argument and is
> binary-safe.
>
> The whole-directory rename detection patch could use this to find the
> last directory separator in a (possibly truncated) pathname.

Maybe something like this for configure.ac:

    AC_CHECK_LIB([c], [memchr],
    [HAVE_MEMRCHR=3DYesPlease],
    [HAVE_MEMRCHR=3D])
    AC_SUBST(HAVE_MEMRCHR)

And documentation with the other HAVE_* variables at the top of the
Makefile?
