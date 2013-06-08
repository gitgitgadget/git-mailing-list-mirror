From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 2/2] read-cache: plug a few leaks
Date: Sat, 8 Jun 2013 09:04:31 -0500
Message-ID: <CAMP44s3K=VtkeCoKqnU9To9YbfO7vph9MsMWtgLWw0n=cYyq5g@mail.gmail.com>
References: <1370644168-4745-1-git-send-email-felipe.contreras@gmail.com>
	<1370644168-4745-3-git-send-email-felipe.contreras@gmail.com>
	<51B31651.6020307@lsrfire.ath.cx>
	<CAMP44s2Bp5p1211e6Utdch4B+v3J83GCY0_ucG7duakswkb+pg@mail.gmail.com>
	<51B32FFD.5070302@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Jun 08 16:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlJl2-0006SJ-8j
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 16:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab3FHOEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 10:04:35 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:63110 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab3FHOEd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jun 2013 10:04:33 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so901306lbi.6
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Q5NNNYaPSHGn6s38oja+MXql29/GfMkA4OZjO1zgmQE=;
        b=LFbSD93hUO6iP7ukhbHcSL/05jVrkGJiKvW9nlGVhu49wc0kLcC1XGH6zxt/pGeqhl
         eM17xYp6LoJcsYLluhi9CUGDaC5KGS72mKEPb+xj2Z3go3S/GZ7jTG1b2iVAFOmcnBXs
         QzpfVNL1kP42SGR29FA+KOlbGSxTGSe27goA10H5V/XdXgzSBIxTDd+hU5I9BaN8Ce7R
         /zZxLDYWZ8te1U4781a1+3nHYe4P7SnZpuDl9wI9Dgay4ZBvM95xH4nj3fPEfcSq37gg
         GTXXkw5X+RlTaC/dGpVHfvEQDgs3SSR7id1Qfn1Z+1Q/QEszj2iZevH2ZX1eWTzHw3L/
         637g==
X-Received: by 10.112.16.163 with SMTP id h3mr3124743lbd.85.1370700271771;
 Sat, 08 Jun 2013 07:04:31 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 07:04:31 -0700 (PDT)
In-Reply-To: <51B32FFD.5070302@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226826>

On Sat, Jun 8, 2013 at 8:22 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 08.06.2013 14:15, schrieb Felipe Contreras:

>> Why leave it out? If somebody makes the mistake of doing the above
>> sequence, would you prefer that we leak?
>
> Leaking is better than silently cleaning up after a buggy caller beca=
use it
> still allows the underlying bug to be found.

No, it doesn't. The pointer is replaced and forever lost. How is
leaking memory helping anyone to find the bug?

--=20
=46elipe Contreras
