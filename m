Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD261F404
	for <e@80x24.org>; Fri, 26 Jan 2018 19:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeAZTev (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 14:34:51 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:38133 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751496AbeAZTeu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 14:34:50 -0500
Received: by mail-qt0-f173.google.com with SMTP id z10so4060041qti.5
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 11:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2ToFfpYOBZ9cDIGZ9+UciiCjRtXQRfB4tM5YuNtJSlQ=;
        b=jVLFHXpZCpGjMJV5Tx9awiFxeZTZBtFA63v1ztLgWTXIccBZhpyQ5hlGa0wdZ79Q1r
         o2eGU14Q4XtVrNR5YVBD1w65Gf3z5NBb7epWCw3noar+MeqrgdNCRkayvMqQ5pIi09l/
         a4xAPajsz3p4TCANmYyfa6+W9kM9/zZ2CwI7sxwf60i2d19OsPolMr6ljpbIBIhvbx63
         zzhGvKRiZ3o7DYcSnAPu+OruwsfIkehE0bf1Gpuu4hXYhMUJ5CQ/fgAaFYA3MXyYFLF5
         RKDpVFFKYRAo6tm2ys7b4WniishL6gcD7vaO0yVJpZD+vebUrqOiweeHyTIk4nGjFH8V
         iK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2ToFfpYOBZ9cDIGZ9+UciiCjRtXQRfB4tM5YuNtJSlQ=;
        b=j05EFucbPDvUL5JlChKiKfxNKJUsYP3fIELKiXqT/oo/UlMAyNJQyVCBIc+rg6grH8
         NZJU2xPlX2MRPOl8QkZWVjEgGEED8mXhBW0ZKNdaasI62mBFN8uHtLHFyq/OHPTbwi1g
         XktjG314AQsQLs6Wh6xDc7RXnFyiByIZWlyUKn7hGVlI3Z9TRMYybhWudyxqCgdNdJH7
         RxWm6ZIJnW1whBJuf5H7SrNsr421Wda1iy8pgH8+stwUhgJAH+kb5anLwfb5EntrK1tA
         5A/iQ65hW1cAqG77u/grALcRgJL6TkpPd+wRhsQcLX4RWttkq8WFVjUBaqdaEvXTMEgC
         YusA==
X-Gm-Message-State: AKwxytf3zPcJYATeQ7GqXoPYvxsKoDhIhQfN5mkmwkhM1KiUyMfB+vr0
        magDBsAxvJ5UXkeISAnt408VwvZQOUzW49b/vr8=
X-Google-Smtp-Source: AH8x224DhAgYv8JqI4EkuxaZfwK4K0N8TO3/RartwHWc0dSZStqsoMoofZG1cGh4mM0zTXLB0oN6mznHuFw7EKG2B5w=
X-Received: by 10.55.104.1 with SMTP id d1mr22910021qkc.71.1516995290019; Fri,
 26 Jan 2018 11:34:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.28.54 with HTTP; Fri, 26 Jan 2018 11:34:49 -0800 (PST)
In-Reply-To: <CAP8UFD31oUtoPMN+S_r5YoKrSN4p_QgZQPE6dF20Wdf6o6vdJw@mail.gmail.com>
References: <CAL21BmkTbr9qYK3+bsbwh9aDQ1twqrNkyUdbaFPSAn5y7ov40Q@mail.gmail.com>
 <CAP8UFD14V-3T0kV=VxYLdozGp5yT-Rzio7PiY8sFn_rVUDxnjA@mail.gmail.com>
 <CAL21Bm=h4o5k2mQ7vob3m-6N-YZ4Rmr5X3_w90ifpR53_+Wnyw@mail.gmail.com> <CAP8UFD31oUtoPMN+S_r5YoKrSN4p_QgZQPE6dF20Wdf6o6vdJw@mail.gmail.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Fri, 26 Jan 2018 22:34:49 +0300
Message-ID: <CAL21Bmnir6GSgZO2TqYZY8NByNuX+8O5BEyfh5URnawhRYPGFg@mail.gmail.com>
Subject: Re: Please review my code
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-01-26 19:42 GMT+03:00 Christian Couder <christian.couder@gmail.com>:
> On Fri, Jan 26, 2018 at 11:32 AM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>> 2018-01-25 23:22 GMT+03:00 Christian Couder <christian.couder@gmail.com>=
:
>>> On Thu, Jan 25, 2018 at 6:20 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=
=D0=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>>>> Please look at my code:
>>>> https://github.com/telezhnaya/git/commits/catfile
>>>> You could send me any ideas here or in Github.
>>>
>>> I left some comments on GitHub. My main suggestion is to try to get
>>> rid of the is_cat global and if possible to remove the "struct
>>> expand_data *cat_file_info" global.
>>
>> Thanks for your comments, I find them very useful. Most of issues are
>> fixed except the main one, that you mentioned here :)
>
> Ok, no problem, we will see what happens on the mailing list.
>
> It looks like the for-each-ref documentation has not been changed though.

Have you seen last commit? I updated cat-file documentation and I
mentioned why I decided not to touch for-each-ref docs. Please share
with me any ideas how can I make that place better.

>
> Otherwise it looks good to me and perhaps you could send your series
> to the mailing list even if it's long. For the first version, you may
> want to add "RFC" in the subject of the patch emails you send.

Great, thanks, I will send it now.
Olga

>
> Thanks,
