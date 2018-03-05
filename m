Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF98F1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932907AbeCEVej (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 16:34:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37397 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932699AbeCEVeh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 16:34:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id 139so18471649wmn.2
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 13:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NIFk/4PYLy+izkqUBMFZZRFW8L9McqSQucHYaLi25wE=;
        b=IlKbxyLbAYFcn/9kt4ds4tK2ezimcUBbMiGUQwUFbiDCmIvOithdZpdlGg4SQ1ukmF
         t7sdnyonicRqOyFOSzxF7qIgJPG9uTLjgGkoY68h2a+hFx6OPdkYGhLwn4xuKHNt2U9Y
         NA99KKGmsUz0DjF/lyipT48jlf9/HOBeS378jqYKss+QFfPhSe0yB0ON1IMNDiiFhFWZ
         cVl26lPZtua7Gw5AYVOc+bwy+C78kGHQ4POstCRd9NcEFvXNbXcdwLB/6Xg1EY5grmqr
         WFsL9hI9Wpjm6gXhNwSCVa/xxHtmd/MZ+AF/tSZwXkDKBEmyZItHNppg6qFyWQdU+/9f
         j7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NIFk/4PYLy+izkqUBMFZZRFW8L9McqSQucHYaLi25wE=;
        b=jkUWH79/kCkxZz/lf2M5t1cP0gmTUdG2gHLR67jB3LS0B39srvTE/XwM6plUyyQvTt
         sIL3j2CVc/7kNKv+J/kn/Lz6IstZ51xIWuLyLLH8rCveiQ0mP4SM57WmSPN5KMr63cGR
         Mht/1SY2y0Et0KbnBdc1DDVfR9tzjJjHEvDvOQNXEoml2HnCi9eOrxlHSl96izB1RKhk
         m2j7jkSB28yeBNPX46e0pSS6wKue4MizJ6suQfNHKsJDR9G4nNY3SpnVWA9mnx6AluC+
         TnDM43uWWCkNwlqPvvgzJ3z+ziz15ahOe6MHuBu67MxVIOH04XFRi32AS04BZc6Hpsmg
         Oc6w==
X-Gm-Message-State: AElRT7Esfzdg0XYx2GqhcGG2GU7pNOpMIemVdUEWt+JmTbCSiBjOOTLE
        iTsJtrsI0fwIa+oPAIdNOx6z3X7v
X-Google-Smtp-Source: AG47ELvFMY32pJdsx83um++I6VCAfhliyEXgf4mifmsiM/HkPUUUBL2ulfIfxQJcdOR7MLkhwP0u0Q==
X-Received: by 10.28.101.69 with SMTP id z66mr9798584wmb.143.1520285675834;
        Mon, 05 Mar 2018 13:34:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v8sm2626555wmh.25.2018.03.05.13.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 13:34:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        olyatelezhnaya@gmail.com, christian.couder@gmail.com,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: t006 broken under Mac OS
References: <f711d7ea-b3a0-82c4-6700-5ec285c91115@web.de>
        <20180303142747.GA28218@sigill.intra.peff.net>
Date:   Mon, 05 Mar 2018 13:34:35 -0800
In-Reply-To: <20180303142747.GA28218@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 3 Mar 2018 09:27:47 -0500")
Message-ID: <xmqqk1uq8avo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I think the ref_array_item.refname flex-parameter is not valid.
> This is the same issue Ramsay mentioned in:
>
>   https://public-inbox.org/git/58b2bdcd-d621-fd21-ab4d-6a9478319b19@ramsayjones.plus.com/
>
> Junio, I think it probably makes sense to eject ot/cat-batch-format from
> pu for now. That series is on pause for a bit while Olga works on some
> other refactoring, and it's causing problems for people who test pu
> regularly.

Yup, thanks for a reminder.
