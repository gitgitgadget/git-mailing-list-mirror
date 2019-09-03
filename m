Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D1FC1F4B7
	for <e@80x24.org>; Tue,  3 Sep 2019 19:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfICTam (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 15:30:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40191 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfICTal (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 15:30:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id u29so13821740lfk.7
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLLfXGIKju239Js0/P8dkoG22LUiBh6JuUn/FUGz4Fo=;
        b=cTIUYU77Au1zGuOiuwO7QnoOeHlK5nvvElb5RTckFXEYmk0fn8lNY8IxIklvlbyslM
         Ll7AjNAl7IrAPDZEFCEPy2xPEiKcvFNGkgUl2gZf5SAPTLPaHLbojoL1ZVx9WyiCo3O7
         dcoPcB/zOnf/j1+H74WSQupox8P9PWgt1bUgNbh+W9r/BMCXMz3MqUKOmmcFBcfACx+K
         +1xrBwyjm8KwSrbg6WAYMqmfy8ncv9mZbjbm1P371dj04TzoQyR87D2hxMjoUBQ/MRQ6
         AAKEIcfOrGeOlR0x15ah4dzPGO0zcs3/MACXzXPzv+XwwLOEmqQgFByUBtgron/VuLmD
         olJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLLfXGIKju239Js0/P8dkoG22LUiBh6JuUn/FUGz4Fo=;
        b=AdQVBTcWG54X/bSb0bjcIqo1XMjVjvxd6lNq6fnjTaywLse0i0VdLLXoXQm2l95/Jb
         A1cORm/YlwMYuqLPNl+m/ay1OUOv7cHW7kiH7HtCug/lfE4qxcA2dWW+Q8atzYOZkdVr
         xktTTWeA1BNKvYQ5OXhP6C6mNovCx0C6fmi/jg7qzRvF3NT9JzyYPmeJnnoEOIW1jfy2
         tsJHZv8XNJ0cUL71qM8kYEQYYT6/BN5OGnrBTUA00AdVE28pg6jo9lXY0pa7M1KaNNwm
         njmM3xwYydurGmpOIASl4ecAtnlzWNuflDRGUNeDcrIat4EyemPuiTYPZHkeWT0vnn74
         NNAQ==
X-Gm-Message-State: APjAAAXJHPAKieM2Jm/zFwyKcI2h8bcCln0N7oipO6ZfFc4uC50EuPZ8
        LB0HAV49J6ro5JbDRTGsV4WUGyPWTGRKdqiH/Zg=
X-Google-Smtp-Source: APXvYqzKLSMmeK0psckwXYQN010UDs5FPXqEFi6/3ZA4J0XLdokAGUyP+sCD6Cs25dAXd/P8OGnXD6Sga79hZEsWpJ0=
X-Received: by 2002:a19:a407:: with SMTP id q7mr19697439lfc.166.1567539039871;
 Tue, 03 Sep 2019 12:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190903144536.8935-1-me@yadavpratyush.com> <20190903180704.11812-1-birger.sp@gmail.com>
 <CAGr--=K4cEjWD4q14M63Muta3X=YSKff4sebH64AKGKWT7+--A@mail.gmail.com>
In-Reply-To: <CAGr--=K4cEjWD4q14M63Muta3X=YSKff4sebH64AKGKWT7+--A@mail.gmail.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 3 Sep 2019 21:30:27 +0200
Message-ID: <CAGr--=KOJjQ2YkovVaqkxi_vFqS2AQ+DXzLhPnG6KipYdVp47w@mail.gmail.com>
Subject: Re: [PATCH v4] git-gui: Add hotkeys to set widget focus
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

I just realised I had forgotten about the local variable prefixed with
an underscore. So v5 of the patch will be coming up.
Also I got quite uncertain, should I have added you in the commit msg
somehow? I've seen elsewhere that people add the "Signed-off-by" line
with the name of the other developer.

Birger
