Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6681F4B7
	for <e@80x24.org>; Fri, 30 Aug 2019 12:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfH3Mt5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 08:49:57 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41685 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3Mt5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 08:49:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id o101so6768538ota.8
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/MJV/I7sEbuaYaB8+thBpU637TylA9iTPnta6bQkME4=;
        b=UJVUdJ8kDVIt2IttcZ5wnqkoVM1Z8FQmvMkw36UQtbD7vpyo2LPsCVCMNt654/P7r/
         FYL1vMDTWrcVCOky0yDSGNMvVta4j/+DSUPRKxBnu1s2ooo1MTlTOr0dpPzgzKQ2aTrU
         uSUsUBhQqxNKoeRXN+Nsn0nqjaZSrQG/WEhGyl3VnuQLSaApVfaX0J1uN3z+NoJo297E
         06Hsd985Ss1UU4Qbz698tpqr28PoEh80Klm//bCKgG2/JqEWUoFlcMQUpqL+JLs9OjyM
         jkxoxQnyDFKHoOIBZGjKebjeNjShG60wMAUG2fLX4VBJYB7Gx8++hut4EPDiMwGwF036
         m/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/MJV/I7sEbuaYaB8+thBpU637TylA9iTPnta6bQkME4=;
        b=ZY1BUUhtaZU/XgndKha0uh03arvWkPZI/7M2DhkWQA522MYeUl/M/77f0yWw1T6oFP
         jrXEu/WV+vnOIZrDoy9eboBdb30yD1QG1JRkNsHuPbagGXAOqyFSMSNysXYC1M7pMF82
         wvYPgXcsPtrc1YWg0uuf09aBq6pMJKDXftEPQzIWTuByzUbQ70zm3HtK04TqfJRSAEEF
         4oo+odfe9sFP0MNSuWq2Wdi44gdCxWrABsi3W+AelW3zoOUvDj5hKkxzAajg0GZNGOs+
         nUAQsNJo0TJtPnR58YECIISI9qfiNl/NnqBNICs/icFREUSCpyceUib5fLvmOhZzyTiH
         NKGQ==
X-Gm-Message-State: APjAAAU8Wm4+HYjUNVYEFxrycycogEkR6WnlCq6W6IHg8eCj2r3pMNYn
        PpmabTFrqZ/vGCiopsdVm9x8+qCJkt9in4OGXxE=
X-Google-Smtp-Source: APXvYqyIgDGZn42uMHuHJHdOEWjyHgqn9oquKfMmtwypohxYtKvRHR4+igNDPKS+LPonjiXdHHPHJ8REg00cU8otetY=
X-Received: by 2002:a9d:7f92:: with SMTP id t18mr3546895otp.323.1567169396057;
 Fri, 30 Aug 2019 05:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org> <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
 <34935414-4e69-114b-7a32-f94514e3679d@iee.email> <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
 <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com> <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Fri, 30 Aug 2019 14:49:30 +0200
Message-ID: <CAAQViEv1wWGTzQ29t0qi9rYoRY=Y86GL7E5rR4XySOBoeRx2pg@mail.gmail.com>
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 9:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ah, your "rm" command needs to learn "-f" option, too, then?

The whole point of this thread was to remove the need of -f forcing the removal.
