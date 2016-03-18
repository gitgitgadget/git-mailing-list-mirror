From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] GPIO bulk changes for kernel v4.6
Date: Fri, 18 Mar 2016 08:47:02 -0700
Message-ID: <CA+55aFwbRVG-5AW+NnMOFZ_hU5i+i7f3FxgEt9Qm7B6pEd7x0g@mail.gmail.com>
References: <CACRpkdbGkfJ9bW1db64msMeQjue+=y+op5EmSx62FWOWDOJwWg@mail.gmail.com>
	<CA+55aFwV4Cq=4zJc6Fw0yAGrTmci_DFAjJKxkk05pjJJf3iYbA@mail.gmail.com>
	<56EB9B0C.4050507@nvidia.com>
	<CA+55aFy=-UAbVo+Xx08tBA7eTPk2B+G3=SbarVxThS57LdakPA@mail.gmail.com>
	<alpine.DEB.2.20.1603181532040.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: linux-gpio-owner@vger.kernel.org Fri Mar 18 16:47:12 2016
Return-path: <linux-gpio-owner@vger.kernel.org>
Envelope-to: glg-linux-gpio@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-gpio-owner@vger.kernel.org>)
	id 1agwcF-0002je-14
	for glg-linux-gpio@plane.gmane.org; Fri, 18 Mar 2016 16:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155AbcCRPrF (ORCPT <rfc822;glg-linux-gpio@m.gmane.org>);
	Fri, 18 Mar 2016 11:47:05 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36470 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbcCRPrE (ORCPT
	<rfc822;linux-gpio@vger.kernel.org>); Fri, 18 Mar 2016 11:47:04 -0400
Received: by mail-io0-f177.google.com with SMTP id g184so85018686ioa.3;
        Fri, 18 Mar 2016 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=911rCvbYkefQCbPdQGFMzHoNDJnErdhBYz3WY07YfNg=;
        b=xg6IBjn7RGr17vE9ezJw7FwiMljRgdIlY1n0f26tT2vJA9CraZYgC/dNGp7mudybrE
         x6cVBP/n6fjQvIkElPXIAmcSNUSSE4Zhgc7bDrjmqE74RXDkhNXnQi9jCKyB/YBfNyDn
         j4358fWS8lDfFhy7RnUR7a5Ln47aCqjj21yXze3fzb/Ho/JOdtez6RGfMtOb27o6YxPd
         zuAkNIabeLh3MqTKu9lvr9nEzy7vIQ1qZQ8pnQghyuLszFgoxh0zDyHu5Z5Mp8Bl4VMV
         0DcVQOCbsHGA83zvwCvBlHDo+s9OZkqlOoXUY05ky0QwuqYg9naNuNX1TbfvEcRxsWe2
         N6rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=911rCvbYkefQCbPdQGFMzHoNDJnErdhBYz3WY07YfNg=;
        b=FAD3nAKjK28z05gNXPgdHt0Bfxwt427yU68afemc9L/w0Mm/T2RFF+aOaQL/cu84DZ
         SzDgtabdis2QpdR5xEJYpRavQLgQ7XNNNKyJREAjsjHu+h6wdv7yexQDO0okzCmBowC+
         GGZIett9FHZDnD32YBjDL8yZTFCRj6sMUshR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=911rCvbYkefQCbPdQGFMzHoNDJnErdhBYz3WY07YfNg=;
        b=E626GLVpATOX/J1wq1uJ8flbV2QJaF2cVhymOX5RJQAIbg1N06klg9Eok4sfYVpm1y
         dhOj60T8ZrTNrt11wu9m+kHDM7AIyGLkWQcrN8kirX0QJRPEiZ8vj3e1pXFAPYy8NXva
         cZBsf6WHGHAfn8ch+iXpJh/RXmtwGdDhVjt0kx+Ju2D7aFm2sdmmHBjP8nWAYwPwogV+
         sSofMFDMNDPsgGB00yyO3Us+//FJnrkgJTlqQPSp7/eDbFPZ3zOT//IKEuuV/k+a5xXQ
         ZSM2Jpy7ZzC5E/h3C+6f3jDOb+1So9vHqp2hPAoYUdiPVE50tgnB+WxwocPHqv4FYfqs
         uncA==
X-Gm-Message-State: AD7BkJJxKUXx+2Eh53molJ4nBI420bvBu4AQgzw5wfYqjYyS7BHshhqPxk4PcWCQTqUFXgIP0NjXSdjw0BoEmw==
X-Received: by 10.107.13.65 with SMTP id 62mr16919856ion.186.1458316022529;
 Fri, 18 Mar 2016 08:47:02 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Fri, 18 Mar 2016 08:47:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603181532040.4690@virtualbox>
X-Google-Sender-Auth: T6q1Jt0bn3GtYrvyEhpw9USwQtg
Sender: linux-gpio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-gpio.vger.kernel.org>
X-Mailing-List: linux-gpio@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289226>

On Fri, Mar 18, 2016 at 7:32 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Fri, 18 Mar 2016, Linus Torvalds wrote:
>
>> I thought git didn't merge two branches that have no common base by
>> default, but it seems it will happily do so.
>
> What happened to "The coolest merge EVER!"?
>
>         http://thread.gmane.org/gmane.comp.version-control.git/5126/

I'm not complaining about multi-root capability in general - it's
still cool. In the kernel, we have aef8755711a2 ("Merge Btrfs into
fs/btrfs") that does something slightly similar.

It's literally just the fact that "git merge" does it with no extra
flags or checks. I'd like people to have to be aware of what they are
doing when they merge two different projects, not do it by mistake.

So making it conditional on a flag like "--no-common-root" is what I'd look for.

Or just make it about the merge stategy. For example, "subtree" makes
sense exactly for merging one project into a subdirectory of another.
But the default merge shouldn't do it.

I don't think the original "resolve" did it, for example. You can't do
a three-way merge without a base.

Note how that above "coolest merge" definitely wasn't done by just
"git merge gitk". I had to play around with the git internals. Now, it
shouldn't be _that_ hard, but at the same time it really shouldn't be
as easy as "I didn't know, so I merged two independent projects".

                       Linus
