Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508441F42D
	for <e@80x24.org>; Fri, 25 May 2018 03:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755044AbeEYDSp (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 23:18:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38475 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755015AbeEYDSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 23:18:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id 94-v6so6602285wrf.5
        for <git@vger.kernel.org>; Thu, 24 May 2018 20:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ROJh3QGSbN0bZN3PVcusUwQxB1h9Hfc1ZRWP7Mp61U4=;
        b=JRrVNQ41oau62oX6GBfz0v/ONBb1XEHUuVIPNgbWUb4JrlcCiayPcfErbas0OBcmya
         52FEvyj4K5r47JCW2Xk4XCXoWPB785MIt8yR+g8ef7mgw0pXSiqHF1G6uL1m04HX3VK6
         v2eugonFF1EDGo3KcQIm4rXEDgoDalnuHR1YrkwM71w4lVV+HDIc6w2orUwvysiE3rN0
         PM7YOkC5bpVJ8Pr0w0TElYfYDQOMgMQZQXbOTGc0sTVlHPUO7kpoFS18213aFtJVxUWy
         hLwVjVdtVjCwxfmwg+mlY5jH5JBET5vIoVoFvspnSkCUY2erusAn/YFAN7gv6dVQUwWL
         C6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ROJh3QGSbN0bZN3PVcusUwQxB1h9Hfc1ZRWP7Mp61U4=;
        b=B0QusLpm91VpEibMu7pgCh/KO7cbeT7DAvV8wH42vbVFIq0cavwbPASZSZd21FdO4x
         U7dBpFolznZkyOByQo5qI4LwHWRUlAzSUBHEu4qjfKAWs+QjXzKx/5nJWYIId809inKz
         JiArdgP5Cy35BQ58u2tkQHqzceUSSfWV6VK4BqL6TcgWZSibi2D985jL5biaY85evDo8
         Q1Od1GCWfan3UqjjnOrRhbv5dgwDaMOoz+s/N242b3ycGr8DydSgTBrf+YxSn0Udj0La
         UJalmXx5CPWX65kn1oPHSkwqfzF645FMZz6ysH2OVr8T2+L1SIq7ScWbhPH43KGAg1fn
         OQUQ==
X-Gm-Message-State: ALKqPwfN8gfThuE9/tTDTMA/MffDfW9pteoqyD0v9+zeJ/3CqpEiB2ZL
        U9XJ/+bEmQSgdDXhSQYPItE=
X-Google-Smtp-Source: AB8JxZocdVzOpmjQ5U8J+JUIIGTzuFpo43Xjo4rFYKVFRQ6s39oNSDDI9fIqh7rp2mb9W8Jij2qpwQ==
X-Received: by 2002:adf:c08a:: with SMTP id d10-v6mr399293wrf.268.1527218322491;
        Thu, 24 May 2018 20:18:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z17-v6sm7190478wrm.8.2018.05.24.20.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 20:18:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] config doc: don't describe *.fetchObjects twice
References: <20180524193516.28713-1-avarab@gmail.com>
        <20180524190214.GA21354@sigill.intra.peff.net>
        <20180524193516.28713-2-avarab@gmail.com>
Date:   Fri, 25 May 2018 12:18:41 +0900
In-Reply-To: <20180524193516.28713-2-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 24 May 2018 19:35:13 +0000")
Message-ID: <xmqq8t88pgmm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Change the copy/pasted description of the fetch.fsckObjects and
> receive.fsckObjects variables to refer to transfer.fsckObjects
> instead.
>
> Let's not duplicate the description of what *.fsckObjects does twice.
> instead let's refer to transfer.fsckObjects from both fetch.* and
> receive.*.

The two paragraphs above are duplicating what each other says,
perhaps meant as a half-joke?  Well played if that is the case ;-).

Thanks for polishing this area.
