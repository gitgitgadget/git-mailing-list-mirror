Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2570ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 14:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiISOyv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 10:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiISOyu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 10:54:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66A76546
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:54:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k12so20620649qkj.8
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date;
        bh=K8kMTyFad9Guy2YrmYxItkEt6fuPQUSYXDrdO9pMuGU=;
        b=SvVUEaQtO3j67U8Z0CoYVRSqRM/wGFnoyYarx/TqMG9IxV5ZTomtl1VmLEGrspz8nB
         bca93QeVIW8vnXoEib+EOXIoMZcYy8jwvHHnJWAg5gmngsOSTaA0zLaEG7/VW6Uftu9z
         TEJZIQ1/P3+55KUVQjAIT+ngW0L2PaTQnMZXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=K8kMTyFad9Guy2YrmYxItkEt6fuPQUSYXDrdO9pMuGU=;
        b=jqlAWZq6JQx7z0G65m/2MH5d1CwLyKIhopcObFTpGEvhr0EpQOGx5pP8yVfQylKo0Y
         Z+RkeMcTNpIeRk4iKPytMxL7rGZZ7bnFjdMrBI/sYgJV9MABGXOZlTXuuuVIVWrn+QPm
         OTXT8ZkODwR9REGZpG6Za8XzVJlcqeCjX1PlykAOiFgx4TB9A2TSkgUgOYQg80zB8YQo
         b4yZLEmcTJkeXxoKf3gEfe2AfyaL7rHSkvJ9tsucRaJ7qCMpSTnW0htdynrpw3/V2D0E
         KECGR10zgLNBfEiD8WVt6WCNPVDaF7HeRVKkJkHntHhlvpwe0XEVC7yBFFZS0edy1DCw
         GGaQ==
X-Gm-Message-State: ACrzQf31PTfH7mwAw2dU09bS3h/VAgwIutysWcXGEFMyV5hRM5v2rMFy
        yf0m68v3UvbOIQLhZp+qiZIqhXTuVq/sIA==
X-Google-Smtp-Source: AMsMyM6eEXqR8KIPmeC2zsNzMpg1RxKMIFlTQSl5c9S2CSmwd29RoqdnLp4ZMIX0bU42bdXL4gM4hg==
X-Received: by 2002:a05:620a:462c:b0:6ce:3aa5:417e with SMTP id br44-20020a05620a462c00b006ce3aa5417emr13465853qkb.736.1663599287674;
        Mon, 19 Sep 2022 07:54:47 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id u19-20020a37ab13000000b006ce5f4720cdsm12312631qke.47.2022.09.19.07.54.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:54:47 -0700 (PDT)
Date:   Mon, 19 Sep 2022 10:54:45 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: b4 new contributor-oriented features
Message-ID: <20220919145445.ifpjcah44pql2erl@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

If you submit patches to git, I would like to invite you to try out b4's new
contributor-oriented features:

* b4 prep: allows to get your patch series ready for sending to the maintainer
  for review
* b4 send: simplifies the process of submitting your patches to the git
  mailing list -- even if you don’t have access to a compliant SMTP server
* b4 trailers: simplifies the process of retrieving code-review trailers
  received on the distribution lists and applying them to your tree

You can view this process as an alternative to GitHub PR + GitGitGadget
(sans all the nice CI features, just the actual submission). You can read full
documentation about this workflow here:
https://b4.docs.kernel.org/en/stable-0.10.y/contributor/overview.html

Note: These features are very new, experimental, and likely contain bugs. I
would be happy to receive any problem reports or other feedback.

Best regards,
Konstantin Ryabitsev
