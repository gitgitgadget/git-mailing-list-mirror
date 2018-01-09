Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327E31F404
	for <e@80x24.org>; Tue,  9 Jan 2018 11:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755508AbeAILJI (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 06:09:08 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:44326 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752345AbeAILJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 06:09:07 -0500
Received: by mail-wr0-f174.google.com with SMTP id w50so4496745wrc.11
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 03:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sVL8eHGOSxcrHM45C7CtDOFJ4drvFOmhJs/AOEiHr9w=;
        b=g80liTxuFEEjRhtWAyTEumUJmrPIEstdzMoNdHowOTp/bTCkyr6/B2jR2QNWME0UPE
         tBqAsy3qvE7BETrTC31P827m34OR03EDB8+Bss8epAuUTYibG8ZNCHegUTDMRHggC93c
         +QRyeVsxYbIP3f2scHU/KSkbecRhmenJwxNHQpuby4kf2tcDdrV8Bc21TsHEFnMq+Trk
         h+XwzyY0jFPD+++6eOEyHjxfU0tjKAyw8WDXn4xcfBcF7as2t9dUANv3SmUm+18mqUvZ
         CIhK24tlHXPHtdnqiGXFvwXYEOfG5/eOk9+DqKBQFesMsizJOKeEhGRnqtEY7ncQHU1B
         KFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sVL8eHGOSxcrHM45C7CtDOFJ4drvFOmhJs/AOEiHr9w=;
        b=aElKkh00mbsRbdEvfpYG1nzfDTIr801FP2ewFFDgd7NnKHgqrwiV6MrniQyWyuB6Eb
         fBReq4/fcsaU6+wxwmLDiHTCuwufWu6p96FNxH3sum6Wv/wtymxq9+Bkt7E/krPt3y8I
         VbxXVe0kDsrFzCbwKrybtMZsvwokLvfhUGy868+VgHHMJECAFhVlEUhC/KnRb82IP/8l
         +7oZd1GrvHRMXVI3EKoeeZATpSmYU9IsTugHVss+kSIvR9fqKaXbOoaxEZimmr3kdwz2
         pecswUXXmcQQct0lSK06arHUJViTLAYEwV4Mi7VyCtCZORrE3PERI9M9iMv4oQF5ZLEl
         AUgw==
X-Gm-Message-State: AKwxytcNvowcDA5NNpcw7zXGl/Qx0EHjI9Ic0cMRrlzDdkZ3RTeTxz9v
        VZXVmWEEqlsfNb+UBZxBY/m2psMMnLgLGKCBBc8=
X-Google-Smtp-Source: ACJfBovl5H499WAyTXBOqsFB7SXvvJ1Y22XKZeACbM+DRmRutg5RGUqMifE3PRUiqou4vOSU5z6RMjpe8NDaAQgzjk8=
X-Received: by 10.223.177.138 with SMTP id q10mr173233wra.169.1515496146268;
 Tue, 09 Jan 2018 03:09:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.197.193 with HTTP; Tue, 9 Jan 2018 03:09:05 -0800 (PST)
In-Reply-To: <CAP8UFD1rO1cFCfZg53gG71qfbapkn3gVvja87YFiMBZTkOqNuw@mail.gmail.com>
References: <CAELBRWLyZ5s2Wvk2U5Ks2adx23Z+51dbEs3QbAq+5nGLe21srQ@mail.gmail.com>
 <20180106082116.11057-1-martin.agren@gmail.com> <CAELBRWJJYfRUxkzoeFfHQbSL5xzPQKt4srdoge=4K4n=ChN-TA@mail.gmail.com>
 <CAP8UFD03-EPxQQk51RZgb9Osdb4P=B67CLU6PrEP0O9chcHOCw@mail.gmail.com>
 <CAELBRWLV7wQm_b9Lvj67KiAMAxq6vNOzA3z62S-f5=3A5LyjZQ@mail.gmail.com> <CAP8UFD1rO1cFCfZg53gG71qfbapkn3gVvja87YFiMBZTkOqNuw@mail.gmail.com>
From:   Yasushi SHOJI <yasushi.shoji@gmail.com>
Date:   Tue, 9 Jan 2018 20:09:05 +0900
Message-ID: <CAELBRW+kvvUVKt2L9xRDtFvD2Vi9qG=3ZnNR2OVmdq6F64RMBg@mail.gmail.com>
Subject: Re: [BUG] v2.16.0-rc0 seg faults when git bisect skip
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Jan 9, 2018 at 12:09 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> ... "i == cnt" is always false above. I think it should be "i == cnt - 1".

uga.  Thanks.  That's stupid of me.

> And with your code one can wonder why the cleanup is part of the loop.

OK.  I have nothing to offer, then.  Thank you for taking care of this!

>> I also found a bug in show_list().  I'm attaching a patch as well.
>
> Could you send it inline as explained in Documentation/SubmittingPatches?

Done that.

Thanks,
-- 
          yashi
