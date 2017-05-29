Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B280020D0A
	for <e@80x24.org>; Mon, 29 May 2017 04:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdE2EL3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 00:11:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35880 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdE2EL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 00:11:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id h64so5130177pge.3
        for <git@vger.kernel.org>; Sun, 28 May 2017 21:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mRgl/jAPLE3zf3nHqSwOxHhjhhgOp1r2iHJo4qWcRf8=;
        b=gy6NqCj13b39pbYHetkvB6seEhtGWiSpGo5xhqoRRk81XenZhjcedeoapmLA+B0FQ7
         xgWi7p1612jXgZWEeqo7x6NOdPkKKO8tKsanJeysrbl7Sz8sQFlxSBnvDm+FVBJPgdH7
         tEt3j5apxbdSFgfm6D9jizkMWv/6fCkhBqb0vSDKERgU+8SUpu9xmQWOVQNdEuEAT77a
         FgZmCYKBbVyk1NjAieQvtgoDePml9cfJiHV78p2k/esOWrBR4Sq59O1JCrDitju1UCWu
         ltKRuCOKisUL+UBTGBkwMngJXmFyh9t+iNKOG+O3J0so9bqqzbhCpj2mHNyVqqjpG/y8
         2VuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mRgl/jAPLE3zf3nHqSwOxHhjhhgOp1r2iHJo4qWcRf8=;
        b=bovox8ksIpH97PQ3AuYe1sHhPJAvf2ZJ2l8SDmZaVWb0RoL07IwTNNJKgW/9trfMJK
         DlaHH6+RAHpNbdokSqfHYVMCKkX7i/Id2cG2otZwmecg1PjQfJeNdW4xKSW2dzCSmKFa
         hXY72qvgSYb1euX2OP3O8bP6pCaBiWx6OQxV/pW4ZhlsCsulXeIxUBsInJifgo7r+VJa
         0+wWrBga9S+IC9u9R+2MD1CVv+EQnJucM/vgLfdyyCLMeiJgSLzWv+yaOEOBCY6mHR6D
         XfH9yw9SuiyaNjNRmKtfbfQ1AiX5xM7d1QWQWDvLASW03M5s//WEuMu7uloUSMIH9cKZ
         gmKw==
X-Gm-Message-State: AODbwcCMFmXL7NeLC6qeLnUg5FoIiXoFlrBM40fs2Nw6+0CAhAVAL9AG
        OfJHtuW/kW9Vbg==
X-Received: by 10.99.125.87 with SMTP id m23mr16530217pgn.79.1496031088135;
        Sun, 28 May 2017 21:11:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:393e:d787:9be9:17cc])
        by smtp.gmail.com with ESMTPSA id k86sm13747461pfk.125.2017.05.28.21.11.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 28 May 2017 21:11:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     git@vger.kernel.org
Subject: Re: 2.13.0-rc1 is broken on SPARC
References: <20170529023619.24zh2owkpxgzt3em@oracle.com>
Date:   Mon, 29 May 2017 13:11:25 +0900
In-Reply-To: <20170529023619.24zh2owkpxgzt3em@oracle.com> (Liam R. Howlett's
        message of "Sun, 28 May 2017 22:36:19 -0400")
Message-ID: <xmqqefv88fpu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Liam R. Howlett" <Liam.Howlett@Oracle.com> writes:

> My SPARC build does not function and seg bus terminates on any command.

Sorry, known issue in the released version 2.13 (we would have
appreciated if a bug report for -rc1 came way before the decision to
tag the final release).

A fix exists on 'pu' (you can merge or cherry-pick a0103914c2); it
was unfortunately held up with an unrelated enthusiasm around an
attempt to use submodule to manage this codebase in our project.

I'll try to untangle the fix proper and quickly merge down to the
maintenance track.

Thanks for a report.
