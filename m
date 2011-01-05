From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: How to import a exist git repository into another git repository?
Date: Tue, 4 Jan 2011 23:02:39 -0800
Message-ID: <AANLkTin=AdUYEj8CJ=+YMROFh3BWhn4A+AeL+8fxkuoa@mail.gmail.com>
References: <AANLkTi=ahqFz=NVMrhtf+u2fJR_PAW-vcXgNYcce=2R+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Edmond Halley <halleyinvent@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 08:03:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaNOn-000492-9w
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 08:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab1AEHDC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 02:03:02 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42087 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1AEHDB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 02:03:01 -0500
Received: by ewy5 with SMTP id 5so6773133ewy.19
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 23:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=3xr7/3wtj173m6DGb7RniMNzCUOR1DdpZFEuFzFRFhE=;
        b=lC3wbuhPwpEMeYrs7Y5di7trgtAeunFwcX8nBrJYz3Qb03LyTxe9uNSYkAW+tElT2g
         cR1E3psfHX6eg3w92kEZFp3nTtZk+cAZfFrEf885+unKZ27RJDz9ikI5YQgxF1UKPp4w
         5rSKj3UUzPvka+bEj3nZY2xi+J8hovM3k31xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=LxOwAD9EJndzLsn8UCbGLQj6JdIfMmuATCY/UMm6EtKm8iLe4PXbhVbCXXutrtc/dj
         GwodSxxbnECP7GwL5jIrPxjOGMov25528nsAJK3LepoP4iaIha48m6RGd7To21fGIj1Z
         wnuWcjN2xxWivoaIAyiAiDI8ms7TnxCcxtVc8=
Received: by 10.213.9.204 with SMTP id m12mr18611176ebm.68.1294210979341; Tue,
 04 Jan 2011 23:02:59 -0800 (PST)
Received: by 10.213.98.83 with HTTP; Tue, 4 Jan 2011 23:02:39 -0800 (PST)
In-Reply-To: <AANLkTi=ahqFz=NVMrhtf+u2fJR_PAW-vcXgNYcce=2R+@mail.gmail.com>
X-Google-Sender-Auth: pVoq2N_0L-bTr9I467lOTp13YIg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164554>

What you're looking for is subtree merge:

http://progit.org/book/ch6-7.html

http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtr=
ee.html

- Andrew Garber

On Tue, Jan 4, 2011 at 10:50 PM, Edmond Halley <halleyinvent@gmail.com>=
 wrote:
> Hi,
>
> I have two exit repos A and B. I would like A becomes part of B. For =
example:
> original:
> A
> |-- a.cpp
> `-- Makefile
>
> B
> |-- b.cpp
> `-- Makefile
>
> combined:
> B
> |-- b.cpp
> |-- Makefile
> `-- A
> =C2=A0 =C2=A0|-- a.cpp
> =C2=A0 =C2=A0`-- Makefile
>
> The git log of repo A is kept in the combined repo.
>
> I try google but the following methods turn out they do not work like
> what I want. I can not view the log of original repo A after
> combining.
> 1) http://stackoverflow.com/questions/1683531/how-to-import-existing-=
git-repository-into-another
> Fail at the following command.
> git checkout -b ZZZ other/master
> error: Untracked working tree file 'Makefile' would be overwritten by=
 merge.
>
> 2) http://thread.gmane.org/gmane.comp.version-control.git/5126/
> git log only give the lastest commit message. I do not know how to ge=
t
> the log if orignal repo A.
>
> Thank you!
>
> Best regards,
> Halley
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
