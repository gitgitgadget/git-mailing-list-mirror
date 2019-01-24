Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D91C81F453
	for <e@80x24.org>; Thu, 24 Jan 2019 23:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfAXXFd (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 18:05:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35824 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfAXXFd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 18:05:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so4896723wmt.0
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 15:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DKzHiXMxv6SA1QtAv+ULLVDyic0V+7eGoPPX/C4J4Ss=;
        b=aoQyOoeV1MxD2eJmc1ZROlkw4RAkpCBfQZAys41mlxA1V6k1AmfMDxuQOKtOdSYzrj
         zvO9bvdVoe4ds+ws4xxYLHZT+O36b0nQNF+SP0q0Z5NUNvD75e1z+8/7Q/QCjCjJHwJT
         S06acW0CgMYEEH+7V12DVywyaR/jkS09Kr2n3el4lQOv5RVPkpijkgoTpbqPwMKFRhkB
         kIIZMb7YWmh42NOWG3Unlpdv1yV5pTaZctu2lezideMiWt72b0aekzqcF+HAg4NOUz/j
         BySvG1vUq6sd5iEDNcotJnN/urQ78bI46CnGckYbTGO0iSX1zxkniWD/c0FivMqRlGWy
         EzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DKzHiXMxv6SA1QtAv+ULLVDyic0V+7eGoPPX/C4J4Ss=;
        b=qk46xJyZf6PR0kn4eoJ45hLV9msTMzsbaRLUbeJIq4oMdooHhBcv9d9wE++EXXJjgg
         gapSSbGl1rwE4IKyp9RfTvmECVaJbIwjAf+kii8GNF1O8mevcHl1YuURaRmFsVyYpsmG
         TM02ioJPDqgh74LU6fsCtcnyN90rqrLUyr6aT4OErDr7rTdHlYzjQB2yeyFulsG7pd37
         irO2IUjfwX8NSPT7jWD92xZVHZ+c4AcAWUxghkjBGMxIjG+9gLIt3RXUR+dN2uTEwbZ0
         X565ICsAGS30opyJC9K+QU+R6YgkVPBwyyDzhlZssf3snjr6acU2k3dbO4BMlKze3KMy
         WRFw==
X-Gm-Message-State: AJcUuke7CddSiHmzjpmbsbKelPZAjfxD5LBGMt+IqxmB1fA5h0NhF/jw
        tgOYUAkMH24hariWmulpkcw=
X-Google-Smtp-Source: ALg8bN4I804DOgRkwuxkS5ORIyeVZ/XhFeoHHGHwYT1oYTlFlYaCXgKQu1VCfrT0Rf0XjJec9xZMDQ==
X-Received: by 2002:a1c:4046:: with SMTP id n67mr4287111wma.123.1548371131422;
        Thu, 24 Jan 2019 15:05:31 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u204sm101345951wmu.30.2019.01.24.15.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 15:05:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, avarab@gmail.com
Subject: Re: [PATCH 0/6] Create commit-graph file format v2
References: <pull.112.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Jan 2019 15:05:30 -0800
In-Reply-To: <pull.112.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Wed, 23 Jan 2019 13:59:14 -0800 (PST)")
Message-ID: <xmqq4l9xhd1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The commit-graph file format has some shortcomings that were discussed
> on-list:
> ...
> This series adds a new version (2) to the commit-graph file.

Sigh.  It is unfortunate that we have to bump the format version
this early before we can say "it is no longer experimental" with
confidence X-<.  Perhaps we have been moving too fast for our own
good and should slow down in introducing new low-level machineries?

Will queue.  Thanks.
