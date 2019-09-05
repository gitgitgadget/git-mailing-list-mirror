Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40D751F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbfIEW1i (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:27:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36133 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730617AbfIEW1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:27:38 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so8439334iof.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oQ6Dts6/KZccU0PaepzdXwgcsS62eRXFN3rVipEfzJg=;
        b=FGrEU7HynsE2t3JOrrSTyEt88dEv0+zmk5wj6FF/b416NuLbxv+zEkiojiDK9p3IFt
         qu5cHR4xSeIs6IO9q7y/Kf6SVBTQzB8nNo4E1n57nZaiAiTVpTruHeHA88YEBMwqgixU
         BTMvu+0QiJuO43hKeINJnU07kSaE8lVl5HeIQNb1IXlN462Mumo/KRLvf8vJq/7D06zl
         5d60v+PdbUiWs1amTL93UYvz8z+BqBk5IITtRkCc9HVvv+Zx1+eZhBXiE5OaxL/Mbwgi
         7zuO8PWyaIF7nhNgZQ3rMNY4kctCVHl/PNv4yCC8aGONSVu+Pbb6yrRx4w20XPAjmMju
         TPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQ6Dts6/KZccU0PaepzdXwgcsS62eRXFN3rVipEfzJg=;
        b=Z+6QQX4CY/EY3yTjh2MO1oWnUWvOcK/soYMI83M3rAioeuc2NSHensfLfJydIGJ5C5
         j3BbIsT2n+XwdkczdxNwXJdxapi0ub7x8F1czpyDdbyn2LZrw3D86dGV0miihKBNN/pc
         T8lITLa/uMikuUQv2l28iA8I0fuhoPXA0eGexOnqT12JCqPwLpmgvDKstsFjL/CezRRx
         w0Ji0hkZyp6tCQu5V74BHBQNhVDu3lDp+OpXdG83ajcMRm3NfYMcHS7jgkPaRv6qsyyu
         7bJnk34UJmUYABVboU9foIeJuafKxL//qAB8AXBErrpgPSNEJVDh8XMwpWyjpLyTo3NY
         ukgw==
X-Gm-Message-State: APjAAAV+dMwmWmFglsPf5XWF5vgBpvMWLFkFZJsvY3UwEpE4Npy15/mM
        auYV+tYA6St9A635J12yYdyWxQ==
X-Google-Smtp-Source: APXvYqzLCMlYxxyuwCYFUIp7iprd5JCVlWFBqHQi5ii1HU09fb3nUPoSf4DZL5N+cYeAStLsb1ROFw==
X-Received: by 2002:a5d:87ce:: with SMTP id q14mr6641910ios.248.1567722457390;
        Thu, 05 Sep 2019 15:27:37 -0700 (PDT)
Received: from localhost ([2601:401:c500:7dd8:3c19:faad:a3bb:990d])
        by smtp.gmail.com with ESMTPSA id u10sm4702276ior.81.2019.09.05.15.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 15:27:36 -0700 (PDT)
Date:   Thu, 5 Sep 2019 18:27:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t: use common $SQ variable
Message-ID: <20190905222736.GA29792@syl.local>
References: <xmqqmufipmfp.fsf@gitster-ct.c.googlers.com>
 <0598bbf4d0b2cb07ff6f06f904cbdd3f5a3ae1af.1567721303.git.liu.denton@gmail.com>
 <20190905222526.GA29743@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905222526.GA29743@syl.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 06:25:26PM -0400, Taylor Blau wrote:
> On Thu, Sep 05, 2019 at 03:10:05PM -0700, Denton Liu wrote:
> > In many test scripts, there are bespoke definitions of the single quote
> > that are some variation of this:
> >
> >     SQ="'"
> >
> > Define a common $SQ variable in test-lib.sh and replace all usages of
> > these bespoke variables with the common one.
> >
> > This change was done by running `git grep =\"\'\" t/` and
> > `git grep =\\\\\'` and manually changing the resulting definitions and
> > corresponding usages.
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >
> > [whoops, forgot to include the mailing list in the last email]
> >
> > Sorry, I wrote this patch up before I saw the email about leaving this
> > as #leftoverbits. No point in letting it go to waste, though.
>
> Thanks for doing this. I marked it as '#leftoverbits' in case anybody
> hosting an Outreachy intern might be interested in having something
> small for a newcomer to dip their toes into sending to the mailing list.

Oh, how silly of me. I was thinking about [1], which I said would be
good #leftoverbits material. This thread was tagged by Junio, not me.
The rest of my point stands, though ;).

> But, there's no shortage of other such tasks, I'd assume, so it's good
> that you cleaned these up.
>
> Both of your 'git grep' invocations look correct to me, so the patch
> below looks like an obviously-correct result. Thanks.
>
> -Taylor
Thanks,
Taylor

[1]: https://public-inbox.org/git/20190904212121.GB20904@syl.local/
