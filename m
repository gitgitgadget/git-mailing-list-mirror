Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7023D20D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdFBB4l (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:56:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34282 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBB4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:56:40 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so10222038pfk.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=V3P8u52Efz71WiRlZaXRAZAskGpMnIaMkC26jvIPONc=;
        b=W8hMC7nrRPTvMmQjrQxIKYXOqFYHuew8cXcvlyT1YJzMmGNXJxFNIE1kwV8ZE2clwV
         Zaerzp/1fjrMr02Q55OarIwUIweZ+wNZ9M4brLHHm2ap8P+gE5wdrqsPbyHpyn09tEhl
         YaiCkQEj/IHBHI5sANDOmu9QbGOJIfqRs1dpgFgiLBoFuhyjdSvYcKSkfVhOei62xPrJ
         H/abkezotucSWAYyg16pm4y1bnH4RRjzFiI8uVFRzfSk9sywoZAXB2f3NyotYbHTmyec
         Z+gv5MvjALesOs9BaspuMa4esxEIKvm2mqVBOXMIO6bugjbcG4XBNRQM7xsSCg7JZEAW
         R8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=V3P8u52Efz71WiRlZaXRAZAskGpMnIaMkC26jvIPONc=;
        b=bn7r3XZ2Lv/qOF3MVOxiNunXmwR9AN2vdyFHsv4BY08c2Gk9Qyg67eAlvZ/yzRHwLF
         9y4ymJwy6dVd+1tuxQY7bixP8/E5GdlpWIrN8urtQMGiPownEZse4SyOsC1NEgg/RSVX
         QfTwgWZz95E9M2in3qFQYiI2iPw7tgjINdAeWrYOs6Ax1OJIxgoBTZ/tKMqh+ZlLcE8o
         gtfM4k10PtMEXy/HPqo7N38PWRjmu0PCbV+m3qsLeLm2H74O9NB3oNWB97Bgu6ELdWVs
         wwxSFvnBZ5Z568y48T4M5a3iNCjxcfae3xyYlNeczTTookLDjyTnJ9eihBcvhB+6hK8N
         naUA==
X-Gm-Message-State: AODbwcAtaCsYxG5h6XfdNsIzltP1TaXnWMR6oiz9nIQAaVTK6mCbz0iq
        221H/Ydthy9wWzFPtQC8nA==
X-Received: by 10.98.201.212 with SMTP id l81mr4197785pfk.225.1496368599468;
        Thu, 01 Jun 2017 18:56:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id y5sm31444140pgb.4.2017.06.01.18.56.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:56:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
References: <20170601155105.28356-1-benpeart@microsoft.com>
Date:   Fri, 02 Jun 2017 10:56:38 +0900
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 1 Jun 2017 11:50:59 -0400")
Message-ID: <xmqqmv9r17ah.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Changes from V3 include:
>  - update test script based on feedback
>  - update template hook proc with better post-processing code and make
>    it executable

I take it that the first three patches are the same as before,
so is the "add documentation" one [5/6].

Will replace; Ævar seems to have some interesting numbers, so I'll
wait a bit more to see how the discussion goes.

Thanks.
