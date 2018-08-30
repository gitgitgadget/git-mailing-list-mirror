Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3551F404
	for <e@80x24.org>; Thu, 30 Aug 2018 15:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbeH3TZq (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 15:25:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50287 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3TZp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 15:25:45 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so2408385wmc.0
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 08:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=d54r9WOQ/IqrR5ahTcSnjZ+qDpWtCFrBbEsXQe5n6/o=;
        b=SgsQ88veAkYVyy8HXfVwquxMPwTXtGuxvx8CvOzUz+2H3opXMsXQrrXZC3r1G9cAnr
         Q49yq3f8QZd1wYkc+SpEFhCfakQPotBAtHOQ7tG6WCvIMRi5hhJjuR93T+1cCOOcP75k
         ph0CJY0j0fcc2XYczuDoI42J5rUvjsKnPTbZDIY+Y43dcJz6qHtZJa4pLSnl5vnQAydc
         MEQMQQ6ihGoZF0bQ1/0FP0yMY+Tnvp3mF1Dg1BzSScEiE6y/T3nrX0G4aGTdjxQOzaKJ
         G6i9tVWqWwlezV9X+SApCxijD/1FBgw96veTbek9oDgUDwPck1gOZfOYN42JtsGi/ceJ
         mkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=d54r9WOQ/IqrR5ahTcSnjZ+qDpWtCFrBbEsXQe5n6/o=;
        b=cV4Hiq3n5U9LJGqByququYkh7KpUv6XE4d/zIPA8uuMC6WPfa6H+u1758ap9fBP+IL
         6ikWNBcRlI4bbX0TxNolNk7zqwwQLXj/v31jjy500r3msQw7FMSMpfhc9tx/B0alaz3Y
         2/XtHabCWFXH44TUw8i/7CCH8rYOPU9T0XR9rC4jtdVXTAQgCdHm8uYZcItL6Dy4ibld
         aA985kI0chSWrtAbgoEW10j0oLhiG+GvHHUndOk2tCURst7JfRVE8GlPzSqyHllyyD4d
         iA9fAXggIopAzSTAEumkCpoKl1IpaXhF7IBL8mx5mucLy3huuptBAzZL5AFjMmvQVRyR
         wNcA==
X-Gm-Message-State: APzg51CMi2kJPq7MRWiAIoGbbqovH1CuZXydOgDMLMGTjZ8fdbu+r02M
        0E1Rs5X7JOrWgBl0Gfszx6c=
X-Google-Smtp-Source: ANB0VdYVBz7+hIgClMnOZXVevd/tyzN7zAa7af4CUJ8f3WVkLjyL7SWDAE1KcDCtUQpusZnxsTevrg==
X-Received: by 2002:a1c:7814:: with SMTP id t20-v6mr2045468wmc.38.1535642583594;
        Thu, 30 Aug 2018 08:23:03 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h18-v6sm7369691wru.42.2018.08.30.08.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 08:23:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 06/10] push doc: correct lies about how push refspecs work
References: <20180429202100.32353-1-avarab@gmail.com>
        <20180731130718.25222-7-avarab@gmail.com>
        <xmqq8t5rcnhg.fsf@gitster-ct.c.googlers.com>
        <87o9djdi0c.fsf@evledraar.gmail.com>
Date:   Thu, 30 Aug 2018 08:23:02 -0700
In-Reply-To: <87o9djdi0c.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 30 Aug 2018 16:52:03 +0200")
Message-ID: <xmqqh8jb7uax.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I.e. the non-refs/{tags,heads}/* update logic treats all updates to
> tags/commits as branch updates. We just look at the tag v2.18.0, see you
> want to replace it with the commit v2.19.0-rc0^{} and see "oh, that's a
> fast-forward".

In my old message you are responding to, I asked what you meant by
"will be treated as branches", and after seeing "as branch updates"
above, I think I know what you want the phrase to mean, namely, that
old-to-new transition requires new to be a descendant of old.  But I
think that is weaker than what other people (including me) thinks of
rules to update refs/heads/* hierarchy (i.e. "branch update").

You are allowing to store an object that is not a commit in
refs/blah/my-tag in your example, so it clearly does not protect the
ref with an extra rule that applies to "branches", namely, "it has
to be a commit."

> Arguably that should be changed, but I won't do that in this series.

OK.
