Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413C61F462
	for <e@80x24.org>; Wed, 19 Jun 2019 00:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfFSAIy (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 20:08:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43753 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfFSAIy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 20:08:54 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so33958096ios.10
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3/Sf94w3R5/jtt1Rf76e6uwfifl35J5SVyDNvHosDg=;
        b=bQEQqHro434DqKNEiC6WpzDpx6+KkVZmeNoX3D9davMavVvgmBjM/kvK2u8iowjAcj
         agOgsdChkOMKi82AMPAWUKGsFH+/FAZxD6RpOV6ZZz4ua4Nn++T3MH8QkBPucS/lwkt/
         LGpLrxGUdQ711ljq4iY/JxDFuTQUjryZvxLbseqQNQayecL3jMrQpuUpChEoyfPyOmcr
         D6SK+ZHO6TbiCE/Pr0Bm7w43koKqmVGET1TCAFA1VA3GzMRxn39n7j98q5kMnQpJAYWS
         DgFezpNHbNF7i+7D7tbD6yfpIwaoOTVFhSClTs91Nu116znQwNckzgpdfHbNf3bn1joX
         Lg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3/Sf94w3R5/jtt1Rf76e6uwfifl35J5SVyDNvHosDg=;
        b=CbpOaIsHHfRLNN2kzz+gc21CUnxSzE3ZxSon0m349IJknYg3u3jmtipHbH5MURmZrs
         4/c9f74u/sBgYsE+uEQiMNpow6glUYdBvJ6gbRdde3+rf0C6b3fX4lqFQEXPajUpZWh5
         61+jUuqjgYYSykdg6iODmEyj8kHAZnstYGnhOllJEMlQUyTsl1VkCAKbJc2C6p0tR/74
         Pmp0r5CvkqgHV/ABOeDDuonhVhMNnL9f6sLj0fCzMk84NN9LQJrL3NDjnZgYzEXX3OtI
         B+v202VL+yxDJKvW3ju5kBWQiA8UuAJiJyr0I9weX9dZBlo36UPTSqs/Zmv7v9t1J/Gm
         nhag==
X-Gm-Message-State: APjAAAWdr548+hwSkLkVUMyVFlWhEomuNSaJQE+JRV/cQeGYZyPkbwIZ
        IJJgX4naUMvo0bl65LqdDUBs0gMqmGSh+4N3hEI=
X-Google-Smtp-Source: APXvYqz3miQfJKduW8fWg0H1nfcHm958TxntF74vBdKfRLeQzBD+YOJOBjV0qHfJ0xTwnbAfmAliPRMTDFs1bR2XRfA=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr5584912ion.16.1560902933098;
 Tue, 18 Jun 2019 17:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 18 Jun 2019 17:08:42 -0700
Message-ID: <CAPUEspi-G7abt-zuLbw0iuyXN0gtrM_6Vy6d+9f-=6FpRsoV4A@mail.gmail.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

shouldn't this also be a problem with builtin/blame.c?

Carlo
