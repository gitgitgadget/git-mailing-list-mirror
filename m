From: Andrew Garber <andrew@andrewgarber.com>
Subject: Re: Why can't I use git-bisect to find the first *good* commit?
Date: Mon, 28 Mar 2011 13:18:18 -0400
Message-ID: <AANLkTinC9Lr9uCTUZSVxVR56+FQm2NGRpPu90fm9OHF5@mail.gmail.com>
References: <AANLkTinQ0rCw2ydisHra779r6_iSOxqRwOStpJrNbx7h@mail.gmail.com>
 <AANLkTin1QCda9BV+gND1kcXRTZBF7hj3Chce5OkLX2a9@mail.gmail.com> <4D909DD1.2050904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4G5V-0004RR-EY
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 19:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab1C1RSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Mar 2011 13:18:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38603 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119Ab1C1RSj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Mar 2011 13:18:39 -0400
Received: by eyx24 with SMTP id 24so1228194eyx.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 10:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BmHrk2zFALfZBtJosFdJNvbW4lebuRYWRwazUKaFr0g=;
        b=c0gn4fEgFK8JJnXv5czeEtzNUu1czQMJZj8FsKiBYDJf2BSCr5NmXqRxDY9JbwFD6Z
         8NYJyRkIzq0kFIAcCjIUR/feTj/US7ypLsblQkXLgQ/bXGFtwT+5Jsib6ZcPzFIe1ddF
         iRvUbxWX42X+/KHitFM7D1v9clfj5z5mNfSpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=SeAqBuI0/BWOXTd6Q0Y45jl6TOKeV6F41HjW4OZOWD1yhZzlfj/32C7JaW0XG9VjpT
         EvkoD/vUdwkEvnIBdH27yUYbuDX20rQ8Lhhb0He6qXeV47qROG21DEqTGFafb7ag7CTA
         1nJFf57zFOER3bcQQfhi3v7I0jyHvA/tcMjF0=
Received: by 10.213.25.212 with SMTP id a20mr1860098ebc.106.1301332718215;
 Mon, 28 Mar 2011 10:18:38 -0700 (PDT)
Received: by 10.213.105.76 with HTTP; Mon, 28 Mar 2011 10:18:18 -0700 (PDT)
In-Reply-To: <4D909DD1.2050904@viscovery.net>
X-Google-Sender-Auth: EfvdsYhcGGNgG-EmWGWKI49IoFM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170162>

On Mon, Mar 28, 2011 at 10:40 AM, Johannes Sixt <j.sixt@viscovery.net> =
wrote:
> Define "end" and "other end"! It's not that trivial.
>
> =C2=A0 =C2=A0 =C2=A0o--o--o--B
> =C2=A0 =C2=A0 /
> =C2=A0--o--o--o--o--G
>
> When I have this history and I mark B as bad and G as good, will I no=
w
> find the first bad or the first good commit?
>
> -- Hannes
>

That kind of situation shouldn't occur: IMO, bisect should only deal
with a single branch (the current branch).
