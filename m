Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E0C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 14:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358562AbhLBOhR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358467AbhLBOhP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 09:37:15 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80663C06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 06:33:53 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id p2-20020a4adfc2000000b002c2676904fdso8923026ood.13
        for <git@vger.kernel.org>; Thu, 02 Dec 2021 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6bB/kxJImV6hTBiN8lPjvwBHSlZivFxzHbGOBCKOVxw=;
        b=hIyMXMUQ9k+92ima43dZtg+RhpzRfgGj6PyTX+T+mgSaF7OvcuxfIwGi6kuEYUqKwV
         KOeuI3xn2UruzBKujshpsOU9K5PHUNpJSnWXRvS0KBYB2QlHVTMX9jqnk+rn8MNLMcQ1
         epkhKoViyI7rC35ALdmdbaDpyreA6cTSm5F2b9/EUomhfUSzFAD31uCQD6HQEVdR1i3s
         5nxqR9j+wZnAAMP994QlEAwrQMmgwE0G7rF50FK7EgscCf4jTjZRR/fiMSJFsxlXlWlG
         J1WqU0dwRe/u4fB/a1GbLTleKCC3Ei56fgqmgVciXgqjnOaMb0i1RHud6rJAFRfXyGqz
         8Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6bB/kxJImV6hTBiN8lPjvwBHSlZivFxzHbGOBCKOVxw=;
        b=UvUljYQHXzGJFXzueUrvVLCeLVeeQKa/04vm98i0XjSx3FmtVKaPgh/8wFe3qYSxi8
         6NJCEWnTj2LvfWoXhj9omuHJDjMGbNXyexkhkH6Ubh1stZ+Cgunp3ibLvjDDA4myjLUe
         LnfVf0DxNBEJs/fk4LeebWUxms3JYen9Yjz9JFt/urwgUqR/uRYrGq7FcWnxutm/ExQY
         PQiLx6NVrj8hrpUfz+wo21Gf/gAqqiPjow+79fApL1D7Sf0SUFgwAGJ9kZMi4r30O+jG
         QGiOHDin41g2K+CfNO1o2EhUz9V9ggP0QxIOfkBKUMl7pNhcELE/39RdKQV1+kUrXFob
         PAyA==
X-Gm-Message-State: AOAM531fVsk5a/aGJNzYcFNFS5SP9/57xQmPD6mysIQgCMpayianHwJG
        LNm2XhIPUvyqgJE1kssOBGRxCw2CLzk=
X-Google-Smtp-Source: ABdhPJw6eZm/5sdCDQlVqsYn35SMoGZhJA55PD2X1H74bEnzcq1J33Ve+8NDSc9kpL6aoWqSKdD4rA==
X-Received: by 2002:a4a:a44b:: with SMTP id w11mr8854190ool.66.1638455632786;
        Thu, 02 Dec 2021 06:33:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a483:be4f:55c1:3cc8? ([2600:1700:e72:80a0:a483:be4f:55c1:3cc8])
        by smtp.gmail.com with ESMTPSA id t13sm11608oiw.30.2021.12.02.06.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 06:33:52 -0800 (PST)
Message-ID: <df8990d5-98da-a05c-31cf-d3f5ce33f498@gmail.com>
Date:   Thu, 2 Dec 2021 09:33:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 01/17] Documentation/technical: add cruft-packs.txt
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <a9f7c738e0ffbc5cdedc26768a0623446c98d239.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:
> +Notable alternatives to this design include:
> +
> +  - The location of the per-object mtime data, and
> +  - Whether cruft packs should be incremental or not.

It was not obvious from this sentence that "incremental" meant that
we could store a number of cruft packs and use the mtime of each pack
as the time for all contained objects.

> +On the location of mtime data, a new auxiliary file tied to the pack was chosen
> +to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
> +support for optional chunks of data, it may make sense to consolidate the
> +`.mtimes` format into the `.idx` itself.
> +
> +Incremental cruft packs (i.e., where each time a repository is repacked a new
> +cruft pack is generated containing only the unreachable objects introduced since
> +the last time a cruft pack was written) are significantly more complicated to
> +construct, and so aren't pursued here. The obvious drawback to the current
> +implementation is that the entire cruft pack must be re-written from scratch.

But you seem to be pointing that direction here. The difference being
that you don't discuss how a list of cruft packs could avoid the .mtimes
file.

I think what is hidden underneath "significantly more complicated to
construct" are situations such as "this object was in an old cruft
pack, but then became reachable, but now is unreachable again". I'll
try to remember to come back to this after seeing the situations you
cover in your tests.

Thanks,
-Stolee
