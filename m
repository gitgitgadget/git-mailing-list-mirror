Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6274D1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfBORv2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:51:28 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39081 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728951AbfBORv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:51:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so10148452wrw.6
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sHWwglW8lkbirSsC1HadayZtcu2jQvdAeX6URLVsw/0=;
        b=A6gaISVlju37Ufyahl1jyBbTpxYrI0IxXC3xd+UvWyMXKj109xn7xCO9RqNAgNHRrB
         sB8RTfQJXZip8nxVmQsnc9YFrtJCYeTnPurSLFzNbiZCJ5uxyaJzKA7OpQEfmiyWomw6
         0PxMLtFXwxwz6uON3TFOrSBXpgs0E6kHIcAB+NdX85lj4m50V2jRfga79VB/adlJrT+E
         YRhbIog4/bvBTYgRjsJB6t5WMoMODzov1G9+WS0uNjLZ1Bj777aJqaSm6eKylxoCE/Ox
         88aM4ts48MdNXStSzhuEzCKuiKhkS6IvMl39k0yj199eWwEUlvJOf1k4TL/XuYEvFyEL
         8U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sHWwglW8lkbirSsC1HadayZtcu2jQvdAeX6URLVsw/0=;
        b=c6pPsWx4cAKLk1yXYHx5Kvacz0JqxCuxJcEg8rpoXi3D8WgfQe8p3RVWJyNnigVuoz
         RPJmKaLGxUrudcSdG3Cp+08IG+r4YlQu+ioW8v24x0+7QmC4BZEZ6vmee1LE1FNQ49iG
         +Rotcef4JCuLUNcEr83bwgcnTGb1x+u7F4eso3BOJ/57LEtEbzKUDCriRcrad9klekP2
         VSpyWbKKn0yd9THb7MEV2akz2iaNPIXqjOkFtIOVVDIXL8GrXBQzoYAnqaVBNANJL+q3
         xYAo44f1ZX7bUK+OHf5v/kdIlplNAijnvMM4eG8bAHSTLjaN0/bVzKOg/xE6UfBq3JDL
         eDxg==
X-Gm-Message-State: AHQUAuYyiFxkFOH3Q26mKUMOmHYQzAHNQrDIbT5ZQTb4dhfEkM0x3GOq
        uDq01YU4INv3rOofkyHIWSU=
X-Google-Smtp-Source: AHgI3IbcChy8vVi9Ot/RhuIk+Jhhc+di+1n/JlNf8hWjbiyh0r2PC0Pp8qN4OvZ/fyYvxkaZ2GI2hg==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr8085863wrr.233.1550253085644;
        Fri, 15 Feb 2019 09:51:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v196sm6999312wmf.15.2019.02.15.09.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 09:51:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Re* [Breakage] 2.20.0-rc0 t1404: test_i18ngrep reports 1 instead of 0 on NonStop in one case
References: <000801d4c174$05b76860$11263920$@nexbridge.com>
        <CACsJy8Bn+2zY6y_QqCjbB3qWM-F=3d0H5vgWj4az=md2FZ8RhA@mail.gmail.com>
        <xmqqftsughks.fsf@gitster-ct.c.googlers.com>
        <20190212002705.GD13301@sigill.intra.peff.net>
        <xmqqef8a86sr.fsf_-_@gitster-ct.c.googlers.com>
        <CAN0heSooOiJkkfr=sKn+dkMmU9knabeTnY90EJyEu2fNT8XMzw@mail.gmail.com>
Date:   Fri, 15 Feb 2019 09:51:23 -0800
In-Reply-To: <CAN0heSooOiJkkfr=sKn+dkMmU9knabeTnY90EJyEu2fNT8XMzw@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 15 Feb 2019 07:08:45
 +0100")
Message-ID: <xmqqwom1549w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On Fri, 15 Feb 2019 at 03:13, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Subject: [PATCH] t1404: do not rely on the exact phrasing of strerror()
>>
>> Not even in C locale, it is wrong to expect that the exact phrasing
>> "File exists" is used to show EEXIST.
>
> s/Not even/Even/? Or s/wrong to expect that/portable to rely on/, or
> something?

Thanks for catching. Negation is not my forté.

