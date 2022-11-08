Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5476C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKHWnl convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 8 Nov 2022 17:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiKHWnh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:43:37 -0500
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855FFFAF2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:43:35 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id 11so12707203iou.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht0sFoGFyH99uWhsk7UwCFV7nO0iBuiJcDvfhj29bXE=;
        b=0EZFcYdKxhH5tr5t+zuqrEE8QDD2qD90dpkMOGhdFR74uVzKly/H56mlqMBWH+mQAA
         CEEsQ4v7omc1nyJ5G7QUUwg4fOMpRrZWpc5tZTHLdjuc/m/RzztGVwZ8y9tGPJMoCFKx
         UZt1WFTG1APrf3+4ZJCMGquLviqM2O0uZ9H11sRcW0OSi/m1Xp4lLdeooeDJiLleMl8d
         HUx9hFNB5guC6Q50E0x8imlhZnkIDEMacfP+/NCvLWVdHb0/RdhUZ8Aatmef26vrHSUm
         R/4eG6SSofR/MlvZCDqd+Q/+KbkFTI+V1hSsEgI+w9LCJeP/Egb2EQtP6SSMfn6F9yRn
         aJGg==
X-Gm-Message-State: ACrzQf16XfnlaNcPKnhRvrM3K5J3FghuF2RBOfW38nNv21x7vRWk+L5q
        MXsfYiL83LU7ez9Mc4Er1ks04Ihxutg7jJ5outQbSksY
X-Google-Smtp-Source: AMsMyM5mq0wFV1bha+7BiMFYm6DeHCw3QGQ20+l9P7VuC/W+17aKj7zpXjCe8cyB0qcO/KaNbNOLdm61kwn/jUBK30A=
X-Received: by 2002:a02:b10c:0:b0:375:8839:bd9a with SMTP id
 r12-20020a02b10c000000b003758839bd9amr18063490jah.177.1667947414783; Tue, 08
 Nov 2022 14:43:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1375.git.git.1667934510.gitgitgadget@gmail.com> <221108.86iljpqdvj.gmgdl@evledraar.gmail.com>
In-Reply-To: <221108.86iljpqdvj.gmgdl@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 8 Nov 2022 17:43:23 -0500
Message-ID: <CAPig+cSWXYhp95kcRn1EHrPW15o_z7uL+TcHO-hf6owP5FQnNw@mail.gmail.com>
Subject: Re: [PATCH 0/4] chainlint: improve annotated output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2022 at 5:29 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Tue, Nov 08 2022, Eric Sunshine via GitGitGadget wrote:
> > (Note to self: Add Ævar to nerd-snipe blacklist alongside Peff.)
>
> Also, and I guess this is an attempt to evade your blacklist. I *did*
> notice when playing around with this that if I now expand the "1 while"
> loop here:
>    [...]
> To something that "follows along" with the parser it shouldn't be too
> hard in the future to add line number annotations now. E.g. for
> "#!/bin/sh\n" you'll emit a token like "\n", but the positions will be
> 0, 10.
>
> But that's all for some hypothetical future, this is already much better

My nerd-snipe blacklist hasn't fully solidified yet, unfortunately (for me).
