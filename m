From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] rebase -i: print the editor name if it fails to launch
Date: Mon, 21 Dec 2009 08:54:05 +0100
Message-ID: <6672d0160912202354m124700dbw6e2089446d88b24@mail.gmail.com>
References: <4B2DE132.1080700@gmail.com>
	 <7v4onlbi3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 08:54:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMd5t-0001Ue-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 08:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbZLUHyL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2009 02:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZLUHyK
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 02:54:10 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:63404 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556AbZLUHyJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2009 02:54:09 -0500
Received: by bwz27 with SMTP id 27so3277415bwz.21
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 23:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cVT8X6SZ3OsFDJzqvOe3ucGAspquoYhLHACz/ghlx8k=;
        b=IxnR2kEXyGVDwTE3PZv5UiuBdaNNW6dxxNlW5G2uBuZBlbfjwXtVObgst0SAWld53d
         Tzc82GdPH3t66Tp2Yx+cmWl/E5hnMbR5KRBM+CZZy/rk7WzfINWyZD3jlvF6fT7UKqB5
         okq6XPfaUGcK1L2BIDNR1u+I5XTlug4grFzFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eMIFk+9tsPqBTNHD/n6bO1zAQStPVPHLtWDTxBQ8/0D5sORrCRuNJ1CpxSoHMQV/L+
         ACdCqfO8gwMBMdFW7TsUga/sR0IjTPSxFkpwLKkTzz9rbE7rpNgzSvKwKPZ1WcRxcgnm
         IA/VhniAH0FDSPYS4xMH5uEDka1p78qUtCIdc=
Received: by 10.204.20.142 with SMTP id f14mr4528734bkb.64.1261382045870; Sun, 
	20 Dec 2009 23:54:05 -0800 (PST)
In-Reply-To: <7v4onlbi3q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135546>

2009/12/20 Junio C Hamano <gitster@pobox.com>:

> Isn't this too elaborate? =C2=A0git_editor() has already run and when=
 it
> attempted to launch the editor it assigned to GIT_EDITOR in order to =
use
> it as an eval string.

I wanted to hide the details about the inner working of git_editor(),
but since it is only called in one place, yes, it is too elaborate.

>
> =C2=A0 =C2=A0git_editor "$TODO" ||
> =C2=A0 =C2=A0die_abort "Failed to run '${GIT_EDITOR:-your editor}'"
>
> would suffice, no?

Yes. Much better. I will rewrite my patch when I'll get home from
work later today.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
