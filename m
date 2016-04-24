From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Sun, 24 Apr 2016 18:56:27 +0200
Message-ID: <CAP8UFD0rKNAoZgCPQkfo_qd7b_V4rOtLqBvQ-XQoeT6OnZidGw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<571CE4D5.8010403@ramsayjones.plus.com>
	<CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 18:56:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auNKk-0005KP-U5
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 18:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbcDXQ4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 12:56:30 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36188 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbcDXQ42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 12:56:28 -0400
Received: by mail-wm0-f46.google.com with SMTP id v188so72905482wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 09:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=mUcIUIL4erbN/1aSwW5tq5CPsy54wTHWfPG0IaPqKSU=;
        b=HVaO9zkwOzd/O8U8lsOA3gbXtkH/G7iRGeWlfuAsm5y/7awwgk+7xFI0PSvM9uayH6
         gRv+nNS7E9d+SnoNPfLeQldNzJx1Kl7GVNJqScM3dUk/NopbjGyv3c2Igili8jb8lG6W
         uXxEdhxdBhq7SzQtUAe0qboSAUw7l9jywe6TM3VaF4LkOybY/mLXmKHCM58RtV8XUp8a
         Ek9xn7OllUjajUUZoLk3Ow3Uza6gaTHbY0QxHnGHIiVsMTF7rShC1/5O+cScl2YwYoa9
         Yb4LvV5dTaA+mpz2nuNv6B90OzsCWiL/ngZZJhO+amK+xz5QqkTArIq2q0fOiFMmxWXw
         3V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=mUcIUIL4erbN/1aSwW5tq5CPsy54wTHWfPG0IaPqKSU=;
        b=TVhw4s5gM0W4Fs3oLgmSCVLguN/U4qP/6yLeUk9K3S/uR5H7xrXbcyDnbVPsX17ELX
         XCdZbeXMXDp1Gsi1/MrdGmcLzuKCtySv+5XZKxfhyTVNyM9w2t9dY44CS/EIuUJrm2BG
         7m5wgZRzGpZGobl4LIRjUUEWZ2Uyo8wOUneLsHxSqLlScEmn5UxbPyVcYp39Fc+q/Z+k
         NlCpLpJjAuyvEpreU+4+AK6nVxTf84s4x5g3Mpfslx4d26Nj+rjlgDy8yBQHb4qYWJET
         VqJ7+gNl8Ans4Ce7WYA73+3dc01SnHmG1+DuNovp3JSfHXe2leShzF0/uqhkhKDXVlVe
         oRjQ==
X-Gm-Message-State: AOPr4FWE56Imu3qMfyCjuuwn6Ai3N/nBi8BkgDVjz4t4aiHrYraO3KwbfTmyY8jUhOmt8iopQGEu58DeV76fWg==
X-Received: by 10.28.32.199 with SMTP id g190mr8078629wmg.62.1461516987234;
 Sun, 24 Apr 2016 09:56:27 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Sun, 24 Apr 2016 09:56:27 -0700 (PDT)
In-Reply-To: <CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292421>

On Sun, Apr 24, 2016 at 6:27 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Apr 24, 2016 at 5:23 PM, Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>>
>> On 24/04/16 14:33, Christian Couder wrote:
>>> This is a patch series about libifying `git apply` functionality, and
>>> using this libified functionality in `git am`, so that no 'git apply'
>>> process is spawn anymore. This makes `git am` significantly faster, so
>>> `git rebase`, when it uses the am backend, is also significantly
>>> faster.
>>
>> I just tried to git-am these patches, but patch #78 did not make it
>> to the list.
>
> That's strange because gmail tells me it has been sent, and it made it
> to chriscool@tuxfamily.org.

Instead of waiting for the patch to appear on the list, you might want
to use branch libify-apply-use-in-am25 in my GitHub repo:

https://github.com/chriscool/git/commits/libify-apply-use-in-am25
