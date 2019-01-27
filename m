Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A101F453
	for <e@80x24.org>; Sun, 27 Jan 2019 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbfA0WeU (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 17:34:20 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33583 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbfA0WeU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 17:34:20 -0500
Received: by mail-wr1-f44.google.com with SMTP id p7so16065431wru.0
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 14:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=tgtBDSA/YECoHvSRR1smCLx15AchDGmbASwiA2SQ5Js=;
        b=SHcuUM/DUFA+UywdDTe8rzojpNexvQmymHIIJtsrjXyONELkXZA87zE3Qg+u4j11cg
         3bB4WMy1Aa/r3AKCKLaUCwLeGTTknjc2u9UZZhOTilqPXAJtOTbUN87TLELBTfl0jftp
         rzoyPG9adeHmazbLX45tdUN9wCv2bkuOVYMkUudQIoDbjPqGrGh/IAMl+Qy6ZQMiFWxR
         eEKIaHCUF/p4oQVJbDMlT+eAbmsEfdst6iMNe8ati24o6urjwGowgDIXDDDHAZvcr+Pr
         5T6Qu5v1kvim7xkG9zDMmFWbjeIGpoaHcCKJVMHLnxck/R3vs0mdAdPULUBcicrvL60s
         ro8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=tgtBDSA/YECoHvSRR1smCLx15AchDGmbASwiA2SQ5Js=;
        b=OcjVc9aZvcuDpnh/TZeYlmfmXSMHB0WU6j8AcNxDm0MzZqgYk2wDOqBIAIt2TSkk+p
         JKLBojupD3gbT1EqkSyPglZnZds1uHQ2UfI7xN/S8cY3sX/hYPto6GyN/oLuOpJO66kD
         l3XdJXZmC6deXnFnfx5x1i/yIGs+89ZOShPGcm1lOgYtNILWu5lKQ5pK5akSIjbra4Lx
         I3IgTfvle3R/5sdYE1sBJC0COUcBux2Mij0TpB9cuJ0ecK/CRDcLjIfMXAMvSv6MIH5g
         vtmtvYlA3u4YpL2XgPukaf0u0VvvoU9MdC7fhAuLvsI17zTbhU2hfIMi9EH8VdVzRhJY
         duuw==
X-Gm-Message-State: AJcUukctSmH9wqk5Iz4pt+icQ+wldYU0NT80/DZUt9gOJh4PD2kvz4WH
        v/q1b0j3pJl4BEJVCI577IE=
X-Google-Smtp-Source: ALg8bN6iowIVnQk4GpcgnF/hMvKcYXAgrX2EpVNiu35m4A2Udi210+d1Pjc2f3X+hz1zbu6jrIMaBQ==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr19426907wrp.61.1548628457828;
        Sun, 27 Jan 2019 14:34:17 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a132sm97471782wmh.5.2019.01.27.14.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 14:34:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        zhiyou.jx@alibaba-inc.com,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH/RFC v2 1/1] test-lint: Only use only sed [-n] [-e command] [-f command_file]
References: <20190110115704.GL4673@szeder.dev>
        <20190120075350.5950-1-tboegi@web.de>
        <xmqqo988fpag.fsf@gitster-ct.c.googlers.com>
        <799c5063-b0a7-df6b-6f86-a92b8b6d679b@web.de>
        <CAPig+cSDnhvVCDE15koO9M1A8TBg+Mbn2OBsfXVvshmRyybApw@mail.gmail.com>
        <f7871d8b-a19b-5816-120b-ce583debc4ca@web.de>
        <xmqq8szbcl9q.fsf@gitster-ct.c.googlers.com>
        <20190125191224.pgugeqskuhzi34hv@tb-raspi4>
Date:   Sun, 27 Jan 2019 14:34:14 -0800
In-Reply-To: <20190125191224.pgugeqskuhzi34hv@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 25 Jan 2019 19:12:24
 +0000")
Message-ID: <xmqq1s4xg26x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> Thanks, both.  Eric's proposed message looks good to me too.
>
> Do you want to ammend the patch locally ?

I just amended it; thanks.


