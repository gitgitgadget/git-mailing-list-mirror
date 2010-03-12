From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Fri, 12 Mar 2010 08:40:07 +0100
Message-ID: <36ca99e91003112340u6256ef4dwb40e308c9a5e3a46@mail.gmail.com>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
	 <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 08:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpzTk-0001du-E4
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 08:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002Ab0CLHkK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 02:40:10 -0500
Received: from mail-fx0-f227.google.com ([209.85.220.227]:50277 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0CLHkI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Mar 2010 02:40:08 -0500
Received: by fxm27 with SMTP id 27so1103638fxm.28
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 23:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ndl3iphuXcA/fz0C+Q+QmAcriR/b75jWYDXhDPzLMQ8=;
        b=W11oAaDpTJn/CkjT6Avn+dzckJQyPhlhcJ9zzNPHtGUaCKg++qRi2EoDKEs3VIqEPV
         Y4fZSrtCpaOuP9S3MB2zaw2z++eNR/KqiVUgkLv7CRiG4TtcghKja4RB2c1sKYh+QaTL
         DA2VWfTRLPMmz/Hvbr1aaGmIHaiB+XabQRINw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pBAD8Bd9UJiJnmG6eX1WLQutBc/GTAAXMlXzvmktGXDb/v5MEiIA8evvk7v8bo6utj
         0WKA3tJyVPqd4Ms1GuuBRnxqZbXqnLsby8r3iz1RxoZDN2zpnyUOLMrBlQnns7lY03vQ
         pfGykOE8wq63jDiDHtD8L3o/tH66VSynXHamQ=
Received: by 10.223.64.83 with SMTP id d19mr2224424fai.15.1268379607157; Thu, 
	11 Mar 2010 23:40:07 -0800 (PST)
In-Reply-To: <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142032>

On Fri, Mar 12, 2010 at 07:53, Junio C Hamano <gitster@pobox.com> wrote=
:
> Erick Mattos <erick.mattos@gmail.com> writes:
>> + =C2=A0 =C2=A0 test "alpha" =3D "$(git branch | sed -n "/*/s/\* //p=
")" &&
>
> Don't read from "git branch" in scripts; use symbolic-ref on HEAD.

I think what he wants is:

        git rev-parse --abbrev-ref HEAD

Bert
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
