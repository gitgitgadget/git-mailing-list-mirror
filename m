Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A6F1F453
	for <e@80x24.org>; Thu, 25 Apr 2019 21:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfDYVbf (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 17:31:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44578 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfDYVbf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 17:31:35 -0400
Received: by mail-ed1-f68.google.com with SMTP id i13so1291392edf.11
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 14:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=VxRPacJkRSmDc0Phvjd8THHT1XqMnzP2vQlOjX+cYnU=;
        b=Hfif6o/7RDUjmjUWZpmbxekczII/7jjh76f55DDUFSiMKaWA1TpAA3eyFgeo12jX64
         mLS5hDTLfOoLw1azM8AYTzGJ9S9Qi2cgOJWkiJgIp2yXDbXwtU88dV17JLfTNvyreP4E
         MQ6YClfV3IqCfg5bcBIgjCU8oYGS180aAjcqvkA4q6hy9Sl0PBoqs/3f96mLyRIXCwP6
         bMJHOar5qM5pFo/zA6MSqw5HYikesLmV91zpYJ26QvOCuE7+q6c2lQfRMUsaecdNuswJ
         bPWQyOLalg75qB/zR4/E4qk4nWeMr+XADkM5M6PvnJrSGoYbzFSSE8Pck51LrD0rE0H9
         jcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=VxRPacJkRSmDc0Phvjd8THHT1XqMnzP2vQlOjX+cYnU=;
        b=W9LVxF5gk6O6sinCn4t1QxdAlbsqR6w5fkOMjKbfaX66/vwwpHqCFXW4D2RH06nhwI
         tW1qlUvdlDfPY3P3BTSoLDloTyfL+7vNxxFiTZlIUlVtXlW609qNgp0iZIpBUQYPNWaT
         fD8sT6jeFDXrkXhVtSdwRTCeUQtcSBhZnasqRBsaUrJTQf0nqU4jPdBcgtDhcDnoVvxP
         imtw3+RpTUNy7yPiWqG5DeayQYkg29vivYz5c8711Ou7XAi6jOXUWmfAlTYTavTO3qXH
         Ckl9ViKKcP1d+6oW4mXlC1geFSW4IrV+Vzf0ouJxx+9x+XDp+hnGdxYpFspEDJ4354O2
         VdoQ==
X-Gm-Message-State: APjAAAXtIt96OiLiXx4YZJknCiiYt3WHHyo379GpL8T81AGD21N80bf/
        YnIiA/nCenJqpc8e5wee43NlxdEJ
X-Google-Smtp-Source: APXvYqyCkyRQL1tGifnx1lzHViAocuCwfCkUDim6/l801xi3kFRjW0J8FKWM3g8GXNoN4HLDptvmwQ==
X-Received: by 2002:a50:b69c:: with SMTP id d28mr25700302ede.126.1556227893011;
        Thu, 25 Apr 2019 14:31:33 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id t52sm6579112edd.54.2019.04.25.14.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 14:31:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/5] commit-graph: create new version flags
References: <pull.112.git.gitgitgadget@gmail.com> <pull.112.v2.git.gitgitgadget@gmail.com> <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <4ddb82916321f093d88282ef4bcab99993339fb5.1556135881.git.gitgitgadget@gmail.com>
Date:   Thu, 25 Apr 2019 23:31:31 +0200
Message-ID: <87bm0tsrf0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Derrick Stolee via GitGitGadget wrote:

> -	hash_version = *(unsigned char*)(data + 5);
> -	if (hash_version != oid_version()) {
> -		error(_("commit-graph hash version %X does not match version %X"),
> -		      hash_version, oid_version());
> +		      graph_version, 1);
>  		return NULL;
>  	}
>
>  	graph = alloc_commit_graph();
>
> +	switch (graph_version) {
> +	case 1:
> +		hash_version = *(unsigned char*)(data + 5);
> +		if (hash_version != oid_version()) {
> +			error(_("commit-graph hash version %X does not match version %X"),
> +			      hash_version, oid_version());
> +			return NULL;
> +		}

This is just munging existing code, but one thing in my series that I
didn't follow-up on was Duy's suggestion[1] of %X here being
nonsensical.

It doesn't make sense to start saying "version A" here when we make it
to version 10, however unlikely that is :)

So I think for the existing %X in this file it should be 0x%X as he
suggests, except in cases like this where we should just use %d.

1. https://public-inbox.org/git/CACsJy8DgNzGK3g2P7ZyRmd7sbiSOXY07KqYEh-gSsPkEZ+D5Qw@mail.gmail.com/
