From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Corrected return values in post-receive-email.prep_for_email
Date: Tue, 7 Dec 2010 14:50:26 -0200
Message-ID: <AANLkTikYnDNRPVd-wd4+3jsX2fBbjxODEGATN5dD7t1E@mail.gmail.com>
References: <002501cb962c$5fa3aa40$1eeafec0$@me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alan Raison <alan@theraisons.me.uk>
X-From: git-owner@vger.kernel.org Tue Dec 07 17:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ0kN-00057G-5r
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 17:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0LGQu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 11:50:29 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51529 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0LGQu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 11:50:29 -0500
Received: by gyb11 with SMTP id 11so89511gyb.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 08:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=r1n529xTU1m5EpDI+FJ2rqe6+wWYZ/RW7ppBipwFmv8=;
        b=bRus8PbJBFjE0NNHgriWTKQvAx0V3JjLIhtkTuYluJ7PPC4Ocmh/9ygsm+UCn8fRN+
         tfTequN98vz+j7j3LwBfWmBfmvSOO05CcKyme37S1/UHHCOqhZ5ljlSUmEQ1L2lmmqYV
         AIM8JrWmWq+V0tf8eZ7YcH3C9b6EtHQYeIebM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lcJdetUU9RZOzUtN93hR2nAFODAKAhjFUd1dzgV33SCBrfvgPbN3paR5q6RdvniG8n
         qCnb2E8qWbiktaRFl/OulI4exk3rJRpqe472YIMTNT+x7DtugeF0ymR13JmzGIP8yWMK
         nqMv3m72D765ewjg65Hod2/VjMnMWa2kHPwrU=
Received: by 10.204.76.137 with SMTP id c9mr689465bkk.40.1291740626703; Tue,
 07 Dec 2010 08:50:26 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Tue, 7 Dec 2010 08:50:26 -0800 (PST)
In-Reply-To: <002501cb962c$5fa3aa40$1eeafec0$@me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163090>

Care to explain in the change log message why the return value should
be 1 instead of 0?

On Tue, Dec 7, 2010 at 2:32 PM, Alan Raison <alan@theraisons.me.uk> wro=
te:
> ---
> =C2=A0contrib/hooks/post-receive-email | =C2=A0 =C2=A06 +++---
> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/contrib/hooks/post-receive-email
> b/contrib/hooks/post-receive-email
> index 85724bf..020536d 100755
> --- a/contrib/hooks/post-receive-email
> +++ b/contrib/hooks/post-receive-email
> @@ -150,7 +150,7 @@ prep_for_email()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0# Anything else (is there anything else?)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0echo >&2 "*** Unknown type of update to $refname
> ($rev_type)"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0echo >&2 "*** =C2=A0- no email generated"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
>
> @@ -166,10 +166,10 @@ prep_for_email()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "*** =
$config_name is not set so no email will be
> sent"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo >&2 "*** =
for $refname update $oldrev->$newrev"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> - =C2=A0 =C2=A0 =C2=A0 return 1
> + =C2=A0 =C2=A0 =C2=A0 return 0
> =C2=A0}
>
> =C2=A0#
> --
> 1.7.3.1.msysgit.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
