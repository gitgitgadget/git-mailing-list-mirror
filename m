Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D11C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 15:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378518AbiDDPY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbiDDPYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 11:24:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5303DDF5
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 08:22:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bg10so20724577ejb.4
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaCHkGltSL3xHh+b2wxs0mdEmUmQsgtdnLTdwoYZwI4=;
        b=mO43ZLvFq/eDVJYlixSPBMxLgOOob1jt/PMNzCBqonZUbgv+j9ZY2heAGeo1NjSzXA
         dJ1u6u9Z5voFh/GEKWGvl9J1U7ajjgVHaiYLCq4oHghOns7ltSEhYDUK7900nl5TQRt4
         dLE3RezQYH20k5xqWnLb5HxLLRl3UV4GXUCv/62E9Km2vDozPx+45r1kq5u1gI6bQ+rV
         mXdN1AMyVoPM6qIdKarCG4dtClrCsc2ba6Q7iVXBuo+EHDd0mT8ZyG6WNIe49mwj1ivA
         mNaUYSx8/vXkkpSgiRV5bNShkhN3fAhSEUnge2k51d0ZXRavaLIWG8Ph4cH+ELdVjg9F
         Nddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaCHkGltSL3xHh+b2wxs0mdEmUmQsgtdnLTdwoYZwI4=;
        b=nK1fKeuVariczVtUUUeTeCAOogYIqZS58AhuAAh4E5IhEgyeMuspyWpa6fs/e24T9h
         AhvY0pq+fY/los2TBOYAOM+Btde8znHFbkFsHVBVVjUr2aGVe0dP22y6/0Drzz4fEX6J
         9O2Sp3aJGczUlszTja7WzkQosdlIfPgFfQ0jiEKkTrmmsOSeWzDwwKvGitiNymIGfpOV
         aaIYlYhbFBQSvVD3xPZ8ZdulmeGV7smR+7X9lpjDAlZD+qpg2usnGi8eDN/NesyL4NTv
         LqR3NwEjJKiZEXeENGpvXX5F/tHhb/BBh+KCPZr7s/6UA1pn3Mv5PwQSWDDzwQnKiGuU
         jxJw==
X-Gm-Message-State: AOAM530Zie/m0UeEXiW0+oUSv4I8fCI5KG01RjgUXTQg7IPQHXjAZ7J1
        dqDXlKClOheWpmYeL1c0cHFa8O5qdXGeT7gGRqdhCg==
X-Google-Smtp-Source: ABdhPJxBgBxxW5/ZSlhVq06zTQb4fRPs3fwQZvikMafiWPkf3GSwQSJUMxD8IfbVtI+cl/zjETg5r8+wmL/7tvn0j7M=
X-Received: by 2002:a17:907:94d5:b0:6e0:2924:bd54 with SMTP id
 dn21-20020a17090794d500b006e02924bd54mr620951ejc.170.1649085748219; Mon, 04
 Apr 2022 08:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220404055151.160184-1-alexhenrie24@gmail.com>
In-Reply-To: <20220404055151.160184-1-alexhenrie24@gmail.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Mon, 4 Apr 2022 17:22:16 +0200
Message-ID: <CAPMMpohXLG2BsO2N1He9aBxm_VuQGCtf32AC67jVkuHQnwVw8A@mail.gmail.com>
Subject: Re: [PATCH] convert: clarify line ending conversion warning
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 4, 2022 at 7:52 AM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> The warning about converting line endings is extremely confusing. Its
> two sentences each use the word "will" without specifying a timeframe,
> which makes it sound like both sentences are referring to the same
> timeframe. On top of that, it uses the term "original line endings"
> without saying whether "original" means LF or CRLF.
>
> Rephrase the warning to be clear that line endings have not been changed
> in the working directory but will be changed on the next checkout, and
> explicitly say which line endings the file currently has in the working
> directory.
>

I think this change is generally a great idea (I agree the existing
message is confusing / not as helpful as it could be).

I think we could do slightly better than "the next time you check it
out", however, in terms of clarity. I just tested and the way I
personally would inelegantly describe it is "the next time you switch
to, merge in, or rebase a branch that has different content for this
file, or explicitly check the file out". I understand "check it out"
is probably technically correct, but as a user, I'm left wondering
whether that's the next time I check it out from scratch (i.e., switch
to a branch that does not have the file, and then switch back - which,
incidentally, is what I originally *assumed* would happen before your
patch - I had never checked), or the next time I switch branches at
all, or the next time I switch to (/merge in /rebase onto) a branch
that has different content for that *specific file*.
