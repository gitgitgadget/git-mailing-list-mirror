Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B782082F
	for <e@80x24.org>; Sun, 25 Jun 2017 22:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdFYWXB (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 18:23:01 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32809 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751358AbdFYWXA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 18:23:00 -0400
Received: by mail-pf0-f178.google.com with SMTP id e7so46498651pfk.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 15:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oKEGtz28PB7xWUGE5Kcr0CBrsj+SM5HsjgaRIMy4lwo=;
        b=lQHY1FB08qLg0HTzjGCUtBAh0X+PJ5kbFd+mrXoGqEf7HP01hPc9oHjbIOJt1zTZt0
         Hdft0VAgqLLDz3pJE//Gsil8pGjUqraG0AAxcBZH+tmp9I9/AyqWgX+3XTtMLacK6JGN
         KpEBZHapuwmhz2v++KOA2Hx5ns1j5akQ7Fk79SO63DD8nxM1yvNCn23YbRgwTTUz8xYh
         itHfFBwQzQGEH2OEnEklR4Y6BFNFAliX2kXi8P+2ZKZInfTxqxEWP5Xux1vsUvUcaSfz
         9++TNoJXIWd0nvfR8Eh2k4tvod3alahh4Q26cWOPldgMfXgNEjcIRnuwJzvSMLm3RPdc
         DoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oKEGtz28PB7xWUGE5Kcr0CBrsj+SM5HsjgaRIMy4lwo=;
        b=DF3C34tyKsXyRVXxag773til3ZDff4SaSvnZuuiJFpIm8+uoEyp1/NtZWHQ1GBZKkF
         Z8f/gb2X94vUTbojt41D4OmyFPQnXUgQTHrZiwlxQuV+IutTUDmjYkMSJR70oY3h/7+E
         unMNPWVIZUu+76HMKytttq2KKkzk0AZRVUUqBaP9X0pubDV4yU8XE4vzUOvIwWUiAhLg
         msZpDtYTQjpuAACF8k7HebewaSdr2gUMRPt6O4z6LNWUA7OTJuSN3DB2SUqzozqSIZ6g
         6LMSG9w8U1tn6w8QtbLA7euL7tziQ36LxvJR3sBh//v4zO8BMBI+o6bAiOwv9KpL62zn
         RuWA==
X-Gm-Message-State: AKS2vOxx059/WZrvehLKy5d9piWmM4ArtISb4EUnFlS+JkdC9OgY81Gb
        ioB80e9iyuuruA==
X-Received: by 10.84.232.137 with SMTP id i9mr21152358plk.154.1498429380082;
        Sun, 25 Jun 2017 15:23:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:644d:1257:a024:dc49])
        by smtp.gmail.com with ESMTPSA id m11sm22116745pfg.85.2017.06.25.15.22.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 15:22:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Getting first tag per branch for a commit
References: <CAGHpTBLP9MiYr2ZoUOaGjGMC+aO_EKYO6SwNLfAu6QFSRnPatQ@mail.gmail.com>
        <xmqqy3sf7mxo.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 25 Jun 2017 15:22:58 -0700
In-Reply-To: <xmqqy3sf7mxo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 25 Jun 2017 14:54:43 -0700")
Message-ID: <xmqqd19r7lml.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Orgad Shaneh <orgads@gmail.com> writes:
>
>> What I'd like to have is a way to tell the first tag per branch (or
>> per merge) that the commit appeared on.
>
>> I think that this can be done by filtering out tags that are connected
>> to already listed tags by first-parent link.
>
> Yes.  When one tag can be reached by another tag, then the former is
> definitely an earlier tag than the latter.
>
> A trivial way to compute it would require O(n^2) invocations of "git
> merge-base --is-ancestor".  Alternatively, I think you can perhaps
> use "git merge-base --independent".

Ah, forget the latter.  "independent" is about solving the opposite
use case--it is to cull the ones that can be reached by other tips.
