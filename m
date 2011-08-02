From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/5] bisect: Add support for a --no-checkout option.
Date: Tue, 2 Aug 2011 11:41:06 +1000
Message-ID: <CAH3Anro-ve2ZoTnbEvWyNH7kEMBCQOoCDfqZbPPxymn12pzAbQ@mail.gmail.com>
References: <1312014511-7157-1-git-send-email-jon.seymour@gmail.com>
	<201107301548.09815.chriscool@tuxfamily.org>
	<CAH3Anrp8aT1UwfstJ99Ug4MD2CZKB9oE_oRLksbkGGE1xSELsg@mail.gmail.com>
	<201107301619.51438.chriscool@tuxfamily.org>
	<7v39hmkkth.fsf@alter.siamese.dyndns.org>
	<CAH3AnroxjFiv25L3N1CQWW6S4vMS7C42b5AzXO09u9091S9asA@mail.gmail.com>
	<7vvcuhhw96.fsf@alter.siamese.dyndns.org>
	<CAH3Anrqp3BVMpTz7DhYBL=9nt1F30_20t=FmcmdZHqMHLEqXqA@mail.gmail.com>
	<7vaabshfmb.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrrvX64s3p_=5mrVcwx5FeO0iT8uX47remyCuCwPpOo=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 03:41:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo3yr-0002BM-Bl
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 03:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364Ab1HBBlJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 21:41:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48147 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab1HBBlH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 21:41:07 -0400
Received: by vws1 with SMTP id 1so4928044vws.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=g5Xv1py+kOP3st8WFjEathPTliR3t7miQtv5eQgdvVM=;
        b=QC/sqlBQRN8htkVTaV6/4EWULc6GbTIPflJcWxyrjotnqox6NvaDORnoI0ntB9KcWW
         bIPv8xUKOvow+vJqoxy4ndpQxADr3S0V1ovcmYC7u1CYk9m78DsdMJWMA1oS3+9mvSdF
         4fwhLLkVMCXZOmmQaWjRIf1X6T7cT2Q34ZFIo=
Received: by 10.52.22.19 with SMTP id z19mr5077548vde.499.1312249266764; Mon,
 01 Aug 2011 18:41:06 -0700 (PDT)
Received: by 10.52.183.39 with HTTP; Mon, 1 Aug 2011 18:41:06 -0700 (PDT)
In-Reply-To: <CAH3AnrrrvX64s3p_=5mrVcwx5FeO0iT8uX47remyCuCwPpOo=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178431>

On Tue, Aug 2, 2011 at 11:15 AM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> On Tue, Aug 2, 2011 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:

>
> How about in the current series, I change the option parsed by
> bisect--helper.c to be:
>
> =C2=A0 =C2=A0--bisect-mode=3Dcheckout|update-ref
>
> The porcelain option can still be --no-checkout (or should it be
> --bisect-mode too?). The porcelain will maintain a state variable
> called (rather than BISECT_NO_CHECKOUT).
>
> =C2=A0 =C2=A0 BISECT_MODE
>
> Then, the next series can add a --bisect-head option (instead of
> --update-ref) to allow the head to be varied (defaulting to
> BISECT_HEAD) if not specified.

To clarify: --bisect-head would default to HEAD if mode is checkout,
to BISECT_HEAD if the mode is update-ref.

jon.
