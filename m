Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7421F1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 20:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbeBTUMU (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 15:12:20 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33820 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbeBTUMT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 15:12:19 -0500
Received: by mail-wr0-f193.google.com with SMTP id m5so17931626wrg.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 12:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9WjDhsS9vTPBUJUP94rbRwtvruhrqsyj/uV9FMFc8pg=;
        b=NgD2eUhpR07yEnEIiWDFbo/8QIInphKxv0+oVBBe/3+ITBS/hFT0iw/fjRLMyf4Y1V
         MoccjrCozD+OksuedF89qTf7w4XofGifzqHgdy5f2EB+oy33Pi+eBhU6RsPMfg7+i2bh
         8YsEzs+FHGvxHsZuOpnxfnsQQ+pH8w3xy4hjt05EVKgg/HfzwPFOXzSizDcUawkoaayp
         vKnk6H4adlZoqgp3TwN25+C+KXscVNJJ/GGlekZW9ZMC33zfBxwpYRmfjgXg5HK7NZf0
         ymbh3VlPlKB+uL0765M/MXBjUqxrDRbDXiTHhrnPAZMYpXU+jaQrrVYWnpyBW5s55pRn
         AMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9WjDhsS9vTPBUJUP94rbRwtvruhrqsyj/uV9FMFc8pg=;
        b=PGqkjSJFOPhBiw9sKJ7y2pM6Mr4oMxYP3qfkT+bk8mnAA3xRyT/ZeykZ6hizWYLXkn
         RpbyNta1Eld1UVo6X2GrtG+ZJOSnB/T7/8XzUodmQL93WX5xc/YlibHqEidX8e2A9GMY
         bHyaEz6Qep8HJdUEhJGRopJQE1QAe2zvs1MPVtZezJcMabI4P5YWoJsJMsoJ9PSTG4p0
         OaJh67+O0Jeym416SgUt/BncyF31AhnPF90nSmhdiUiZacLV7TQ4eRn53daLfl3MlYdb
         Tl/0CG8ph06CFNZFGHcEi6F0lDo1fp7pQGmP/MhVG2MTSkJOOp0MI24RjHSCFM0T3QsZ
         8kMA==
X-Gm-Message-State: APf1xPCl45JVZD9tdenlx89ldn3RwaQiJF06QMT3wkKKF1c9cDAOhdOT
        lGk7OmO8BTaNWByvaKy+fwE=
X-Google-Smtp-Source: AH8x225G0nvueWU0++XjgVGx8LJqUVQ8JT30kUgUDHwR3qfM/jur0xuVKisj55dslwtMQgRpinLx4w==
X-Received: by 10.223.139.131 with SMTP id o3mr708222wra.279.1519157537900;
        Tue, 20 Feb 2018 12:12:17 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w134sm2507373wmd.6.2018.02.20.12.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 12:12:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     marmot1123 <marmot.motoki@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2] Fix misconversion of gitsubmodule.txt
References: <01020161b2696296-9d580cc6-c21f-4fa2-a876-7d77d36cb44a-000000@eu-west-1.amazonses.com>
        <01020161b30b99df-5029ec2b-a5cb-475b-b54f-9879a117a7f3-000000@eu-west-1.amazonses.com>
        <20180220193834.GM27038@zaya.teonanacatl.net>
Date:   Tue, 20 Feb 2018 12:12:16 -0800
In-Reply-To: <20180220193834.GM27038@zaya.teonanacatl.net> (Todd Zullinger's
        message of "Tue, 20 Feb 2018 14:38:34 -0500")
Message-ID: <xmqqfu5v2zfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> If replacing the non-ASCI apostrophes is the goal, aren't
> there a number of others in the same file worth cleaning up
> at the same time?
>
> $ grep '’' Documentation/gitsubmodules.txt
> the submodule’s working directory pointing to (i).
> superproject expects the submodule’s working directory to be at.
> When deinitialized or deleted (see below), the submodule’s Git
> but no submodule working directory. The submodule’s Git directory
> the superproject’s `$GIT_DIR/config` file, so the superproject’s history
> The deletion removes the superproject’s tracking data, which are
> The submodule’s working directory is removed from the file
>
> This does seem to be the only file which includes the
> non-ASCII apostrophe under Documentation.

Thanks for checking.  I agree that it is a good idea to clean the
whole file up at the same time.  The title would need to be updated,
as it will no longer be "fix misconversion".  The justification would
also become different---"the 'overhaul' did not just move the text
but made the apostrophe style changes and reverting that change is a
good thing" was a good justification for "fix misconversion", but
now we need to explain to the future readers of "git log" why we
prefer to turn all of them in this file to ASCII single quotes (just
saying "make it consistent" is sufficient).

Thanks.

