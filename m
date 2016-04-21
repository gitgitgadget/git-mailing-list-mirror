From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 10:59:52 -0700
Message-ID: <CA+55aFzYWoeUq3MFgGtELaN-2sEc4j3egsAHZHVzK1CNPOqhKQ@mail.gmail.com>
References: <20160421113004.GA3140@aepfle.de>
	<87lh473xic.fsf@linux-m68k.org>
	<CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
	<CA+55aFzk4rZFdhOjkPDqFC3_tk4BUvx4-STsY2L_tKMH2FxCCA@mail.gmail.com>
	<xmqqvb3aswp0.fsf@gitster.mtv.corp.google.com>
	<CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:02:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atItV-0002XY-0O
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 20:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbcDUR7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:59:55 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34249 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcDUR7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:59:54 -0400
Received: by mail-ig0-f195.google.com with SMTP id qu10so11218547igc.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2016 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=zkoKlhEdELs7vBb42nVFSXgXoQOq+1AGGETvG+Vk3Sc=;
        b=Gi6On+Kc5FD2ce/0gFkQv0mHEM+G5ZN5LHW+lqGfgs6Oa0DybCeLJgEaNO6PZRXRHZ
         xlJIsMC3jX8n3mTwonGkNcnz3/mN9UrRFyaxAlrrdQa+0k53RrfE5zMH3a7aNnUuE22V
         E3faOtf6aSZyDgN9L9KpxMPp8j8WI5EbH5CiFCnFXjhhIIDU3Ysan4hO/1Pgs8h8kXRw
         Wcx82k/OKqDR5jy/BHQu5AV9VQi6JGh5T9A0EUy2/f6s4RJ7lMcq4dSYh4lBflnl713M
         PVJijrvuTU08rLqoUb0S5X4MrXhHfnO5iMF7pdLKQ3cwZJLENMfp27GYYeycxjpdkaZB
         e+4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=zkoKlhEdELs7vBb42nVFSXgXoQOq+1AGGETvG+Vk3Sc=;
        b=R5m3fvbFgNlBoacXBB95rEcS0AEpAN+NTDk0ODupu88xcAm3e1kV27O1fBl7h4IR19
         cEo4kyjkl7RH2pNKH0lUIMUMM/C/1RGpyv59N04jSC6tft6yZHskm1Wy9gpn3scNz1y7
         +y/h7DU7P/nBJp60PE4JsiauMoDxuabBaUyIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zkoKlhEdELs7vBb42nVFSXgXoQOq+1AGGETvG+Vk3Sc=;
        b=DdULTUFvBG3cYQNYVtI8IY3qF3fh3Tvj6/9gBSLxv4D5SL+Z/s5TuvA9sNa0A6fxPs
         Q2dVihAt7GV1+6yeVFWXZkqUSPxU7UdtOwhrmMrcuyZpnPCshtTPbixkVGfDSnO82hv7
         WVmipr8Nt75qTn/vgRwRM3GROpFRNgBPydrGTVKBVw1d6LwEOXS5l5BlXAHdCCKWzD+w
         ezoAYxBSgUB1F2Ot8y09WKwZlSVmbSPUZYK58eip0m8kA8KEUak8rG1sCWM9e7H0e7Pi
         /MOZWcnziY9JPnzkMyEtE3N/yqU2zJUPpoIWfuNHkAIj4+XlNYXwZMKjTUodyGM/YmA4
         6D8A==
X-Gm-Message-State: AOPr4FXYi+NzOcWoJX1mC/GV4uM7zmyOJLWTuTx2vyYpQQ9Ypuq2HeYM8muFrCjAVqisV3WUeikfA/dOswB6Cg==
X-Received: by 10.50.129.69 with SMTP id nu5mr5325673igb.45.1461261592946;
 Thu, 21 Apr 2016 10:59:52 -0700 (PDT)
Received: by 10.36.2.9 with HTTP; Thu, 21 Apr 2016 10:59:52 -0700 (PDT)
In-Reply-To: <CA+55aFwOtyW7zLHdJND=FGBWKBfhQV95RPVRG5gcoRUrtGCrAQ@mail.gmail.com>
X-Google-Sender-Auth: pll2eFUcv0B82qBweTtZzGUUJF0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292137>

On Thu, Apr 21, 2016 at 10:43 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other words, I'm trying to convince people that my patch not only
> gives a good result, but that the "weight numbers" I use make some
> kind of conceptual sense from a complexity cost angle.

Basically, the patch approximates the numerical representation of the
distance measure with the complexity of the suffix.

It's not a *true* length of the suffix (which does heavily favor
first-parent use, kind of like the current code), but I think it's
better than the pretty random "+65535" that the current git code has.
That number is clearly just completely made up. The new numbers at
least have some kind of logic behind them.

And the current code obviously does give really bad results. Picking
the v4.6-rc1 tag as a base just because it happens to get a lot of
first-parent traversals (800!) from one second-parent commit that is
close to 4.6-rc1 is just obscene.

So the more I look at my patch, the more I go "it's a real improvement
on the current situation".

That said, I do think that a much bigger conceptual change that
actually does full traversal and be much more complicated might be the
only "correct" solution.

So my patch is just a "improve heuristics" small fixlet rather than
something optimal.

                 Linus
