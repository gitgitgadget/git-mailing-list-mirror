Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AEFC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 17:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381070AbiDTR3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiDTR3I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 13:29:08 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6C146657
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:26:19 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id y85so2609254iof.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjJ85CgYqgu+NiK7+otq1f4iA7x2wzyn5JqbQaA1pNo=;
        b=n9EKRiluwUYpSpdhjdYWOJq8tX1cX6Usg+0hdpVTCteQo7MeqB7YQSADUczIlTQYGy
         L/KyOtCebZyins22f9o92P6c9ay+SsiMKlQxANBIeEyzwdVxk2Cnk8x19ccyxZYXT6NL
         e+7AbRwcxUy3kIsh7TkQer8HDGvcnzz4Xqp2jMLz7R0UzYzzWpQVm7Bo+WYg/d5mUkhO
         MdX1CWuQkPQ413NiCiQ2NAb+kixLcThgziGfyCOjhgtWi7SmMIB4OpP1foBBPC4AQJ+r
         AfTeiz2mi21FsTaX5p6/+Hn/Jhz8PkqG+QynHWBmM+VSehW/5pnT3nIjpeSdwB6fkc6F
         OV0Q==
X-Gm-Message-State: AOAM5307mvjsi9aX3suNT362v8naTpkBnSDllYDdAFbfEI0xPlJaltRq
        Nh/kxSrjet4mV11NW9ON8w1Bc3kRf5IEpLihrUU=
X-Google-Smtp-Source: ABdhPJyUF7ZZizdI+ZHe49+gtjvkk6JBqWGXvyVUPnj7BNb/Z3FEZeQyQB+S4PmyjnFkGj5Ju/lxzL/97C4hUR6U3Ww=
X-Received: by 2002:a5d:88c7:0:b0:649:7b59:949c with SMTP id
 i7-20020a5d88c7000000b006497b59949cmr9687906iol.181.1650475579084; Wed, 20
 Apr 2022 10:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
In-Reply-To: <CAJCZ4U-9KYGK0jwnL1GyOYW-CMjV_Eo--g85CbexsV=aQnn7aw@mail.gmail.com>
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Wed, 20 Apr 2022 19:25:42 +0200
Message-ID: <CA+JQ7M8+FR+_t+Fafoggz47bT0joAZFEkjhjf72teZgdNEoNZQ@mail.gmail.com>
Subject: Re: help request: unable to merge UTF-16-LE "text" file
To:     Kevin Long <kevinlong206@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 6:29 PM Kevin Long <kevinlong206@gmail.com> wrote:
>
> The problem file is a .sln file (Visual Studio "solution"). Edited in
> both branches. It is a "text" file, but is encoded as such:

Can you convert it to utf-8 in both branches and then merge?
  iconv.exe -f utf-16le -t utf-8 foo.sln > tmp.sln && mv -f tmp.sln foo.sln
