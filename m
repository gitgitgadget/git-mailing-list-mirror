Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EBC433EF
	for <git@archiver.kernel.org>; Mon, 31 Jan 2022 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381041AbiAaV1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 16:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiAaV05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 16:26:57 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2915C061714
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:26:57 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q11so4433190ild.11
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 13:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=09ZVxkbgCxvUSCuf0BKATojgh/slW83XJcSvwnLFCZY=;
        b=1RUJlWwCmwUjPP0p8RnxykgOqHFR92/m7HNnDtFHtp7l7pDxqtcCp7OOC8RH+Kgmdy
         0oI2H81Q8/zzYT6cxpWA8eF/spz5gsC3ZsM1APn6WTnnheK3jiICQ0aFBfitWOH4Pc2O
         aVTKSOJ547LYhPL6RYrbn+BHL/613QbPP+8D9lJZacJ5EBiFnNFHOWgiZrMWTCA8tCHA
         gEv6b5auk82lOeXcrY80jPq7eZrrSbK7E5gTTg0Xsgt25+wGv9l2m9a6dSDWTKPLauA2
         sTuTeF0cW22Vrvi9FHMTtpRCq7uPoXeF3Q5HVdfnipT/osyQlopXExm+vDks3R1pUXxw
         FFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=09ZVxkbgCxvUSCuf0BKATojgh/slW83XJcSvwnLFCZY=;
        b=1WljQTRw4W360xUk9TmytInIYdvsUj8adxrKmv/qcvJ+F/ikpLPoaHSrPAFuWCsWlY
         WnESRms2sOBrXNnG9oHUWisxDC19TCl++b4Rg3rWwEtd3ohetdbz8fkT+/ItyFfRNBPW
         KRjF9QjdhN43SJAy6hn5GdEEOU3tBYsrhtjw1G9Pp/yMXZyuOrgsT+Qx8XdzqWaaqweA
         DTkjw7Ity+VKvpQlzPvYc44jLlxzFNNdKMESLxC2ffwCwviVLGts3lip8jmuuSX6ANJG
         X2AJYefJL6+vnwh7mY3zu1XEMnyn07s7Q0VX8WKdwlaMsvuYeivof9ILfDqdmAzpyAWy
         BwyQ==
X-Gm-Message-State: AOAM532fgXiZkmvPcSOeI634GfcSQiukm7YKrDwkp7FCReKnB6pQ6LKu
        HZa3onaq6/oDrAZ8e05LmrLmRw==
X-Google-Smtp-Source: ABdhPJz1SLp9crW7MIFPQZjDypPk3XiuCzNUYShmUQJkZMEyxOsqTsdYJiawow9vDxQJNgQYOT8E0w==
X-Received: by 2002:a92:6c07:: with SMTP id h7mr13693055ilc.118.1643664417254;
        Mon, 31 Jan 2022 13:26:57 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y19sm3820239ilq.60.2022.01.31.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 13:26:57 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:26:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 2/3] t1405: mark test that checks existence as REFFILES
Message-ID: <YfhUIJuO70va6gr8@nand.local>
References: <pull.1209.git.git.1643651420.gitgitgadget@gmail.com>
 <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ded69d89709d23147b29f67122b659293414405.1643651420.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 31, 2022 at 05:50:19PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:
> From: Han-Wen Nienhuys <hanwen@google.com>
>
> The reftable backend doesn't support mere existence of reflogs.

Perhaps I'm missing something obvious, but this and the previous patch
seem to be conflicting each other.

My understanding of the previous change is that you wanted a reflog
entry when the REFFILES prerequisite isn't met. But this patch says what
matches my understanding is that reftable and reflogs do not play
together.

If reflogs do not interact with the reftable backend, then what does
this patch do?

Thanks,
Taylor
