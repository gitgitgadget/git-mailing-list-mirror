Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 772B91F803
	for <e@80x24.org>; Tue,  8 Jan 2019 19:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfAHTbA (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 14:31:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38017 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbfAHTa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so5647436wml.3
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 11:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NDFIQFLU4C0Dqd8yuQqkA7UYijEQVw/XAIR8FsOlctU=;
        b=KECfNOss476WG1CyHM1o6nkAj3TKKSWaHetCcRNicCZtonOsLmfSPrRMUIAjwLvbfg
         PJI3EJXaBpikIyME/wfRy54iPbcNaHdJtYkPmEvCs2MsqpStaSyMYtxHrwORDQDLNt6P
         NfWH7k0cpgWvfrRQ5xChwgNPeo5LWohngMl1YLJNGFNAyQljoNla4eDqDed7PPn47yh2
         ZPmJCKxh3VY1Je+RhhcMf6GaZOjj+6dAoS+FhBei3IUMiqIUqsUOUrbTz1saNzy+W3ZQ
         wUYnh4laYEcd2QoJ+VhTFos4A1q7MysB8+jFemPbYsSnArBxMHk2+XU1bQXS3fBJCqPK
         XOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NDFIQFLU4C0Dqd8yuQqkA7UYijEQVw/XAIR8FsOlctU=;
        b=f9h+Z9KssbRQTQG3NiXF6kWHtIk/uFsADz+xdUoXnBdrCIL5VXbMzxmEaiHVPUS+fs
         yCBXq9xKqnCHsFKWY+e9aqNfxMCkARKyAFqGhJV/alF89+hTS5esow3G1iLjGZs9W8Bd
         X1Pqh4GmiTh44gMS+YjTpvazSMG91+6sxB8A/yzBhn48VGGZTpO5VaXZO2Xyx7X/pox/
         Qd4FDPLmvzyl64+Fi5zncKZ/aQUDx25ROcAnKTVJ/3YnszQ9Royjx4djqjiBEBMJkdec
         6fps6nJxHGobX1G7YB157LTE8xWJlfK+cuFtc0sTagCzeTeRcnOQR3qbYZF9XcKkbhyt
         jbtQ==
X-Gm-Message-State: AJcUukcinLc/vF+krYnCy3qWDQfv0E11RlLi9jQCxA0uwpyCOUOkVsps
        /sOvKC3N46wb52swm6KVWZ8=
X-Google-Smtp-Source: ALg8bN7dN8Sx72Wvjyd12cUfgk3YnSx1iZlcoKjXR5bCfzX4POyjGHPQI/hPdt9h609GGokRT/OgDQ==
X-Received: by 2002:a1c:ae15:: with SMTP id x21mr2716099wme.146.1546975856562;
        Tue, 08 Jan 2019 11:30:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 129sm12721888wmd.18.2019.01.08.11.30.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 11:30:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     16657101987@163.com
Cc:     worldhello.net@gmail.com, git@vger.kernel.org, sunchao9@huawei.com
Subject: Re: [PATCH v4 0/1] pack-redundant: remove unused functions
References: <20190102043456.15652-4-worldhello.net@gmail.com>
        <20190108164100.73219-1-16657101987@163.com>
Date:   Tue, 08 Jan 2019 11:30:55 -0800
In-Reply-To: <20190108164100.73219-1-16657101987@163.com> (16657101987's
        message of "Wed, 9 Jan 2019 00:40:59 +0800")
Message-ID: <xmqqzhsb3q1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

16657101987@163.com writes:

> From: Sun Chao <sunchao9@huawei.com>
>
> I'm particularly grateful to Junio and JiangXin for fixing the patches,
> and I noticed Junio send a new commit to remove more unused codes and
> suggest to SQUASH it.
>
> So I create this new version of patches to do this work, I also have
> checked the left codes and remove a unused struct based on Junio's
> last commit of `https://github.com/gitster/git/commits/sc/pack-redundant`.
>
> --
>
> Sun Chao (1):
>   pack-redundant: remove unused functions

Is this meant to replace [v3 3/3]?

