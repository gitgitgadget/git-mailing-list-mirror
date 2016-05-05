From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Thu, 5 May 2016 10:50:08 +0200
Message-ID: <CAP8UFD0Ku_q56JMvyh9UncJ2D+QsOcB4Svyr5ZWj+KqAaHORMw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
	<CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
	<CAP8UFD3o_u48rRHP7ZOWnVH7X0O5wwM-Gk-VpH5PP_kFx19ZpQ@mail.gmail.com>
	<CACsJy8AtEv9HHOJUDVKmO=qLkWctvS2zoGdo03jtQwyy2kKzRQ@mail.gmail.com>
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
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 10:50:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayEzG-0003H6-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 10:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756106AbcEEIuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 04:50:13 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36264 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbcEEIuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 04:50:10 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so11696420wmn.1
        for <git@vger.kernel.org>; Thu, 05 May 2016 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PRsA5AjaVMNtaMob3qxFr6LT+KWWpNlvYntkwOaoaSo=;
        b=pc/e4xmTJjKDsRPTtuYudT9gKzvKdnU1zr70U3v9Dj5xZzdiBGm1kg+uLBCxAG9kxb
         AgdIoHpDiLVsosfTV1LkPKRqqQIOsO2R5jngSQBtgS64RPNmcfK+jXozWyvz6s5Jw4M7
         40nXySHatAkEh0P8QrxmAD7UYYrT/xCo0E7KLkcbBakNkxFG0LJUOUx9KtpX4GLQxlWM
         wkZMsEXTowDcVIpuNsWaa9NkwSCJyZh9md4g07c9LSFIZYLMgCxokfhkF6igue//44v5
         Y6Tif5E2EkuIznUw9wKLuz645GEr9bD3meIcKLolY0iauXulwpDjpQejaRjX+KKQJ9mX
         5oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PRsA5AjaVMNtaMob3qxFr6LT+KWWpNlvYntkwOaoaSo=;
        b=bhI6KhDfhPowi4TgOhJBpELuor/tkl4TAusf7oIhnmoNqb/jaZeo6DumqN2NflegYn
         tJuEKiHjsrnZjo+3IlRYnagJ0hYE6xH/2Ac/tcvgzxR8Yzy9tNjiFjzdrf8RuboQ+7TB
         Kp+vPAa6PRBYVm92UC5XMuji4m6xW7eAaNrgqalQ6Zroj0S3p20t9thGlSceY90mIyrl
         otfqSD3N/UxjoG5Qr17dTf1zBz0Z1eni9Uj/lIrJTOzMCrJ9g8oe7gVJDSh2cFvnb4Ya
         +hbAlAwwql2UvFrwzk4FSZx9S3bMt4sPRYAjQP0ogmr5g5/lA5efKYIo/NpP84PQGVah
         KAnw==
X-Gm-Message-State: AOPr4FUwqOJVRTvtir5rmc41nEHG0iBb+Ewo6A2LoYYSfFJ8j3Ob3SMyzDRL4+n1t89WHV0belto6OObvKDmUw==
X-Received: by 10.28.128.83 with SMTP id b80mr2194278wmd.89.1462438208827;
 Thu, 05 May 2016 01:50:08 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Thu, 5 May 2016 01:50:08 -0700 (PDT)
In-Reply-To: <CACsJy8AtEv9HHOJUDVKmO=qLkWctvS2zoGdo03jtQwyy2kKzRQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293633>

On Wed, May 4, 2016 at 1:32 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, May 4, 2016 at 5:39 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> Right now I get:
>>
>>> git log --summary -M -C -B -1 20f1d27
>> commit 20f1d274609f5dde2eaaa279e7ee79fd5ef9c849
>> Author: Christian Couder <chriscool@tuxfamily.org>
>> Date:   Fri Apr 22 20:55:46 2016 +0200
>>
>>     Move libified code from builtin/apply.c to apply.{c,h}
>>
>>     Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>
>>  copy builtin/apply.c => apply.c (96%)
>>  rewrite builtin/apply.c (96%)
>
> Ah.. I forgot about -B to break rename pairs! This looks good. I
> really need to go back to diff rename hints series, so we can annotate
> this commit and don't have to use -B every time.
>
>> And using format-patch:
>>
>>> git format-patch -M -C -B -1  -o ../../patches/test-libify-apply-use-in-am/ 20f1d27
>> ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
>>> wc ../../patches/test-libify-apply-use-in-am/0001-Move-libified-code-from-builtin-apply.c-to-apply.-c-.patch
>>   5264  23426 147133
>
> It's a lot of lines, but if you look at diff stat, it's 244 insertions
> and 4906 deletions. I _think_ deletions are something reviewers don't
> have to pay much attention to (trusting that git moves code
> correctly), so only 244 lines to review are really nice. But I may be
> wrong.

Yeah, you are right. I hadn't looked at the diff stat. Thanks.
