From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Mon, 9 May 2016 21:03:34 +0530
Message-ID: <CAFZEwPNgEHOYhdqaX6W=_j7OUoBbX-=fHBLndGYO20OZjRUx2w@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605080858190.4092@virtualbox>
	<CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
	<alpine.DEB.2.20.1605091657290.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 17:58:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aznBk-0002yL-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 17:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbcEIPdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 11:33:36 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36061 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbcEIPdf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 11:33:35 -0400
Received: by mail-yw0-f193.google.com with SMTP id u62so23640372ywe.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=G9mr7pFJpc64d/553K0GG3vC+Ocr/xkMpKfeZm+HgcI=;
        b=XFhAvXWFbnuCiCW162OEn/0/a/kRmvNisATFFhjSsD8iZ4xnr0A2CjQEkv6TjqZpTz
         RltxrvjCs59QYylFhTGJXhi/bbE1g0tO3Ki94w7s/sDLg9y0en484W7rEIs5l2t1fmxN
         50qXKUJQLyuDhpA7bCKdJvcYjPLds+AL7vIHlBFvrkCTDvoChSo9AvVIj4sQ5c3D2ZPU
         iMMDiU2+HNKxPAxH9aAE4DrZyOh26ZofWOl5ibgpTYdb00MlwhHCBScmdBD7vwDSzs4z
         d01uRz+c56xvqQyOakVlFR6c27y/ZTj0hRaQZMJljEQP0QZsgkPhyeelH6QEbtDTrJ94
         JNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=G9mr7pFJpc64d/553K0GG3vC+Ocr/xkMpKfeZm+HgcI=;
        b=nOo/6NQse5gxZLAl1MjgaMZJiOmz2q+t+YP7eWcFJ+x6Nh5qnsaE9tyugBKMAQpkjk
         ZB/uAsb3kpaVvE5AW9Oy9moyZyIxBXAq94xUC4pecQTkXuFjUjzEpKWRctmC4hD8vcJg
         albuL9JjTr45l3BcpVjeE8wzGcWswzkd0pjUz138OakiP+eFKRw3TTK/dnUvi0JFa5uS
         QMbCkpQlLVlpBppZiTuO7KjZkqcjGwxsu8lOl1urUXfyZhzJZfkRqBCYvzwlRY6nVFVG
         aSX/GCreqtv5hWHyMERBAv1qEo8wCWmxAXGsns52oFYP0G4w71CF8o2w1/0tM5U4HYNt
         BUrQ==
X-Gm-Message-State: AOPr4FXgujuylGv60/rbjZWlNDvPdQWXPdXeoYLAwy9olCAP7IxlvsKtDJu5wBnxyFE/M6kBLm4h3xSInKWmWg==
X-Received: by 10.13.235.143 with SMTP id u137mr22200218ywe.20.1462808014936;
 Mon, 09 May 2016 08:33:34 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Mon, 9 May 2016 08:33:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605091657290.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294001>

Hey Johannes,

On Mon, May 9, 2016 at 8:29 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Sun, 8 May 2016, Pranit Bauva wrote:
>
>> On Sun, May 8, 2016 at 12:34 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> >
>> > On Fri, 6 May 2016, Pranit Bauva wrote:
>> >
>> >> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> >> index 3324229..d8de651 100644
>> >> --- a/builtin/bisect--helper.c
>> >> +++ b/builtin/bisect--helper.c
>> >> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>> >>       NULL
>> >>  };
>> >>
>> >> +enum subcommand {
>> >> +     NEXT_ALL = 1
>> >> +};
>> >
>> > I still do not think that this enum needs to have file scope. Function
>> > scope is enough.
>>
>> In the very initial patch I made it in function scope. To which you
>> pointed out[1] that in all other examples but for one have file scope
>> so then I thought maybe that exception was a wrong example and I
>> should stick to the convention of putting it in file scope.
>
> Oh, sorry, I meant to imply that it is good as it is by saying "so this
> code is fine"...
>
> I was just surprised because I thought I remembered that some old C
> standard does not allow enums to be function scoped. But I was wrong.
>
>> But now I also realize that builtin/replace.c uses "cmdmode" instead of
>> "subcommand" so I am still wondering what would be the most appropriate?
>
> I think the replace.c code is really a good example. Function-scoped,
> using the "cmdmode" name that obviously corresponds to the OPT_CMDMODE
> name.

Sure. WIll do!

Regards,
Pranit Bauva
