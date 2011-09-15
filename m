From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 4/4] attr.c: respect core.ignorecase when matching
 attribute patterns
Date: Thu, 15 Sep 2011 10:38:23 -0500
Message-ID: <CA+sFfMd7B6suV1YQppJGJmoCr+du3-GaG5dFhp=DyEngb-wR4g@mail.gmail.com>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<1316051979-19671-5-git-send-email-drafnel@gmail.com>
	<7vsjnyqws3.fsf@alter.siamese.dyndns.org>
	<7vobymqwjf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, git@vger.kernel.org, sunshine@sunshineco.com,
	bharrosh@panasas.com, trast@student.ethz.ch, zapped@mail.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 17:38:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4E1G-0000B8-1S
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 17:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934089Ab1IOPiZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 11:38:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40047 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934054Ab1IOPiY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 11:38:24 -0400
Received: by fxe4 with SMTP id 4so750929fxe.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 08:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uG6viR7hVhrMOYrUmSIs6TmciZ7wki9o6ZC2Q6bSMT4=;
        b=C8D/BUv8PDHBO+psE/x3khyq+XklHwqc2w3sq8J7c9RvOKtKy7HZRlbmZTXiCZq2BX
         aX01KtpsPQyPOJyd6wZuzRAFzCf/fxiDSy8GPsyD4Wi2C/QQZN5JCJQRCg5NNdzn7iG7
         2tB5/YO6sVXhrAl+gXXiDgxrLzbiGBD+7wpTg=
Received: by 10.223.94.134 with SMTP id z6mr1158275fam.8.1316101103169; Thu,
 15 Sep 2011 08:38:23 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Thu, 15 Sep 2011 08:38:23 -0700 (PDT)
In-Reply-To: <7vobymqwjf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181472>

On Wed, Sep 14, 2011 at 11:06 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>
> Junio C Hamano <gitster@pobox.com> writes:

> > An alternative approach may be to move reading of core.attributesfi=
le to
> > default_config, and drop git_config() call from bootstrap_attr_stac=
k(),
> > getting rid of git_attr_config callback altogether.
>
> That is, something like this on top of your patch.

Ok.

I'll send a reroll that slides this underneath my top patch, and
addresses Hanne's comment.

-Brandon


> =C2=A0attr.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
 15 ++-------------
> =C2=A0builtin/check-attr.c | =C2=A0 =C2=A02 ++
> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0=
 =C2=A01 +
> =C2=A0config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=
=A03 +++
> =C2=A0environment.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A05 files changed, 9 insertions(+), 13 deletions(-)
