From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC 2/2] Future Proofing: Pass around pointers to either
 functions or data
Date: Wed, 30 Mar 2011 12:09:46 +0200
Message-ID: <AANLkTi=nxA0BrLruQ9zc_SajH2ghpZX14Ra7QOo9fMBx@mail.gmail.com>
References: <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com> <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 12:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4sLv-0000hg-4n
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 12:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728Ab1C3KKI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2011 06:10:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43137 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab1C3KKH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2011 06:10:07 -0400
Received: by fxm17 with SMTP id 17so907612fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 03:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=SiTwSIdeA6tJUZwioPOQBQsvWuutKzxi13ikCyBle8E=;
        b=BHH9nSlcioHBgbcDt1CYG0LoIMOisY9nASMtAOpuvikaj0hRpJZflHFS/QOBrdeifF
         vFNaOTT1x5qnA0zKJ9Zlue+XWyPj7H9onykp18STbndwiHDyHEdX2+anDmGB/cmIvmoQ
         Ed/os6132VnBkRIrjXQ/TLlrdGMXM3bdhEhtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Qa1zEHN5iJC+uTzpwp3739WNmh6y9Kdw/O5gLdi5+gEvYRIPHga6s5qonn0IWzDaNa
         YCimXvXftWrWwE/FMIzTOoYTxyUPcdSvq0YHvv98qyUouuvTeUdXfYVE+9nhocFmO+gH
         iFs6HlTxHX3yT+Iaj+p8meyjMMzuCHQCpft8U=
Received: by 10.223.35.147 with SMTP id p19mr1063641fad.13.1301479806124; Wed,
 30 Mar 2011 03:10:06 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Wed, 30 Mar 2011 03:09:46 -0700 (PDT)
In-Reply-To: <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170375>

On Tue, Mar 29, 2011 at 5:28 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> +#define ALT_ODB_FN_INFO_FUNC(variable, function) \
> + =A0 =A0 =A0 union alt_odb_fn_info variable =3D { \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .func =3D (alt_odb_fn_cb)function \
> + =A0 =A0 =A0 }
> +#define ALT_ODB_FN_INFO_DATA(variable, data_) \
> + =A0 =A0 =A0 union alt_odb_fn_info variable =3D { \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .data =3D data_ \
> + =A0 =A0 =A0 }

We try to stay away from C99 features like this, as it doesn't work on
all compilers we target.
