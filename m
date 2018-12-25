Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4D6211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 08:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbeLYIq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 03:46:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36227 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLYIq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 03:46:56 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so13213440wmc.1
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LRUEiHmNSOea9VRwEjJbxLOR6H4l+hBHl09j9u2jt3s=;
        b=vIO4xnL9Y/pBZdolnaaLXB0ullNVLblcNjNg9tVvgB1jV+AQdUlU6BBkv0Z1RzG/KM
         g6m/OiG6Gu4cBdYae55+Y4bYTsWEnntprJk8ztezNR9DOZIheE+kUHxefcQGNfzYBRDD
         8je+MO/o8OoD3OlBsdksGjvAFheNs3ttlDcD+K7QDxT2ep2JZPe1c6bYXoD+LDDIaoLq
         GzikQo5R3Yvk300V66fsc4XNq7kB9ILcw8CldC8YbEo2dv24ynPjDGXhhsXLjBuAawdL
         XNOVnngZXKYUF88V8GOCG/ulMAgK8GW7CGlQhfAIrzkvGglKGYW51cPM6FZ6SKs5lxeS
         P4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LRUEiHmNSOea9VRwEjJbxLOR6H4l+hBHl09j9u2jt3s=;
        b=olPdcTRolGz+ayFbT60exIsjfdN0eZXPZogSZcfPs9kAzMbjZL4vq8muZcOoLZsndF
         Kw68T2Gwl7i5JVcgA1LAudhHnONnI7BhDZtxtWXBw04fhkB6YgJWlm9sdTzY21PM/3W9
         4uaLKE4cFU6Ifr4rYI2kB/2xxVOKO0jeDUL2U87/PzbvSmt86CBTDCYztL+u6e+rib/v
         lZyAPk9lv1BgyM5hsUEK8DldDyhZMUiYiD7d9tnfVEsO50mcpLQU3yTuq+RpJOMhF21r
         B6Oz+tUrJ986px72+hF6yWOp5GV/FxtdckcaBewWAUM3MnIcKEfwOE7r49F4Y8GX0DAj
         ffag==
X-Gm-Message-State: AA+aEWbc141licqbMqzRvbFzvGQXxLBpc3a+/SD8OZmgHK0eL2iXlIjw
        MRThCO3DMT8SZYViFPOtm2g=
X-Google-Smtp-Source: ALg8bN4EBuGa6E6in4/TI8NoKju8ngUXDUNOZ04y672vnt6QJ086+I+dGKI72Ibww6vxgRkBmcekKQ==
X-Received: by 2002:a1c:7eca:: with SMTP id z193mr15412495wmc.140.1545727614220;
        Tue, 25 Dec 2018 00:46:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8sm52735521wmd.0.2018.12.25.00.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 00:46:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 1/1] abspath_part_inside_repo: respect core.fileMode
References: <pull.104.v2.git.gitgitgadget@gmail.com>
        <pull.104.v3.git.gitgitgadget@gmail.com>
        <b935e11d21fc2a34953d1fc651ea09f1a4c1a769.1545692162.git.gitgitgadget@gmail.com>
        <xmqqftumb8zv.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 25 Dec 2018 17:46:52 +0900
In-Reply-To: <xmqqftumb8zv.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 25 Dec 2018 12:06:28 +0900")
Message-ID: <xmqqa7kuat8j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> the resulting index entry is "blub" or "BLUB".  Shouldn't we verify
> that "git add" adds an expected path to the index, instead of
> blindly trusting that it says "Yeah, I did as I was told" with its
> exit status?  Would we be adding 'blub' as that is what we told
> 'git' to add, or would it be 'BLUB' as that is what exists on the
> filesystem that is case insensitive but case preserving?

Needless to say, the last part of the above is a mere thetorical
question, and I am not questioning the established behaviour or
suggesting to "improve" it.  On a case insensitive filesystem, we
trust what readdir() gave us (but match them with pathspec case
insensitively) for a new path that is not in the index.  When we
update the contents of a path that is already in the index, we
preserve the case in the index, even when readdir() reports the same
path in different case (iow, we trust the case in the index more
than what readdir() gives us)..

What I am wondering in the above is if we should document that in
the test, perhaps with a simple

	git ls-files blub >actual &&
	echo BLUB >expect &&
	test_cmp expect actual

or something like that.
