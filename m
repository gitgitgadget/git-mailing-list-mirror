Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D6201F404
	for <e@80x24.org>; Fri, 30 Mar 2018 21:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeC3VpQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 17:45:16 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34240 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeC3VpP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 17:45:15 -0400
Received: by mail-qk0-f177.google.com with SMTP id z184so10218161qkc.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 14:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=MRnb8O5h5ImjCTet6r/5mMnZskQH3PMETN0D3SYRyIU=;
        b=RNoBkk0Zhn35V3DsJ6a0VJ1kI/BOJYY9+2/Cy3EBStrfrv3pCSLylq8qMHvTQ+5Nb2
         ++ax1kLhkNySpuR+pgQIlkoUcFyJk5I+9D5C1mz6COui2FpZEeLg9NPosQs0HA86JbZk
         i2DHarxAFQnPY0R5mCRpY7qW0NRKWn4/cZU4SKQMVDRZdUvlN5EHSPHV21iKHz+Ql7OI
         DHXYEZhDWJymCNmsJW0kIixPPOENc2K04n1zFM3ZYOoHttiB0kY1SAsH3c9QJahtyEPI
         bHQ4bHiLUCnFuDoO9IIUMWfe6IYk8fab9Y2vfBh46PZe2RvYeSyyHE94eZMDi/fi266p
         jbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=MRnb8O5h5ImjCTet6r/5mMnZskQH3PMETN0D3SYRyIU=;
        b=nH1LjD6DhIoZ2W55hNFF7h26jpGsR3VR3Kjfkftn1EfCURMA+a1blrFptBiB3QTYbw
         OkjV7/U2rs9QWfha0SvD+NRTZx9ROvkY9Vuo8vBj7KiY2uukm+Zf7qDZfWo/ICDoANvl
         ZLy0U/d212CzOTI79n5mez81ZToaDRQh5SmtSpa39VePxz77eVrlWuzLg1iXMBvQQ7vP
         MCZJYsEd+5tU/qrMIZ0jAgtsfQF/bahEA5ekT2QMK570u20Zo4T/eXnV8s6718WIWkgZ
         0Gx9kR+0v4Q5GfGoEfEd/TxscRW+lrlEc05gIhNpVUi+mUxFH5omAnj8XhnqIK5doZhY
         F1KQ==
X-Gm-Message-State: ALQs6tBQyePpDK7011LLm97hJYq+zfhpB1oSE4oBQPkBoyLK7aXDekCO
        ugKd9ukGFr8ZiCpRuP0IviY/elVbVirnJROei55eSA==
X-Google-Smtp-Source: AIpwx4/RvfGwP0dkhBwe1cZY3NoyHnEpXwhDgXxMdR4WaScYBtWiKN/WFoqusYMAdEHQjew/Rts7AEC92JBOWTws8Dc=
X-Received: by 10.55.108.69 with SMTP id h66mr966036qkc.42.1522446314369; Fri,
 30 Mar 2018 14:45:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 30 Mar 2018 14:45:13 -0700 (PDT)
In-Reply-To: <20180327173137.5970-1-predatoramigo@gmail.com>
References: <CAPig+cS3GjYo+5C_W6WqzK3RP=W+918E6Cz=FSvHky6EWCEZPA@mail.gmail.com>
 <20180327173137.5970-1-predatoramigo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 30 Mar 2018 17:45:13 -0400
X-Google-Sender-Auth: -Y9kS5YCI5ecr2mpZl_-eCEmHzU
Message-ID: <CAPig+cSykgDMO-CMc0O5g5ke7D3VSKoaQdNLQDHfu8oTWTDS6w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5] test: avoid pipes in git related commands for test
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 1:31 PM, Pratik Karki <predatoramigo@gmail.com> wrote:
> Avoid using pipes downstream of Git commands since the exit codes
> of commands upstream of pipes get swallowed, thus potentially
> hiding failure of those commands. Instead, capture Git command
> output to a file and apply the downstream command(s) to that file.
>
>
> Signed-off-by: Pratik Karki <predatoramigo@gmail.com>

Unnecessary double blank line above sign-off.

Aside from that minor hiccup (which Junio fixed when queuing), this
iteration addresses all my review comments[1] from the previous round
and does not seem to introduce any new issues.

Thanks.

[1]: https://public-inbox.org/git/CAPig+cS3GjYo+5C_W6WqzK3RP=W+918E6Cz=FSvHky6EWCEZPA@mail.gmail.com/
