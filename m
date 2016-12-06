Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE4D1FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 18:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753480AbcLFSWY (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 13:22:24 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35584 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751798AbcLFSWX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 13:22:23 -0500
Received: by mail-qk0-f178.google.com with SMTP id n204so388683678qke.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 10:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/AX1gwtJZd9g5LuIn/AuIjARAqYlm4IOrUprCSRxTy8=;
        b=mJ1irryu6Y/4kdQhSxpcF7cn43EEGCdB9nBAWguAWuUnxZLn06v8mMXv5q0cun3l3B
         889uQyy43W7wciOCzoiBU6mwqj/LGhqpsEn4INI2N0I9JTcRimkxQoekK+d3644gOIB+
         vgVD+8JM9lba0poAMBghO9bC9DpuQlFDRq0dS/ebTUyqesWXjiT6Sx9MTP8vZ2NUbHl/
         hKBClais33Mb7DXvhBepnZAe43AUmNzeN8U5MNn8X0SwQY5yxs8aWQQRlQ2S3zdf0UvY
         OOmZnqrxsL51N9+/syh2dFK3aa1Esnveqt/U6b/9gImieE4ROuo3aXBGAGKke/4vKV5d
         0wUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/AX1gwtJZd9g5LuIn/AuIjARAqYlm4IOrUprCSRxTy8=;
        b=KrJ8m4i+BBWQmmxXazBsgQh26G0Zy0k+MK2TaoU/Szc9ZG64+B8yhfwshRpfpkDz2Y
         938pYHr7uoM7ba3sOmPsRkwKJNaQ3u14C6FGEuLxw3nxE/TjJn69I8SM9CMUfh9+4wNY
         urR5l7os28zxE5SrNVrwQN2eWSAvbVOG+r00Zpftw7mXTjBx5HShddEP2fh7Wwx4sO8a
         Q69SPtuoCS64sejI5LdyDpqgWUhQtQYpefQ+phdG18YSQ6VrjF9nu1dYB77Y4QxdM9aM
         iEeEGatSgdg6UZjN6OVGzHa78hFoHL3KYiskfyBc9gbxVhzpfVq9z+0hWdJhXKaobIAI
         JyHw==
X-Gm-Message-State: AKaTC00qIsArA2dTnXNWT2JoyIxAmTB/INv/BtaX4nuNyjyIl65baJTEoInW1yDXlAfSMjK5mjswcPE+uarz8Yhm
X-Received: by 10.55.20.164 with SMTP id 36mr5830457qku.86.1481048542564; Tue,
 06 Dec 2016 10:22:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 6 Dec 2016 10:22:21 -0800 (PST)
In-Reply-To: <20161206150955.mvq4ocamaei52bap@sigill.intra.peff.net>
References: <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1611301325210.117539@virtualbox>
 <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1612051126320.117539@virtualbox>
 <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1612061411000.117539@virtualbox>
 <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net> <alpine.DEB.2.20.1612061512190.117539@virtualbox>
 <20161206150955.mvq4ocamaei52bap@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Dec 2016 10:22:21 -0800
Message-ID: <CAGZ79kZoy2zSgSEc7kfAZ9tg9_uJxa+_FNFVO8UEDLVK6YDxVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 7:09 AM, Jeff King <peff@peff.net> wrote:

>>
>> Maybe even go a step further and say that the config code needs a context
>> "object".
>
> If I were writing git from scratch, I'd consider making a "struct
> repository" object. I'm not sure how painful it would be to retro-fit it
> at this point.

Would it be possible to introduce "the repo" struct similar to "the index"
in cache.h?

From a submodule perspective I would very much welcome this
object oriented approach to repositories.
