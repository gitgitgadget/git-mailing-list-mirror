Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9DD1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfARJwo (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 04:52:44 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36180 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfARJwo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 04:52:44 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so3863325wmc.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 01:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=ophQr9Ro9iQ3Nnw75kEdjoTWpChWBggIfDiDs7N5eXs=;
        b=S7OQ9wzDFWXZLwsYCd2GvsmljEqDuPU7HrLChDYMSMjyy2RDWLRhePFQWeKasyiIr+
         afSvIxE7rZIkyhg22SdJpLZBpARV6JbsJ0slA6n/1zWi2eUrWq2TeSZviETiE3A8ZVkE
         EtXua8n0VifUQbBlrwajaqyA+uKmQDT84go0nU5tSDo0b1u8e5FVyv1vMjHxwR6eGQHx
         xdz0HgLdT4H6f17XIdrclYWOZ1n5P0LX0T9NWYQuxqmTOyHA9dbiuy8HeLhtY6C0LvSN
         sgmEkAeyCp3yV43VDHmZCoD0Ol4Bf7OnIpEQjfJ5ybCcVfbExh4HuEgw1/DN31Ylvlpr
         crKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=ophQr9Ro9iQ3Nnw75kEdjoTWpChWBggIfDiDs7N5eXs=;
        b=WRFu66i/so/kA3/aL2SkkUs6hLzwnoRsR1LoRdgQK+7GBgTpTVVOhnc2WPfMutHkFU
         ud5TtF8tL6DnUNPqJ2GCQ6UXrl4j727W1FrRTR2VXmfyKcWPAjWTCz9gxOntv4ZYZBzl
         1Xvy2vP+KKQip7hysw3paY6bh+3vub9yCtQU9w56ubY61HgI2dL3wiPScqbkinDyTNaS
         u9y1x5lp8hvyI5o4X6fnVyap9xZeAGxmTkF8Q1L6Y0yYEzJsSDqiBlyoLbmsz5c1E1UC
         S0Qe1jFRTfC90WPbZrs+CMixBFegbKhMEp3oUSfjURfY4lLTmjmVAi1um/LNjpmqjXAA
         1AEQ==
X-Gm-Message-State: AJcUukfgCv4GRU0CBRQZBT2n1p+1QCueYwV5NGl7iIlyzmmpE6HJnluD
        ZiKgFCUL4wUFdidtosVWlSI=
X-Google-Smtp-Source: ALg8bN72/cHN932idGUi5wv62NWpb7sXvvAQFsqz650fBxQlWVn1xVjiSPuI/J7zZyOwz9W2d4z4UQ==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr15195643wma.109.1547805162795;
        Fri, 18 Jan 2019 01:52:42 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c65sm41897165wma.24.2019.01.18.01.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 01:52:42 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Barret Rhoden <brho@google.com>
Cc:     git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 0/3] blame: add the ability to ignore commits
References: <20190107213013.231514-1-brho@google.com> <20190117202919.157326-1-brho@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190117202919.157326-1-brho@google.com>
Date:   Fri, 18 Jan 2019 10:52:41 +0100
Message-ID: <87imym47iu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 17 2019, Barret Rhoden wrote:

> Adds the ability to ignore a set of commits and their changes when
> blaming.  This can be used to ignore a commit deemed 'not interesting,'
> such as reformatting.
>
> v1: https://public-inbox.org/git/20190107213013.231514-1-brho@google.com/
> v1 -> v2
> - extracted the skiplist from fsck to avoid duplicating code
> - overhauled the interface and options
> - split out markIgnoredFiles
> - handled merges
>
> Barret Rhoden (3):
>   Move init_skiplist() outside of fsck
>   blame: add the ability to ignore commits and their changes
>   blame: add a config option to mark ignored lines

Looks much better this time around, I skimmed it, but quickly discovered
that there's no tests for any of it, which is a prerequisite for getting
something like this in.

