Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA459C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 07:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLAHJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 02:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbiLAHJB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 02:09:01 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C8A48778
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:09:01 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id h24so441797qta.9
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 23:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VYg60L2RKMM3LXNVHI/fEHgk7pxtwEOF8YE9GlBs/Gw=;
        b=JQCKzIueBzSpl6RHfsMPSTzYTUjVJCSkypXZ7s6yW/Vp2RogxvHyRdCKQOdPcA5rFN
         A1kqmR6mQW5C6v2QonlvSMgKH0/h2/mbFzRcOIOIr+GY14YAinMgtoVbEjIlNe5Gxpcz
         aMZpl4+6By67FgZd3WHU0usupAYeFD9IT/1OWLSugnS+3cd1rrmadu3YVRYgWQ5RqkPJ
         mfIcTIGi2HW5LNoNpc2HX8WwfKg7NULWAe8P1PwJQV+UjYQIr0AlX+L22vtZF036ZOl7
         ikuSlQcTqpferaxsT4sAPaO0NCtO6ida2crYUWDhp5ZChYinnFSfIUJqpr0ZFxJ1YsQg
         QsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYg60L2RKMM3LXNVHI/fEHgk7pxtwEOF8YE9GlBs/Gw=;
        b=3hTd9Cl5zQMUuJy2H3wix3WnFi8FEaUuovCnAo6cDSamqgyeaG3Ui/3PdmzmgA8PhQ
         WAsXAii1OCNScXpinUESTmnFx8u9qKMR/T0sNxoyyewWg/VsiNFzkFF9WH2yvfKj5cDq
         Rwu/EZV6g9D22w9yatNohl6VJB02i2REx3CNPv4zCpbc+lq3CxuqUJmBATWZLhCz9abb
         yHdrpbwggcK7sceBT7L+SDTVbgFBVNF6aSKzGzQ5PDO2H5oxl+cwFLxGeWqMbJIixMYU
         jrTjziFuSksz7OPjINlWO77pRVvBle5umbCjmGe8aqlp3fwSIadug4nqdyKhq2hKCV5t
         tBvg==
X-Gm-Message-State: ANoB5pnTRTfkqV3gU5gKw8BsFSKh77WkmVbPfzE2OmGyr63rHxTLsAUD
        lqVKiAsNp8nwEe2coUJiUB6nIA2++ehsZfkZtc8=
X-Google-Smtp-Source: AA0mqf7peGAF48Rd0KS9SgDgNe0bi58Qz8lT53/Bl6E0lr3sxtkkKsrXJx7AR8fK1gtj+nc1iyouHocS8qHnHr9VdjU=
X-Received: by 2002:a05:622a:4c05:b0:3a5:274c:6118 with SMTP id
 ey5-20020a05622a4c0500b003a5274c6118mr59919570qtb.425.1669878540153; Wed, 30
 Nov 2022 23:09:00 -0800 (PST)
MIME-Version: 1.0
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <221129.867czejabi.gmgdl@evledraar.gmail.com> <xmqqlenu2dxx.fsf@gitster.g>
 <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net> <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
In-Reply-To: <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
From:   Ping Yin <pkufranky@gmail.com>
Date:   Thu, 1 Dec 2022 15:08:48 +0800
Message-ID: <CACSwcnTj8kiM83+x3V69avohqW4ABOBVe4uG5n3giY-tQEP_Vg@mail.gmail.com>
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        mailinggit list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I wonder if OP has diff.wordRegex config (or attributes triggering a
> diff.*.wordRegex) that is doing something else.

Wow, you are right, sorry for the noise.

$ git config -l | grep word
diff.wordregex=[[:alnum:]_]+|[^[:space:]]
