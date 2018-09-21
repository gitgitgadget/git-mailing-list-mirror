Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F9BF1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390683AbeIUWe5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:34:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42195 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUWe4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:34:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so13475200wrr.9
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZuBb+myHZhuv1Ud8kqCa0PbU1bYi5CjkwgSzJuI5LaM=;
        b=eJ55VkDi6vVuG2yiQen8T3WGq4lirM30pOQ15G4J7+OXWQ0logialh7Gsj8AVEKA7+
         SeqZ0uDvO82TtrYyeiY3xaGMh4TuPMwOeXDvmatejR7So0KFKdMc6rk7SKmaKrYCTMLx
         jF8/cUrpBd7YKc3GbZYmFfQwHWD2EgSvY++LOfpA2/Mgoy4fhW7QVD/XgXh9TqWcvwyw
         gcq44DeaKDYNqf6419/iJ5hcEaX38rRQaprcZqOV8EfjV+pzHcSkDZ142CFk84VVttsA
         docHn9X/V5OoXgAzlEGK8n2IXvPoNsr8/RJdHsP1wTD6Hwz4tuTz0lDCYlM0MrTFzjAF
         bkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZuBb+myHZhuv1Ud8kqCa0PbU1bYi5CjkwgSzJuI5LaM=;
        b=uoCvQe/zV/8U/gzquB7DdeoG84NFEqtoV51vkJo1kDsJycOZ9ICc4KM7USPPhUQJWq
         BDgkyScxvRIt6OcyPXH33+oZYhMVsdPrdF7CiptBOYuTepE9pFOCxuhm3//3D+pg+R9r
         +1ntt0UhdtmUsacFl1LMA7Ee4gni/banJZ6kGSshFqTmhrQBehYCOhQRg+u6QJoERsUa
         iexVHb/WLwqNbgNiNasHEwVhOw6ydjVK0ytUkOMXpDDc20NgrHeN1aJNtBcQibwRcXt8
         W7i0ZPjcZELaEfpCYGroHPtOSG/0nXjqUwtkLeJuRYezMZf7w2r5D6KoX2OleuyARelF
         b0qw==
X-Gm-Message-State: ABuFfoj7ElAuJE982iQbVEStIA8EYhQdBqiUhFUsN8REHijd9G9MSwE8
        lXsT8N18VG0qnAJ7kgnX4cc=
X-Google-Smtp-Source: ACcGV61PyI9fXlwcAtK0//qixKCSUmm+MeUz4hf5cXvaM5HJCD0eWhQe3CTBMIW1CmAL6Tscul0clg==
X-Received: by 2002:a5d:4a10:: with SMTP id m16-v6mr7287721wrq.278.1537548312659;
        Fri, 21 Sep 2018 09:45:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t20-v6sm4617867wmi.24.2018.09.21.09.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:45:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] transport.c: introduce core.alternateRefsPrefixes
References: <cover.1537466087.git.me@ttaylorr.com>
        <3639e9058859b326f64600fcd0b608171b56ce9f.1537466087.git.me@ttaylorr.com>
        <CAPig+cT7WTyBCQZ75WSjmBqiui383YrKqoHqbLASQkOaGVTfVA@mail.gmail.com>
        <20180921140732.GA43093@syl>
Date:   Fri, 21 Sep 2018 09:45:11 -0700
In-Reply-To: <20180921140732.GA43093@syl> (Taylor Blau's message of "Fri, 21
        Sep 2018 10:07:32 -0400")
Message-ID: <xmqqfty2x0iw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> ...' block with your suggestion above. It's tempting to introduce it as:
>
>   expect_haves() {
>     printf "%s .have\n" $(git rev-parse -- $@)
>   }
>
> And call it as:
>
>   expect_haves one three two >expect
>
> But I'm not sure whether I think that this is better or worse than
> writing it twice inline.

If the expected pattern is expected to stay to be just a sequence of
"<oid> .have" and nothing else for the foreseeable future, I think
it is a good idea to introduce such a helper function.  Spelling it
out at the use site, e.g.

	printf "%s .have\n" $(git rev-parse a b c) >expect

will become cumbersome once the set of objects you need to show
starts growing.

	expect_haves a b c >expect

would be shorter, of course.  And as long as we expect to have ONLY
"<oid> .have" lines and nothing else, there is no downside that the
details of the format is hidden away inside the helper.

