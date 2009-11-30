From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Mon, 30 Nov 2009 13:08:58 -0500
Message-ID: <32541b130911301008v4156f0c6ge9f30952565392f9@mail.gmail.com>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com> 
	<905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com> 
	<cover.1259201377.git.apenwarr@gmail.com> <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com> 
	<7vr5rlerqf.fsf@alter.siamese.dyndns.org> <32541b130911261405q6564d8f2o30b7d7fd6f708d05@mail.gmail.com> 
	<7vvdgs1qip.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFAgh-0004ct-PB
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 19:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbZK3SJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 13:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752772AbZK3SJP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 13:09:15 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:35116 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZK3SJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 13:09:14 -0500
Received: by ywh12 with SMTP id 12so4193301ywh.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 10:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XWMG6RLdqxhlHlQlw2Z7D4tUn2qzOzd2Mlp4SNEcwy4=;
        b=kWrhWInbocVNJZ4S0LWN5ap6sVdRR8x6oAM6/63ROhKz74e6LJ+kGNUj4XLgp05PXq
         ceZ5dkJvSph4DAx2HC+YnybVyRPVAMiYM1US4yVCvbXJ2pxyYh1EBv8fVD+WVcMrHJcP
         mLQ5e/3auuBy2UOHy4Zh1USVc788v8NfqwNPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tT0gZxFQu7FKg2KNqZM675QfLo/jJ2YZSNjfwklB5Yj0vVwm7/FWSjt2ygM8maEIqE
         Y8UGeBIvBvxDZJ+qW83wNCGcxh8gP8tG1Kcr5vzQ//mHsXMDLomUGHDGHlBT/PAyozz/
         NA8iCkbY8O+d4dSCjiTcjinHdZOJhvqLKpAMI=
Received: by 10.150.173.3 with SMTP id v3mr7820799ybe.52.1259604558088; Mon, 
	30 Nov 2009 10:09:18 -0800 (PST)
In-Reply-To: <7vvdgs1qip.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134125>

On Mon, Nov 30, 2009 at 1:21 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> As long as you choose the default "no-op" value carefully enough so t=
hat
> existing callers will naturally use it without modification, the old =
code
> will work the way they did before the new optional feature was added.=
 =A0In
> other words, "let's implement this as purely an opt-in feature" is of=
ten
> preferrable over "let's force semantic conflict and compilation failu=
re,
> just in case existing callsites may also want to trigger this new
> feature".
>
> That is why [1/8] patch in your series uses 0 to mean "don't do the f=
unny
> 'favor' trick, but just leave the conflicts there".

There's just one bit to add to this: when converting a non-bitfield
int into a bitfield, really odd things can happen.  That was my main
rationale for avoiding the change to bitfield without changing the
signature.  That said, the amount of code isn't really that big so
this point doesn't matter much.

> I've queued the series with minor fixes to 'pu' and pushed it out.

Since I see you didn't change a couple of things you mentioned in
earlier comments (the NEEDSWORK comment and the sq-then-eval trick) do
you still want me to respin this series?

Thanks,

Avery
