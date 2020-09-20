Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E8CC43466
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C643120796
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 08:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgITIlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 04:41:02 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46051 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgITIlC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 04:41:02 -0400
Received: by mail-ej1-f67.google.com with SMTP id i26so13584531ejb.12
        for <git@vger.kernel.org>; Sun, 20 Sep 2020 01:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONkmv2h09vBvNvjhu75Hr8Lme6sk6gxHcNwzrhzEYOs=;
        b=F/JFf/2DyMHTWY+wx7kiONJ8qsaazoqWUF1TS1i44TAHu9AFQPHFa+KkZtNSHvgZ+a
         ml9namOU0OIhlgXfBuqkNh+6ASwQw4LpijsibSZiseN7e3Nig9nH+nAoEOXbbLjAPFN0
         KZ7rnINYZlCs56LVS3WFXv3gjZH8hGvgyVnCDOqU/lP1Hr8uxA7YH3Y4dv35RBVW3w/T
         Vhi9+8aOEn+nqoUqMuDP53n3UqcXPW3Zv4igGD81FBZ1QvFlQwlWjzsIeFQv9bx+mYgN
         tOE9X/dmNgvozID8+niIm8O1KMuzmaW0hqSVvp0i3ULAM+sqi/J/Ylw+qIMmup8UFAoC
         S8bA==
X-Gm-Message-State: AOAM531kgBlGbK4cggZ9lEIdc/YkYl0oKR7VtAGNib6tpzp0h0oRjenW
        ZaFdTeYvhjRSGUvLrH51IP5vrNqr8HHAgS9Eclg=
X-Google-Smtp-Source: ABdhPJxgdsm78NDwfmAP3dzADm2xUwX185j2Hgd/Ch4EhwQn1VhobwHWW1cbx1177RkOMcO5ukZ6dKI/DKJmwg6FRv8=
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr43633033ejb.202.1600591260847;
 Sun, 20 Sep 2020 01:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200920074841.17043-1-luke@diamand.org> <20200920074841.17043-2-luke@diamand.org>
In-Reply-To: <20200920074841.17043-2-luke@diamand.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 20 Sep 2020 04:40:49 -0400
Message-ID: <CAPig+cQiJBC4+T3Cqg==1aNoe_DULLZ=BTQoNnygJXZvTLJu0A@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] git-p4: demonstrate `unshelve` bug
To:     Luke Diamand <luke@diamand.org>
Cc:     Git List <git@vger.kernel.org>,
        "Liu Xuhui (Jackson)" <Xuhui.Liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 20, 2020 at 3:48 AM Luke Diamand <luke@diamand.org> wrote:
> +# Create an initial clone, with a commit unrelated to the P4 change
> +# on HEAD
>  test_expect_success 'initial clone' '
> -       git p4 clone --dest="$git" //depot/@all
> +       git p4 clone --dest="$git" //depot/@all &&
> +    test_commit -C "$git" "unrelated"
>  '

The indentation of the new line is still bad[1].

[1]: https://lore.kernel.org/git/CAPig+cSx35oTR_Er-DyxqV0HZw+tDHPf1GdARfw=-2bhTz02gw@mail.gmail.com/
