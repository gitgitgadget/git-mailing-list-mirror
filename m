From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More builtin git-am issues..
Date: Fri, 4 Sep 2015 18:35:46 -0700
Message-ID: <CA+55aFw9BmBKEbibwVs+LuVQR2=PKt+hh5LAhdmVC-OkgBB3eg@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<CA+55aFw-PObyj2boqpeA9DDcKeAuCGouT7Qd2Zw02+sxvd2CgA@mail.gmail.com>
	<xmqq613pek1b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 03:35:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY2OW-0004CX-HK
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 03:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759277AbbIEBft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 21:35:49 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36516 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756270AbbIEBfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 21:35:47 -0400
Received: by ioii196 with SMTP id i196so41760360ioi.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 18:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QD+YeAgMlTLmbtFDjeXkLGGq952ftWA9tv54wWaSfrY=;
        b=F99Pcwa+b+QXqx5L2FVtaiiC4PbyYonKNhH1CjAziha68F8fqijyuMZjNFzxKtRVWI
         l0lOw/68QEja6dXgRnV+0WJGFYQFH+rtAQYMkIfvsBhXZhsXjZwrw7HFeXzw05H2YuNs
         NmzMFXpUgEPlmA/3Bt15gI004KTszOypSCgIivo64z/stDMo85ZXuSvi+3i+TNkAOESP
         aXlNu42Vg3nOqRZnt8hX9dW9G6B8Eat18BtZmSeudXN3nwhEYWMT2kM9xL3XtEfvfAKO
         fJydGWVFUeauvFv3Jlge4273hQxR/g0x9AC3DgwJAVwDSzOUYdGFqXpnjlxU7E37Gl3a
         /Fdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QD+YeAgMlTLmbtFDjeXkLGGq952ftWA9tv54wWaSfrY=;
        b=B9N/xPmRp37kX9Athp6y29OmoftQ7tBgLXoksn/JuzIGl808cUsNJKs0Cd/F2eWGJI
         itNBDLmJ6RAJs/rfzjayVKKV+EV1uzcIXUFntzMi7kEU6h9QX8jgwtw+amFW9Ugd9dQQ
         B7KCckvbIJve5Otcy33l+vH+ut0pw337p0cbs=
X-Received: by 10.107.38.67 with SMTP id m64mr11726396iom.89.1441416946875;
 Fri, 04 Sep 2015 18:35:46 -0700 (PDT)
Received: by 10.36.124.195 with HTTP; Fri, 4 Sep 2015 18:35:46 -0700 (PDT)
In-Reply-To: <xmqq613pek1b.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: CE22ZjVAZbvl9wZC-MtGNhWN3kg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277359>

On Fri, Sep 4, 2015 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> OK, I didn't know that was acceptable in the kernel community
> to have random comments like that inside the block.  Can these
> comments span multiple paragraphs?  What I am wondering is what
> you want to see in a case like this:
>
>      Signed-off-by: Noam Camus <noamc@ezchip.com>
>      Acked-by: Vineet Gupta <vgupta@synopsys.com>
>      [ Also removed pointless cast from "void *". - Linus]
>      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>      [ Ahh, we have to tell at least these people
>
>       - stakeholder class 1
>       - staeholder class 2
>      ]
>      Cc: foo
>      Cc: bar

So quite frankly, at that point if git doesn't recognize it as a
sign-off block, I don't think it's a big deal.

That said, the original "git am" rules actually seem to be rather
straightforward: it's never an issue about "last block of text", and
it's simply an issue of "is there a sign-ff _anywhere_ in the text".

That simplicity has a certain appeal to me. I don't think it was
necessarily written that way because it was "well designed" - I
suspect it is more an issue of "easy to implement in a shell-script".

And it's possible that I'm mis-reading the scripts too. It's not like
I _remember_ what the exact behavior was, I just think it used to work
really well for us (ie I don't recall seeing lots of those empty lines
in the middle of the sign-off block before, and this current merge
window it happened for four of the emails I applied from Andrew's
119-patch series..

Four out of 119 emails may not be a big percentage, but it does mean
that it's not horribly unusual either..

                Linus
