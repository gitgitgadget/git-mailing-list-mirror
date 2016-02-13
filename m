From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Sat, 13 Feb 2016 07:53:49 +0700
Message-ID: <CACsJy8Bg5LzXKuvastiy5WAKBR8D4iOhTcCprYqmNc3fy-HrBA@mail.gmail.com>
References: <56B32953.2010908@gmail.com> <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox> <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
 <20160213004300.Horde.fMBUV1thpmh_xekWw-EOFAA@webmail.informatik.kit.edu> <20160212234655.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 01:54:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUOTt-0002WX-7r
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 01:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbcBMAya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 19:54:30 -0500
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35065 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbcBMAyU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Feb 2016 19:54:20 -0500
Received: by mail-lb0-f180.google.com with SMTP id bc4so53994567lbc.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 16:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=e+QypIY5rpH5Ci670K3PMFFBOgHRcXuPJ7mNWKawnh4=;
        b=g6WnEPPMgaqsCB65/zUQ8hXoi6b0U/4v0rm0JG0yb7r0ugCf949nhHw0wwINnRnoy4
         4/RcTgq8Lhyl700iCs/DEhFBCfCfxfdAyMF5t5hfttxVPGjnBd1rhf5QN9IcMai6THYx
         VPH1Q40e1jwT2eVTAIaoSfdcoBEmvHAcncR5r1eEjMRsBQjGe3ZHkJPqr8kvnkv2O9HL
         92lVTecKqgXniVf1j33ldE+gFLQe001P0RXScHBCLepZ4hVAeoRKL3Tbcsi2pEemcTp9
         OgOzcyQuaHI0LhKMH4/O7DGJdn4ZAa9RQJXl8xWqaEPH/rBlQ+MLEdUx4ooffXq8gWG3
         HAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=e+QypIY5rpH5Ci670K3PMFFBOgHRcXuPJ7mNWKawnh4=;
        b=WoJ8ZPlUWcO3S5Y3wL8If2cutAI7WNzdWRvxyG+7JkZZUme767N9w2sGqAFpDCyCZG
         QHRH66JGJ+e6pfIZEYeRedlhFm7P9u8GSvZxUtBjfCHVwJkzCEqx+JGMXbPFgcua1kRC
         z/vIOZJENw8XnLEzXHU0dfdC40fndiI7XCmHirknvcLS3vYGEUzUnzWubo4iSbrwX0eK
         gXpPEXqADi0Cq0zzbLrG9V3nkoHx4lllcamNyPoR26tytbwFep1VI9XcT/xS2XiUOZWu
         AYZXRgAXPg7sz2NPYrD85m368NIopmLQQK24UK2vXcQHCvrH7mIlA4cgXiocNsSvtxMP
         0Z9w==
X-Gm-Message-State: AG10YOQVtmSBulzWPpk3HVjqAvg1kH0YZlMN26yYOw8yzLYW1wciqIuX0gNW6Tn1HeaF5+q7lmZ+fWVsjxElBA==
X-Received: by 10.112.130.41 with SMTP id ob9mr1894693lbb.81.1455324858806;
 Fri, 12 Feb 2016 16:54:18 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Fri, 12 Feb 2016 16:53:49 -0800 (PST)
In-Reply-To: <20160212234655.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286101>

On Sat, Feb 13, 2016 at 6:46 AM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 13, 2016 at 12:43:00AM +0100, SZEDER G=C3=A1bor wrote:
>
>>
>> Quoting SZEDER G=C3=A1bor <szeder@ira.uka.de>:
>>
>> >Now, if 'git for-each-ref' could understand '**' globbing, not just
>> >fnmatch...
>>
>> Oh, look, though the manpage says:
>>
>>   <pattern>...
>>       If one or more patterns are given, only refs are shown that ma=
tch
>>       against at least one pattern, either using fnmatch(3) or liter=
ally,
>
> Yeah, we might want to update that. Wildmatch is basically fnmatch()
> compatible, but it understands "**" (which I _think_ is the reason we
> picked it up in the first place).

The second reason is consistent behavior across platforms.

> I think we dropped it into place by
> default because "**" is otherwise meaningless for fnmatch.
>
> I don't think there are any other differences between the two, but Du=
y
> probably knows offhand.

Nope. I think that's the only difference, feature-wise, between
fnmatch and wildmatch.

> It looks like we mention fnmatch() in a few places in the documentati=
on,
> and AFAIK each of these is now outdated.
--=20
Duy
