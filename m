Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F17720A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 01:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeLKBs1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 20:48:27 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38503 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbeLKBs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 20:48:27 -0500
Received: by mail-wm1-f43.google.com with SMTP id m22so540417wml.3
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 17:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2rvGtOvsUHn/KN6BpKTpd1gm89KLO5JX4VtOZHlglNA=;
        b=aUmOVLC6jd5W9Tkm95DyLeYD4jS7MWObwlOL0vdD8RF/R9U5LCCkdKeyF5ltJXQrAK
         7yeN2Xta8vMYUE2ZO40r4/s1ezsSW27jnz4XOCh5aNDKgtnvjtPzy0FqjOMjLXaQ1SL4
         odFok7HtYT4qbHfn6Bg29WqMhFQT4R4d+h7MMealr2bSvl2J519RptXi1PqkM/Xchxi6
         RJu+IEzthrc3x1L4xcJ2YZhVBpODdLQb4XNfNmF8sW7nUV3bkClgdX9szd3iyr97NbYD
         yckwE6+hqP9eEoqHanBmfJepePpUyu4BQCUulQo35v0EuhCF8lXHEuNBvdCH4Gj5elj3
         pHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2rvGtOvsUHn/KN6BpKTpd1gm89KLO5JX4VtOZHlglNA=;
        b=SiE24co2nvbdROaf6/0RdG1xbrEwAG7PCFSzpzKr0DEUGSCGadUZUSQOyJPiIL4aG+
         TTUH60EYXaaQDUwHyXJ5tBe0hbwJZuzCSBrLMkC4NQ3ntHBUGOxBl+LIyAdHsLyJHss9
         SovgQQW/spfrkHGeJoDDulVnqmnNun1qYVy5VkpxT0kwFnEizKgzEO3OHSlsWGEmhBHh
         j79qAPv8zNEpUwYOlZ/jiUlEB8/I6qOO6oDhTqZt4GFFAfxpBiPn9N7hc1Nsd51ZGcHI
         aR4IsMSlkh/9gpoN1AozdJy+HlSreOJrmOwsVYU+goKkrb6b+d226OdfKl1j5z0BoZIb
         bzWQ==
X-Gm-Message-State: AA+aEWZekMidBIxmP2IKD2LkI3A6bZD2GvnBgwmCPEij/6/aJ+wmRww6
        kJxKWBTatKbD0ZDHJfuyZR4=
X-Google-Smtp-Source: AFSGD/WXF0eDPt0onNLDGJfkIxau1URIAOVcMeFzI0fSQQJ5OPfhdRDgrJtBWpfFaaNU8qbdB2/dGg==
X-Received: by 2002:a1c:2686:: with SMTP id m128mr513156wmm.52.1544492904615;
        Mon, 10 Dec 2018 17:48:24 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o17sm599568wmg.35.2018.12.10.17.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 17:48:23 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Dec 2018, #01; Sun, 9)
References: <xmqq8t0z3xcc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGVHnaZLg4fuptVmNa=jRHg0cMDTWjv1NdLQJXPe=+ahw@mail.gmail.com>
Date:   Tue, 11 Dec 2018 10:48:23 +0900
In-Reply-To: <CABPp-BGVHnaZLg4fuptVmNa=jRHg0cMDTWjv1NdLQJXPe=+ahw@mail.gmail.com>
        (Elijah Newren's message of "Mon, 10 Dec 2018 12:05:10 -0800")
Message-ID: <xmqqsgz4n89k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Sun, Dec 9, 2018 at 12:42 AM Junio C Hamano <gitster@pobox.com> wrote:
>
>> Git 2.20 has been tagged.  I'd expect that we would slow down to see
>> how stable it is and queue only the brown-paper-bag fixes for a week
>> or so, before opening the tree for the next cycle, rewinding the tip
>> of 'next', etc.
>
> Does this mean you'd prefer we continue to wait a little longer before
> sending in new series and re-rolls, or just that you are managing
> expectations about when they might be queued?

More of the latter.  The best way to find bugs that matter in real
life is to use the software in the real project settings, i.e. you
guys work on your own topics using Git.  I'll keep reviewing and
commenting just like other reviewers, but the new patches won't come
close to 'next' (as I said elsewhere, being in 'pu' does not count
much---it is like getting bookmarked) in the meantime.

