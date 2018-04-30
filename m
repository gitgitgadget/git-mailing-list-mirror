Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F2A215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeD3STK (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 14:19:10 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:33600 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbeD3STJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 14:19:09 -0400
Received: by mail-yw0-f182.google.com with SMTP id g16-v6so2871750ywk.0
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e9JJdIR/XJ0EiBLuRa1aZ0/56I0kzJUk8USqJWWVyZA=;
        b=toXxUcTCUgPmWk0gMq3E7MXm3e2Qto2wZnk9jt1RHGYo77O068N2FMbsLB10RPUb/F
         UboYaNzH+bEUJFtv9fRHTQvZj3qeqIvzpofQRjcOvDagewfZbOdiINbz15YFBqBQhtv3
         jqZvqMiZRpRosf1F0nCbU30wssj3/TKYmFLYYzcf1elNdQPA6brmv8+qZu/vG/oTSw3C
         vUf6dV35tFSmEgqqgOM3ChlZXb/m9iek8VL43PUGelQhpiU5ySNsUh3CYi/5vFEqgaxp
         K1xpkEYW4AXpO3SW7iVI5EX94Tq8WJ5QtV+xPwJRxi1cILKE0dLpsYhHwQ2dAZNHvi3M
         Zs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e9JJdIR/XJ0EiBLuRa1aZ0/56I0kzJUk8USqJWWVyZA=;
        b=XNN+ZHsValNqkddbe/imCf5jxgqHD5lVc8eH+fZOr9y2/j+b6MR5LTpy9ocqmTfX37
         f7nzlPmT7++cEINAOouj8rc3eKY35VeEh4GDwepzXqh0qgNgA6wYzREugQeC10IRcRNM
         MBTch/lxvwgC7q/8cogBmIRWCe5xmmxl0c7CyEgRQ661gKa9Dr/4pNmzs99rZfAJUXUm
         K6Zh15QeeCqnFNsXn8zpjLeF7OxN0D+BX5RFeTwSTty+aSpgikik8hx0zDcg90kS7Ach
         T9C2Lbns2fujMqQiDFEEYkWMXeyZogCqlCbuwaeb7S4Xy4rxEyFQrAqFTvASNetmO6vP
         rbQg==
X-Gm-Message-State: ALQs6tADLPhvFJKOJBHSKPTqiuGy8m47ncAFZ+IvzSW7BnnrYu8WSXlh
        MAJ2y4WbwIhZm0j5mqsX3O4WDghmn3QNKQpvLRPmrg==
X-Google-Smtp-Source: AB8JxZoIqGmvhwxQZAEpY5dQPWu+Wd5sVq8TGIGrpdrGauBti3ewakZwQpqerFfs2s1paldbz6E6Tv3wpfced5Dkrug=
X-Received: by 2002:a81:4ec9:: with SMTP id c192-v6mr7092344ywb.421.1525112348566;
 Mon, 30 Apr 2018 11:19:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 11:19:08
 -0700 (PDT)
In-Reply-To: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
References: <CAEp-SHXo2fnyUSMDqJnfOkh_R21R2FjFUtQ14u9s6-tV039tHg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 11:19:08 -0700
Message-ID: <CAGZ79kZQ3ce8QTJy2Siiuoz=pa6qWweNc8GTpoygkvKuoFXaAA@mail.gmail.com>
Subject: Re: git-submodule is missing --dissociate option
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 1:29 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
> This seems to be a hole in the git feature set. I believe it is fairly
> easily worked around, but it would be best to provide the option for
> ease of use (and maybe performance?).
>
> git clone has both a --reference feature and a --dissociate option,
> with dissociate allowing for a reference to *only* speed up network
> transfers rather than have the resulting clone rely upon the reference
> always being there (creates an independent repo).

With the advent of git-worktree, I claim that --reference without further
--dissociate is dangerous, such that the combination of these two are
not the best UX, you could wish for.

> But git submodule only allows for --reference, so there isn't a an
> option to make a speedy independent submodule clone in one shot:
> https://git-scm.com/docs/git-submodule
> I checked the latest online documentation (currently at 2.16.3) and
> the documentation in the latest sources (almost 2.18):
> https://github.com/git/git/blob/next/Documentation/git-submodule.txt
>
> As far as I am aware this can be worked around with 'git repack -a'
> and manual removal of the objects/info/alternates file afterward.
> Though I don't know if this results in a less speedy clone than
> dissociate would.

That is an interesting workaround!
I agree we should have the --dissociate option available for submodules.
Care to implement it?

Thanks,
Stefan
