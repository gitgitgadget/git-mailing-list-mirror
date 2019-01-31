Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633701F453
	for <e@80x24.org>; Thu, 31 Jan 2019 21:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfAaVgB (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 16:36:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42285 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAaVgB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 16:36:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so4906446wrx.9
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 13:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tyFsyGCxj/BZl+2fJQ5GmQQu7FZQ0HAvrrZ5iasTbPw=;
        b=LIC/POEWALuCSEhFFqLIsUdMd8AADPzO9h25jTMS/XqFhTVCV3I07P3uBpOvFi5tk6
         HEC5lt+EYWGnx6MSDVnrZ4Gx2vKLWfng2k9p38Kr0RwkcdZImH5K7Fd5h+lKQnBaQvYH
         7cPxbW7vfJW3I/pkUN32rC6LaNH/f09tvAu1xiuG3CyD9se9GQtW3Vo8hnrW3R/jNeRB
         yvYtZvP/aj5azwZz8nXBxRJLpGQk6BgJtu4uN0QVTmBaqsW8rDjyFwsK5A8bCH4kOTOT
         oeWl2tEMczNYm32BR2czbxl/Ey9Wpk6dVtFOPHUsC80nSMqpVhPZS41oqnHLTY2TRZ1f
         aRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tyFsyGCxj/BZl+2fJQ5GmQQu7FZQ0HAvrrZ5iasTbPw=;
        b=VOX856NnmjsBKxTyhh6PTrcoip7k30LTtKyJs4VbThi6/Sg+w4gRTK2UMBtaePD1mI
         /rj2+GLonDsD0P7RfFP945SkD7QLlT+nhr8dV/enYkm5bXSks7H8d+YsSA5jCP812wSY
         WS2LtlPywGQfaQLJCskktrpE7Vm7ukXg4hcsoqkKZiDRNfANKzvVMh02PuWKM9p+DoZ5
         567upAgLzIPiNmCjLBUJjcZIY/NGvTSKT75WSSgVyMsnmndNV5duyKrNRoGooJqbKXes
         eHb1qUTvD1ihDfJkWulkh3Q3MT5DRCM3d5fZOaMrwSeWFZZUSE9ymYY7/Mrs2GfGbPWV
         pazg==
X-Gm-Message-State: AJcUukc2PyITNkiAFhcHKMs4a3DYLlb3C51UOdWiLB6b9LSZA0vnmYfX
        PEg9LqXUY2B/T28E3EmqpLU=
X-Google-Smtp-Source: ALg8bN7wyLTkHyDJ7Z6FJ2nHHVczvbluiDoInAamDvxiz85nDdnNoCpSFw1tPyRv+brihloavJJc6w==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr34875890wrc.0.1548970559277;
        Thu, 31 Jan 2019 13:35:59 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e16sm12546444wrn.72.2019.01.31.13.35.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 13:35:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Alban Gruin <alban.gruin@gmail.com>, phillip.wood@dunelm.org.uk,
        Michal Nowak <mnowak@startmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Broken interactive rebase text after some UTF-8 characters
References: <a50734d9-4d30-5847-b5df-67a8458a36cb@startmail.com>
        <339d4dbd-b1bd-cf88-12b0-2af42f35ded7@talktalk.net>
        <23c60f2f-43ff-94ec-6100-861c655ec80b@startmail.com>
        <8c43e31b-01d8-a1c5-d19c-8efd0e5c1714@talktalk.net>
        <505c2e2e-c9bc-aa57-c498-2acced0b8afa@gmail.com>
        <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net>
Date:   Thu, 31 Jan 2019 13:35:57 -0800
In-Reply-To: <2cbb5818-643d-bafd-6721-91e0d291a5fd@talktalk.net> (Phillip
        Wood's message of "Thu, 31 Jan 2019 20:40:43 +0000")
Message-ID: <xmqqimy41pdu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>> Are we misusing C formats?
>
> The C standard and POSIX both say that the * refers to the maximum
> number of bytes to print but it looks like it is being treated as the
> maximum number of characters on OpenIndiana.
>
> Johannes - Perhaps we should change it to use fwrite() unless printf()
> gets fixed and we're sure no other operating systems are affected?

Avoid such a rewrite, as "%*.s" that takes (int, char *) are used in
many other places in our codebase, if you can.

