Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4392A1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 17:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbeJTBL1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 21:11:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33112 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 21:11:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id l14-v6so23111857edq.0
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4IL3KtuZEd8LkFeOipcLZVlLJhuDKnmbHVu/bou+h0=;
        b=fCrwbM55hRmI+lBL9o+747wo3WsqGakromMNN78bO0QSe19PezjU8B5MwmG6KC3TdR
         AVL74wCIzpisReDBh4aMvnhPoCAo1nfvG3IHBGtI3/fXd7/jN8TG4+DIQtDj52HgrJS8
         J+QhCrDjB9KaQ9Hak750KGRlfV2i6bpmro1i6vjvscbCDSv20NGA5T9WLwS64+2Hd0lY
         dYeX0OTofKyqF7VrbqWB1MXG97iNn1j2yYgOd6z8mdlNR2B6nw1v0biCZVcSmFraeEjU
         emnFWVUAETQb/+0YJmdXfoKYybjyxX6x8Nc/nce+awAwSqgHcK0IDlu523X/KQb08vMF
         U8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4IL3KtuZEd8LkFeOipcLZVlLJhuDKnmbHVu/bou+h0=;
        b=t07Bduj3EMnM10yba9hmrz5S4R/IVK/4VFatp0IEpn39Im50zlqecStKgR1yCn2JeC
         kPKXMO+SfeZWMfL3GhuTSrUik7VTT8UvlPS19F0XKWyU7MjiCTqo1ShU9CgwVSr2IbkX
         CAp7acnYUjryoCZtcUzyOX+gdCXG3befgDp4BFrZDAbaWO21SPFb8hC7yZDFd7NvrIEa
         a7P51klNJQkgnmAtxy8fcX9Xwue8KzWdqK3VjHks50N9R56PC6hzMKqrU5v/hWQQEHXF
         V99w+S8SzrbX4/CyH04KAg74qRHuXykl0eOnXoA5dppa6X2FLG7lzAefgeINui6vmjxo
         I8vQ==
X-Gm-Message-State: ABuFfohyHxkb2WOQN3TdYIatzyL+29SIhh9MALsuRLUitqgxevd6N1V2
        +a6jYzBjzD93VfQWE22BMWXjLvE6/oi5+94iyyFPcA==
X-Google-Smtp-Source: ACcGV602QGOtXZ57VeTJYS/M/lxvB8QgTtSNLG8TV7vItkmvvtt5jd1Lqa6ipE/Ds1Vfh8IgebBt4AdBuiM7xH8mmtA=
X-Received: by 2002:a17:906:9a1:: with SMTP id q1-v6mr30911661eje.126.1539968669060;
 Fri, 19 Oct 2018 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
 <xmqqr2gu8dsx.fsf@gitster-ct.c.googlers.com> <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org>
 <CAGZ79kYChLNDB_f1KR2k7G9FvHkX7x_yXdhxMRpLFWpRR0SoPg@mail.gmail.com>
 <a9a51e28-208d-d8dd-a868-bc2f8cc79598@kdbg.org> <2ca9d427-38fb-ff6e-4e2f-1947d86e6273@kdbg.org>
In-Reply-To: <2ca9d427-38fb-ff6e-4e2f-1947d86e6273@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 19 Oct 2018 10:04:17 -0700
Message-ID: <CAGZ79kZ=u8UrLbbrAu1PnOg57bqx0wuzfx4P3Ki60LmfUTo4Jw@mail.gmail.com>
Subject: Re: [PATCH v2] diff: don't attempt to strip prefix from absolute
 Windows paths
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, andreenkosa@gmail.com,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +test_expect_success 'diff --no-index from repo subdir with absolute paths' '

I was late looking at the test, and was about to propose to guard it to run only
on Windows (as this test seems of little use in other OS), but after thinking
about it I think we should keep it as-is, as there may be other OS that have
interesting absolute path which I may be unaware of.

Reviewed-by: Stefan Beller <sbeller@google.com>
