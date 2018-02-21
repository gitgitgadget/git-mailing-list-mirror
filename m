Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE75E1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 22:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeBUWfj (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 17:35:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40917 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeBUWfh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 17:35:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id t82so227810wmt.5
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 14:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+gfuL4TJip8KrPClfuBVebjzok/8OsQI+r5eWfoAolU=;
        b=OORGIBdXesMHbeXbbLZpexoId6gNCwpXgGj97jLYPtWb5vSTSnFkerGMNcQrHsGdhq
         QERja0Vt8q7MuZW5KoB5oZqNVw7Wi+PnVgafq+F55BCAKYG+PGMvV7XrIh+t/mPeG4l9
         yys9vVjL01s2Nm/VYWu+heznCZIzFtOh3SubpJmRdioGB1c+Qzv1KQ794Gpt4HDv9PTr
         feXNXIo4sjOVS4HZpM6tfnFYtLKq4YMwfOeOC1Mvs8d3hTvch3M7Fralh75u98ZUwsXS
         LMxBnIs/fFS3toaQqrm7xGWl6BDAeqYmPHtNSyddV0Qu2rnIkSL5Au8FpD/IWGCwlOvR
         TsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+gfuL4TJip8KrPClfuBVebjzok/8OsQI+r5eWfoAolU=;
        b=OogPYd7L8zPEafH0up9FnpfGRV7SsrjIbZPyMIpq8idoNPw1TUCptZp3yaswYb3Sjt
         l1NkNj0Oz7DkZklUaRgi3uMBRbVNUdSR375lONQhacubY5LEkdUkkNaFVWj3zNnRqFk9
         64hdkPe6iEpJoykBVECBvIZw3zAm8kVThhFxAaaVbMehY/1yTr0dsDAI72mQs4geiwRs
         4YYKcJUJpAX7S9GmYXXMpUAdDk3WQbpCWpva6/W4RdWR/ZZglfqAG1KIS+xySLAgTBsw
         p2tmEd3AktkH7kYUwlG6e7clasaibepDi9Fh2nLYPVgdmojhyqBHA/t4a/eniG47aFUN
         kC/w==
X-Gm-Message-State: APf1xPAsQbivaU0sJ7c+QVD1maVrmVIosvnwuPmsy/3CryD7dcw6kvFb
        2y4QyMSNW+KIe/3Jsh6Qq94=
X-Google-Smtp-Source: AH8x227whav0rZUYPSAgD9PrsxlCfVLLcHHeHIFOKz72qwGAm1W2MkMBoncD7UUmVRk+bU3xKBwBag==
X-Received: by 10.28.97.7 with SMTP id v7mr1262066wmb.154.1519252535612;
        Wed, 21 Feb 2018 14:35:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 62sm33977865wml.24.2018.02.21.14.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 14:35:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 0/3] Re: t7006: add tests for how git config paginates
References: <450ff45707b58d6796d55cd594b50686e5d62fc2.1518365675.git.martin.agren@gmail.com>
        <cover.1519238410.git.martin.agren@gmail.com>
Date:   Wed, 21 Feb 2018 14:35:34 -0800
In-Reply-To: <cover.1519238410.git.martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Wed, 21 Feb 2018 19:51:41 +0100")
Message-ID: <xmqqmv02x96x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  The entire thing looked reasonable.

Will replace.
