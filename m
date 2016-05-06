From: Armin Kunaschik <megabreit@googlemail.com>
Subject: Re: Portability of git shell scripts?
Date: Fri, 6 May 2016 18:57:45 +0200
Message-ID: <CALR6jEiWQUO0WsOVah2O+9-j2Qx7juYjP7cb1v+P=Ey0oqQszg@mail.gmail.com>
References: <CALR6jEh5dAcnqiyo4kXkj+8imfQQd0nT=baPOW_qbJpJwmFsyw@mail.gmail.com>
	<20160504212028.GG21259@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 06 18:57:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayj4Z-0000ci-I3
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758646AbcEFQ5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:57:47 -0400
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35020 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758620AbcEFQ5q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 12:57:46 -0400
Received: by mail-yw0-f177.google.com with SMTP id g133so193737036ywb.2
        for <git@vger.kernel.org>; Fri, 06 May 2016 09:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8tRTqGAoS1AQeuqQ26bI7VfuzwjV8eoqdPeoap5d3As=;
        b=Q5AT9PEPrpwZ2QccZvuLvVveQPlCWO9GG+65oecTr5w3yf8VSOSqsjKNOqYu3Q6tRJ
         a0URrMAc6gXY4cg9atV/uFn00Mlahk1RBiPnHV/04JwC7IgPjSWsDV/bMKF5sD1Cm5CV
         HGsHT8JwCAWxZCkjqkr9p43V5uTjocyU5mDrM7hr1lr6BsUValzyUtczbXqVqPC2z4KW
         WqnB35ESB/xgqE16jtLv2QvJOvItVYASh2mh0Im+j90KKus+b8pCq4xdXcaTF9hi0ItH
         6QBV/GwJqaPjhCR6uY9f8HvTJAqFC2/xXR3QNJu2cHYHWG4NQPglFRrLMebCK4DGjDxI
         RabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8tRTqGAoS1AQeuqQ26bI7VfuzwjV8eoqdPeoap5d3As=;
        b=P62tY1CZ5Yoj89/IBQ6mXrV5yXLLDyuEC/eL+Imi95U2Nr4YZXoyt7yoQxVDOvPwiq
         imtqiwQ7k/oDnfD5w6j/vctOUId4XV8mU4J3ppiiO82kiki1NDmYy0pR/LMgbzOoN4TN
         G8uqh30y/l/RvLVNKnTFPk9Fi4q+kG9BG05CFKDx3mDq03uYdRvAxGv6KHb6bF9aqauR
         6QCB4Iz9nquLg27q5qpIaN8aqc9dgw18E1d3CY+mRPL2O4h1+X1HDwypHjpWtryrG6wx
         yQrMDcA7juFGg4yrL+jBKwMKNk6kYb1NPq4pI/26ZOX5yjEyt2VBmKkHThowX2PLKRiR
         DF3w==
X-Gm-Message-State: AOPr4FVr6yUqFB73wRnq1EEArxRNOep0K+c7bm09dplU0tgP+V3M0OhNepIGSH/jkNdd1eaGJ4j+v/3IIR3nOw==
X-Received: by 10.129.160.74 with SMTP id x71mr12875732ywg.131.1462553865865;
 Fri, 06 May 2016 09:57:45 -0700 (PDT)
Received: by 10.129.45.132 with HTTP; Fri, 6 May 2016 09:57:45 -0700 (PDT)
In-Reply-To: <20160504212028.GG21259@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293832>

On Wed, May 4, 2016 at 11:20 PM, Jeff King <peff@peff.net> wrote:
> On Wed, May 04, 2016 at 08:17:38PM +0200, Armin Kunaschik wrote:
>
>> I'm trying to compile/test/use git 2.8.2 on AIX 6.1 with no bash available.
>> /bin/sh is a hard link to /bin/ksh which is a ksh88, a posix shell.
>> Is this supposed to work?
>
> We aim for a practical subset of Bourne shells, including bash, dash,
> ash, ksh, etc. There's at least one Bourne-ish shell known not to work,
> which is Solaris /bin/sh[1]. POSIX is usually a good guide, but we aim
> for practical portability more than adhering strictly to the standards
> document.
>
> I've tested with mksh in the past (though it's possible that we've
> introduced a regression since then). But I think we've run into problems
> with ksh93[2]. I don't know about ksh88, or what construct it doesn't
> like.  It may or may not be easy to work around.

In general ksh (88 or 93) is posix compliant... and bash is moving away
from posix. :-) But I know what you mean.

>> As an example: make test fails on nearly every t34* test and on tests
>> which contain rebase.
>> The installation of bash (and manually changing the shebang to
>> /bin/bash) "fixes" all rebase test failures. So obviously git-rebase
>> is not portable at some point.
>
> Right. Any modern-ish Bourne shell will do, so moving to bash is one way
> to fix it.

My last compile of git 2.2.2 did far better than the current 2.8.2. So
it looks like
there were more recent changes that broke portability.

>> Does it make any sense to put work into making these scripts portable,
>> that is, work with posix shells?
>
> Maybe. :) If you can find what it is that ksh88 is unhappy with, we can
> see how painful it is to adapt to. But given my looking into ksh93 in
> [2], I suspect it will be easier to just use a more modern shell.

Regarding [2] this was a bug which was fixed quite fast. To me this is no
real showstopper. Modernity of ksh93 depends on the letter after the 93 :-)

>> And, as last resort, is it possible to configure git use bash in some
>> or all shell scripts?
>
> You can set SHELL_PATH in your config.mak file.

I tried a build with SHELL_PATH=/bin/bash. Many problems "went away".
Others appeared. I'll give it a few more days to look into it.

First finding:
make test does not make it through t3513-revert-submodule.sh anymore.
The test is not portable since it uses the z-flags of GNU-tar. When -z
is removed,
(and extension is changed back to tar) everything runs and tests smoothly.

Is this report enough to start the magic to change things?

Regards,
Armin
