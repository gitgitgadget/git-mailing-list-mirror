Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5F2C1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 23:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfAVXVX (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 18:21:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40257 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVXVX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 18:21:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so282544wrt.7
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 15:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Hn4C6t5af0U53rymGrHUkLybk3yw4yxxBgSTr+JKRh8=;
        b=q5rVnSmmu4qFSog+3ZIMT5dv3KdrKsy/IADLTxrrtAkJpI8/NkJzvITtNsmY3RTtLs
         GatMN8glxUaBqiX6f9HLoySwwxIKpJAYl+g49Q7hS8xnF4SToRj+zQnK+9VbR+oVhant
         0jqS3E/WKjU7cu/yjz/MXiZwT6qxYf7TrpELolF2AqNsbHHwGVqnFFC0B1ur8OPTud6c
         PZ0JKWG1StKUCkm9fkqwS1mmZl6aodjolUS4hnthmyOXjG9xXlRZaSyThsPR4mWOYtoh
         vaT91e6F9FWWDMwsdT86aZQrFIND/xl4PjVAbA3sfoC7ioPUFZF+HcMpd7ugLMdV1TLO
         4bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Hn4C6t5af0U53rymGrHUkLybk3yw4yxxBgSTr+JKRh8=;
        b=R1ogUGdstZz3t9vKSgrK7kN31G86tj/Uph37UMyOkPf4RjGNdcP3BGgHp+2h/zlfkf
         XeYB8gi+OIIVjjIi04RIiM/bBuqyiB6EKgRrs75kSVjPO1lc8VsJad8DzqXsSNVIG0ae
         RJtGRNwfV1k2vSzik858F35CfWgDLuofTRwvT/Skdh2OHPGH3buiE3NGsyh7rBCavtxm
         7KYEyO3M5Lyy45E/C8J//UIdpSPh7NFMPWSDqWGpSrXrCk3zi97X/pX7DJ7r5/86QYgK
         Y2c7++XQY4havrKSrhVa0x0WdXzAPvhMi2q4o5MQG6thhFs+L2AyLA2PFPQHjIMUxQ0D
         sZbQ==
X-Gm-Message-State: AJcUukfkvtdvUUovsCLhAY4Cm0VXnCzj4RzkDoq1zyYp/64Y7keUvBI/
        IKInvNVPIr8LubgUBBXagC4=
X-Google-Smtp-Source: ALg8bN7mkU75i4O1q4StGYQ1IIZ7k5wVVjO0GDO9W7W75jn5gR65ATOXdejuZyBsZkGVbesWG/LbJQ==
X-Received: by 2002:a5d:4d87:: with SMTP id b7mr33202537wru.316.1548199281507;
        Tue, 22 Jan 2019 15:21:21 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y145sm40839788wmd.30.2019.01.22.15.21.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:21:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH 00/14] Trace2 tracing facility
References: <pull.108.git.gitgitgadget@gmail.com>
Date:   Tue, 22 Jan 2019 15:21:20 -0800
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com> (Jeff Hostetler via
        GitGitGadget's message of "Tue, 22 Jan 2019 13:22:12 -0800 (PST)")
Message-ID: <xmqqlg3ccm8f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This patch series contains a greatly refactored version of my original
> Trace2 series [1] from August 2018.

Great to see this series revived.  Looking forward to reading it
thru.

Thanks.

> A new design doc in Documentation/technical/api-trace2.txt (in the first
> commit) explains the relationship of Trace2 to the current tracing facility.
> Calls to the current tracing facility have not been changed, rather new
> trace2 calls have been added so that both continue to work in parallel for
> the time being.

