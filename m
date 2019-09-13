Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6651F463
	for <e@80x24.org>; Fri, 13 Sep 2019 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfIMHwv (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 03:52:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfIMHwv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 03:52:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id e17so26121180ljf.13
        for <git@vger.kernel.org>; Fri, 13 Sep 2019 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xT1/ui1gVBLXv66AdnmjXDOiVfqWY45zxdTRIuNtV4=;
        b=TI2SHtxqhAxJDn9+18MaHhEXnzHi1s0WeZUCGoFXtgFk/sEwQiiHt2DjUFFwSp7xJp
         WqeonQtwIQeu2Dq0T60HhCJOkifLE/7Nkzit96x+tUVU2d0yKwPCqjjHmEMdgaFza5At
         aPYPHwbeFh0XkMQUIBzBWRxstwUw3h/vN1qhleG0mMCuzs2vOjJ6O9UAk3HPgeD/ttsj
         NX/I7aJQxD7sqljkt224ZLFAY88gAU3ErzWN4cjlGjqNnKPVmbWXwaqMspR3iti00bkJ
         RQiv6HDQ1yCH7SQ75Hc9kHtaiYU4O1jC49ljqr6UjltvI5rXK0W0gtnbnFCiZiOIESXS
         mtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xT1/ui1gVBLXv66AdnmjXDOiVfqWY45zxdTRIuNtV4=;
        b=adSAuLVgUJDyXj4DQwuUoHp/1UPS+hUpiK40m5TVzhoklsmFQuZRv0mMqrcNr9kIFa
         MiyNwNQOD5cEq3DTWaA8xAOgnU324zNrluOtP6N1j4E5iDVZlS+qq7ZCMI/LAwkOsWXw
         B2cqGC3zSfJMhlMJfEgH3t1czQK2C6xna0rJIpBUhv3j8vB5WKdbEYHpGlvKl+NuhkkK
         huHcA8MF0q53DmFCL8M85C+6/aawBKLylXsU0+h6+xh0e4873Ku10JzcG1J49d8V5ATm
         G8XfPcClLTeM0OKaW2lwKa7c3m++PB+gbVyZSux4ns4ybTxa1gQXexxpsvGRvcB4hekn
         zFMw==
X-Gm-Message-State: APjAAAU9eNOTj0i6h3kQPNjqmRsU/MQ6Z4dPEh4LqqtHVlNZDlRaMDD8
        98elIXNeB/05gzOuqn3a4WxIVkR5yxdyjV7CseLRPpvxPKrofA==
X-Google-Smtp-Source: APXvYqwVfPnGArFcZ5Sme9JT2MRXTW2R/ZlpFk5+j/mVNOBdP10HH4Ejq3ItX+cfQrK4M8lzEIMozUXj3Ho6YB+xB3s=
X-Received: by 2002:a05:651c:1035:: with SMTP id w21mr19754916ljm.119.1568361169576;
 Fri, 13 Sep 2019 00:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <ab1f68cc8552e405c9d04622be1e728ab81bda17.1567713659.git.bert.wesarg@googlemail.com>
 <b82a00441ff1a6a9cea3fd235c1c33729ec31b71.1567713659.git.bert.wesarg@googlemail.com>
 <20190911205539.vb6asqcc22nzgdqa@yadavpratyush.com> <CAGr--=Jz9xN6NMmiXjHeq9wZsYUx4eqfQrWjjVMkj3J1YCG_8g@mail.gmail.com>
 <20190912162924.phb5o2ppovnxa7nn@yadavpratyush.com> <db01db41-eff0-fb56-161a-ba26d1b18f55@xiplink.com>
 <56a6fbf8-4486-6bad-f847-793bb6b4e070@iee.email>
In-Reply-To: <56a6fbf8-4486-6bad-f847-793bb6b4e070@iee.email>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Fri, 13 Sep 2019 09:50:16 +0200
Message-ID: <CAGr--=JDKrYT=Z8iwPVRy58OB9teH7bHXrYSZHqYHhJ=5wrJzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] git-gui: add hotkey to toggle "Amend Last Commit"
 check button/menu
To:     Philip Oakley <philipoakley@iee.email>,
        Marc Branchaud <marcnarc@xiplink.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Marc and Philip,


On 12/09/2019 22:34, Marc Branchaud wrote:
> I disagree!  Who expects anything to work properly when capslock is on?

Me :-)


On Fri, Sep 13, 2019 at 12:23 AM Philip Oakley <philipoakley@iee.email> wrote:
> I'd tend to agree. In other areas the use of shift is often used as the
> complement of the unshifted action, so it does feel 'odd'. Thus it could
> be used directly as the bool for amend or direct commit.
>
> This all assumes that Caps Lock is equivalent to having the shift on,
> rather than being a special extra key.

It seems all the Ctrl+(lowercase character) hotkeys in git-gui have an
equivalent Ctrl+(uppercase character).
So for this feature, we should keep the Ctrl+E bind aswell as the
Ctrl+e bind. If nothing else, to keep it consistent with the rest of
the hotkey bindings.
But honestly, (as Marc pointed out) it is a quite weird that
Ctrl+Shift+(character) has the excact same function as
Ctrl+(character). Perhaps we should find another way to bind the
hotkeys, where the state of Caps Lock doesn't matter? If possible.


Birger
