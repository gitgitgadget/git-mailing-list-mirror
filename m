Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B02BF1F406
	for <e@80x24.org>; Mon, 14 May 2018 16:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeENQkQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 12:40:16 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:35731 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeENQkP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 12:40:15 -0400
Received: by mail-oi0-f41.google.com with SMTP id a6-v6so11292796oia.2
        for <git@vger.kernel.org>; Mon, 14 May 2018 09:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FBOs47b9MCQcb/JVJA4hg1gy0Zr21WuKiAjtG1QRDZY=;
        b=UBiAJGrVP2GQweJ6zaryOkGmSNJ7gHQKmKYrkVhzDYyGupyBabL6a7r2XwUnLyjkqZ
         DsWRteE150kwcWeI/dbzZHlOOysd4p4/NRzaTfti5P7BKuIvJCJl0nrZ212+slavVSKH
         wExtVL0uaXXKVYFUknEp3oIK9LLxSx+7kkFJG60rvZfxmRBkQfn24sBAnG8d5ILE5SW6
         jLjCqoRU3d8nypKER53dAOLCEN/Ia175yk+FZLYusl5tzugDr+P77HASluQjBM6vrhuO
         KgVDvZSPmIp3OqInZWAIlYEcw66YebboI6tlQoetmz12T0CMO8vpjk7jyc8QaH61PSdg
         7GYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FBOs47b9MCQcb/JVJA4hg1gy0Zr21WuKiAjtG1QRDZY=;
        b=QdKdySTo1xecBBJF3eoQLEKxjwcMK0azdkW0gsACqhX9mBjHe+r9qIioAjySYH4dFj
         /6RIn5lZmhUZhGtb0Kdm+GMEFVh+OCZbmmx3y4rhUP2xYiJ1rgmHJkglvj+9UkWcdG9w
         dh6/yV2JzwU24LF55bHziZFdEWsR1hqMFAkkIQ028VWqFnkc4IAlkb466jOM/gwGhqZX
         2RAH/wzvThH8pBc1VHMQ49QpRUJ/JZO1ekJ8wTy8Xpm7TXK3HLFUhf6qXxNeTP+ylVe1
         8rM81Qz9NKMAEepRdRHuDrwk0dB89xshm8yFzsPJlSalHmXQ+p7y/T+Ps/SgRfzdY2ER
         84ag==
X-Gm-Message-State: ALKqPweNk9C+n9h8qjtIhJhQ7iJXul1ToxYXx9nTKWWkbintlgtot8GM
        X2+YPro/51aosjit7gyrCAmiJPk+LJXCdoh7dUk=
X-Google-Smtp-Source: AB8JxZrIBsjpfqzsitx8lun7ub2TygqpjrVAv14vl8oMJLTTGyJaLITcprgpQdEKb07E+X87g2L/js4gQut1OnatZ3Y=
X-Received: by 2002:aca:1904:: with SMTP id l4-v6mr7440094oii.216.1526316015350;
 Mon, 14 May 2018 09:40:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 14 May 2018 09:39:44 -0700 (PDT)
In-Reply-To: <CAPig+cRUD7FnJqSZ=hkz0GAgOROiY+gvHKRjKVfkKtqDZyt5mA@mail.gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com> <CAPig+cRUD7FnJqSZ=hkz0GAgOROiY+gvHKRjKVfkKtqDZyt5mA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 May 2018 18:39:44 +0200
Message-ID: <CACsJy8C+-f61H_kyUGspFh2z1q1fb0ug=p9e0tmCJC-ovC9ryA@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 5:33 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> It _might_ feel as bit less weird if it was presented as --no-<option>
> or --no-{...} or --no-<...> or --no-... or something, but those seem
> pretty weird too, so perhaps not. Anyhow, it's not a major issue; the
> --[no-]foo idea seems pretty intuitive, but if it can't be easily
> implemented, then falling back to your --no- idea makes sense.

Oh good I was thinking --no-... too or we could even do "--no- (press
tab for more)" or something to make it more obvious. As long as we
make sure there's another --no-option somewhere, then we will only
complete the --no- part and can replace the "..." (or "press tab for
more") with real candidates in the next tab/
--
Duy
