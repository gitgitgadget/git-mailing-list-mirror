Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9475B1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeIKWTX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 18:19:23 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:44857 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbeIKWTX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 18:19:23 -0400
Received: by mail-wr1-f41.google.com with SMTP id v16-v6so26833951wro.11
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Nuu+chMgywh1vtfVVpfXH7fiuHEjar8lhy8Nra4+9g=;
        b=jq+uDlQKKkXvbnoZeSAHR92d1OVudZ7OcXdxcFJTGJIruHdkPoTvAz6YvBcmLZW6WQ
         SHaFZLzoKp4LUAJ5A1o6NAuisSBuFDbUiAHFrFVlwk00bvxATlbUfipkNGFl2YvnTF/b
         GREKXfUlhoFhim8/kUHuuqr6dkqmfPbhUOsM8EsfQp16D0Zxnp9RMQHZF/ygAd3RG3Ku
         kPaeGpwfHxFOw0j5oWUeJsEJXmYMxQmyPLdOzWL25F8xJD8jcpLpYjhUUrvuLqzjnTo1
         c1g81urJLQXatM9LjLSbM13EGt4mRMS64Ye2J9C858bbNIPSHQ6rafwjM2/XpBQ7jQSs
         JQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Nuu+chMgywh1vtfVVpfXH7fiuHEjar8lhy8Nra4+9g=;
        b=RHL7bM6dkCqkZH4bEZep+mk5Dp2DyT1PKsIhzxs1fwKgflK7jTMa9N85jR86W9zrT3
         fqQ0UkkxhRvjepR4EIWy672QOUcz12LxLqReq67EJ9f9dz+s12Bim2ztN0cB755L6h2+
         RPtvluBSF6Nf54frwDbj5utW66nssFxNC5xaCvnhMoIQOgDN9TW+4ymXjV9FmCc4PUKp
         yGFan1yU24t4BxC3xh7gqqs/mZhiZ9vQi+Spvp+xA5jyjh+cAMU2So1dKM6y6Alth1IY
         mtDPorU0tejraxHSqf1/BdVVY2EO/GQwqr4lQpG8Rn3fSHe6e+qZgb4r1mfOqBl67Yzb
         ao8w==
X-Gm-Message-State: APzg51BMRzG4oEWXOBcud4Yf87KWbsAEywwoR0Wo9RB+RBq77bAN3ijc
        qaO0WQ1Cd0XLryfus2EQWVxMeeBGmBylWxekJNM3Pg==
X-Google-Smtp-Source: ANB0VdYO1fzNhLc51zSl+3Z+R3QFJgw6a+Aq6dKvmpFLMGDKaTFx1XoYBbrrhav+gyENuHayFD9BskDqGegjwrzVYgM=
X-Received: by 2002:adf:fe06:: with SMTP id n6-v6mr13879673wrr.171.1536686344258;
 Tue, 11 Sep 2018 10:19:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c90:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 10:19:03 -0700 (PDT)
In-Reply-To: <CAGZ79kYK7ish4_DaZN2bCfZz7LNAjxogQH1k6T=hFcxxkXzJQw@mail.gmail.com>
References: <CAFXrp_fLwL5=K3B5rWjY+imoqtskT8LG-UH8ec3CPwM0iiSzFg@mail.gmail.com>
 <CAGZ79kYK7ish4_DaZN2bCfZz7LNAjxogQH1k6T=hFcxxkXzJQw@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 11 Sep 2018 10:19:03 -0700
Message-ID: <CAGf8dgKLz14ijnXwV0Y=M48Rij-scA19E_uXk3pBc0T02oE_0Q@mail.gmail.com>
Subject: Re: Is it possible to git clone --filter= without any objects?
To:     Stefan Beller <sbeller@google.com>
Cc:     Ciro Santilli <ciro.santilli@gmail.com>,
        Matthew DeVore <matvore@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 11, 2018 at 10:15 AM, Stefan Beller <sbeller@google.com> wrote:
> You might be pleased to hear about a series floating on the mailing list,
> that started at
> https://public-inbox.org/git/cover.1533854545.git.matvore@google.com/
> and promised to filter trees away, and its latest version can be found at
> https://public-inbox.org/git/cover.1536081438.git.matvore@google.com/

I mentioned this in an email to the original poster in which I forgot
to also CC the mailing list:

By "without any objects" in your email subject, do you mean "without
blob and tree objects"? If yes, there is some code in the
md/filter-trees branch that can do that with a "--filter=tree:0"
option. As far as I know, it is not yet in any released version of
Git, but hopefully will be in the next one (the "What's Cooking" [1]
email mentions that it will be merged to the "next" branch, which is
one of the steps before it is released).

[1] https://public-inbox.org/git/xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com/
