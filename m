Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5177C61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 09:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBDJeH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 04:34:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDJeF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 04:34:05 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3627A34010
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 01:34:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ee13so632605edb.5
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 01:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oRE/O1rwLWXjSxyP45lnEh3nU5IOZPd75lTeyTET02o=;
        b=iloKUnVIgQRThBpaXt4bp/HjmgOcIPYn/fH7MBtnYUwHJ7TLH/IpjaqQHdIeqrNz4H
         eXuhl/JJgecE/u4j8gmvNJWLT1C/lmRJPW2I16y4wcL2muftHSgV0lXzSM6sZ0Pb+ZcL
         aL4THPrDPA8BSY9E2EKFy+efrHFNGiXwmP+WzCDphBlaS/8sdHNr8KSFHv13JVWkCJ5j
         iFDvqSIIABPMkSjUcKsF6LVITBw3wviaxmOwVGeA5iRFbhVnC86vnhfPmp/qiZ8iaL5E
         W8U9adHV8cELvkUGbpAF7kUeyNF8UUIdxAKvMaaGhMv9wSGPB2SEKiFC6MQHGFl4Bxg5
         y1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRE/O1rwLWXjSxyP45lnEh3nU5IOZPd75lTeyTET02o=;
        b=RI3jx23/lgrgf1N9gcTeEl9O8qAikTR7CCaHNeG3lS+gmMa916/RYRLrTQndNyagGM
         F6QUcDvj489eqRmK2NIIykpRkNymnP0stCLQ9IIx9Dj/pqnyBhGJgGQSmpBlnD3gTj8f
         AYEZNeznriiPjsuWThIke/hBWIeT7MWHbCoBHoMDIS2Bt0sSeEy14I1ifmv6PxAj/yc0
         QkHJEWXRIAQORS7NrJwDqRkiPBibfyG/h6sGTXhd2k94HOmAyemy7vJ5Adnn2GmwniXP
         +jV15NhkZuKm4yVkQHY9H4f15UzOvmSIbc0DrgpNYMz3qcDi8YMQPOgpofx5vO5iUZ6M
         ed7Q==
X-Gm-Message-State: AO0yUKU8qXJ/LWA2rMcDRyEAShMURguyWr28us4oLsyFmeTkF19RjE+Y
        UcR0C6+QavLfM/NgXZujajlqgWQlwTg=
X-Google-Smtp-Source: AK7set95HJDX1OIoSS02hxGmu+/IsXcZm/mpSnRqDsIv/TAKDayU5IjkB0qgRA7RGKGND2MOALu52Q==
X-Received: by 2002:a05:6402:2206:b0:4a2:1b97:228c with SMTP id cq6-20020a056402220600b004a21b97228cmr11538708edb.28.1675503239413;
        Sat, 04 Feb 2023 01:33:59 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w12-20020a056402268c00b0049e65e4ff20sm2251667edd.14.2023.02.04.01.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 01:33:58 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g>
Date:   Sat, 04 Feb 2023 12:33:56 +0300
In-Reply-To: <xmqqr0v7o0pp.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        02 Feb 2023 20:02:42 -0800")
Message-ID: <871qn5pyez.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:


> * so/diff-merges-more (2022-12-18) 5 commits
>  - diff-merges: improve --diff-merges documentation
>  - diff-merges: issue warning on lone '-m' option
>  - diff-merges: support list of values for --diff-merges
>  - diff-merges: implement log.diffMerges-m-imply-p config
>  - diff-merges: implement [no-]hide option and log.diffMergesHide config
>
>  Assorted updates to "--diff-merges=X" option.
>
>  May want to discard.  Breaking compatibility does not seem worth it.
>  source: <20221217132955.108542-1-sorganov@gmail.com>

Hi Junio,

This does not break any compatibility, as far as me and I believe
reviewers of these series are aware.

Please either merge this or explain what do you mean in more details.

Thanks,
-- Sergey Organov
