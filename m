From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Mon, 25 Apr 2016 17:11:10 +0700
Message-ID: <CACsJy8DfcEeOwoN0e401gwuBG-HskY7-k1RYb58+vrEjm8P5CQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
 <CACsJy8AAQJhX+b1UUhVxC_vV_4r=XjDSbtDDd5MLkgwKri8dEg@mail.gmail.com> <CAP8UFD05Cpsms8Tf_VmMeemoerfMm0E8fUqL3o0n_9d1hu7VMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:11:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1audUZ-000456-8K
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 12:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbcDYKLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 06:11:42 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36002 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106AbcDYKLm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 06:11:42 -0400
Received: by mail-lb0-f181.google.com with SMTP id ys16so75154817lbb.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 03:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fOr9yVKP3fTBvWF8vcNElms3rusgBY3SK93BvdbgT7U=;
        b=j5naLLJY3KrX7KX851SYMHo7fDDOomkV4BUyndOXWp7uC3SVBRD0hIgH7wl0WcEfDP
         01n+fy9YGcUFP/9VXxugdHEXOaUEDAkKlnNAQzgiZMSpKzTy7De6MyZw0qrjDpEro2x2
         dvcl3iGEtewDr5bbxuHKw39JxGhX/rYOG7rPzF8NBem1wuyEZWTW/PdfFFph12H2zE7D
         yxpmirumbjVm0p9huQevQTDld2vRrgGJrBPIebOqCP6TuuIKGZh8bcdn2kb80d2aeISB
         mtwmNIX/UY96nPkDkAGclK8DQMfvq8SBQ/ZjsqJYgZCCBQyueVBgqW/o/YjG1do/bGvb
         +mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fOr9yVKP3fTBvWF8vcNElms3rusgBY3SK93BvdbgT7U=;
        b=DcPeiHvYBuumoX31U/fFMwrIOhe8NchdiPYpA9QfPF7vMRObrt4vlli0pRpAFzL85F
         rLiFE795x9USggj0o/vy7EUBDgXfUexLeaFEiqBVgQIewC5bDMbHSsf+DqHUjb3r7NXd
         gQHZrcWyOK4/+3Gf8nyG7IKqbzQfMsl5KE6wM1OS/Ey8Ix1Svp6CsBHrcOkx2BcXiLoi
         QMyFVSpqOdSSWdC3iJo+d+4/to27tBL8CTyfAWSY/R4WOrK/OqLKmLJpscc9X0vlFgZE
         r59lfmXR1EcBaNkEZAO0OcMxFO/3z5l+lV75GGZMSDN1EMwNPaGlcgI/Zkaffz49JRIV
         fItg==
X-Gm-Message-State: AOPr4FUURrZFtnblAiuyT1DN0Clb5m4N7g9iZkzDsLFvwhFJY2zC9Y8KkvyjTd3BmckyanesHN5Gem8v4CIxkQ==
X-Received: by 10.112.130.41 with SMTP id ob9mr13359326lbb.81.1461579100320;
 Mon, 25 Apr 2016 03:11:40 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 03:11:10 -0700 (PDT)
In-Reply-To: <CAP8UFD05Cpsms8Tf_VmMeemoerfMm0E8fUqL3o0n_9d1hu7VMg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292465>

On Mon, Apr 25, 2016 at 4:57 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>> But why write so many times when nobody reads it? We only need to
>> write before git-apply exits,
>
> You mean `git am` here I think.
>
>> either after successfully applying the
>> whole series, or after it stops at conflicts, and maybe even at die()
>> and SIGINT. Yes if git-apply segfaults,
>
> Here too.

Yep it's git-am. I didn't read the series, I simply ran and misread
the traces a bit.

>> then the index update is lost,
>> but in such a case, it's usually a good idea to restart fresh anyway.
>> When you only write index once (or twice) it won't matter if
>> split-index is used.
>
> Yeah I agree, but it would need further work, that can be done after
> this series is merged.

Sure.

> And I am not sure if the potential gains on a typical rebase would be worth it.

I didn't point it out, but in pathological cases where your patch
series touches a lot of (or even every) files in the worktree, the
gain from split-index lowers and could even disappear. I don't know
how often that can happen in real life though.

Also, if you start to use split-index often, please note that I
haven't addressed the sharedindex.* pruning part (it's labeled
"experimental" for a reason), you may have to un-split the index and
rm $GIT_DIR/sharedindex.* manually from time to time to keep disk
usage down.
-- 
Duy
