From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Wed, 10 Feb 2010 21:20:18 +0100
Message-ID: <6672d0161002101220h34ebbda8o3fde503d41c8313e@mail.gmail.com>
References: <4B6E7564.7040109@gmail.com>
	 <7vtytsevsd.fsf@alter.siamese.dyndns.org>
	 <6672d0161002071444lba0f751w3e7e33043e1ec2e8@mail.gmail.com>
	 <7vbpg060qx.fsf@alter.siamese.dyndns.org>
	 <6672d0161002072337r2ad002adq69f4c686da8cdf09@mail.gmail.com>
	 <7vzl3i137f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 21:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfJ2v-0005xx-PI
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 21:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0BJUUV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 15:20:21 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:39328 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab0BJUUU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 15:20:20 -0500
Received: by ewy28 with SMTP id 28so468850ewy.28
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 12:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lHDCQ1U1FVAbHFyt5QERQ87naUq44YVKCXFvsKL+3Ak=;
        b=SgnVyeJm3B6yYkgrulntvd/IejWm1wGBsnfZHwtUUKu4Tf1385hZeviA5ph+b8GfUc
         Xwd+wrcDIILfxYt+quoIj5v9GwDNnok8vF15yrILGbjeqmj5yNw1I1Cb+dveaYKaqr84
         vb05CB9YqLKOdBSqMKxKH8by37hdOcB6xLpNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wcWzy96VG/CazJeKpqPd32LEBBx3L0724v/I/Is25c823oTNAGgy1Cdw8zbPxQCHSw
         0XtoV8cCw47+nPzKNDlfl1qD/SEy4teLBiLTjJpRhq8F3NPdLYH1B1TUhY/J5TEjRaSp
         WBrbR366XA19EryThyPoDDHgIWptT9CXwoRB0=
Received: by 10.216.88.143 with SMTP id a15mr429258wef.206.1265833218365; Wed, 
	10 Feb 2010 12:20:18 -0800 (PST)
In-Reply-To: <7vzl3i137f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139544>

2010/2/9 Junio C Hamano <gitster@pobox.com>:
> I actually changed my mind after thinking about it a bit more.

Thanks for thinking more about it and for your explanation
about the algorithm

I am quite busy at the moment, but I hope to get started
on a patch series after the end of February.

> I'd like to see this logic (and only this logic, without relying on t=
he
> diff hunk offset numbers at all) done first, because it is very much =
in
> line with what we already do, and more importantly, because it is a m=
ore
> general solution that is applicable outside the context of rebase.

I'll try to implement that logic. It seems that it should cover
99% of all real-world use cases. I will not worry about the general
case (tons of blanks) until I have got the first patch working.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
