Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FEE41F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 18:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbeKPFDf (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 00:03:35 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41888 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 00:03:35 -0500
Received: by mail-ed1-f49.google.com with SMTP id 14so8441116eds.8
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 10:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pfhSWsIkIuzb6XSRp9TOEMc9u4Q/OzMwxU3wc5OXqKQ=;
        b=FaI9NmOnaJuIzT7iiaAKmdMNNFU9DPkZZ8+D/OYlqMbL9Zph/IyJPcfHFJNeK2zQ/R
         5yryjHWQg/LmazjJAaOjTzaSgO+2R5XeoTVmAvH5aeO8HKVpc9EzSTjpcYEEgtNLKE6V
         j+NN+S8LVLI6AaDPPiQeqLcy9kuKfxUiJQanYmKWVKYlxNXsEoJJqFYhmitsGnraYym6
         5O6m/iT7dtL0uNw2JcGFl6YSV3lz0ylIrJGXp7UPlo5xkO7wPq8TFVe1xArfx3tTVh32
         6obeQncfCSkJ8jEZDRZKFshY6A+eIynItMygClLFMymrgj+0MbsOXsLfcNRQy61z3gPM
         zXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pfhSWsIkIuzb6XSRp9TOEMc9u4Q/OzMwxU3wc5OXqKQ=;
        b=DWRz4RIyzpLaAriEXwYKNblCA3jQ6s3QjRKzTJE+xoTmVoRc/yUJGuKsKaDN8rGuTG
         AQjTVoLAUeA3h6HIakMN/xDlOF/NEY/4YdCznO70J9F9bs7M1y3yyfetlfGQZG7ekD3k
         NRn/2oloEz5Mrc3SSa3lScowETMPtGLt9Zhfo7hcE4+t3z8jNoJCNqmz03CaQH7xaPV6
         9CYQcKhAGM3Q4y/rglpF9wLgQr/p8igZCzTBJqU1pGQdyQrqVRWJlGsfU5vk52b6BLp1
         HVp7QaF0ekkq+6PQ4R+PaU0ZJu1Jg2sLpF9bxkWeREaqmOrHEjXqoRweHVVSDiIxmy9/
         TJaA==
X-Gm-Message-State: AGRZ1gIhq0coSfEHzf30+SWYyVvEVTcbW17XlIPOu79SGTNAqaUnZQvw
        /GA0BWeZ3xtb1NrNWVDdrGHcxADY
X-Google-Smtp-Source: AJdET5fSsgBiyg/BvrLpoH/10lJT8IdELG1r5NTMdKGFURZSgdCTHb6c+q/9yrGU/8VKggXstvBfVA==
X-Received: by 2002:aa7:c3c1:: with SMTP id l1mr6829870edr.70.1542308075431;
        Thu, 15 Nov 2018 10:54:35 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id y17-v6sm4474281ejj.43.2018.11.15.10.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 10:54:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
References: <20181115182826.GB25806@pure.paranoia.local>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181115182826.GB25806@pure.paranoia.local>
Date:   Thu, 15 Nov 2018 19:54:32 +0100
Message-ID: <87pnv6189j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 15 2018, Konstantin Ryabitsev wrote:

> Hi, all:
>
> Looks like setting url.insteadOf rules alters the output of
> git-request-pull. I'm not sure that's the intended use of insteadOf,
> which is supposed to replace URLs for local use, not to expose them
> publicly (but I may be wrong). E.g.:
>
> $ git request-pull HEAD^ git://foo.example.com/example | grep example
>   git://foo.example.com/example
>
> $ git config url.ssh://bar.insteadOf git://foo
>
> $ git request-pull HEAD^ git://foo.example.com/example | grep example
>   ssh://bar.example.com/example
>
> I think that if we use the "principle of least surprise," insteadOf
> rules shouldn't be applied for git-request-pull URLs.

I haven't used request-pull so I don't have much of an opinion on this,
but do you think the same applies to 'git remote get-url <remote>'?

I.e. should it also show the original unmunged URL, or the munged one as
it does now?
