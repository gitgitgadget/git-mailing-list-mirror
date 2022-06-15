Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56606C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 01:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbiFOBuk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiFOBui (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 21:50:38 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094949276
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 18:50:35 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b142so7779562qkg.2
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 18:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6dOoK6RLziYH7IdKGTwuzxm0XsTgXQTt7aqGjN7rgXU=;
        b=k4S3E1LdoOQCYjrsk5A1/wfaL88kvzPoL4vjDnvaHW78q3KUi2x2ENabXCzzzKTdHe
         X+/4llKngnkIbk5Ed5BLKqLEDR0sfMn8PAh8IbpW9iO+O6SkhgxUiYjXdbl/dq71lFDF
         YJvtZs43KF6szDtaU73Dw+zogzbCmTl6PTNTcs1gtM0oYvtIgTdhRBl9pSlIngPIbQ3p
         jnHOHtbHCmG2k7/9a+zftRypmyjQscoVB0g9KTYOLY+4bwHZHr9bKddA/cZ63ICeh0wN
         QIgIxBfyNeb29CRLA1bn19BJAYyhI5Hzl9bJb2zdBg1JbpvkaZBG/qNt3KQIkYiBEDbl
         KofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6dOoK6RLziYH7IdKGTwuzxm0XsTgXQTt7aqGjN7rgXU=;
        b=ywEJg01h9hjIGHgLZP0TkmhpAojCpqF/EkhSh/H2rfVmCAAEt3kOIrN1btyzXR8Odk
         JCp7Cn11X7wYiX2sanHNbvjDrwr4QLnj1JTtAw7C58prEIOXEssIz5imZG5Ew69B+r/g
         J5oxAWZqtSjdBhQW8GrcU+xIVNEm806IgjjDxAi3ZCi8xWgbaf5rh7V6Aemm59ZfErzB
         gw2BoSDNLQ01wENw3c1DihRQa5oOr69+YV6O3rZSkdFrjavGT06gaHW/PWoGtNQc2UNr
         qu5ruvt7nJmA4mLa9UAD+7J4bfALYvS+O3ckY+WJ+ob7/O3VMetsSw9Im9CZa9l6cXiS
         vOrA==
X-Gm-Message-State: AOAM533bLm0jXA3TzaOB6YoAqZtkuHyJClU+SOuW+I7AIxmK5/8msqgm
        8rV22+SlI4xHGqgFal3xfH9w7nayv29PPOJs
X-Google-Smtp-Source: ABdhPJyWVKXFNnvOuxO3792c/1dP3S9SzHLjQAVhFCIMGs37Re7gbJNKJO7HH/JqCsCVHzEyWsFWkw==
X-Received: by 2002:a05:620a:4505:b0:6a6:f875:a609 with SMTP id t5-20020a05620a450500b006a6f875a609mr6321327qkp.710.1655257833998;
        Tue, 14 Jun 2022 18:50:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a240100b0069c72b41b59sm11486542qkn.2.2022.06.14.18.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:50:33 -0700 (PDT)
Date:   Tue, 14 Jun 2022 21:50:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config: correct log.showRoot description
Message-ID: <Yqk66CTVbX22Xi+e@nand.local>
References: <b7aa801c3995fffdce37d90adba9253485b616e3.1655223201.git.git@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7aa801c3995fffdce37d90adba9253485b616e3.1655223201.git.git@grubix.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 06:14:22PM +0200, Michael J Gruber wrote:
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index 456eb07800..b210f24cca 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -40,10 +40,10 @@ log.graphColors::
>  	history lines in `git log --graph`.
>
>  log.showRoot::
> -	If true, the initial commit will be shown as a big creation event.
> -	This is equivalent to a diff against an empty tree.
> -	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
> -	normally hide the root commit will now show it. True by default.
> +	If `false`, tools like linkgit:git-log[1] or linkgit:git-whatchanged[1]
> +	will not treat the initial commit as a big creation event.  Any root
> +	commits in `git log -p` output would be shown without a diff attached.
> +	The default is `true`.

This looks good to me. An alternative approach which would work to would
be to replace "If `true`" with "When `true`". I have a vague preference
towards the latter, since it explains what log.showRoot does, rather
than what it does not do.

But this works just as well, and I think that I'm splitting hairs
anyways ;).

Thanks,
Taylor
