Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647651F404
	for <e@80x24.org>; Fri, 20 Apr 2018 00:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753848AbeDTADq (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 20:03:46 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:41257 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753581AbeDTADp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 20:03:45 -0400
Received: by mail-wr0-f178.google.com with SMTP id v24-v6so18329222wra.8
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 17:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QZDDTvrp5favQgm2Th2QOFzTm2Qba3pfETseVtcPjJI=;
        b=l1l3hLtVAtE9kUXR5kNLqnFRHpldrnUbIZaKFxC34ftveCgeOAwY8xLO6f3jlvxlFv
         qNgEc7dEDo1HExbFWoEYlhGeFdfCwFedSWP8kRvNiWPRj18NtprznT67Fnmm0XTisWDT
         xjG9uiVQkBRsw3/3+ZdC/A5ccpHWN2/6H/Af2OwbFukCCWUMlV2vR4hvSFeWJ4LHB109
         8ZULu17VfwtCDyryevl9zNpVIhGW03IV4knzXtEzVVcYi3ZkXncL4DUKwkSKExIqtBKf
         lsu0MhzGvFzh9RF6HlCcFfMwOU7ttU66t8tK1oNFCPoQXCo9KuqdF6ryZ7xire5MBPIt
         yolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QZDDTvrp5favQgm2Th2QOFzTm2Qba3pfETseVtcPjJI=;
        b=EBxB20QtjihPEg70biDxtSM18HN051or2PiMQlg5DiJMj9u/hkn1KjVUnFZklaG7Dz
         u+30Wl818N5PmhFyjKZJq0/ZMbX9VTnKQ318frMCYySY4EZ1ADHhunceeWJH6LDfDS/P
         7jHBsYmvF6nooM4Kcz66LEqEQq2mD98FQ3mfBqbYn2La2HC8G9QMZJJKN17CG3pajCaw
         NVeRD0B1K8nsItngOGpHi3jMAg4H+JLgeDIGRLaJs2ctuyMOE58KzluMSJvYxKQGareO
         sbBomMv5bPNEfbBtxEyUrBgSbbHS/YGHiT0vMo6wK1gYi+9tS5FgnGMz9N0aZdtALJP/
         VDCA==
X-Gm-Message-State: ALQs6tBRwdpmRVJHG/Qxdcjs4GXipF4OEEFw7nD5vXpBTA5p+ollwBwb
        qa3FOQS5mnHYlQ7b29KkEmo=
X-Google-Smtp-Source: AIpwx48l+gfxt6oCCLt8sxADcJj+zJ4OXD3T+qNf8C+fX/Janij6scqZKzQlTkYUGj57jm9CTusuAA==
X-Received: by 2002:adf:e549:: with SMTP id z9-v6mr99095wrm.186.1524182623838;
        Thu, 19 Apr 2018 17:03:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 39-v6sm7637368wry.89.2018.04.19.17.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Apr 2018 17:03:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, git <git@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] git-send-email: Cc more people
References: <20180418140503.GD27475@bombadil.infradead.org>
        <87tvs8e174.fsf@evledraar.gmail.com>
        <xmqqr2ncgqhl.fsf@gitster-ct.c.googlers.com>
        <20180419121024.GD5556@bombadil.infradead.org>
        <646938104.13100.1524141300699.JavaMail.zimbra@efficios.com>
Date:   Fri, 20 Apr 2018 09:03:41 +0900
In-Reply-To: <646938104.13100.1524141300699.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 19 Apr 2018 08:35:00 -0400
        (EDT)")
Message-ID: <xmqqtvs6d9r6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@efficios.com> writes:

>>> I'd further say that these new CC-sources should be disabled by
>>> default and made opt-in to avoid surprising existing users.
>> 
>> But I disagree with this.  The current behaviour is surprising to
>> existing users, to the point where people are writing their own scripts
>> to replace git send-email (which seems crazy to me).
>
> We could perhaps go with a whitelist approach. The four
> main match I would be tempted to add are: Acked-by, Reported-by,
> Reviewed-by, and Tested-by.

A tool that suddenly starts sending e-mails to more addresses
without letting the end-users know when and why the change in
behaviour happened is a source of irritated "somebody made a stupid
change to git-send-email without telling us that caused unwanted
e-mails sent to unexpected places and embarrassed me" bug reports.
I do agree with a whitelist approach from that point of view, and in
the initial rollout of the feature, that whitelist should be limited
to what we already send out.

The users who learn about this new feature can opt into whitelisting
the common 4 above before we enable them by default.  FWIW, I
personally think these will be a sensible default (in addition to
what we already Cc).  I however prefer an approach to introduce
these more gradually.

