From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 18:01:32 +0100
Message-ID: <AANLkTinCYnvhZ49HgTWVNObQimRVwb+K6Pu3djE2RBFN@mail.gmail.com>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
 <7vfwr8jfsl.fsf@alter.siamese.dyndns.org> <AANLkTikTPVf1fZiTxsmLe-MCWVQY4YBGen5Bj_Yn0SSz@mail.gmail.com>
 <20110228165827.GB24915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 18:02:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu6UE-0006yt-KA
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 18:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755249Ab1B1RCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 12:02:13 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34320 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab1B1RCN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 12:02:13 -0500
Received: by gyh20 with SMTP id 20so1588682gyh.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 09:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=EtBTBxQG4lulLmtqOKJkvIuCyZh+rCIu5ZAWN1uHiyA=;
        b=e8kbMJA8sR8Ghnaa11/3ZidvX3/+4cMSGtTo4W0z6Xybm/HMju5OLO0CjV20biUUJj
         WxKF8WuhUScfBsbLQQBpL+Fr4ToHYj2sVeSv4cGV0KD6gaWeJz1gH4+AfJ6//pSAXyS+
         uUjFgd/1iTGRQPMt12i8RYMIFr/IaotEXAQmI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nh4kJ7AfTk/sapcdnuPjGyFJHiHR2IMyU4toIIEmXtLybP1dWyTLVujiREwrQlol0i
         UHtxvHOEo15G3ImIufUqsqdDQkNl7gkCSxAxpo7SjgkvJ5jA4TrG1HR0MBkTPrJNmWIV
         hJBhAPLJtdGFRzctsrn0EcLy7PoMFSYweWooU=
Received: by 10.150.218.16 with SMTP id q16mr7381100ybg.349.1298912532442;
 Mon, 28 Feb 2011 09:02:12 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Mon, 28 Feb 2011 09:01:32 -0800 (PST)
In-Reply-To: <20110228165827.GB24915@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168123>

Heya,

On Mon, Feb 28, 2011 at 17:58, Jeff King <peff@peff.net> wrote:
> =C2=A0$ time git verify-pack \
> =C2=A0 =C2=A0 =C2=A0.git/objects/pack/pack-36c50f6082df404c26a699f270=
2946e0cce6208f.idx
> =C2=A0real =C2=A0 =C2=A02m37.338s
> =C2=A0user =C2=A0 =C2=A02m35.874s
> =C2=A0sys =C2=A0 =C2=A0 0m1.348s
>
> =C2=A0$ time git index-pack --verify \
> =C2=A0 =C2=A0 =C2=A0.git/objects/pack/pack-36c50f6082df404c26a699f270=
2946e0cce6208f.pack
> =C2=A0real =C2=A0 =C2=A01m37.208s
> =C2=A0user =C2=A0 =C2=A01m36.106s
> =C2=A0sys =C2=A0 =C2=A0 0m1.048s

Wow, impressive results, a full minute shaved off.

> OK, with the CPU time it probably took longer than your emails. But I
> ate some ice cream while it computed. :)

You lucky man ;)

--=20
Cheers,

Sverre Rabbelier
