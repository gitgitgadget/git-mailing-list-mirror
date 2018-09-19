Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276941F453
	for <e@80x24.org>; Wed, 19 Sep 2018 03:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbeISIgP (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 04:36:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35627 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeISIgP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 04:36:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id o18-v6so5047424wmc.0
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 20:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MQZ4lEuRYgo+TQuUgHVgyGCCn9A8uClUTCTuqxaPtpY=;
        b=trQDJh8BDBhiMipYZYsx5GhVmLT29nqbxASwWjjp/iceTbQph2jGXu/I30+StKSkZP
         Wr9klNj/aHtlsqYu822hJnPMY+jqIAUoDyqqMBXkC+LhqwfHwgUmSXgIMPw2muhLMlzK
         ligNW7VEmeHR4N6mKsWkSF2Iaw2szzEJ+0YcasnQ8fFzPw392mHToA3eZWjJ73/tXBkK
         INsew9++qlkx6UA69pleKpJeF8jUWuP86jmLQzu0GN1GH0psVA2jk46oXeQ50B1Ji59o
         xjx9DwFa2v2lD2cpEPwljiq2mKyFTTJijgxlG6AZ4lTrzUozamkBognEbJ1elUT0z8sx
         f2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MQZ4lEuRYgo+TQuUgHVgyGCCn9A8uClUTCTuqxaPtpY=;
        b=cxoReLJ+wOpykl1A673jsOi5EEygldt533b+oZZYkqWYtpl1MMF3BS6nnlZp3eA5Dz
         a43paAfoyF2cW9oT3Hsd1ZSL1arKDAahVXvkthgX3CcItk8aESUVAa94weswrDt7iwc5
         vbafieS2mHVm/atSKKvg/7vRaUY0TJexKIdDvaqBhKOxRwAQqoGOEX4Ban/HhKE+0ZC5
         vZ0tPJwtBew/tjSCe1rrBDmKFaYhQB3nM010/Z3QW7Hzyxqz+pRfR6IMLkeLSLcp0PW8
         TpTImSQoZnoEQyF79RSp+fWRwOLt2ensWT66ycE2R1M7iw3njJCQbCQrsM/FaEU+sxec
         /d/w==
X-Gm-Message-State: APzg51AW1do43q7Y2Nhx9egOEJBBkXk7VQgyunhWdrlHM5VGzAW0QjSE
        CfQXI6ZisABkZd2g3uhmVDg=
X-Google-Smtp-Source: ANB0VdZozG1fhYxuTp8GTckpE6/XwKOL9w5DWuZl9+aZWif5xm6q4UYd9CQBKiHtoNt6amKxNjEruw==
X-Received: by 2002:a1c:bc86:: with SMTP id m128-v6mr18441518wmf.147.1537326028686;
        Tue, 18 Sep 2018 20:00:28 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o6-v6sm2478898wmc.15.2018.09.18.20.00.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 20:00:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] Add an EditorConfig file
References: <20180917230307.588334-1-sandals@crustytoothpaste.net>
Date:   Tue, 18 Sep 2018 20:00:27 -0700
In-Reply-To: <20180917230307.588334-1-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Mon, 17 Sep 2018 23:03:07 +0000")
Message-ID: <xmqqtvmm42es.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> To make automatically configuring one's editor easier, provide an
> EditorConfig file.  This is an INI-style configuration file that can be
> used to specify editor settings and can be understood by a wide variety
> of editors.  Some editors include this support natively; others require
> a plugin.

Good intentions.  One thing that makes me wonder is how well this
plays with "make style" and how easy will it be to keep their
recommendations in sync.  Ideally, if we can generate one from the
other, or both from a unified source, that would be great.
