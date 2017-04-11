Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BFE51FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbdDKKMt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:12:49 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35965 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbdDKKMH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:12:07 -0400
Received: by mail-lf0-f49.google.com with SMTP id s141so48681691lfe.3
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=y/Bsw+fSlSG2M+DMz0VHjDN7TxBE8rD1qv8x0I1iuY0=;
        b=f6jyQnnXH+fA24M/ctnSg9ZYepr0RBVarcLRZVZHmQkHstpsonEMmEmPGjg+fl6k/m
         E8EualOo1PmonPqxr2aqT22xgjee9G41c4/06SzKW83ekvwkE4G8oX+4KK+ILc99f4JA
         g2it/uzt0250ZK+ctomufXkAXVVcKDn/NSal1XE4aVAm0F9ia74p3l9C7/Q4E2CO3nx1
         oRU8fnWZrr4WrMrOgPTun1TR+AKTnQk9pDEJRAv+mel586ZIplpY/l1UaFZkrk/TUUd7
         rbE3T393kUI/v2Xzot2evY7prONJT38w989H4Cu/eEFl5GXo9sTN0keoCEospWPjvrCk
         JyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=y/Bsw+fSlSG2M+DMz0VHjDN7TxBE8rD1qv8x0I1iuY0=;
        b=Q4DBKTep0jo1b26Nv1xC8hrjHHJBYHY1junUFcXz5gF9fLaHvKtTYFEKM1QhyTWY81
         9gU4RV8tqtLFN/EYFbdGVT4GGCsYEYnf8p7iqqTiiYmgIprcz8wLUMEu3SqMtyDlXR6J
         u605wyrH386QKUBgLU0DAHQSZQNIj0ahONJpuP1R3a2AnMzeQp4LL4z4F2rERqhC0vbx
         ceOGL7/IlaeEGul8V7ch6dLKPxOo50aULnEOHx0IDL1zN+uCZ6YPGeLZn3OBnZex7yQj
         onq54m+RzWlbftNcV6yFA3fQuVQNk/IFfIOE7pKy0jdmoUmT6Pm6laZkMe3NCUidKyZw
         1iTg==
X-Gm-Message-State: AFeK/H1pgcSS37mFrb5NBDm4Q9eOP4RQhJaH7mfGiZpKVAGwNReuQsXIiooQOjYl8iaHA4SRS50XdUsEcBZ+Ow==
X-Received: by 10.46.74.2 with SMTP id x2mr16867888lja.87.1491905526181; Tue,
 11 Apr 2017 03:12:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.150.10 with HTTP; Tue, 11 Apr 2017 03:12:05 -0700 (PDT)
In-Reply-To: <xmqqh91vqquf.fsf@gitster.mtv.corp.google.com>
References: <xmqqh91vqquf.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 11 Apr 2017 12:12:05 +0200
Message-ID: <CAP8UFD2PitxZDMm+qRrFOj+tQQsEUadOiQQjXjDnBCuHd9m21g@mail.gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #01; Tue, 11)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * cc/split-index-config (2017-03-30) 1 commit
>  - read-cache: avoid using git_path() in freshen_shared_index()
>
>  The split-index code configuration code used an unsafe git_path()
>  function without copying its result out.
>
>  Needs to be explained better.
>  The code looked OK, though.

In:

http://public-inbox.org/git/xmqq7f367o0s.fsf@gitster.mtv.corp.google.com/

it looked like you were ok with the explanation or you actually wanted
it to be shorter.
So should I send a shorter one? Or should I add explanation about why
git_path() is unsafe?
