From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki (fetch
 & push)
Date: Mon, 29 Aug 2011 07:42:48 +0200
Message-ID: <CAGdFq_iYRkfnTbYAgmX1g4uOxWb_ZYxr+TNinVfWRV-zXrnzAg@mail.gmail.com>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr> <7v4o14dppz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	=?UTF-8?Q?Sylvain_Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 07:43:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxudB-0000cI-6v
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 07:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab1H2Fn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Aug 2011 01:43:29 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56443 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab1H2Fn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2011 01:43:28 -0400
Received: by pzk37 with SMTP id 37so7864182pzk.1
        for <git@vger.kernel.org>; Sun, 28 Aug 2011 22:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=j3IFv6bfe5rHNrMdL7y7RNSKW4T81ctiWp3117XQ5Pk=;
        b=rn/SanuXseDf3+wiLgchY19Z6enHY8g7QjhWy0G0HfDxLRuK2Brzn2CwVglq903nol
         ghoZScAhdeodpOjp/kQKzja4v+B1dN5zFtG+SMgs+wf/d2mrrL2FMj7ImmmWW360Xjcc
         cB0DOBCossDnxZoMtm84umxxg+1HCH8pFMWP8=
Received: by 10.142.226.2 with SMTP id y2mr2348350wfg.449.1314596608140; Sun,
 28 Aug 2011 22:43:28 -0700 (PDT)
Received: by 10.68.55.170 with HTTP; Sun, 28 Aug 2011 22:42:48 -0700 (PDT)
In-Reply-To: <7v4o14dppz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180296>

Heya,

2011/8/26 Junio C Hamano <gitster@pobox.com>:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>> In short, the changes since v3 are:
>>
>> * Adapt to newer Git, which seem to require a "done" command at the
>> =C2=A0 end of the fast-import stream. I don't understand why this is
>> =C2=A0 needed, since fast-import is called without the --done flag b=
y
>> =C2=A0 remote-helpers, but if I don't do this, "git fetch" doesn't
>> =C2=A0 terminate and keeps waiting ...
>
> Hmmmm, is this a regression in fast-import? Can this be bisected if s=
o?

We agreed that making this change is the best way to go forward, since
there's so few (read: none) remote-helpers yet, the fix is trivial,
and it solves a design mistake while the api is not yet set in stone.

--=20
Cheers,

Sverre Rabbelier
