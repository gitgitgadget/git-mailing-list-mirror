Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2CF820A29
	for <e@80x24.org>; Sun, 24 Sep 2017 20:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbdIXUAX (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 16:00:23 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:43453 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752758AbdIXUAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 16:00:22 -0400
Received: by mail-pf0-f178.google.com with SMTP id y29so2782873pff.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2017 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HKGbMP8t/O/3BsOoIA+WqPTrqPQXwbr53cYRZPGRPBA=;
        b=MfUcQjlW2yOo2bLWh0YeB5gxrEsdFus6pZWw6yTcAPlC/XtG1Fyu6bl1yinOb35PkC
         J1Xr8gglo/KAAJcpgIfHvgivT1CUxtnq4eidvXTh8jhSF4mqIAykTc+lcdjwRfhsQ0mZ
         xHXQ9U9VX/9ozDD1JU5LbY6c+JqyJS+y5qxX62TFaUmdq9effkqGs2rTwTPSk0ytMQ0R
         LXcqinsXDh3mzifXbNQ9D4H7bKE5LLf4QwcWxWH3ll0GozVp+J1aMpX2PhASrzlLQfeV
         SnPENURTwrZEPuflLjXDX5Pb0tqlj1cVgviydj8eM8YAmshw8YG5bBXqJRDe5uHh6NiY
         ZUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HKGbMP8t/O/3BsOoIA+WqPTrqPQXwbr53cYRZPGRPBA=;
        b=ZEM0NKDiFYEdpqGvKPc6OSJNbHywjVUiHwvfmqFNlrBt3g+otTwA6wS+gi+stGkKKj
         NDzIfBHbCRQRGFdTSpeG2O7I49aLDofvbMi1RCfO6hgbdInsosx88h5ogUuj28yVqUMx
         IElt/Ppw6XQQ7MRHUVD7TQnltkbYhZUK8Tx+YQd4P+tfqIl8kEeM7KQ79QwFOpsmE8pd
         BEQQaEVE+sKzT0c5j29XALCiK2Hmz+ih6XeSAClMewFBItvNcxH1J6zwOvT6XkVqmPEB
         ueScygDr/Zqph1DvJQ81gQd6q4pEyEa2fSV5VfYvRGliiBN1YUZ5X/AE1oXZ0fTzFPsL
         u9vQ==
X-Gm-Message-State: AHPjjUhhKGHIYtaYDUILaDBTfSf84PQY+oJvWgioQdeuCXJsj9TCHlWP
        tA79aZjUw1lRo1hdQYzzSIU4QSJessMoDQkAkvY=
X-Google-Smtp-Source: AOwi7QDMY9CLRZ9gsPP2a9ThXiTntR+ORLbpwyq7rYOXltuh6+eWDJeoP3Cfv8hBPfwWCxKvz0eJgn2PvLV+hzJ2Zyw=
X-Received: by 10.101.81.135 with SMTP id h7mr5615795pgq.48.1506283221661;
 Sun, 24 Sep 2017 13:00:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.137 with HTTP; Sun, 24 Sep 2017 13:00:21 -0700 (PDT)
In-Reply-To: <xmqqh8vsh963.fsf@gitster.mtv.corp.google.com>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com> <xmqqh8vsh963.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 24 Sep 2017 22:00:21 +0200
Message-ID: <CAN0heSqAi1ryRyXLqKV+pfj1eHCuqFRhu4o+a+222vSsQZwymg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 September 2017 at 09:01, Junio C Hamano <gitster@pobox.com> wrote:
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
>> Since Junio collected my "independent" patches into ma/leakplugs, this
>> is a re-roll of that whole topic. I got the first two patches from
>> Junio's tree. The only difference there is "builtin/" at the very start
>> of the first commit message.
>
> Thanks, all 6 look sensible.

Thanks for queuing and thanks for adding the empty line in patch 5.
