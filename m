From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 22:24:38 -0800
Message-ID: <CA+P7+xq_JC3TbkXtD7rOEf1qinQcXk1xLSnMqM-bHrPh_S+tBA@mail.gmail.com>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
 <CAPig+cROoc+Y-V_6hw6Hx4X9pFGmRjfhpzYGKhswwa=bA5b=+g@mail.gmail.com>
 <CA+P7+xpkbZyuQ7gpC+_KzJPfGo+xHpVFWEmr1oS7FD30jjJSOQ@mail.gmail.com> <20160225062311.GA5541@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 25 07:25:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYpMJ-0003mh-J2
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 07:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758997AbcBYGZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 01:25:00 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34046 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbcBYGY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 01:24:59 -0500
Received: by mail-ig0-f172.google.com with SMTP id g6so7805512igt.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 22:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aq29qft0mwu5ruGHpt7JaJgrPf3lxCbUHBeweHAmisU=;
        b=eYNHtahsE8qQ5GUsEnVGaiJtr7C9EMPxPqL9WeBMqWipZbsr6ghWqG8K3TrgqXwcMt
         2/mLW7mt2X3tmUJgRKXLfWhjN1dhx4WbuuObLT6IcyRsvCalaQO7lPRIIzP9QFB54mnE
         75A2WF3DthNwEEnxy8XZu4PYrsGzWnezeElXnJWV5xGe5xzCOK7I9O/rvVmkf4wkwrmR
         jFzkTR8wANXXmVIH1XgddHeFXRQroWn73ZY2CipUjpIvxTPYAvYa36sxRMbT04vLzpN7
         bEf3EFNSS+emJ90Ji/wNCrDKnqofHtzTG4kaZzB4dvnMNWf1FukwFE71ZHoaBPjQ+F4Z
         IdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aq29qft0mwu5ruGHpt7JaJgrPf3lxCbUHBeweHAmisU=;
        b=KYmBtkatwB2Dew6D3T2NyusuDc8hlEGwdiWNjnpCouDbLXg7iK2fHPvIvX/v5vQDO/
         i/A/e+L3XGa1zGE9GcsCpISqe9zOclfIjgsOPTT4+2JkBcvpmRSdmYuhA1bMC0VSMekR
         0bu/4o9aDWpjR+xJ/lBy5Pj2CE9ZUt0Lsa9KBmw3cfgkM3Hm8+r9Jk+LhdCxsaS9DvEF
         ORA63gZExvMVtwA6vLz15/Ry5rsgumMiZ8j3ihN5q5rAZbMoOG/Sw0srB5+EuIJA40V+
         yX2MfKubxftUhvxbZkSWmTlyQpYGaWWE+PjM6KIahubXTNhsQkHAqmx7507dKDuBmKzy
         CEXg==
X-Gm-Message-State: AG10YOTAyEj2dY4iWaY/Kk1YshBgwXFx1vfRRh+TcxQDOLZoJvVzfOzZq7cCkrkmMjWDmfza8nhesD6Xc+6y4g==
X-Received: by 10.50.32.2 with SMTP id e2mr1352625igi.73.1456381498290; Wed,
 24 Feb 2016 22:24:58 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Wed, 24 Feb 2016 22:24:38 -0800 (PST)
In-Reply-To: <20160225062311.GA5541@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287335>

On Wed, Feb 24, 2016 at 10:23 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Feb 24, 2016 at 10:19:05PM -0800, Jacob Keller wrote:
>
>> >> +               /* combined all the values before we quote them */
>> >
>> > Comment repeats what the code already says, thus not terribly useful.
>> >
>> > Also: s/combined/combine/
>> >
>> I tend to make comments like this when I change the obvious way it was
>> done, I commented this because I based it on a scratch patch from Jeff
>> that didn't have them put together before quoting.
>
> That's a good point. The _what_ is not interesting here, but the _why_
> might be. Namely that we must quote the whole thing as a unit, or the
> parser on the receiving end will not be able to read it.
>

I can reword the comment to explain the _why_

> I'd also be amenable to relaxing the parser (which is as strict as it is
> only out of laziness, and the fact that it was reading the output only
> of its nearby generator function). But I can understand if you don't
> feel like digging into that.
>
> -Peff

I really don't want to dig that far into it. I think that working
within the current parser is just fine.

Regards,
Jake
