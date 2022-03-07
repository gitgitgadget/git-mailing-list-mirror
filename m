Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D7C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343739AbiCGW0Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 17:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiCGW0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 17:26:24 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A66FA20
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 14:25:28 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 25so8971326ljv.10
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 14:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CDWLXQMz2ixu1mbgLwxJ2X+BlcjKdum3AhyokQAxS0=;
        b=KmMRcB9MILESeLsDHOgH9x3r3J6ZfSKawHyhBfzA+/8S/pB2sVAlRashUDer4fsrTh
         2XJfMGgGJB3x+ZYIztoL1cLhVSWME3ak+zReoXcESY61Rky+pjdcQCHz2kLrRei0wkLk
         cPPsqfNHAnbzziqayPF6dGTeriqVZYdrUN+6hSHw5KXKS1MBF0qA1xa0FR/5wCNyuqe+
         GYWWIahwxcWaSMUpfVOeCLduSu4G1KgOpwydsm+7jVdyHBkC52HWgrlxl6rok9WZ1hn2
         rfQCLsuz0fTAa1gRm0yk5/xu/GgDr+BcvoXkBMAPuho6rVXYsxrraUOjgrTIauAaMhJP
         wqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CDWLXQMz2ixu1mbgLwxJ2X+BlcjKdum3AhyokQAxS0=;
        b=IiZcUK1xX9I5JVtBZQ2hYklMtmdI3XyVWOuTVdyBCzMjftrPIn+dugXpxktsBN1EAH
         +Qo/tawgpMFcILcqwncBE2OGOxrCmUaS7jHtpjYTbPtbU7qKkbT/938J5fwZrKCz3KY7
         on+fQTb+bJjpJkhmW8simkJ3a4QFK64OzTRBoS6Hpg+0+flMtJkn18E+10VOxsavqqFv
         Dzy8PydWBN3BRvD1wVv+RqaYhKOt5/CXtEwbTkFgB1j2ltY+mo8Uv9Ty81RNMjmUig+r
         azKBHzVydV9NoTaftrHZMqo/YbYb6XfDSm8Gm9IlpwVkRQORvQFIVrkEZmlQhQGfVaNn
         GGAQ==
X-Gm-Message-State: AOAM530FnY67SCp3Q40Ji+6AXipglhr3EXQVmRQs+fWLDq8JfRy/6/cK
        XXvvACfewLLR8powZrynZCciGi0H8QZaEkeliIw9K0yJsNA=
X-Google-Smtp-Source: ABdhPJwiV2OUgRZqluMYeRxyzh0+Upc/TP0V1NRsMCA/3RjKXCwEeaVk9G+xrXR5AGB9Ct4JxeEcYFee38BOiQreO/U=
X-Received: by 2002:a05:651c:140a:b0:247:df30:2bcc with SMTP id
 u10-20020a05651c140a00b00247df302bccmr6740994lje.429.1646691927098; Mon, 07
 Mar 2022 14:25:27 -0800 (PST)
MIME-Version: 1.0
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com> <CA+ARAtquQOtcDtc0nCWkxyP2enb_QbxyoK9b3HWf-2JzbaKbkQ@mail.gmail.com>
In-Reply-To: <CA+ARAtquQOtcDtc0nCWkxyP2enb_QbxyoK9b3HWf-2JzbaKbkQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Tue, 8 Mar 2022 03:55:15 +0530
Message-ID: <CA+CkUQ93Z7e0iTFMOpiY+a-UyrfQhmvdQXQ-SoDBVUu+GsKshA@mail.gmail.com>
Subject: Re: Git in GSoC 2022?
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Git Community <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 8, 2022 at 1:08 AM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> I'm glad to share the news that Git has been accepted as a mentoring
> organization [1] for GSoC!
>
> Since it is possible to invite mentors now, I've invited the mentors who
> have suggested ideas[2] so far. I've used the e-mail mentioned in the
> ideas page to send the invite.

Great. I have accepted the invitation.

Thanks,
Hariom
