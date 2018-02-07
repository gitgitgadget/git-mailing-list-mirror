Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89801F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeBGST3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:19:29 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33560 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbeBGST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:19:27 -0500
Received: by mail-wr0-f176.google.com with SMTP id s5so2095593wra.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 10:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ztKTXpZtJhTyiSzr52IuY4zs7ffZS6xNli9jZ1opUz0=;
        b=KWlF/lhXXeIQQiLKwECUQ4o+wrSusaFw0hicX71zV1I+CSodZMPv/gTORR8zXxR7+I
         hUbB4cw2WqFS+KTA+E/ItVDn/1O9t0hLzBAYRHiIkiw13ZWVXRMs0IErpBw4hSOwa5/J
         eG3yCOBXBqhXhwSt9xj6P9OrRUykgIvGaJmHVyPYvDSFz7tliSPZ7/2S8covPBg+v7sp
         3in3EpYSLulhVhETJwAwcbP2PoamfxEmwQGIt7cjdQ47Jb8kCT8M8STgO4vi34yR3Gjs
         Q44/n6Z7i2wZgFV9IDNOuH0WQM+xXdyArwBJbSxI6SB0qND3fPFbv+/TXdV3JEQDLJZF
         T7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ztKTXpZtJhTyiSzr52IuY4zs7ffZS6xNli9jZ1opUz0=;
        b=ITSTl30NLNtMYk4DGsB+HI40XX/osDimhTvT4KVBcgbenmoBTN9gj213FYFUBYTNlz
         rarVDfnYPoh8a4c5WI7lcRnMM5iJp4q1T7AY0tFMM8bDwg+xUTc0OxGM2SX7PMkxrj8z
         g6LbBUttPT+oPRkN0gVPu2xJEMSrk34DSD4eCxmvvGkze5idYT3YU9mGZnhKthx/kFPe
         GeVOo+N1mc/Y1OvAItoNnAA7fwNVRGTaM8H9SqCt8vHz2XDjK9C5/JKe+VvYufNLg8OA
         Q8naBzJHauhNpD8SHmqLt9riPXBKoY6/AffU9P9k7GPib23RmNK0s64RGighGK1qEQ7p
         z3GA==
X-Gm-Message-State: APf1xPAcLhyw7XnvvfThX1rfIDaZx8SCSPQbZpzTVTUX5u27+SsTESxT
        3qoJqfhC5YMIVLMiGmoJSJk=
X-Google-Smtp-Source: AH8x226GBrGf7FbtxYEKuJRbXuIPoNz1xFaFZWStOi6Rh9arGVXqLw8IlBSfz7TYhivI7tog89TX6Q==
X-Received: by 10.223.164.197 with SMTP id h5mr6577934wrb.108.1518027565449;
        Wed, 07 Feb 2018 10:19:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v75sm4760644wrb.12.2018.02.07.10.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 10:19:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] diff: add --stat-with-summary (was --compact-summary)
References: <20180201130221.15563-1-pclouds@gmail.com>
        <xmqqefm3cgd7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8B5DYpSQnJiLK8r4naaBh0YWLGwn9FuvM6EhP74E4E_CA@mail.gmail.com>
        <xmqq8tc7b6yt.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CQLnzX6vijE+WHE3_nwqVfFiNWFb_rcA-Lw_fvGf=aFw@mail.gmail.com>
        <CAPig+cR9RycfLz0C6tXA4iPXdqoyczfij8CBaU4MmRGRmuRhSQ@mail.gmail.com>
        <CACsJy8AiBq__c0UET5ywMbTTz_MJNo-bZ-qAaoGZXdMNnECcaQ@mail.gmail.com>
Date:   Wed, 07 Feb 2018 10:19:23 -0800
In-Reply-To: <CACsJy8AiBq__c0UET5ywMbTTz_MJNo-bZ-qAaoGZXdMNnECcaQ@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 7 Feb 2018 17:36:26 +0700")
Message-ID: <xmqqy3k47jdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> ...
> Then we still need to decide the new keyword for this feature, I feel
> compact is a bit too vague (I read --stat=compact as "it's compact
> stat", not "stat with compact summary"), so perhaps
> --stat=compact-summary, or just --stat=summary?

Yup, this is about giving summary in a compact way, not about giving
a compact stat information.  I agree with all the above reasoning,
and that is why I said that your "compact-summary" was a good way to
refer to the feature.
