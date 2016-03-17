From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Thu, 17 Mar 2016 04:14:47 -0400
Message-ID: <CAPig+cTi7biYK7=P07-VZvA=d6mwgsdYxZG_vvVm7sRj2fcu6Q@mail.gmail.com>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
	<20160317015044.GB12830@sigill.intra.peff.net>
	<CAPig+cRkAE4BzbgniP=peHE-pBfKt1i2C4MqJcJ36sMfsSh3KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 09:14:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agT55-0006Mj-3D
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 09:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbcCQIOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 04:14:50 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34528 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756248AbcCQIOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 04:14:48 -0400
Received: by mail-vk0-f48.google.com with SMTP id e185so92677533vkb.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=Zf5w/Kdmeo13YLa7f6svNC8gkJsk9ql39+ML1glfj0k=;
        b=fdpbhxq7iZJyuvsAqYhw0rBM3vYkYx4ayThdspodhPyC6lNaSSIy/BjaSsZ1g2Ps8c
         yhcVGkjWt33lCwnw25w0VQB9zZkG2WULdMvmzEeyDGwa8LkiiZGuRJDHRCT3aC4cogRS
         5DyHk+SVDAe30vqS+OMfoLcifNuZs74Nj7hdRxJEJiV1P+0fQ00/Dl+DB0ceAFNOtOKn
         Sqv8PLurH0XEc1siKhgpSKzW29gln2NX6q50+7GZCvtBMy10hmT7b1jbo7bb/m5Ewru5
         mlU3kElKiARYHLaDuPeL/fUXezlqZprpDs+ZMm4fnzm+oRZ/VBHuqu6xRGvUGAGXqK7R
         Gyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Zf5w/Kdmeo13YLa7f6svNC8gkJsk9ql39+ML1glfj0k=;
        b=QV7TOSlSxK7KYmK2atB0kVZ8tMkH05JAVLoaG2Itt8ExJkSKUKQZGroIS3V/P0PIl8
         cR5+nRAs4j1f+KIoVbeHvmKKn0CrF3QsJZEssvWSLwSWK4oBc1D0dAB2wxePTWXVNAeB
         iRVqwQ46P54sGecbsB22Q/rTAMAELwsBG4//EFLo/CmTKDalMNOtAmu2Uzcll4HfhsGP
         E4ui8wId6vtP0csR2SGgEW01XMDBmVaId8PG4+4ItBxcWAsnGke/vc89rFrZ6bNeB8S0
         fmcVaC2vf2CfSxFqX8z+MTPJdvLXQ+5o3xZnUm4NnGJ3O/BNE8ZWlOl27tkxfjmKcBD3
         6LyQ==
X-Gm-Message-State: AD7BkJKv9Sjok2XoFLZ4q16QGkcMxnZ7Sg660DnADG7obexE7AkXcNvyewwfzniBFKSqneUNFvI9bNBvDcZ6KA==
X-Received: by 10.31.168.76 with SMTP id r73mr9910022vke.117.1458202487115;
 Thu, 17 Mar 2016 01:14:47 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 17 Mar 2016 01:14:47 -0700 (PDT)
In-Reply-To: <CAPig+cRkAE4BzbgniP=peHE-pBfKt1i2C4MqJcJ36sMfsSh3KQ@mail.gmail.com>
X-Google-Sender-Auth: g3LkF4zKkVS469rCvNmJAPGJXpE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289088>

On Thu, Mar 17, 2016 at 3:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> I also realized that Pranit can achieve the desired behavior without
> modifying OPT__VERBOSE at all. Specifically, rather than initializing
> his opt_verbose variable to -1, he can instead initialize it to 1.
> Then:
>
> * if --verbose is seen (one or more times), opt_verbose will be >=2,
> and the real verbosity level will be (opt_verbose - 1)
>
> * if --no-verbose is seen, opt_verbose will be 0
>
> * if neither is seen, then opt_verbose will remain 1

Eh, this is bogus. "git commit --no-verbose --verbose" would leave
opt_verbose at 1, which would fool it into thinking neither had been
seen.

Thus, a further +1 for an OPT__VERBOSE which understands "unspecified".

> However, I think this approach is far too ugly and non-obvious to
> seriously suggest using it, whereas the change to OPT__VERBOSE is
> easily understood and could prove useful in the future for other
> commands with multiple verbosity levels.
