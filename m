Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E3C64EC4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCGAvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCGAve (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:51:34 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3173C7AF
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:51:33 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id cr10-20020a056a000f0a00b005cfec6c2354so6271916pfb.9
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678150292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8aC37dmhiQjGbK37mCO2HdrERY6ziq9rANIQ3ByOMA=;
        b=sT94IMfxVOrSbkR5zCJ1ZhZj3mU/5S9/We+Jzp0YWBLoRqtnDGEb3fXP9PPjorCEPs
         8B0XnsqQDYrSjmDzB/pzVhqQCmXBR0+vHMsnBg6itF1w7otw9fO9koj2tKzhPL8Kn/yS
         0VatrF1NkYfqX/zMEEk8mcDRvTE7FvHTf5L+m0tygXLSRKLFl0rBXoR0mj0xeVvZj11/
         +NSZpoo2QH2rwWk7QdF87uD++itFb45eIbofYdLgFjDW/L1X9o403ILAiV9J28HGUZi7
         bIwJm5Myp/xzSP6BYfwXY4rgtN6B034hmLgJR6d2kG7MLhgN/2w7tOcMN1thrk7ZQavk
         BocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678150292;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p8aC37dmhiQjGbK37mCO2HdrERY6ziq9rANIQ3ByOMA=;
        b=EuAFXaJ50cjwxnEVFioagGkeqpS7c5PatM7DDcCuHhs+fLo8huSGvpFHWsLN2hw7Qj
         P5Jv8MAqWvYizx2C/Se7rKbWa93V3TOfjU2AYX6pMW99iPlVY1f+S584bsUMV8GBqNty
         qygUEqQRQ8X9/L01viBYWu6wiZWizn/JLKtITuyy89VMbwtC5YU9Iuj9NM7ua4ASA+1I
         DjcpEF9YgGV06FeCmAocTQtiw+lFO9HFx4aTVnImhKm/sVJ1O9H/p5zGSFYtUrmxlNrk
         DlF7CCAE/347HyYP1JDPeoaQRnKsK98rNqr9+UdtBsBofH5StiKIS3GWq3x4WxiMgIaV
         p7tA==
X-Gm-Message-State: AO0yUKXFHa6+I7eK+Oi1z0cpjq9Zc3bc2iqXVzYj99PydJWaRBYueHtt
        KbrxLd7wZ0vSHhOltfBGnH1w7jdXoMSNRg==
X-Google-Smtp-Source: AK7set+xSx/uxLtVlsnLf1K47qK1JsYnQJUBlwYazpsVZnXReKgJZooH+pITNYT6g2Y3tvJd+mC7l5H55iVtBg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a63:7349:0:b0:503:20b2:483c with SMTP id
 d9-20020a637349000000b0050320b2483cmr4367343pgn.2.1678150292662; Mon, 06 Mar
 2023 16:51:32 -0800 (PST)
Date:   Mon, 06 Mar 2023 16:51:31 -0800
In-Reply-To: <20230228185642.2357806-5-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com> <20230228185642.2357806-5-calvinwan@google.com>
Message-ID: <kl6llek9idt8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v2 5/6] tests: remove duplicate .gitmodules path
From:   Glen Choo <chooglen@google.com>
To:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, steadmon@google.com,
        peff@peff.net, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Swapping `git add <submodule>` to `git submodule add <submodule>`
> in a previous patch created a .gitmodules file with multiple
> submodules pointing to the same path in certain tests. Fix tests
> so that they are run on the original added submodule rather than
> a separate manually configured submodule.

Without reading the diff, I thought that having multiple configured
submodules was a bug that needed to be fixed (I also wasn't sure which
previous patch was being referenced). But after reading the diff, this
seems much more like a test simplification.

I think this is might be better squashed with the previous patch (the
combined diff of both patches looks ok to me) with some extra
clarification, e.g.:

  In some of the tests, we modify .gitmodules to check whether the
  value of "submodule.subname.ignore" is respected. When we were using
  "git add", we also had to temporarily turn the gitlink into a
  submodule by setting "submodule.subname.path", but since "git
  submodule add" handles that for us, let's use the real submodule
  instead.

> @@ -194,27 +191,24 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>  '
>  
>  test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match) [.gitmodules]' '
> -	git config --add -f .gitmodules submodule.subname.ignore all &&
> -	git config --add -f .gitmodules submodule.subname.path sub &&
> +	git config --add -f .gitmodules submodule.sub.ignore all &&
>  	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual2 &&
>  	test_must_be_empty actual2 &&
> -	git config -f .gitmodules submodule.subname.ignore untracked &&
> +	git config -f .gitmodules submodule.sub.ignore untracked &&
>  	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual3 &&
>  	test_must_be_empty actual3 &&
> -	git config -f .gitmodules submodule.subname.ignore dirty &&
> +	git config -f .gitmodules submodule.sub.ignore dirty &&
>  	git commit -m "Update .gitmodules" .gitmodules &&
>  	git diff HEAD >actual4 &&
>  	test_must_be_empty actual4 &&
> -	git config submodule.subname.ignore none &&
> -	git config submodule.subname.path sub &&
> +	git config submodule.sub.ignore none &&
>  	git diff HEAD >actual &&
>  	sed -e "1,/^@@/d" actual >actual.body &&
>  	expect_from_to >expect.body $subprev $subprev-dirty &&
>  	test_cmp expect.body actual.body &&
> -	git config --remove-section submodule.subname &&
> -	git config --remove-section -f .gitmodules submodule.subname &&
> +	git config --unset submodule.sub.ignore &&
>  	git reset --hard pristine-gitmodules
>  '

Not the fault of this patch, but I think that this diff would have been
easier to read if the latter part were moved into "test_when_finished",
and it would be clear that we are just undoing what we are setting up a
few lines earlier (instead of a whole test block earlier).
