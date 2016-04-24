From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 00/83] libify apply and use lib in am
Date: Sun, 24 Apr 2016 18:27:45 +0200
Message-ID: <CAP8UFD0dEYPSku8w=7ehJFFgtNFO8EbUc4RDn+KRdrYG3-=Rxg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<571CE4D5.8010403@ramsayjones.plus.com>
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
X-From: git-owner@vger.kernel.org Sun Apr 24 18:28:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auMtH-0000ev-Et
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 18:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbcDXQ1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 12:27:48 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36146 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbcDXQ1r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 12:27:47 -0400
Received: by mail-wm0-f54.google.com with SMTP id v188so72437427wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=OpVSoc9gkU2hiy+v4j8s8sbmJ1923xoYS+QJRsXZCFI=;
        b=0wyDETr6X3YygUUDQPS0x+8UmZ71cZN0l6xvWjGn4ceU7/npQnqMporf1911wWi08H
         SC4lOMtTtw8NjAhXDARPWJ5K3I4DdugsWudG7gNZ8KYe713/sWaZwg/Xq+aKViLduvkE
         GkzZE0ggae3Cax4NDvOY2V/yO/3WirXRqDetWmVPQcQLT14+6KyLaThuTdqpIsTdLSFn
         bCeB/5MvE584vcsjP+8HFbcuaMfvYIjUJckoCm7e5nifFfp489VaG1wFdJ0wXeJTgr4V
         BcPVWnk4gyohQOP6FkYgECKtqlNXJbyqiPWefWH1D73dIy2wEzyhgpe96uYuhH/Sf4Nk
         rIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=OpVSoc9gkU2hiy+v4j8s8sbmJ1923xoYS+QJRsXZCFI=;
        b=FzbgbNKPp3+EcZ+d/vNQwII9qS6e4eAQDGhWTrTajS3O2I22M7m8auna4mSHa1RAGd
         Mysbr8d1Nw9hju5PPZXhPnwgiU46ahxUP2iWTbJvm2s4TEPxZZLKqkYcF4crLIb4/B79
         1kAatGCbwzJQkDclbeROai3++lcaE8+nEay6WUe9xqYSO6VFzxS42JevOPXWROZad+uz
         FzGtT9GT/CnhyggwRe9cygGsdqT5tXzgaBZJwPmeejq80ATxSJw64wEWaDo+3nlnPw3H
         3MDTddiCHFVpflZyxvOcCGAc2a1C3pn+4lvvb47ASQk7cuWYyGYGTLLAdiZ1RHpqlf3m
         MpgA==
X-Gm-Message-State: AOPr4FV7bXxCbcynLS5l/aBiupI2D5uf6O3aLUnt3yGjsvcJ1Sff45+cgZrD7yu0Fa4qsrK3oj6fFH0L/N92Xw==
X-Received: by 10.194.117.70 with SMTP id kc6mr33428646wjb.94.1461515265391;
 Sun, 24 Apr 2016 09:27:45 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Sun, 24 Apr 2016 09:27:45 -0700 (PDT)
In-Reply-To: <571CE4D5.8010403@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292417>

On Sun, Apr 24, 2016 at 5:23 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
>
> On 24/04/16 14:33, Christian Couder wrote:
>> This is a patch series about libifying `git apply` functionality, and
>> using this libified functionality in `git am`, so that no 'git apply'
>> process is spawn anymore. This makes `git am` significantly faster, so
>> `git rebase`, when it uses the am backend, is also significantly
>> faster.
>
> I just tried to git-am these patches, but patch #78 did not make it
> to the list.

That's strange because gmail tells me it has been sent, and it made it
to chriscool@tuxfamily.org.

I use send-email and smtp.gmail.com. Just after sending patch #78 the
connection to smtp.gmail.com was closed with:

4.7.0 Try again later, closing connection. (MAIL) j6sm6717101wjb.29 - gsmtp

Then I had to wait a few minutes before I could send the last patches.

> (Also, patches #59 and #62 both issue a 'new blank line at EOF' warning).

Ok, I will take a look at that.

Thanks,
Christian.
