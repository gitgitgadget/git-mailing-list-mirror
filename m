Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69185ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 16:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344535AbiHZQuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344559AbiHZQuD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 12:50:03 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8941AE3C07
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:48:31 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id g16so1533803qkl.11
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 09:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=kndzUYjTjhRUsBUozQq48r7S0n78pqdr/Odg5r8h3PA=;
        b=PDZkLqJNzpJtv46TExCzoSMGHtCQmxiqcpfJYZZ0ZdnwseGcxhLM8XLQigENBqEqUi
         5kGg8N5c+uwjUwWfGOoVi+sIiAD2ZOrD9P31J4ZvmMgyKtp/+SuY9kHe0bziWa0Nr/b7
         bKUIU5Q/c06D6QyvTrG6fZQcb69HPPAevVf+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=kndzUYjTjhRUsBUozQq48r7S0n78pqdr/Odg5r8h3PA=;
        b=zquunTkRMoBfrSbrIpQUp/VhXonGfb1asmCXCxavmRQH5KCVzg6iz0jNt14wS31MX9
         UiJ9klhNiCelxwSwKiuCPqtKtOM2E/Kla12rABrHI1XsRJLLISN/zwgocshZxqLYfh2z
         AuCB6slxJksNv6q0q5PUe81xjA/yhJiNPS8RuUwbLiwtNWg30dGWEYb+l3KoC5gAnOGU
         /Auha7DfHYiV2gY0fofT61q3blLTCzddBDRiLdA0o7Wztgaq8hxscPx3FWP3gG6IyLxL
         YgxNPFzJLHK7kbdhE5hCKgBg0GrvjoiK2D+KGuP6MdcyPnff80+1QFeTG8KnLv8a6leE
         MDwA==
X-Gm-Message-State: ACgBeo2QN+YzNykmX/JAju1LTKbeYs8IBGwI6kamK9Tzg+lgq5bjKWDQ
        wcGEVqakdNHc6x++1bDOgvqFJI0tVyoMng==
X-Google-Smtp-Source: AA6agR65LUnUCPaSHSyMd2UKoW5Rxrbmjz+xD3/C/X9ZiOlCnnKlwkF6Vnpg5p2HGOBr9FhN/pNGfw==
X-Received: by 2002:a05:620a:4244:b0:6a7:9714:a7c4 with SMTP id w4-20020a05620a424400b006a79714a7c4mr422053qko.611.1661532509932;
        Fri, 26 Aug 2022 09:48:29 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a400500b006b872b606b1sm40582qko.128.2022.08.26.09.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:48:29 -0700 (PDT)
Date:   Fri, 26 Aug 2022 12:48:28 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: Re: forcing an in-body From header
Message-ID: <20220826164828.cxsveqtjiyimdj7s@meerkat.local>
References: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c403e526-7455-4f26-fcef-97c99f9af539@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 03:17:34PM +0200, Rasmus Villemoes wrote:
> Hi,
> 
> Some mailing lists mangle the real From: header, making it a little hard
> for maintainers to apply patches directly using 'git am'. See e.g.
> https://lists.openembedded.org/g/openembedded-core/message/166515 . One
> way to work around that is by having an in-body From: "header".

This is only tangentially related to the problem at hand, but the list in
question is also mirrored on lore.kernel.org:

https://lore.kernel.org/openembedded-core/20220531151052.3667079-1-sean.anderson@seco.com/

The mirroring is done with a direct push hook from groups.io, which is why we
get messages without all the groups.io mangling.

> However, merely setting sendemail.from or format.from is not enough to
> get such a header, if the value happens to be identical to the patch
> author (which it would usually be). So, could we get some config knob
> and/or command line switch to force an in-body from header? Then one
> could set that on a per-project basis, for projects with such mailing lists.

I agree that it's a nice feature to have, though I would put this into the
sendemail config instead of using an env variable, something like:

    [sendemail]
      in-body-headers = From

-K
