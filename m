From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] cherry-pick -x: add newline before pick note
Date: Wed, 17 Nov 2010 01:14:16 -0500
Message-ID: <AANLkTinAWSNKK3VMY_jAy-8-M-80d_EvW299ZfVFPwpo@mail.gmail.com>
References: <d0318dcd2b52f2e818888003e3dd81c7b713fec6.1289920242.git.git@drmicha.warpmail.net>
 <20101116193018.GA31036@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Martin Svensson <martin.k.svensson@netinsight.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 17 07:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIbID-0007mb-BS
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 07:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933366Ab0KQGOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Nov 2010 01:14:47 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54731 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932824Ab0KQGOr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Nov 2010 01:14:47 -0500
Received: by iwn35 with SMTP id 35so1735787iwn.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=akqaVpLOcyBgC67qYF69+0gCgEwxfNdOFq9yDBsvJuU=;
        b=ti17VNYPqkrD5pQvDcx449DJ+UmURut6CMwF9MAvawHbecx4Pkeid97216zGXqHJd6
         6UKAPGaXQfbcuDosiBhDxvEL58SM3SZtt4RGD1Z7yy5HS6PdKabclb8yfAbid/mkVAJR
         vxD8tnb5VMcPwYZZVRkWCxqPAd4aNtt4B9Aro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iK5k2rDtZUEcJjwfH0ZUB60jSyQC4qTxjVYspj8Hf3UuX11isFoa23isiqiHIyTmEd
         hAblBStK0/gV+igPa6jNIsZuweINKLy4VXolS5buljZ9KrEZvJVMyHZrx8eP00mOsxnp
         S1XyJ/SRIXv7Q2BX+py7XOcpdOCEtxLMVuCWk=
Received: by 10.231.10.139 with SMTP id p11mr6616009ibp.179.1289974486657;
 Tue, 16 Nov 2010 22:14:46 -0800 (PST)
Received: by 10.231.161.21 with HTTP; Tue, 16 Nov 2010 22:14:16 -0800 (PST)
In-Reply-To: <20101116193018.GA31036@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161598>

On Tue, Nov 16, 2010 at 2:30 PM, Jeff King <peff@peff.net> wrote:
> shouldn't it result in:
>
> =C2=A0message subject
>
> =C2=A0Message body.
>
> =C2=A0(cherry picked from commit ...)
>
> =C2=A0Signed-off-by: Jeff King <peff@peff.net>

+1.

> Even better, I wonder if it should actually be:
>
> =C2=A0message subject
>
> =C2=A0Message body.
>
> =C2=A0Signed-off-by: Jeff King <peff@peff.net>
> =C2=A0Cherry-picked-from: ...

+2.

> And then you could actually sign off the cherry-pick separately, too,=
 if
> you wanted, by adding a line _below_ the cherry-picked-from. I have n=
o
> idea if people are trying to grep for "cherry picked from commit...",
> which my proposal would break.

I can fix my regex easily enough, but I'd also be happy to have this
use some other switch than -x.

BTW, I notice that cherry-pick also misbehaves if the original commit
message doesn't end in a newline. I'm not sure whether that's a
cherry-pick bug for not checking that case, or whether it's a commit
bug for not ensuring a newline terminates the commit message.

j.
